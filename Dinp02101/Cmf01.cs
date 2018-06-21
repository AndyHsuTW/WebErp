using System;
using System.Collections.Generic;
using System.Data.SqlClient;

using ErpBaseLibrary.DB;

namespace DINP02101
{
    public class Cmf01
    {
        #region properties from database

        public string cmf0102_cuscode { get; set; }

        public string cmf0103_bname { get; set; }

        #endregion

        /// <summary>
        /// 取得客戶列表
        /// </summary>
        /// <returns></returns>
        public static List<Cmf01> GetList()
        {
            List<Cmf01> cmf01List = new List<Cmf01>();

            using (var conn = new SqlConnection { ConnectionString = MyConnStringList.AzureGoodeasy })
            using (var sqlCmd = conn.CreateCommand())
            {
                conn.Open();

                sqlCmd.CommandText = @"SELECT cmf0102_cuscode, cmf0103_bname FROM cmf01";

                using (var sqlReader = sqlCmd.ExecuteReader())
                {
                    if (sqlReader.HasRows)
                    {
                        while (sqlReader.Read())
                        {
                            Cmf01 cmf01 = new Cmf01();
                            cmf01.cmf0102_cuscode = Convert.ToString(sqlReader["cmf0102_cuscode"]);
                            cmf01.cmf0103_bname = Convert.ToString(sqlReader["cmf0103_bname"]);

                            cmf01List.Add(cmf01);
                        }
                    }
                }
            }

            return cmf01List;
        }
    }
}
