using ErpBaseLibrary.DB;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dsap02101
{
    public class Inf01
    {
        public string inf0164_dividend { get; set; }
        public string inf0127_tax_flag { get; set;}
        public static Inf01 getDividend(string pcode)
        {
            Inf01 cm = new Inf01();
            using (var conn = new SqlConnection { ConnectionString = MyConnStringList.AzureGoodeasy })
            using (var sqlCmd = conn.CreateCommand())
            {
                conn.Open();
                sqlCmd.CommandText = String.Format(@"select inf0164_dividend, inf0127_tax_flag from inf01 where inf0102_pcode = @pcode");
                sqlCmd.Parameters.AddWithValue("@pcode", pcode);

                    using (var sqlReader = sqlCmd.ExecuteReader())
                    {
                        if (sqlReader.HasRows)
                        {
                            while (sqlReader.Read())
                            {
                                cm.inf0164_dividend = Convert.ToString(sqlReader["inf0164_dividend"]);
                                cm.inf0127_tax_flag = Convert.ToString(sqlReader["inf0127_tax_flag"]);
                            }
                        }
                    }
                }
            return cm;
        }
    }
}
