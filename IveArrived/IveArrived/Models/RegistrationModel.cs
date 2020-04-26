using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace IveArrived.Models
{
    public class RegistrationModel
    {
        public string Role { get; set; }
        public string DisplayName { get; set; }
        public string ContactName { get; set; }
        public string Address { get; set; }
        public string City { get; set; }
        public string ZipCode { get; set; }
        public string Country { get; set; }
        public string Email { get; set; }
        public string PhoneNumber { get; set; }
        public string Password { get; set; }
        [FromForm]
        public IFormFile Logo { get; set; }
        [FromForm]
        public IFormFile Flier { get; set; }
    }
}
