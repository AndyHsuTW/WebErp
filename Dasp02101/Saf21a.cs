using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ErpBaseLibrary.DB;

namespace Dsap02101
{
    public class Saf21a
    {
        public int id { get; set; }
        public int saf21a01_seq_seq { get; set; }
        public string saf21a02_pcode { get; set; }
        public string saf21a03_relative_no { get; set; }
        public string saf21a41_product_name { get; set; }
        public string saf21a43_runit { get; set; }
        public int saf21a16_total_qty { get; set; }
        public int saf21a51_gift_qty { get; set; }
        public int saf21a56_box_qty { get; set; }
        public int inf0164_dividend{get;set;}
        public int saf21a57_qty { get; set; }
        public int saf21a37_utax_price { get; set; }
        public double saf21a13_tax{get;set;}
        public double saf21a11_unit_price{get;set;}
        public int saf21a50_one_amt{get;set;}
        public string remark { get; set; }
        

        public static List<Saf21a> GetList(string docno)
        {
            if (String.IsNullOrEmpty(docno))
            {
                throw new ArgumentNullException("docno");
            }

            List<Saf21a> saf21aList = new List<Saf21a>();

            using (var conn = new SqlConnection { ConnectionString = MyConnStringList.AzureGoodeasy })
            using (var sqlCmd = conn.CreateCommand())
            {
                conn.Open();

                sqlCmd.CommandText = String.Format(@"
                    select saf21a.id,
                    saf21a.[saf21a01_seq_seq],
                    saf21a.[saf21a02_pcode],
                    saf21a.[saf21a03_relative_no],
                    saf21a.saf21a41_product_name,
                    saf21a.saf21a43_runit,
                    saf21a.saf21a16_total_qty,
                    saf21a.saf21a51_gift_qty,
                    saf21a.saf21a56_box_qty,
                    inf01.inf0164_dividend,
                    saf21a.saf21a57_qty,
                    saf21a.saf21a37_utax_price,
                    saf21a.saf21a13_tax,
                    saf21a.saf21a11_unit_price,
                    saf21a.saf21a50_one_amt,
                    saf21a.remark

                    from saf21a
                    left join inf01 
                    on inf0102_pcode = saf21a.saf21a02_pcode
                    WHERE saf21a01_docno = @docno
                ");
                sqlCmd.Parameters.AddWithValue("@docno", docno);

                using (var sqlReader = sqlCmd.ExecuteReader())
                {
                    if (sqlReader.HasRows)
                    {
                        while (sqlReader.Read())
                        {
                            Saf21a saf21a = new Saf21a();
                            saf21a.id = Convert.ToInt32(sqlReader["id"]);
                            saf21a.saf21a01_seq_seq = Convert.ToInt32(sqlReader["saf21a01_seq_seq"]);
                            saf21a.saf21a02_pcode = Convert.ToString(sqlReader["saf21a02_pcode"]);
                            saf21a.saf21a03_relative_no = Convert.ToString(sqlReader["saf21a03_relative_no"]);
                            saf21a.saf21a41_product_name = Convert.ToString(sqlReader["saf21a41_product_name"]);
                            saf21a.saf21a43_runit = Convert.ToString(sqlReader["saf21a43_runit"]);
                            saf21a.saf21a16_total_qty = Convert.ToInt32(sqlReader["saf21a16_total_qty"]);
                            saf21a.saf21a51_gift_qty = Convert.ToInt32(sqlReader["saf21a51_gift_qty"]);
                            saf21a.saf21a56_box_qty = Convert.ToInt32(sqlReader["saf21a56_box_qty"]);
                            saf21a.inf0164_dividend = Convert.ToInt32(sqlReader["inf0164_dividend"]);
                            saf21a.saf21a57_qty = Convert.ToInt32(sqlReader["saf21a57_qty"]);
                            saf21a.saf21a37_utax_price = Convert.ToInt32(sqlReader["saf21a37_utax_price"]);
                            saf21a.saf21a13_tax = Convert.ToInt32(sqlReader["saf21a13_tax"]);
                            saf21a.saf21a11_unit_price = Convert.ToInt32(sqlReader["saf21a11_unit_price"]);
                            saf21a.saf21a50_one_amt = Convert.ToInt32(sqlReader["saf21a50_one_amt"]);
                            saf21a.remark = Convert.ToString(sqlReader["remark"]);


                            saf21aList.Add(saf21a);
                        }
                    }
                }
            }
            return saf21aList;
        }
    }
}
