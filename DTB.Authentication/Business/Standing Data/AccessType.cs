using System.Data;

namespace DTB.Authentication
{
    public class AccessType : StandingDataItem, IAccessType
    {
        #region Enums
        public enum Level
        {
            NotSet = 0,
            Read = 1,
            Write = 2,
            Delete = 4,
            Full = 7
        }
        #endregion

        #region Properties
        int IAccessType.ID
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
        string IAccessType.Name
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

        protected override string IDColumn => "actID";
        protected override string NameColumn => "actName";
        #endregion

        #region Constructors
        public AccessType()
        {

        }
        public AccessType(IDataReader oDataReader) : base(oDataReader)
        {
        }
        #endregion

        #region Methods
        public bool Equals(Level eLevel)
        {
            return ((int)eLevel == this.ID);
        }
        #endregion
    }
}