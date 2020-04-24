using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using IveArrived.Entities;
using IveArrived.Services.Firebase;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;

namespace IveArrived.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class FirebaseController : ControllerBase
    {
        private readonly IFirebaseService firebaseService;
        private readonly UserManager<IdentityUser> userManager;

        public FirebaseController(IFirebaseService firebaseService, UserManager<IdentityUser> userManager)
        {
            this.firebaseService = firebaseService;
            this.userManager = userManager;
        }
        public async Task AddFirebaseTokenToUser([FromBody] FcmToken data)
        {
            var user = await userManager.GetUserAsync(HttpContext.User);
            await firebaseService.AddFirebaseToken(data, new Guid(user.Id));

        }
    }
}