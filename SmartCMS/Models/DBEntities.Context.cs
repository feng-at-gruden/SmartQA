﻿//------------------------------------------------------------------------------
// <auto-generated>
//    此代码是根据模板生成的。
//
//    手动更改此文件可能会导致应用程序中发生异常行为。
//    如果重新生成代码，则将覆盖对此文件的手动更改。
// </auto-generated>
//------------------------------------------------------------------------------

namespace SmartCMS.Models
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class SmartCMSEntities : DbContext
    {
        public SmartCMSEntities()
            : base("name=SmartCMSEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public DbSet<Article> Articles { get; set; }
        public DbSet<Category> Categories { get; set; }
        public DbSet<Configuration> Configurations { get; set; }
        public DbSet<Log> Logs { get; set; }
        public DbSet<UserRole> UserRoles { get; set; }
        public DbSet<User> Users { get; set; }
    }
}