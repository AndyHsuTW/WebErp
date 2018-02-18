using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ErpBaseLibrary.DB;

namespace Dinp02301
{
    /// <summary>
    /// 幣別匯率
    /// </summary>
    public class Cnf14
    {

        #region properties from database

        /// <summary>
        /// 幣別代號
        /// </summary>
        public string cnf1401_exchange_code { get; set; }

        /// <summary>
        /// 固定匯率
        /// </summary>
        public double cnf1406_exchange_fix { get; set; }

        #endregion

        public static Cnf14 GetData(string exchangeCode)
        {
            Cnf14 cnf14 = null;

            using (var conn = new SqlConnection { ConnectionString = MyConnStringList.AzureGoodeasy })
            using (var sqlCmd = conn.CreateCommand())
            {
                conn.Open();

                sqlCmd.CommandText = String.Format(@"
        SELECT TOP 1 [cnf1406_exchange_fix]
        FROM [cnf14] 
        WHERE cnf1401_exchange_code = @exchangeCode
");

                sqlCmd.Parameters.AddWithValueSafe("@exchangeCode", exchangeCode);

                using (var sqlReader = sqlCmd.ExecuteReader())
                {
                    if (sqlReader.HasRows)
                    {
                        if (sqlReader.Read())
                        {
                            cnf14 = new Cnf14();
                            cnf14.cnf1401_exchange_code = exchangeCode;
                            cnf14.cnf1406_exchange_fix = Convert.ToDouble(sqlReader["cnf1406_exchange_fix"]);
                        }
                    }
                }
            }

            return cnf14;
        }

    }
}
