using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using ErpBaseLibrary.DB;

namespace Dinp02301
{
    /// <summary>
    /// 共同代號設定檔
    /// </summary>
    public class Cnf10
    {

        #region properties from database

        /// <summary>
        /// 資料分類
        /// </summary>
        public string cnf1001_filetype { get; set; }

        /// <summary>
        /// 資料代碼
        /// </summary>
        public string cnf1002_fileorder { get; set; }

        /// <summary>
        /// 文字說明. 簡稱
        /// </summary>
        public string cnf1003_char01 { get; set; }

        /// <summary>
        /// 文字說明2. 名稱
        /// </summary>
        public string cnf1004_char02 { get; set; }

        /// <summary>
        /// 數字1
        /// </summary>
        public string cnf1008_dec01 { get; set; }

        #endregion

        /// <summary>
        /// 根據資料分類取得資料
        /// </summary>
        /// <param name="fileType"></param>
        /// <returns></returns>
        public static List<Cnf10> GetList(string fileType)
        {
            List<Cnf10> cnf10List = new List<Cnf10>();

            using (var conn = new SqlConnection { ConnectionString = MyConnStringList.AzureGoodeasy })
            using (var sqlCmd = conn.CreateCommand())
            {
                conn.Open();

                sqlCmd.CommandText = String.Format(@"
    SELECT [cnf1001_filetype]
          ,[cnf1002_fileorder]
          ,[cnf1003_char01]
          ,[cnf1004_char02]
          ,[cnf1008_dec01]
      FROM [dbo].[cnf10]
      WHERE cnf1001_filetype = @fileType ");

                sqlCmd.Parameters.AddWithValue("@fileType", fileType);

                using (var sqlReader = sqlCmd.ExecuteReader())
                {
                    if (sqlReader.HasRows)
                    {
                        while (sqlReader.Read())
                        {
                            Cnf10 cnf10 = new Cnf10();
                            cnf10.cnf1001_filetype = Convert.ToString(sqlReader["cnf1001_filetype"]);
                            cnf10.cnf1002_fileorder = Convert.ToString(sqlReader["cnf1002_fileorder"]);
                            cnf10.cnf1003_char01 = Convert.ToString(sqlReader["cnf1003_char01"]);
                            cnf10.cnf1004_char02 = Convert.ToString(sqlReader["cnf1004_char02"]);
                            cnf10.cnf1008_dec01 = Convert.ToString(sqlReader["cnf1008_dec01"]);

                            cnf10List.Add(cnf10);
                        }
                    }
                }
            }

            return cnf10List;
        }

    }
}
