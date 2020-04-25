using Microsoft.AspNetCore.Identity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace IveArrived.Entities.ApplicationUser
{
    public class ApplicationRole : IdentityRole<int>
    {
        public ApplicationRole() : base()
        {

        }

        public ApplicationRole(string roleName)
        {
            Name = roleName;
        }
    }
}
