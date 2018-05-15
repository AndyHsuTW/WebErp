using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using ErpBaseLibrary.DB;

namespace Dinp02401
{
    /// <summary>
    /// 專案合約資料
    /// </summary>
    public class Gaf04
    {
        #region properties from database

        public int id { get; set; }

        public string gaf0404_project_fullname { get; set; }

        public string cnf0501_file { get; set; }

        public string cnf0502_field { get; set; }

        #endregion

        /// <summary>
        /// 根據公司代號,專案代號取得專案合約資料
        /// </summary>
        /// <param name="bcode">公司代號</param>
        /// <param name="projectNo">專案代號</param>
        /// <returns></returns>
        public static Gaf04 GetData(string bcode, string projectNo)
        {
            Gaf04 gaf04 = null;

            using (var conn = new SqlConnection { ConnectionString = MyConnStringList.AzureGoodeasy })
            using (var sqlCmd = conn.CreateCommand())
            {
                conn.Open();

                sqlCmd.CommandText = String.Format(@"
        SELECT top 1 id,
            gaf0404_project_fullname
        FROM [dbo].[gaf04]
        WHERE gef0401_project_no = @projectNo
        AND gaf0401_bcode = @bcode ");

                sqlCmd.Parameters.AddWithValueSafe("@projectNo", projectNo);
                sqlCmd.Parameters.AddWithValueSafe("@bcode", bcode);

                using (var sqlReader = sqlCmd.ExecuteReader())
                {
                    if (sqlReader.HasRows)
                    {
                        if (sqlReader.Read())
                        {
                            gaf04 = new Gaf04();
                            gaf04.id = Convert.ToInt32(sqlReader["id"]);
                            gaf04.gaf0404_project_fullname = Convert.ToString(sqlReader["gaf0404_project_fullname"]);

                        }
                    }
                }
            }

            return gaf04;
        }


    }
}
