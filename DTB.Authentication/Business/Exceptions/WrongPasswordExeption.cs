using System;

namespace DTB.Authentication 
{
    public class WrongPasswordExeption : Exception
    {
        public WrongPasswordExeption() : base("Wrong application password")
        {

        }
  
    }
}
