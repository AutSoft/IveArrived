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
                .Where(d => d.RecipientTokens.Any(t => t.UserId == currentUserId))
                .Select(d => d.ToDto())
                .ToListAsync();
        }

        [HttpPost]
        public async Task<DeliveryModel> Subscribe([FromBody] PackageSubscriptionModel subscription)
        {
            var delivery = await context.Delivery
                .Include(d => d.CourierService)
                .Include(d => d.Courier)
                .FirstOrDefaultAsync(d => d.PackageId == subscription.PackageId);

            if (delivery == null)
            {
                return null;
            }

            var token = await context.FcmToken.FirstOrDefaultAsync(t => t.Token == subscription.FirebaseToken)
                        ?? new FcmToken
                        {
                            Token = subscription.FirebaseToken,
                            UserId = await currentUser.CurrentUserId()
                        };

            delivery.RecipientTokens.Add(token);

            await context.SaveChangesAsync();

            return delivery.ToDto();
        }

        [HttpPost]
        public async Task DoorBell([FromBody] DoorBellModel package)
        {
            var delivery = await context.Delivery
                .Include(d => d.RecipientTokens)
                .FirstOrDefaultAsync(d => d.PackageId == package.PackageId);

            if (delivery == null)
            {
                return;
            }

            var token = await context.FcmToken.FirstOrDefaultAsync(t => t.Token == package.ResponseFirebaseToken)
                        ?? new FcmToken
                        {
                            Token = package.ResponseFirebaseToken,
                            UserId = await currentUser.CurrentUserId()
                        };

            delivery.CourierToken = token;
            await context.SaveChangesAsync();

            await firebase.SendMultiCastNotification(
                delivery.RecipientTokens.Select(t => t.Token),
                new Dictionary<string, string>
                {
                    { "MessageType", nameof(DoorBell) },
                    { nameof(DoorBellModel.PackageId), package.PackageId }
                });
        }

        [HttpPost]
        public async Task DoorBellResponse([FromBody] DoorBellResponseModel package)
        {
            var delivery = await context.Delivery
                .Include(d => d.CourierToken)
                .FirstOrDefaultAsync(d => d.PackageId == package.PackageId);

            if (delivery?.CourierToken == null)
            {
                return;
            }

            await firebase.SendNotification(
                delivery.CourierToken.Token,
                new Dictionary<string, string>
                {
                    { "MessageType", nameof(DoorBellResponse) },
                    { nameof(DoorBellModel.PackageId), package.PackageId },
                    { nameof(DoorBellResponseModel.IsAvailable), package.IsAvailable.ToString() }
                });
        }

        [HttpPost]
        public async Task DeliveryCompleted([FromBody] DeliveryCompletedModel package)
        {
            var delivery = await context.Delivery
                .FirstOrDefaultAsync(d => d.PackageId == package.PackageId);

            if (delivery == null)
            {
                return;
            }

            delivery.State = package.Success ? DeliveryState.DeliverySuccess : DeliveryState.DeliveryFailed;

            await context.SaveChangesAsync();
        }
    }
}