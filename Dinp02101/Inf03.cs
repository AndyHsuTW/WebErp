using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ErpBaseLibrary.DB;

namespace Dinp02101
{
    /// <summary>
    /// 廠商基本資料檔
    /// </summary>
    public class Inf03
    {
        #region properties from database

        public string inf0301_mcode { get; set; }

        public string inf0302_bname { get; set; }

        public string inf0303_fname { get; set; }

        #endregion


        public static List<Inf03> GetInf03(params string[] mCode)
        {
            List<Inf03> inf03List = new List<Inf03>();

            using (var conn = new SqlConnection { ConnectionString = MyConnStringList.AzureGoodeasy })
            using (var sqlCmd = conn.CreateCommand())
            {
                conn.Open();

                sqlCmd.CommandText = String.Format(@"
        SELECT [inf0302_mcode]
            ,[inf0302_bname]
            ,[inf0303_fname]
        FROM [inf03] 
        WHERE inf0302_mcode IN('{0}')", String.Join("','", mCode));

                using (var sqlReader = sqlCmd.ExecuteReader())
                {
                    if (sqlReader.HasRows)
                    {
                        while (sqlReader.Read())
                        {
                            Inf03 inf03 = new Inf03();
                            inf03.inf0301_mcode = Convert.ToString(sqlReader["inf0302_mcode"]);
                            inf03.inf0302_bname = Convert.ToString(sqlReader["inf0302_bname"]);
                            inf03.inf0303_fname = Convert.ToString(sqlReader["inf0303_fname"]);

                            inf03List.Add(inf03);
                        }
                    }
                }
            }

            return inf03List;
        }
    }
}
