using System;
using System.Collections.Generic;
using System.Text;
using IveArrived.Entities;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace IveArrived.Data
{
    public class ApplicationDbContext : IdentityDbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
            : base(options)
        {
        }

        public DbSet<Profile> Profile { get; set; }
        public DbSet<FcmToken> FcmToken { get; set; }

    }
}
