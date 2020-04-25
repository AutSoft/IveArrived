using IveArrived.Data;
using IveArrived.Services.CurrentUser;
using Microsoft.AspNetCore.Mvc;

namespace IveArrived.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class CourierController : ControllerBase
    {
        private readonly ICurrentUserService currentUser;
        private readonly ApplicationDbContext context;
        public CourierController(ICurrentUserService currentUser,
            ApplicationDbContext context)
        {
            this.currentUser = currentUser;
            this.context = context;
        }
    }
}