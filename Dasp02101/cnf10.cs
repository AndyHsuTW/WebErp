using ErpBaseLibrary.DB;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dsap02101
{
    public class cnf10
    {
        public string cnf1003_char01 { get; set; }
        public static string getPaymentInfo( string paymentCode)
        {
            cnf10 cm = new cnf10();
            using (var conn = new SqlConnection { ConnectionString = MyConnStringList.AzureGoodeasy })
            using (var sqlCmd = conn.CreateCommand())
            {
                conn.Open();
                sqlCmd.CommandText = String.Format(@"select cnf1003_char01 from cnf10 where cnf1001_filetype = 'S05' and cnf1002_fileorder = @paymentCode");
                sqlCmd.Parameters.AddWithValue("@paymentCode", paymentCode);
                try
                {
                    using (var sqlReader = sqlCmd.ExecuteReader())
                    {
                        if (sqlReader.HasRows)
                        {
                            while (sqlReader.Read())
                            {
                                cm.cnf1003_char01 = (string)sqlReader["cnf1003_char01"];
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    return ex.Message;
                }
            }
            return cm.cnf1003_char01;
        }
    }
}
