using System;
using IveArrived.Entities;
using IveArrived.Entities.ApplicationUser;

namespace IveArrived.Models
{
    public class DeliveryModel
    {
        public int Id { get; set; }
        public string Description { get; set; }
        public string Address { get; set; }
        public DateTime? EstimatedDeliveryStart { get; set; }
        public DateTime? EstimatedDeliveryEnd { get; set; }
        public string PackageId { get; set; }
        public DeliveryState State { get; set; }
        public string SenderName { get; set; }
        public string SenderPhoneNumber { get; set; }
        public string SenderEmailAddress { get; set; }
        public string RecipientName { get; set; }
        public string RecipientPhoneNumber { get; set; }
        public string RecipientEmailAddress { get; set; }
        public string PaymentInfo { get; set; }
        public CourierModel Courier { get; set; }
        public CourierServiceModel CourierService { get; set; }
    }
}