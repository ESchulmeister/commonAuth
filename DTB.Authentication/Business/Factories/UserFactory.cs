using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Threading.Tasks;
using DTB.Authentication.Data;

namespace DTB.Authentication
{
    internal class UserFactory
    {
        #region Methods
        public  IUser Authenticate(int iApplicationID, string sUserName, string sPassword)
        {
            IUser oUser = null;

            var lstParameters = this.PrepareParameters(iApplicationID, sUserName, sPassword);

            using (var oUserDBEntities = new UserDBEntities())
            {
                var oDataObject = new DataObject(oUserDBEntities);

                try
                {
                    using (var oDbDataReader = oDataObject.LoadDataReader("dbo.usp_Authenticate", lstParameters))
                    {
                        oUser = this.InstantiateUser(oDbDataReader);
                    }
                }
                catch(SqlException oSqlException)
                {
                    this.HandleSqlError(oSqlException);
                }
                finally
                {
                    oUserDBEntities.Database.Connection.Close();
                }

            }

            return oUser;
        }

        public async Task<IUser> AuthenticateAsync(int iApplicationID, string sUserName, string sPassword)
        {
            IUser oUser = null;

            var lstParameters = this.PrepareParameters(iApplicationID, sUserName, sPassword);

            using (var oUserDBEntities = new UserDBEntities())
            {
                var oDataObject = new DataObject(oUserDBEntities);

                try
                {
                    using (var oDbDataReader = await oDataObject.LoadDataReaderAsync("dbo.usp_Authenticate", lstParameters))
                    {
                        oUser = this.InstantiateUser(oDbDataReader);
                    }
                }
                catch (SqlException oSqlException)
                {
                    this.HandleSqlError(oSqlException);
                }
                finally
                {
                    oUserDBEntities.Database.Connection.Close();
                }

            }

            return oUser;
        }


        protected List<IDbDataParameter> PrepareParameters(int iApplicationID, string sUserName, string sPassword)
        {
            var lstParameters = new List<IDbDataParameter>();

            var oSqlParameter = new SqlParameter("@applicationID", SqlDbType.Int);
            oSqlParameter.Value = iApplicationID;
            lstParameters.Add(oSqlParameter);

            oSqlParameter = new SqlParameter("@userName", SqlDbType.NVarChar, 50);
            oSqlParameter.Value = sUserName;
            lstParameters.Add(oSqlParameter);

            oSqlParameter = new SqlParameter("@password", SqlDbType.NVarChar, 8);
            oSqlParameter.Value = sPassword;
            lstParameters.Add(oSqlParameter);

            return lstParameters;
        }

        protected void HandleSqlError(SqlException oSqlException)
        {
            if (oSqlException.Number == Constants.SqlReturnCode.NoUser)
            {
                throw new InvalidLoginException();
            }

            if (oSqlException.Number == Constants.SqlReturnCode.WrongPassword)
            {
                throw new WrongPasswordExeption();
            }
            throw oSqlException;
        }

        protected IUser InstantiateUser(IDataReader oDbDataReader)
        {
            if (!oDbDataReader.Read())
            {
                return null;
            }

            IUser oUser = new User(oDbDataReader);

            oDbDataReader.NextResult();

            oUser.Permissions = new List<IPermission>();
            while (oDbDataReader.Read())
            {
                oUser.Permissions.Add(new Permission(oDbDataReader));
            }

            return oUser;
        }
        #endregion
    }
}
