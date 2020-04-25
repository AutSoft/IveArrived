using IveArrived.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace IveArrived.Services.Firebase
{
    public interface IFirebaseService
    {
        Task AddFirebaseToken(string token);
        Task SendMultiCastNotification(IEnumerable<string> tokens, Dictionary<string, string> data);
        Task SendNotification(string token, Dictionary<string, string> data);
        Task SendAll(Dictionary<string, string> data);
    }
}
