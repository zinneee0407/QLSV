//------------------------------------------------------------------------------
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
    using System.Collections.Generic;
    
    public partial class tbl_doan
    {
        public int Masv { get; set; }
        public string TenDA { get; set; }
        public Nullable<int> GVHD { get; set; }
        public Nullable<int> GVPB { get; set; }
        public Nullable<int> linhvuc { get; set; }
        public Nullable<double> Diem { get; set; }
        public Nullable<int> Namtn { get; set; }
    
        public virtual tbl_giangvien tbl_giangvien { get; set; }
        public virtual tbl_giangvien tbl_giangvien1 { get; set; }
        public virtual tbl_linhvuc tbl_linhvuc { get; set; }
    }
}
