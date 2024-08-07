using System;
using System.Threading.Tasks;
using DTB.Authentication;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace AuthenticationTest
{
    [TestClass]
    public class AuthenticationTest
    {
        [TestMethod]
        //Proper Authetication
        public void CanAuthenticate()
        {
            var oAuthenticator = new Authenticator();

            IUser oUser = oAuthenticator.Authenticate(4, "admin", "admin");

            Assert.IsNotNull(oUser);


        }

        [TestMethod]
        ///Invalid  application ID
        public void WillFailBadApp()
        {
            var oAuthenticator = new Authenticator();

            try
            {
                IUser oUser = oAuthenticator.Authenticate(2, "eschulmeister", "test");
                Assert.Fail("Exception not thrown");
            }
            catch(InvalidLoginException)
            {
            }
            catch(Exception oException)
            {
                Assert.Fail($"Wrong type of Exception thrown - {oException.GetType().FullName}");
            }

        }

        [TestMethod]
        ///Invalid password
        public void WillFailPassword()
        {
            var oAuthenticator = new Authenticator();

            try
            {
                IUser oUser = oAuthenticator.Authenticate(1, "eschulmeister", "boo");
                Assert.Fail("Exception not thrown");
            }
            catch (WrongPasswordException)
            {
            }
            catch (Exception oException)
            {
                Assert.Fail($"Wrong type of Exception thrown - {oException.GetType().FullName}");
            }

        }

        [TestMethod]
        //Original password @ Different case
        public void WillFailCaseSensitivePassword()
        {
            var oAuthenticator = new Authenticator();

            try
            {
                IUser oUser = oAuthenticator.Authenticate(4, "eschulmeister", "Test");
                Assert.Fail("Exception not thrown");
            }
            catch (WrongPasswordException)
            {
            }
            catch (Exception oException)
            {
                Assert.Fail($"Wrong type of Exception thrown - {oException.GetType().FullName}");
            }

        }
    }
}
