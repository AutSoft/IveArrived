using System;
using IveArrived.Entities;

namespace IveArrived.Models
{
    public class AddOrEditDeliveryModel
    {
        public int Id { get; set; }
        public string Description { get; set; }
        public string Address { get; set; }
        public string City { get; set; }
        public string ZipCode { get; set; }
        public string Country { get; set; }
        public DateTime? EstimatedDeliveryStart { get; set; }
        public DateTime? EstimatedDeliveryEnd { get; set; }
        public DeliveryState State { get; set; }
        public string RecipientName { get; set; }
        public string RecipientPhoneNumber { get; set; }
        public string RecipientEmailAddress { get; set; }
        public string PaymentInfo { get; set; }
        public int CourierId { get; set; }
    }
}