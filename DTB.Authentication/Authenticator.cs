using System;
using System.Threading.Tasks;

namespace DTB.Authentication
{
    public class Authenticator
    {
        #region Methods
        public IUser Authenticate(int iApplicationID, string sUserName, string sPassword)
        {
            var oUserFactory = new UserFactory();

            IUser oUser =  oUserFactory.Authenticate(iApplicationID, sUserName, sPassword);
            if (oUser == null)
            {
                throw new InvalidLoginException();
            }

            return oUser;

        }
        public async Task<IUser> AuthenticateAsync(int iApplicationID, string sUserName, string sPassword)
        {
            var oUserFactory = new UserFactory();

            IUser oUser = await oUserFactory.AuthenticateAsync(iApplicationID, sUserName, sPassword);
            if (oUser == null)
            {
                throw new InvalidLoginException();
            }

            return oUser;

        }
        #endregion
    }
}
