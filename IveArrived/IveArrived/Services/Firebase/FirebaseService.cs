using FcmSharp;
using FcmSharp.Requests;
using FcmSharp.Settings;
using IveArrived.Data;
using IveArrived.Entities;
using IveArrived.Services.CurrentUser;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

namespace IveArrived.Services.Firebase
{
    public class FirebaseService : IFirebaseService
    {
        private readonly ApplicationDbContext dbContext;
        private readonly ICurrentUserService currentUserService;
        private readonly FcmClient client;

        public FirebaseService(ApplicationDbContext dbContext, ICurrentUserService currentUserService)
        {
            this.dbContext = dbContext;
            this.currentUserService = currentUserService;
            //var settings = FileBasedFcmClientSettings.CreateFromFile(Path.Combine(options.Value.CredentialsPath, options.Value.CredentialsFile));
            //client = new FcmClient(settings, new FcmHttpClient(settings));

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
            var message = new FcmMessage()
            {
                ValidateOnly = false,
                Message = new Message
                {
                    Token = token,
                    Data = data,
                },
            };
            await client.SendAsync(message);
        }
    }
}
