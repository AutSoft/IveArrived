using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace IveArrived.Models
{
    public class CourierRegistrationModel
    {
        public string DisplayName { get; set; }
        public string Email { get; set; }
        public string PhoneNumber { get; set; }
        public string Password { get; set; }
        [FromForm]
        public IFormFile Logo { get; set; }
    }
}