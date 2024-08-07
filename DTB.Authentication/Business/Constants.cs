namespace DTB.Authentication
{
    public static class Constants
    {
        public static class SqlReturnCode
        {
            public const int WrongPassword = 500022,
                                NoUser = 500021,
                                NoApplicationPermissions = 50023;
        }
    }
}
