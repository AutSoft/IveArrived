using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace IveArrived.Entities
{
    public class FcmToken
    {
        public int Id { get; set; }
        public string Token { get; set; }
        public Guid ProfileId { get; set; }
    }
}
