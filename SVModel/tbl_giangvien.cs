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
    
    public partial class tbl_giangvien
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public tbl_giangvien()
        {
            this.tbl_doan = new HashSet<tbl_doan>();
            this.tbl_doan1 = new HashSet<tbl_doan>();
        }
    
        public int Magv { get; set; }
        public string Tengv { get; set; }
        public Nullable<System.DateTime> Namsinh { get; set; }
        public Nullable<bool> Gioitinh { get; set; }
        public string Hocvi { get; set; }
        public string Email { get; set; }
        public string Dienthoai { get; set; }
        public string Diachi { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tbl_doan> tbl_doan { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tbl_doan> tbl_doan1 { get; set; }
    }
}
