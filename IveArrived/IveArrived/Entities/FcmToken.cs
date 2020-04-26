using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace IveArrived.Entities
{
    public class FcmToken
    {
        public FcmToken()
        {
            Deliveries = new HashSet<FcmTokenToDelivery>();
        }
        [Key]
        public int Id { get; set; }
        public string Token { get; set; }
        public int UserId { get; set; }
        public virtual ICollection<FcmTokenToDelivery> Deliveries { get; set; }
    }
}
