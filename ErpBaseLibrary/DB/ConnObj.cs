using System;
using System.Collections.Generic;
using System.Configuration;

namespace ErpBaseLibrary.DB
{
    public class ConnObj
    {
    }
    public class MyConnStringList
    {
        public static string AzureGoodeasy = ConfigurationManager.ConnectionStrings["ConnMASMainDB"].ConnectionString;
    }
}
