using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.Entity;
using System.Linq;
using System.Threading.Tasks;

namespace DTB.Authentication
{
    /// <summary>
    /// Base class for data objects
    /// </summary>
    internal class DataObject
    {
        #region Fields
        #endregion

        #region Properties
        public virtual string ConfigurationKey
        {
            get;
            protected set;
        }

        protected Database Database
        {
            get;
            set;
        }
        #endregion

        #region Constructors
        public DataObject(DbContext oDbContext)
        {
            this.Database = oDbContext.Database;
        }

        #endregion

        #region Methods


        protected virtual DataTable LoadDataTable(string sProcedure, ICollection<IDbDataParameter> aParameters = null)
        {
            DataTable oDataTable = new DataTable();
            try
            {
                using (IDataReader oDataReader = this.LoadDataReader(sProcedure, aParameters))
                {
                    oDataTable.Load(oDataReader);
                }
            }
            catch (Exception)
            {
                throw;
            }

            return oDataTable;

        }

        public IDataReader LoadDataReader(string sProcedure, ICollection<IDbDataParameter> aParameters = null)
        {
            var oDbCommand = this.CreateCommand(sProcedure, aParameters);
            this.Database.Connection.Open();

            IDataReader oDataReader = oDbCommand.ExecuteReader(CommandBehavior.CloseConnection);

            this.UpdateOutputParameters(aParameters, oDbCommand);

            return oDataReader;
        }

        public async Task<IDataReader> LoadDataReaderAsync(string sProcedure, ICollection<IDbDataParameter> aParameters = null)
        {
            var oDbCommand = this.CreateCommand(sProcedure, aParameters);
            await this.Database.Connection.OpenAsync();

            IDataReader oDataReader = await oDbCommand.ExecuteReaderAsync(CommandBehavior.CloseConnection);
            this.UpdateOutputParameters(aParameters, oDbCommand);

            return oDataReader;
        }

        protected DbCommand CreateCommand(string sProcedure, ICollection<IDbDataParameter> aParameters = null)
        {
            this.Database.Initialize(force: false);

            var oCommand = this.Database.Connection.CreateCommand();
            oCommand.CommandType = CommandType.StoredProcedure;
            oCommand.CommandText = sProcedure;

            this.AppendIDbDataParameters(oCommand, aParameters);

            return oCommand;
        }

        public void ExecuteScalar(string sProcedure, ICollection<IDbDataParameter> aParameters = null)
        {
            var oDbCommand = this.CreateCommand(sProcedure, aParameters);
            this.Database.Connection.Open();

            oDbCommand.ExecuteScalar();
            this.UpdateOutputParameters(aParameters, oDbCommand);
        }
        public async Task ExecuteScalarAsync(string sProcedure, ICollection<IDbDataParameter> aParameters = null)
        {
            var oDbCommand = this.CreateCommand(sProcedure, aParameters);
            await this.Database.Connection.OpenAsync();

            await oDbCommand.ExecuteScalarAsync();

            this.UpdateOutputParameters(aParameters, oDbCommand);
        }

        public void ExecuteNonQuery(string sProcedure, ICollection<IDbDataParameter> aParameters = null)
        {
            var oDbCommand = this.CreateCommand(sProcedure, aParameters);
            this.Database.Connection.Open();

            oDbCommand.ExecuteNonQuery();
            this.UpdateOutputParameters(aParameters, oDbCommand);
        }

        public async Task ExecuteNonQueryAsync(string sProcedure, ICollection<IDbDataParameter> aParameters = null)
        {
            var oDbCommand = this.CreateCommand(sProcedure, aParameters);
            await this.Database.Connection.OpenAsync();

            await oDbCommand.ExecuteNonQueryAsync();

            this.UpdateOutputParameters(aParameters, oDbCommand);
        }

        protected void UpdateOutputParameters(ICollection<IDbDataParameter> aParameters, DbCommand oDbCommand)
        {
            if(aParameters == null)
            {
                return;
            }
            
            string sErrorMessage = String.Empty;

            foreach (IDbDataParameter oIDbDataParameter in oDbCommand.Parameters)
            {
                if (!(oIDbDataParameter.Direction != ParameterDirection.Output || oIDbDataParameter.Direction != ParameterDirection.Input))
                {
                    continue;
                }

                var oParameter = aParameters.FirstOrDefault(oThisParameter => String.Compare(oThisParameter.ParameterName, oIDbDataParameter.ParameterName, false) == 0);
                if (oParameter == null)
                {
                    continue;
                }
            }
        }

        protected void AppendIDbDataParameters(DbCommand oDbCommand, ICollection<IDbDataParameter> aParameters)
        {
            if (aParameters == null)
            {
                return;
            }

            foreach (var oParameter in aParameters)
            {
                this.HandleWhitespace(oParameter);

                oDbCommand.Parameters.Add(oParameter);
            }
        }

        protected void HandleWhitespace(IDbDataParameter oParameter)
        {
            if (oParameter.Value == null)
            {
                oParameter.Value = System.DBNull.Value;
                return;
            }

            if (oParameter.DbType != DbType.String)
            {
                return;
            }

            if (String.IsNullOrWhiteSpace(((string)oParameter.Value)))
            {
                oParameter.Value = System.DBNull.Value;
            }
        }

        #endregion

    }
}
