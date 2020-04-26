using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.Encodings.Web;
using System.Threading.Tasks;
using System.Web;
using IveArrived.Data;
using IveArrived.Entities;
using IveArrived.Mapper;
using IveArrived.Models;
using IveArrived.Services.CurrentUser;
using IveArrived.Services.Firebase;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using NSwag;

namespace IveArrived.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class CourierServiceDeliveryController : ControllerBase
    {
        private readonly ICurrentUserService currentUserService;
        private readonly ApplicationDbContext context;
        private readonly IFirebaseService firebase;

        public CourierServiceDeliveryController(ICurrentUserService currentUserService,
            ApplicationDbContext context,
            IFirebaseService firebase)
        {
            this.currentUserService = currentUserService;
            this.context = context;
            this.firebase = firebase;
        }

        [HttpGet]
        public async Task<List<DeliveryModel>> ListDeliveries()
        {
            int currentUserId = await currentUserService.CurrentUserId();
            return await context.Delivery
                .Include(d => d.CourierService)
                .Include(d => d.Courier)
                .Where(d => d.CourierService.Id == currentUserId)
                .Select(d => d.ToDto())
                .ToListAsync();
        }
        [HttpPost]
        public async Task ChangeDeliveryState([FromBody] DeliveryStateChangeModel dto)
        {
            var delivery = await context.Delivery
                .Include(d => d.RecipientTokens)
                    .ThenInclude(dt => dt.Token)
                .FirstOrDefaultAsync(d => d.Id == dto.DeliveryId);

            if (delivery == null)
            {
                return;
            }

            delivery.State = dto.NewState;

            await context.SaveChangesAsync();

            await firebase.SendMultiCastNotification(
                delivery.RecipientTokens.Select(t => t.Token.Token),
                new Dictionary<string, string>
                {
                    { "MessageType", nameof(ChangeDeliveryState) },
                    { nameof(DeliveryModel.PackageId), delivery.PackageId },
                    { nameof(DeliveryModel.State), delivery.State.ToString() }
                });
        }

        [HttpPost]
        public async Task ChangeDeliveryCourier([FromBody] DeliveryCourierChangeModel dto)
        {
            var delivery = await context.Delivery
                .Include(d => d.RecipientTokens)
                .ThenInclude(dt => dt.Token)
                .FirstOrDefaultAsync(d => d.Id == dto.DeliveryId);

            if (delivery == null)
            {
                return;
            }

            delivery.Courier = await context.Users
                .FirstOrDefaultAsync(u => u.Id == dto.CourierId);

            await context.SaveChangesAsync();

            await firebase.SendMultiCastNotification(
                delivery.RecipientTokens.Select(t => t.Token.Token),
                new Dictionary<string, string>
                {
                    { "MessageType", nameof(ChangeDeliveryCourier) },
                    { nameof(DeliveryModel.PackageId), delivery.PackageId },
                    { nameof(DeliveryModel.Courier.DisplayName), delivery.Courier.DisplayName }
                });
        }

        [HttpPost]
        public async Task<DeliveryModel> AddOrUpdateDelivery([FromBody] AddOrEditDeliveryModel dm)
        {
            var currentUser = await currentUserService.CurrentUser();
            var delivery = await context.Delivery
                .FirstOrDefaultAsync(d => d.Id == dm.Id);

            if (delivery == null)
            {
                delivery = new Delivery
                {
                    Address = dm.Address,
                    Courier = await context.Users.FirstOrDefaultAsync(u => u.Id == dm.CourierId),
                    CourierService = await context.Users.FirstOrDefaultAsync(u => u.Id == currentUser.Id),
                    Description = dm.Description,
                    EstimatedDeliveryEnd = dm.EstimatedDeliveryEnd,
                    EstimatedDeliveryStart = dm.EstimatedDeliveryStart,
                    PackageId = Convert.ToBase64String((Guid.NewGuid().ToByteArray())).Replace('/', 'S'),
                    PaymentInfo = dm.PaymentInfo,
                    RecipientEmailAddress = dm.RecipientEmailAddress,
                    RecipientName = dm.RecipientName,
                    RecipientPhoneNumber = dm.RecipientPhoneNumber,
                    SenderEmailAddress = currentUser.Email,
                    SenderName = currentUser.DisplayName,
                    SenderPhoneNumber = currentUser.PhoneNumber,
                    State = dm.State
                };
                context.Delivery.Add(delivery);
            }
            else
            {
                delivery.Address = dm.Address;
                delivery.Courier = await context.Users.FirstOrDefaultAsync(u => u.Id == dm.CourierId);
                delivery.Description = dm.Description;
                delivery.EstimatedDeliveryEnd = dm.EstimatedDeliveryEnd;
                delivery.EstimatedDeliveryStart = dm.EstimatedDeliveryStart;
                delivery.PaymentInfo = dm.PaymentInfo;
                delivery.RecipientEmailAddress = dm.RecipientEmailAddress;
                delivery.RecipientName = dm.RecipientName;
                delivery.RecipientPhoneNumber = dm.RecipientPhoneNumber;
                delivery.State = dm.State;
            }

            await context.SaveChangesAsync();

            return delivery.ToDto();
        }
    }
}