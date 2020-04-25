using Microsoft.AspNetCore.Identity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace IveArrived.Entities.ApplicationUser
{
    public class ApplicationUser : IdentityUser<int>
    {
        public virtual ICollection<ApplicationUserRole> UserRoles { get; set; }
    }
}
