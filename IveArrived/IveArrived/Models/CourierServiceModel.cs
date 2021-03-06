﻿using System;
using FirebaseAdmin.Auth;

namespace IveArrived.Models
{
    public class CourierServiceModel
    {
        public int Id { get; set; }
        public string Role { get; set; }
        public string DisplayName { get; set; }
        public string ContactName { get; set; }
        public string Address { get; set; }
        public string City { get; set; }
        public string ZipCode { get; set; }
        public string Country { get; set; }
        public string Email { get; set; }
        public string PhoneNumber { get; set; }
        public string LogoUrl { get; set; }
        public string FlierUrl { get; set; }
    }
}