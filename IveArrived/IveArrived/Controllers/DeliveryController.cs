using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using IveArrived.Data;
using IveArrived.Entities;
using IveArrived.Entities.ApplicationUser;
using IveArrived.Mapper;
using IveArrived.Models;
using IveArrived.Services.CurrentUser;
using IveArrived.Services.File;
using IveArrived.Services.Firebase;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace IveArrived.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class DeliveryController : ControllerBase
    {
        private readonly ICurrentUserService currentUser;
        private readonly ApplicationDbContext context;
        private readonly IFirebaseService firebase;

        public DeliveryController(ICurrentUserService currentUser,
            ApplicationDbContext context,
            IFirebaseService firebase)
        {
            this.currentUser = currentUser;
            this.context = context;
            this.firebase = firebase;
        }

        [HttpGet]
        public async Task<List<DeliveryModel>> ListForCourier()
        {
            int currentUserId = await currentUser.CurrentUserId();
            return await context.Delivery
                .Include(d => d.CourierService)
                .Include(d => d.Courier)
                .Where(d => d.Courier.Id == currentUserId)
                .Select(d => d.ToDto())
                .ToListAsync();
        }

        [HttpGet]
        public async Task<List<DeliveryModel>> ListForRecipient()
        {
            int currentUserId = await currentUser.CurrentUserId();
            return await context.Delivery
                .Include(d => d.CourierService)
                .Include(d => d.Courier)
                .Include(d => d.RecipientTokens)
                    .ThenInclude(dt => dt.Token)
                .Where(d => d.RecipientTokens.Any(t => t.Token.UserId == currentUserId))
                .Select(d => d.ToDto())
                .ToListAsync();
        }

        [HttpPost]
        public async Task<DeliveryModel> Subscribe([FromBody] PackageSubscriptionModel dto)
        {
            var delivery = await context.Delivery
                .Include(d => d.CourierService)
                .Include(d => d.Courier)
                .Include(d => d.RecipientTokens)
                    .ThenInclude(d => d.Token)
                .FirstOrDefaultAsync(d => d.PackageId == dto.PackageId);

            if (delivery == null)
            {
                return null;
            }

            var token = await context.FcmToken.FirstOrDefaultAsync(t => t.Token == dto.FirebaseToken)
                        ?? new FcmToken
                        {
                            Token = dto.FirebaseToken,
                            UserId = await currentUser.CurrentUserId()
                        };

            if (delivery.RecipientTokens.All(rt => rt.Token.Id != token.Id))
            {
                delivery.RecipientTokens.Add(new FcmTokenToDelivery
                {
                    Token = token,
                    Delivery = delivery
                });
            }

            await context.SaveChangesAsync();

            return delivery.ToDto();
        }

        [HttpPost]
        public async Task DoorBell([FromBody] DoorBellModel dto)
        {
            var delivery = await context.Delivery
                .Include(d => d.RecipientTokens)
                .ThenInclude(dt => dt.Token)
                .FirstOrDefaultAsync(d => d.PackageId == dto.PackageId);

            if (delivery == null)
            {
                return;
            }

            var token = await context.FcmToken.FirstOrDefaultAsync(t => t.Token == dto.ResponseFirebaseToken)
                        ?? new FcmToken
                        {
                            Token = dto.ResponseFirebaseToken,
                            UserId = await currentUser.CurrentUserId()
                        };

            delivery.CourierToken = token;
            await context.SaveChangesAsync();

            await firebase.SendMultiCastNotification(
                delivery.RecipientTokens.Select(t => t.Token.Token),
                new Dictionary<string, string>
                {
                    { "MessageType", nameof(DoorBell) },
                    { nameof(DoorBellModel.PackageId), dto.PackageId }
                });
        }

        [HttpPost]
        public async Task DoorBellResponse([FromBody] DoorBellResponseModel dto)
        {
            var delivery = await context.Delivery
                .Include(d => d.CourierToken)
                .FirstOrDefaultAsync(d => d.PackageId == dto.PackageId);

            if (delivery?.CourierToken == null)
            {
                return;
            }

            await firebase.SendNotification(
                delivery.CourierToken.Token,
                new Dictionary<string, string>
                {
                    { "MessageType", nameof(DoorBellResponse) },
                    { nameof(DoorBellModel.PackageId), dto.PackageId },
                    { nameof(DoorBellResponseModel.IsAvailable), dto.IsAvailable.ToString() }
                });
        }

        [HttpPost]
        public async Task DeliveryCompleted([FromBody] DeliveryCompletedModel dto)
        {
            var delivery = await context.Delivery
                .Include(d => d.RecipientTokens)
                .ThenInclude(dt => dt.Token)
                .FirstOrDefaultAsync(d => d.PackageId == dto.PackageId);

            if (delivery == null)
            {
                return;
            }

            delivery.State = dto.Success ? DeliveryState.DeliverySuccess : DeliveryState.DeliveryFailed;

            await context.SaveChangesAsync();

            await firebase.SendMultiCastNotification(
                delivery.RecipientTokens.Select(t => t.Token.Token),
                new Dictionary<string, string>
                {
                    { "MessageType", nameof(CourierServiceDeliveryController.ChangeDeliveryState) },
                    { nameof(DeliveryModel.PackageId), delivery.PackageId },
                    { nameof(DeliveryModel.State), delivery.State.ToString() }
                });
        }
    }
}