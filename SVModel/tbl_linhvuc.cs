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
    
    public partial class tbl_linhvuc
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public tbl_linhvuc()
        {
            this.tbl_doan = new HashSet<tbl_doan>();
        }
    
        public int Malv { get; set; }
        public string Tenlv { get; set; }
        public string ghichu { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tbl_doan> tbl_doan { get; set; }
    }
}
