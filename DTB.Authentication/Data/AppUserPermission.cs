//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace DTB.Authentication.Data
{
    using System;
    using System.Collections.Generic;
    
    public partial class AppUserPermission
    {
        public int perID { get; set; }
        public Nullable<int> apuID { get; set; }
  //      public int apID { get; set; }
        public Nullable<int> actID { get; set; }
        public string perMetadata { get; set; }
        public bool perActive { get; set; }
        public string perCreatedBy { get; set; }
        public Nullable<System.DateTime> perCreatedDate { get; set; }
        public string perModifiedBy { get; set; }
        public System.DateTime perModifiedDate { get; set; }
    
        public virtual AppPermission AppPermission { get; set; }
    }
}
