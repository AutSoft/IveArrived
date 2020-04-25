using System;
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
        private readonly IHttpContextAccessor httpContext;
        private readonly IFirebaseService firebase;

        public DeliveryController(ICurrentUserService currentUser,
            ApplicationDbContext context,
            IHttpContextAccessor httpContext,
            IFirebaseService firebase)
        {
            this.currentUser = currentUser;
            this.context = context;
            this.httpContext = httpContext;
            this.firebase = firebase;
        }

        [HttpGet]
        public async Task<List<DeliveryModel>> ListForCourierService()
        {
            int currentUserId = await currentUser.CurrentUserId();
            return await context.Delivery
                .Include(d => d.CourierService)
                .Include(d => d.Courier)
                .Where(d => d.CourierService.Id == currentUserId)
                .Select(d => d.ToDto())
                .ToListAsync();
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
                .Where(d => d.PackageId == subscription.PackageId)
                .FirstOrDefaultAsync();

            if (delivery == null)
            {
                return null;
            }

            var token = await context.FcmToken.FirstOrDefaultAsync() ?? new FcmToken
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
                .Where(d => d.PackageId == package.PackageId)
                .FirstOrDefaultAsync();

            if (delivery == null)
            {
                return;
            }

            await firebase.SendMultiCastNotification(
                delivery.RecipientTokens.Select(t => t.Token),
                new Dictionary<string, string>
                {
                    { nameof(DoorBellModel.PackageId), package.PackageId }
                });
        }

        [HttpPost]
        public async Task DoorBellResponse([FromBody] DoorBellResponseModel package)
        {
            var delivery = await context.Delivery
                .Include(d => d.RecipientTokens)
                .Where(d => d.PackageId == package.PackageId)
                .FirstOrDefaultAsync();

            if (delivery == null)
            {
                return;
            }

            await firebase.SendMultiCastNotification(
                delivery.RecipientTokens.Select(t => t.Token),
                new Dictionary<string, string>
                {
                    { nameof(DoorBellModel.PackageId), package.PackageId }
                });
        }

        [HttpPost]
        public Task DeliveryCompleted([FromBody] DeliveryCompletedModel package)
        {
            throw new NotImplementedException();
        }
    }
}