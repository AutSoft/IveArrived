using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using IveArrived.Entities.ApplicationUser;
using IveArrived.Models;
using IveArrived.Services.File;
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
        private readonly UserManager<ApplicationUser> userManager;
        private readonly IFileService fileService;

        public AccountController(SignInManager<ApplicationUser> signInManager, 
            UserManager<ApplicationUser> userManager,
            IFileService fileService)
        {
            this.signInManager = signInManager;
            this.userManager = userManager;
            this.fileService = fileService;
        }

        [HttpPost]
        public Task Login(LoginModel loginModel)
        {
            return signInManager.PasswordSignInAsync(loginModel.UserName, loginModel.Password, false, false);
        }

        [HttpPost]
        public async Task Register([FromForm] RegistrationModel model)
        {
            string logoUrl = null;

            if (model.Logo != null)
            {
                logoUrl = await fileService.Publish(model.Logo.OpenReadStream(), 
                    Path.GetExtension(model.Logo.FileName));
            }
            string flierUrl = null;

            if (model.Logo != null)
            {
                flierUrl = await fileService.Publish(model.Flier.OpenReadStream(),
                    Path.GetExtension(model.Flier.FileName));
            }

            var reguser = new ApplicationUser
            {
                Email = model.Email,
                UserName = model.UserName,
                DisplayName = model.DisplayName,
                ContactName = model.ContactName,
                Address = model.Address,
                City = model.City,
                ZipCode = model.ZipCode,
                Country = model.Country,
                LogoUrl = logoUrl,
                FlierUrl = flierUrl
            };

            var result = await userManager.CreateAsync(reguser, model.Password);

            await userManager.AddToRoleAsync(reguser, model.Role);


        }
    }
}