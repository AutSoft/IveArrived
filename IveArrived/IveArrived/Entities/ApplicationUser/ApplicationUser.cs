using Microsoft.AspNetCore.Identity;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace IveArrived.Entities.ApplicationUser
{
    public class ApplicationUser : IdentityUser<int>
    {
        public string Role { get; set; }
        public string DisplayName { get; set; }
        public string ContactName { get; set; }
        public string Address { get; set; }
        public string City { get; set; }
        public string ZipCode { get; set; }
        public string Country { get; set; }
        public string LogoUrl { get; set; }
        public string FlierUrl { get; set; }

        public virtual ICollection<ApplicationUserRole> UserRoles { get; set; }
    }
}
