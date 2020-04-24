using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace IveArrived.Entities
{
    public class Profile
    {
        [Key]
        public Guid UserId { get; set; }
    }
}
