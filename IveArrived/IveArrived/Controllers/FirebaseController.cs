using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using IveArrived.Entities;
using IveArrived.Services.CurrentUser;
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

        public FirebaseController(IFirebaseService firebaseService)
        {
            this.firebaseService = firebaseService;
        }
        [HttpPost]
        public async Task AddFirebaseTokenToUser([FromBody] string token)
        {

            await firebaseService.AddFirebaseToken(token);

        }

        [HttpGet]
        public async Task SendToEveryone([FromQuery]string msg)
        {
            await firebaseService.SendAll(new Dictionary<string, string>
            {
                {nameof(msg), msg}
            });
        }
    }
}