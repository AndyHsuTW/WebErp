using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Newtonsoft.Json;
using ErpBaseLibrary.DB;
using System.Data.SqlClient;
/// <summary>
/// Summary description for Helper
/// </summary>
namespace LogHelper
{
    public class UserLog
    {

        public static string EnterPageLog(string user, string programno)
        {
            var result = "";
            using (var conn = new SqlConnection(MyConnStringList.AzureGoodeasy))
            {
                conn.Open();
                var cmd = conn.CreateCommand();
                try {

                    cmd.CommandText = @"
                    insert into [dbo].[cnf18] 
	                    ([cnf1801_bcode]
	                    ,[cnf1802_b_date]
	                    ,[cnf1803_user]
	                    ,[cnf1804_progno]
	                    ,[adduser]
	                    ,[adddate]
	                    ,[moduser]
	                    ,[moddate])
                    VALUES
	                    (ISNULL((SELECT top 1 cnf0701_bcode  FROM [dbo].[cnf07] where cnf0751_tax_headoffice='0'),'Not Found bcode')
	                    ,GETDATE()
	                    ,@user
	                    ,@programno
	                    ,@user
	                    ,GETDATE()
	                    ,@user
	                    ,GETDATE())";
                    cmd.Parameters.AddWithValue("@user", user);
                    cmd.Parameters.AddWithValue("@programno", programno);
                    cmd.ExecuteNonQuery();
                    result = "success";
                
                }
                catch (Exception ex) {
                    result = ex.ToString();
                }
            }
            return result;
        }

        public class LogData
        {
            public string cnf1801_bcode { get; set; }
            public string cnf1802_b_date { get; set; }
            public string cnf1803_user { get; set; }
            public string cnf1804_progno { get; set; }
            public string cnf1805_e_date { get; set; }
            public string user { get; set; }

        }

    }
}