using FcmSharp;
using FcmSharp.Requests;
using FcmSharp.Settings;
using IveArrived.Data;
using IveArrived.Entities;
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
        private readonly FcmClient client;

        public FirebaseService(ApplicationDbContext dbContext)
        {
            this.dbContext = dbContext;
            //var settings = FileBasedFcmClientSettings.CreateFromFile(Path.Combine(options.Value.CredentialsPath, options.Value.CredentialsFile));
            //client = new FcmClient(settings, new FcmHttpClient(settings));

        }
        public async Task AddFirebaseToken(FcmToken fcmToken, Guid userId)
        {
            var prevToken = await dbContext.FcmToken.SingleOrDefaultAsync(t => t.Token == fcmToken.Token);

            if (prevToken == null)
            {
                var t = new FcmToken
                {
                    ProfileId = userId,
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
