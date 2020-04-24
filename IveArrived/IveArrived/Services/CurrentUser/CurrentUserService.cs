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
        private readonly UserManager<IdentityUser> userManager;

        public CurrentUserService(IHttpContextAccessor httpContext, UserManager<IdentityUser> userManager)
        {
            this.httpContext = httpContext;
            this.userManager = userManager;
        }

        public async Task<Guid> CurrentUserId()
        {
            return new Guid((await userManager.GetUserAsync(httpContext.HttpContext.User)).Id);
        }
    }
}
