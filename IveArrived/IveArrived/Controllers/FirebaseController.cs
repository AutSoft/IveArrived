using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using IveArrived.Entities;
using IveArrived.Entities.ApplicationUser;
using IveArrived.Services.Firebase;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;

namespace IveArrived.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class FirebaseController : ControllerBase
    {
        private readonly IFirebaseService firebaseService;
        private readonly UserManager<ApplicationUser> userManager;

        public FirebaseController(IFirebaseService firebaseService, UserManager<ApplicationUser> userManager)
        {
            this.firebaseService = firebaseService;
            this.userManager = userManager;
        }

        [HttpPost]
        public async Task AddFirebaseTokenToUser([FromBody] FcmToken data)
        {
            await firebaseService.AddFirebaseToken(data);

        }
    }
}