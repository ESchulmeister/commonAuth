using System;
using System.Collections.Generic;

namespace DTB.Authentication
{
    public interface IUser
    {

        int ID { get; set; }
        string Login { get; set; }
        string FirstName { get; set; }
        string LastName { get; set; }
        string Clock { get; set; }
        string Email { get; set; }
        bool IsActive { get; set; }
        string CreatedBy { get; set; }         
        DateTime CreatedDate { get; set; }
        string ModifiedBy { get; set; }
        DateTime ModifiedDate { get; set; }

        List<IPermission> Permissions { get; set;  }
    }
}
