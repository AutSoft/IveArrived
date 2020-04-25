using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace IveArrived.Entities
{
    public class FcmTokenToDelivery
    {
        [Key] 
        public int Id { get; set; }

        public virtual FcmToken Token { get; set; }
        public virtual Delivery Delivery { get; set; }
    }
}