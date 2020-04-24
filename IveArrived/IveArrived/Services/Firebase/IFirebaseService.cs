using IveArrived.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace IveArrived.Services.Firebase
{
    public interface IFirebaseService
    {
        Task AddFirebaseToken(FcmToken fcmToken);
    }
}
