using System;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace IveArrived.Entities
{
    public class FcmToken
    {
        [Key]
        public int Id { get; set; }
        public string Token { get; set; }
        public int UserId { get; set; }
    }
}
