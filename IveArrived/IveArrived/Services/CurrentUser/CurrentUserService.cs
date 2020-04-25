using IveArrived.Entities.ApplicationUser;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace IveArrived.Services.CurrentUser
{
    public class CurrentUserService : ICurrentUserService
    {
        private readonly IHttpContextAccessor httpContext;
        private readonly UserManager<ApplicationUser> userManager;

        public CurrentUserService(IHttpContextAccessor httpContext, UserManager<ApplicationUser> userManager)
        {
            this.httpContext = httpContext;
            this.userManager = userManager;
        }

        public async Task<int> CurrentUserId()
        {
            if (await IsSignedIn())
            {
                return (await userManager.GetUserAsync(httpContext.HttpContext.User)).Id;
            }

            return 0;
        }

        public Task<bool> IsSignedIn()
        {
            return Task.FromResult(httpContext.HttpContext.User.Identity.IsAuthenticated);
        }
    }
}
