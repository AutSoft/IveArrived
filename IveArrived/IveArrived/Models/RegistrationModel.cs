using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;

namespace IveArrived.Models
{
    public class RegistrationModel
    {
        public string Role { get; set; }
        public string UserName { get; set; }
        public string DisplayName { get; set; }
        public string ContactName { get; set; }
        public string Address { get; set; }
        public string City { get; set; }
        public string ZipCode { get; set; }
        public string Country { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public IFormFile Logo { get; set; }
        public List<IFormFile> Fliers { get; set; }
    }
}
