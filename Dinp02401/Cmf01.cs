using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using ErpBaseLibrary.DB;

namespace Dinp02401
{
    public class Cmf01
    {

        #region properties from database

        public string cmf0102_cuscode { get; set; }

        public string cmf0103_bname { get; set; }

        #endregion

        public static Cmf01 GetData(string cuscode)
        {
            Cmf01 cmf01 = null;

            using (var conn = new SqlConnection { ConnectionString = MyConnStringList.AzureGoodeasy })
            using (var sqlCmd = conn.CreateCommand())
            {
                conn.Open();

                sqlCmd.CommandText = String.Format(@"
        SELECT [cmf0103_bname]
        FROM [cmf01]
        where [cmf0102_cuscode] = @Cuscode ");

                sqlCmd.Parameters.AddWithValue("@Cuscode", cuscode);

                using (var sqlReader = sqlCmd.ExecuteReader())
                {
                    if (sqlReader.HasRows)
                    {
                        while (sqlReader.Read())
                        {
                            cmf01 = new Cmf01();
                            cmf01.cmf0102_cuscode = cuscode;
                            cmf01.cmf0103_bname = Convert.ToString(sqlReader["cmf0103_bname"]);
                        }
                    }
                }
            }

            return cmf01;
        }
    }
}
