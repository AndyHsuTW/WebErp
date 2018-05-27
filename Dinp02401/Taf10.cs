using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using ErpBaseLibrary.DB;

namespace Dinp02401
{
    /// <summary>
    /// 人事主檔
    /// </summary>
    public class Taf10
    {

        #region properties from database

        public string taf1001_empid { get; set; }

        public string taf1004_cname { get; set; }

        #endregion

        public static Taf10 GetData(string empid)
        {
            Taf10 taf10 = null;

            using (var conn = new SqlConnection { ConnectionString = MyConnStringList.AzureGoodeasy })
            using (var sqlCmd = conn.CreateCommand())
            {
                conn.Open();

                sqlCmd.CommandText = String.Format(@"
        SELECT [taf1004_cname]
        FROM [taf10] 
        WHERE taf1001_empid = @empid ");

                sqlCmd.Parameters.AddWithValueSafe("@empid", empid);

                using (var sqlReader = sqlCmd.ExecuteReader())
                {
                    if (sqlReader.HasRows)
                    {
                        if (sqlReader.Read())
                        {
                            taf10 = new Taf10();
                            taf10.taf1001_empid = empid;
                            taf10.taf1004_cname = Convert.ToString(sqlReader["taf1004_cname"]);

                        }
                    }
                }
            }

            return taf10;
        }

    }
}
