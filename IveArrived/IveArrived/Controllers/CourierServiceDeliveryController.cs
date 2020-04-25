using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using IveArrived.Data;
using IveArrived.Entities;
using IveArrived.Mapper;
using IveArrived.Models;
using IveArrived.Services.CurrentUser;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace IveArrived.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class CourierServiceDeliveryController : ControllerBase
    {
        private readonly ICurrentUserService currentUser;
        private readonly ApplicationDbContext context;

        public CourierServiceDeliveryController(ICurrentUserService currentUser,
            ApplicationDbContext context)
        {
            this.currentUser = currentUser;
            this.context = context;
        }

        [HttpGet]
        public async Task<List<DeliveryModel>> ListDeliveries()
        {
            int currentUserId = await currentUser.CurrentUserId();
            return await context.Delivery
                .Include(d => d.CourierService)
                .Include(d => d.Courier)
                .Where(d => d.CourierService.Id == currentUserId)
                .Select(d => d.ToDto())
                .ToListAsync();
        }
        [HttpPost]
        public async Task ChangeDeliveryState([FromBody] DeliveryStateChangeModel package)
        {
            var delivery = await context.Delivery
                .FirstOrDefaultAsync(d => d.Id == package.DeliveryId);

            if (delivery == null)
            {
                return;
            }

            delivery.State = package.NewState;

            await context.SaveChangesAsync();
        }

        [HttpPost]
        public async Task ChangeDeliveryCourier([FromBody] DeliveryCourierChangeModel package)
        {
            var delivery = await context.Delivery
                .FirstOrDefaultAsync(d => d.Id == package.DeliveryId);

            if (delivery == null)
            {
                return;
            }

            delivery.Courier = await context.Users
                .FirstOrDefaultAsync(u => u.Id == package.CourierId);

            await context.SaveChangesAsync();
        }

        [HttpPost]
        public async Task<DeliveryModel> AddOrUpdateDelivery([FromBody] AddOrEditDeliveryModel dm)
        {
            var currentUserId = await currentUser.CurrentUserId();
            var delivery = await context.Delivery
                .FirstOrDefaultAsync(d => d.Id == dm.Id);

            if (delivery == null)
            {
                delivery = new Delivery
                {
                    Address = dm.Address,
                    Courier = await context.Users.FirstOrDefaultAsync(u => u.Id == dm.CourierId),
                    CourierService = await context.Users.FirstOrDefaultAsync(u => u.Id == currentUserId),
                    Description = dm.Description,
                    EstimatedDeliveryEnd = dm.EstimatedDeliveryEnd,
                    EstimatedDeliveryStart = dm.EstimatedDeliveryStart,
                    PackageId = Convert.ToBase64String(Guid.NewGuid().ToByteArray()),
                    PaymentInfo = dm.PaymentInfo,
                    RecipientEmailAddress = dm.RecipientEmailAddress,
                    RecipientName = dm.RecipientName,
                    RecipientPhoneNumber = dm.RecipientPhoneNumber,
                    SenderEmailAddress = dm.SenderEmailAddress,
                    SenderName = dm.SenderName,
                    SenderPhoneNumber = dm.SenderPhoneNumber,
                    State = dm.State
                };
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
                delivery.SenderEmailAddress = dm.SenderEmailAddress;
                delivery.SenderName = dm.SenderName;
                delivery.SenderPhoneNumber = dm.SenderPhoneNumber;
                delivery.State = dm.State;
            }

            await context.SaveChangesAsync();

            return delivery.ToDto();
        }
    }
}