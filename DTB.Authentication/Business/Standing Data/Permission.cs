using System.Data;

namespace DTB.Authentication
{
    public class Permission: StandingDataItem, IPermission
    {
        #region Properties

        public string Metadata { get; set; }

       
        int IPermission.ID 
        { 
            get
            {
                return base.ID;
            }
            set
            {
                base.ID = value;
            }
        }
        string IPermission.Name
        {
            get
            {
                return base.Name;
            }
            set
            {
                base.Name = value;
            }
        }

        public IApplication Application { get; set; }
        public IAccessType AccessType { get; set; }

        protected override string IDColumn => "apID";
        protected override string NameColumn => "permName";

        #endregion

        #region Constructors

        public Permission()
        {

        }

        public Permission(IDataReader oDataReader) : base(oDataReader)
        {
        }

        #endregion

        #region Methods
        protected override void Load(IDataReader oDataReader)
        {
            base.Load(oDataReader);

            this.Metadata = oDataReader.ReadColumn("perMetadata");

            this.AccessType = new AccessType(oDataReader);
            this.Application = new Application(oDataReader);
        }

        #endregion

    }
}
