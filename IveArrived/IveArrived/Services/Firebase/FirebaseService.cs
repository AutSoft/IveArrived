using IveArrived.Data;
using IveArrived.Entities;
using IveArrived.Services.CurrentUser;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using FirebaseAdmin;
using FirebaseAdmin.Messaging;
using IveArrived.Configuration;
using Microsoft.CodeAnalysis.Options;
using Microsoft.Extensions.Options;

namespace IveArrived.Services.Firebase
{
    public class FirebaseService : IFirebaseService
    {
        private readonly ApplicationDbContext dbContext;
        private readonly ICurrentUserService currentUserService;

        public FirebaseService(ApplicationDbContext dbContext, ICurrentUserService currentUserService)
        {
            this.dbContext = dbContext;
            this.currentUserService = currentUserService;
        }
        public async Task AddFirebaseToken(FcmToken fcmToken)
        {
            var prevToken = await dbContext.FcmToken.SingleOrDefaultAsync(t => t.Token == fcmToken.Token);

            if (prevToken == null)
            {
                var t = new FcmToken
                {
                    ProfileId = await currentUserService.CurrentUserId(),
                    Token = fcmToken.Token
                };

                dbContext.FcmToken.Add(t);
            }

            await dbContext.SaveChangesAsync();
        }

        public async Task SendNotification(string token, Dictionary<string, string> data)
        {
            var message = new Message
            {
                Token = token,
                Data = data,
            };
            await FirebaseMessaging.DefaultInstance.SendAsync(message);
        }

        public async Task SendMultiCastNotification(IEnumerable<string> tokens, Dictionary<string, string> data)
        {
            var message = new MulticastMessage
            {
                Tokens = tokens.ToList(),
                Data = data,
            };
            await FirebaseMessaging.DefaultInstance.SendMulticastAsync(message);
        }
    }
}
