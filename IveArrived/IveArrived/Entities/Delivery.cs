using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace IveArrived.Entities
{
    public class Delivery
    {
        public Delivery()
        {
            RecipientTokens = new HashSet<FcmToken>();
        }

        [Key]
        public int Id { get; set; }
        public string Description { get; set; }
        public string Address { get; set; }
        public DateTime? EstimatedDeliveryStart { get; set; }
        public DateTime? EstimatedDeliveryEnd { get; set; }
        public Guid PackageId { get; set; }
        public DeliveryState State { get; set; }
        public string SenderName { get; set; }
        public string SenderPhoneNumber { get; set; }
        public string SenderEmailAddress { get; set; }
        public string RecipientName { get; set; }
        public string RecipientPhoneNumber { get; set; }
        public string RecipientEmailAddress { get; set; }
        public virtual ICollection<FcmToken> RecipientTokens { get; set; }
        public virtual ApplicationUser.ApplicationUser Courier { get; set; }
        public virtual ApplicationUser.ApplicationUser CourierService { get; set; }
    }

    public enum DeliveryState
    {
        PackageAssembly = 0,
        PackageReady = 1,
        DeliveryInProgress = 2,
        DeliverySuccess = 3,
        DeliveryFailed = 4
    }
}