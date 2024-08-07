using System;

namespace DTB.Authentication
{
    public class InvalidLoginException : Exception
    {
        public InvalidLoginException() : base("Invalid UserName or Password")
        {

        }
    }
}
