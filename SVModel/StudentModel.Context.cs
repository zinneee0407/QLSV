﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace SVModel
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class BaiTH5Entities : DbContext
    {
        public BaiTH5Entities()
            : base("name=BaiTH5Entities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<sysdiagram> sysdiagrams { get; set; }
        public virtual DbSet<tbl_chuyennganh> tbl_chuyennganh { get; set; }
        public virtual DbSet<tbl_doan> tbl_doan { get; set; }
        public virtual DbSet<tbl_giangvien> tbl_giangvien { get; set; }
        public virtual DbSet<tbl_khoahoc> tbl_khoahoc { get; set; }
        public virtual DbSet<tbl_linhvuc> tbl_linhvuc { get; set; }
        public virtual DbSet<tbl_sinhvien> tbl_sinhvien { get; set; }
    }
}
