
using System.Data;

namespace DTB.Authentication
{
    public class Application : StandingDataItem, IApplication
    {
        #region Properties
        int IApplication.ID
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
        string IApplication.Name
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

        protected override string IDColumn => "appID";
        protected override string NameColumn => "appName";
        #endregion

        #region Constructors
        public Application()
        {

        }
        public Application(IDataReader oDataReader) : base(oDataReader)
        {
        }
        #endregion

        #region Methods
  
        #endregion
    }
}