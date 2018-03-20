using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using ErpBaseLibrary.DB;

namespace Dinp02301
{
    /// <summary>
    /// 公司基本資料檔
    /// </summary>
    public class Cnf07
    {
        #region properties from database

        public string cnf0701_bcode { get; set; }

        /// <summary>
        /// 總或分公司簡稱
        /// </summary>
        public string cnf0702_bname { get; set; }

        /// <summary>
        /// 總或分公司名稱
        /// </summary>
        public string cnf0703_bfname { get; set; }

        /// <summary>
        /// 0:總公司 1:分公司 2:倉庫  B版所有程式
        /// </summary>
        public string cnf0751_tax_headoffice { get; set; }

        #endregion

        /// <summary>
        /// 取得公司基本資料列表
        /// </summary>
        /// <returns></returns>
        public static List<Cnf07> GetList()
        {
            List<Cnf07> cnf07List = new List<Cnf07>();

            using (var conn = new SqlConnection { ConnectionString = MyConnStringList.AzureGoodeasy })
            using (var sqlCmd = conn.CreateCommand())
            {
                conn.Open();

                sqlCmd.CommandText = String.Format(@"
    SELECT [cnf0701_bcode]
          ,[cnf0702_bname]
          ,[cnf0703_bfname]
          ,[cnf0751_tax_headoffice]
      FROM [cnf07] 
    WHERE status != '1' ");

                using (var sqlReader = sqlCmd.ExecuteReader())
                {
                    if (sqlReader.HasRows)
                    {
                        while (sqlReader.Read())
                        {
                            Cnf07 cnf07 = new Cnf07();
                            cnf07.cnf0701_bcode = Convert.ToString(sqlReader["cnf0701_bcode"]);
                            cnf07.cnf0702_bname = Convert.ToString(sqlReader["cnf0702_bname"]);
                            cnf07.cnf0703_bfname = Convert.ToString(sqlReader["cnf0703_bfname"]);
                            cnf07.cnf0751_tax_headoffice = Convert.ToString(sqlReader["cnf0751_tax_headoffice"]);

                            cnf07List.Add(cnf07);
                        }
                    }
                }
            }

            return cnf07List;
        }
    }
}
