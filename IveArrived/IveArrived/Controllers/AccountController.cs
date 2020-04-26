using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using IveArrived.Data;
using IveArrived.Entities.ApplicationUser;
using IveArrived.Mapper;
using IveArrived.Models;
using IveArrived.Services.CurrentUser;
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
        private readonly ICurrentUserService currentUserService;
        private readonly ApplicationDbContext context;

        public AccountController(SignInManager<ApplicationUser> signInManager,
            UserManager<ApplicationUser> userManager,
            IFileService fileService,
            ICurrentUserService currentUserService,
            ApplicationDbContext context)
        {
            this.signInManager = signInManager;
            this.userManager = userManager;
            this.fileService = fileService;
            this.currentUserService = currentUserService;
            this.context = context;
        }

        [HttpPost]
        public async Task Login(LoginModel loginModel)
        {
            var result = await signInManager.PasswordSignInAsync(loginModel.Email, loginModel.Password, false, false);
            if (result.Succeeded)
                return;
            else
            {
                throw new Exception("Invalid username or password");
            }
        }

        [HttpPost]
        public async Task<IActionResult> Logout()
        {
            await signInManager.SignOutAsync();

            return Ok();
        }

        [HttpPost]
        public async Task<IActionResult> Register([FromForm] RegistrationModel model)
        {
            string logoUrl = null;

            if (model.Logo != null)
            {
                logoUrl = await fileService.Publish(model.Logo.OpenReadStream(),
                    Path.GetExtension(model.Logo.FileName));
            }
            string flierUrl = null;

            if (model.Flier != null)
            {
                flierUrl = await fileService.Publish(model.Flier.OpenReadStream(),
                    Path.GetExtension(model.Flier.FileName));
            }

            var reguser = new ApplicationUser
            {
                Email = model.Email,
                UserName = model.Email,
                DisplayName = model.DisplayName,
                ContactName = model.ContactName,
                Address = model.Address,
                City = model.City,
                ZipCode = model.ZipCode,
                Country = model.Country,
                LogoUrl = logoUrl,
                FlierUrl = flierUrl,
                SecurityStamp = new Guid().ToString(),
                EmailConfirmed = true,
            };

            var result = await userManager.CreateAsync(reguser, model.Password);

            if (result.Succeeded != true)
            {
                return BadRequest();
            }

            await userManager.AddToRoleAsync(reguser, model.Role);

            return Ok();
        }

        [HttpPost]
        public async Task<IActionResult> UpdateSME([FromForm] EditProfileModel model)
        {
            string logoUrl = null;

            if (model.Logo != null)
            {
                logoUrl = await fileService.Publish(model.Logo.OpenReadStream(),
                    Path.GetExtension(model.Logo.FileName));
            }
            string flierUrl = null;

            if (model.Flier != null)
            {
                flierUrl = await fileService.Publish(model.Flier.OpenReadStream(),
                    Path.GetExtension(model.Flier.FileName));
            }

            var currentUser = await currentUserService.CurrentUserId();

            var sme = context.Users.FirstOrDefault(x => x.Id == currentUser);

            if (sme != null)
            {
                sme.Address = model.Address;
                sme.City = model.City;
                sme.DisplayName = model.DisplayName;
                sme.ContactName = model.ContactName;
                sme.ZipCode = model.ZipCode;
                sme.PhoneNumber = model.PhoneNumber;
                sme.LogoUrl = logoUrl ?? sme.LogoUrl;
                sme.FlierUrl = flierUrl ?? sme.FlierUrl;
            }

            await context.SaveChangesAsync();

            return Ok();
        }

        [HttpGet]
        public async Task<CourierServiceModel> Me()
        {
            return (await currentUserService.CurrentUser()).ToDto();
        }
    }
}