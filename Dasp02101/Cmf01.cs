using ErpBaseLibrary.DB;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dsap02101
{
    public class Cmf01
    {
        public string cmf0103_bname { get; set; }
        public string cmf0109_ozipcode { get; set; }
        public string cmf0110_oaddress { get; set; }
        public string cmf01a17_telo1 { get; set; }
        public string cmf01a23_cellphone { get; set; }
        public string cmf01a05_fname { get; set; }
        public string cmf01a03_recid { get; set; }
        public static List<Cmf01> GetCustomerCodeName(string custcode)
        {
            Cmf01 cm = new Cmf01();
            List<Cmf01> result = new List<Cmf01>();
            using (var conn = new SqlConnection { ConnectionString = MyConnStringList.AzureGoodeasy })
            using (var sqlCmd = conn.CreateCommand())
            {
                conn.Open();
                sqlCmd.CommandText = String.Format(@"select [cmf0103_bname], cmf01a.cmf01a03_recid, cmf0109_ozipcode, cmf0110_oaddress, cmf01a.cmf01a17_telo1, cmf01a.cmf01a23_cellphone, cmf01a.cmf01a05_fname from cmf01 left join cmf01a on cmf01a02_cuscode = cmf0102_cuscode where cmf0102_cuscode = @customCode");
                sqlCmd.Parameters.AddWithValue("@customCode", custcode);
                using (var sqlReader = sqlCmd.ExecuteReader())
                {
                    if (sqlReader.HasRows)
                    {
                        while (sqlReader.Read())
                        {
                            cm.cmf0103_bname = (string)sqlReader["cmf0103_bname"];
                            cm.cmf0109_ozipcode = (string)sqlReader["cmf0109_ozipcode"];
                            cm.cmf0110_oaddress = (string)sqlReader["cmf0110_oaddress"];
                            var test = sqlReader["cmf01a05_fname"] == null;
                            cm.cmf01a05_fname = (string)( sqlReader.IsDBNull(6) ? "" : sqlReader["cmf01a05_fname"]);
                            cm.cmf01a17_telo1 = (string)(sqlReader.IsDBNull(4) ? "" : sqlReader["cmf01a17_telo1"]); 
                            cm.cmf01a23_cellphone = (string)(sqlReader.IsDBNull(5) ? "" : sqlReader["cmf01a23_cellphone"]);
                            cm.cmf01a03_recid = (string)(sqlReader.IsDBNull(1) ? "" : sqlReader["cmf01a03_recid"]);
                            result.Add(cm);
                        }
                        
                    }
                }
            }
            return result;
        }
    }
}
