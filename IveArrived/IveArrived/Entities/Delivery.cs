﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace IveArrived.Entities
{
    public class Delivery
    {
        public Delivery()
        {
            RecipientTokens = new HashSet<FcmTokenToDelivery>();
        }

        [Key]
        public int Id { get; set; }
        public string Description { get; set; }
        public string Address { get; set; }
        public string City { get; set; }
        public string ZipCode { get; set; }
        public string Country { get; set; }
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
        public virtual FcmToken CourierToken { get; set; }
        public virtual ICollection<FcmTokenToDelivery> RecipientTokens { get; set; }
        public virtual ApplicationUser.ApplicationUser Courier { get; set; }
        public virtual ApplicationUser.ApplicationUser CourierService { get; set; }
    }
}