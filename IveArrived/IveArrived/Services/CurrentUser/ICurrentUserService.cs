using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using IveArrived.Entities.ApplicationUser;

namespace IveArrived.Services.CurrentUser
{
    public interface ICurrentUserService
    {
        Task<int> CurrentUserId();
        Task<bool> IsSignedIn();
        Task<ApplicationUser> CurrentUser();
    }
}
