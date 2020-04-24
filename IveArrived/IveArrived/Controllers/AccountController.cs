using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using IveArrived.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;

namespace IveArrived.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AccountController : ControllerBase
    {
        private readonly SignInManager<IdentityUser> signInManager;

        public AccountController(SignInManager<IdentityUser> signInManager)
        {
            this.signInManager = signInManager;
        }
        public Task Login(LoginModel loginModel)
        {
            return signInManager.PasswordSignInAsync(loginModel.UserName, loginModel.Password, false, false);
        }
    }
}