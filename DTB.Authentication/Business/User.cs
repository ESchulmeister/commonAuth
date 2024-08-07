using System;
using System.Collections.Generic;
using System.Data;

namespace DTB.Authentication
{
    public class User : IUser
    {
        #region Properties

        public int ID { get; set; }
        public string Login { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Clock { get; set; }

        public string Email { get; set; }

        public bool IsActive { get; set; }

        public string  CreatedBy { get; set; }

        public DateTime CreatedDate { get; set; }

        public string ModifiedBy { get; set; }
        public DateTime ModifiedDate { get; set; }

        public List<IPermission> Permissions { get; set; }

        #endregion

        #region Constructors
        public User()
        {

        }

        public User(IDataReader oDataReader)
        {
            this.ID = oDataReader.ReadColumn("usrID", 0);
            this.Login = oDataReader.ReadColumn("usrLogin");
            this.FirstName = oDataReader.ReadColumn("usrFirstName");
            this.LastName = oDataReader.ReadColumn("usrLastName");
            this.Clock = oDataReader.ReadColumn("usrClock");
            this.Email = oDataReader.ReadColumn("usrEmail");
            this.IsActive = oDataReader.ReadColumn("usrActive",true);
            this.CreatedBy = oDataReader.ReadColumn("usrCreatedBy");
            this.CreatedDate = oDataReader.ReadColumn("usrCreatedDate", DateTime.Now);
            this.ModifiedBy = oDataReader.ReadColumn("usrModifiedBy");
            this.ModifiedDate = oDataReader.ReadColumn("usrModifiedDate", DateTime.Now);



        }
        #endregion
    }
}
