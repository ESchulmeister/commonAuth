using System.Data;

namespace DTB.Authentication
{
    public abstract class StandingDataItem
    {
        #region Properties
        public int ID { get; protected set; }
        public string Name { get; protected set; }

        protected abstract string IDColumn { get; }
        protected abstract string NameColumn { get; }

        #endregion

        #region Constructors
        protected StandingDataItem()
        {

        }
        protected StandingDataItem(IDataReader oDataReader)
        {
            this.Load(oDataReader);
        }
        #endregion

        #region Methods
        protected virtual void Load(IDataReader oDataReader)
        {
            this.ID = oDataReader.ReadColumn(this.IDColumn, this.ID);
            this.Name = oDataReader.ReadColumn(this.NameColumn, this.Name);
        }
        public override string ToString()
        {
            return this.Name;
        }

        #endregion
    }
}
