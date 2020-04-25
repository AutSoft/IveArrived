using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using IveArrived.Data;
using IveArrived.Entities;
using IveArrived.Entities.ApplicationUser;
using IveArrived.Mapper;
using IveArrived.Models;
using IveArrived.Services.CurrentUser;
using IveArrived.Services.File;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace IveArrived.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class CourierController : ControllerBase
    {
        private readonly ICurrentUserService currentUser;
        private readonly ApplicationDbContext context;
        private readonly IFileService fileService;
        private readonly UserManager<ApplicationUser> userManager;

        public CourierController(ICurrentUserService currentUser,
            ApplicationDbContext context,
            IFileService fileService,
            UserManager<ApplicationUser> userManager)
        {
            this.currentUser = currentUser;
            this.context = context;
            this.fileService = fileService;
            this.userManager = userManager;
        }


        [HttpPost]
        public async Task<IActionResult> Register([FromForm] CourierRegistrationModel model)
        {
            string logoUrl = null;

            if (model.Logo != null)
            {
                logoUrl = await fileService.Publish(model.Logo.OpenReadStream(),
                    Path.GetExtension(model.Logo.FileName));
            }

            var reguser = new ApplicationUser
            {
                Email = model.Email,
                UserName = model.Email,
                DisplayName = model.DisplayName,
                LogoUrl = logoUrl,
                PhoneNumber = model.PhoneNumber,
                SecurityStamp = new Guid().ToString(),
                EmailConfirmed = true
            };

            var result = await userManager.CreateAsync(reguser, model.Password);

            if (result.Succeeded != true)
            {
                return BadRequest();
            }

            await userManager.AddToRoleAsync(reguser, Constatns.RoleNames.CURRIER);

            var currentUserId = await currentUser.CurrentUserId();

            context.CourierServiceToCourier.Add(new CourierServiceToCourier
            {
                Courier = reguser,
                CourierService = await context.Users.FirstOrDefaultAsync(u => u.Id == currentUserId)
            });
            await context.SaveChangesAsync();

            return Ok();
        }

        [HttpGet]
        public async Task<List<CourierModel>> MyCouriers()
        {
            var currentUserId = await currentUser.CurrentUserId();
            return await context.CourierServiceToCourier
                .Include(c => c.Courier)
                .Include(c => c.CourierService)
                .Where(c => c.CourierService.Id == currentUserId)
                .Select(c => c.Courier.ToCourierDto())
                .ToListAsync();
        }
    }
}