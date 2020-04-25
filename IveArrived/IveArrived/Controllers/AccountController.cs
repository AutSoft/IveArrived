using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using IveArrived.Entities.ApplicationUser;
using IveArrived.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;

namespace IveArrived.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class AccountController : ControllerBase
    {
        private readonly SignInManager<ApplicationUser> signInManager;
        private readonly SignInManager<ApplicationUser> signInManager;
        private readonly UserManager<ApplicationUser> userManager;
        private readonly RoleManager<ApplicationUser> roleManager;

        public AccountController(SignInManager<ApplicationUser> signInManager)
        public AccountController(SignInManager<ApplicationUser> signInManager, UserManager<ApplicationUser> userManager
            , RoleManager<ApplicationUser> roleManager)
        {
            this.signInManager = signInManager;
            this.userManager = userManager;
            this.roleManager = roleManager;

        }

        [HttpPost]
        public Task Login(LoginModel loginModel)
        {
            return signInManager.PasswordSignInAsync(loginModel.UserName, loginModel.Password, false, false);
        }

        public async Task Register(RegistrationModel model)
        {

            var reguser = new ApplicationUser
            {
                Email = model.Email,
                UserName = model.UserName,
            };

            var result = await userManager.CreateAsync(reguser, model.Password);


        }
    }
}