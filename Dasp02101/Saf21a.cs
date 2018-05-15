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
        public double inf0164_dividend{get;set;}
        public int saf21a57_qty { get; set; }
        public double saf21a37_utax_price { get; set; }
        public double saf21a13_tax{get;set;}
        public double saf21a11_unit_price{get;set;}
        public int saf21a50_one_amt{get;set;}
        public string remark { get; set; }

        public static List<Saf21a> AddItem(Saf21 saf21, List<Saf21a> saf21aList)
        {
            if (saf21aList == null || saf21aList.Count == 0)
            {
                throw new ArgumentNullException("saf21aList");
            }

            using (var conn = new SqlConnection { ConnectionString = MyConnStringList.AzureGoodeasy })
            using (var sqlCmd = conn.CreateCommand())
            {
                conn.Open();
                sqlCmd.CommandText = @"
    INSERT INTO [dbo].[inf29a]
               (
               [inf29a00_inf29id]
               ,[inf29a01_docno]
               ,[inf29a02_seq]
               ,[inf29a04_sizeno]
               ,[inf29a05_pcode]
               ,[inf29a05_shoes_code]
               ,[inf29a09_retail_one]
               ,[inf29a09_oretail_one]
               ,[inf29a10_ocost_one]
               ,[inf29a10_cost_one]
               ,[inf29a11_dis_rate]
               ,[inf29a12_sub_amt]
               ,[inf29a13_sold_qty]
               ,[inf29a14_trn_type]
               ,[inf29a17_runit]
               ,[inf29a26_box_qty]
               ,[inf29a33_product_name]
               ,[inf29a36_odds_amt]
               ,[inf29a38_one_amt]
               ,[inf29a39_price]
               ,[inf29a40_tax]
               ,[inf29a41_pcat]
               ,[adduser]
               ,[adddate])
    OUTPUT INSERTED.ID
         VALUES
               (
               @inf29a00_inf29id
               ,@inf29a01_docno
               ,@inf29a02_seq
               ,@inf29a04_sizeno
               ,@inf29a05_pcode
               ,@inf29a05_shoes_code
               ,@inf29a09_oretail_one
               ,@inf29a09_retail_one
               ,@inf29a10_ocost_one
               ,@inf29a10_cost_one
               ,@inf29a11_dis_rate
               ,@inf29a12_sub_amt
               ,@inf29a13_sold_qty
               ,@inf29a14_trn_type
               ,@inf29a17_runit
               ,@inf29a26_box_qty
               ,@inf29a33_product_name
               ,@inf29a36_odds_amt
               ,@inf29a38_one_amt
               ,@inf29a39_price
               ,@inf29a40_tax
               ,@inf29a41_pcat
               ,@adduser
               ,@adddate  ) ";

                foreach (var inf29a in saf21aList)
                {
                    sqlCmd.Parameters.Clear();

                    sqlCmd.Parameters.AddWithValue("@inf29a00_inf29id", inf29.id);
                    sqlCmd.Parameters.AddWithValue("@inf29a01_docno", inf29.inf2901_docno);
                    sqlCmd.Parameters.AddWithValue("@inf29a02_seq", inf29a.inf29a02_seq);
                    sqlCmd.Parameters.AddWithValueSafe("@inf29a04_sizeno", inf29a.inf29a04_sizeno);
                    sqlCmd.Parameters.AddWithValueSafe("@inf29a05_pcode", inf29a.inf29a05_pcode);
                    sqlCmd.Parameters.AddWithValueSafe("@inf29a05_shoes_code", inf29a.inf29a05_shoes_code);
                    sqlCmd.Parameters.AddWithValueSafe("@inf29a09_retail_one", inf29a.inf29a09_retail_one);
                    sqlCmd.Parameters.AddWithValueSafe("@inf29a09_oretail_one", inf29a.inf29a09_oretail_one);
                    sqlCmd.Parameters.AddWithValueSafe("@inf29a10_ocost_one", inf29a.inf29a10_ocost_one);
                    sqlCmd.Parameters.AddWithValueSafe("@inf29a10_cost_one", inf29a.inf29a10_cost_one);
                    sqlCmd.Parameters.AddWithValueSafe("@inf29a11_dis_rate", inf29a.inf29a11_dis_rate);
                    sqlCmd.Parameters.AddWithValueSafe("@inf29a12_sub_amt", inf29a.inf29a12_sub_amt);
                    sqlCmd.Parameters.AddWithValueSafe("@inf29a13_sold_qty", inf29a.inf29a13_sold_qty);
                    sqlCmd.Parameters.AddWithValueSafe("@inf29a14_trn_type", inf29a.inf29a14_trn_type);
                    sqlCmd.Parameters.AddWithValueSafe("@inf29a17_runit", inf29a.inf29a17_runit);
                    sqlCmd.Parameters.AddWithValueSafe("@inf29a26_box_qty", inf29a.inf29a26_box_qty);
                    //                    sqlCmd.Parameters.AddWithValueSafe("@inf29a31_currency", inf29a.inf29a31_currency);
                    //                    sqlCmd.Parameters.AddWithValueSafe("@inf29a32_exchange_rate", inf29a.inf29a32_exchange_rate);
                    sqlCmd.Parameters.AddWithValueSafe("@inf29a33_product_name", inf29a.inf29a33_product_name);
                    sqlCmd.Parameters.AddWithValueSafe("@inf29a36_odds_amt", inf29a.inf29a36_odds_amt);
                    sqlCmd.Parameters.AddWithValueSafe("@inf29a38_one_amt", inf29a.inf29a38_one_amt);
                    sqlCmd.Parameters.AddWithValueSafe("@inf29a39_price", inf29a.inf29a39_price);
                    sqlCmd.Parameters.AddWithValueSafe("@inf29a40_tax", inf29a.inf29a40_tax);
                    sqlCmd.Parameters.AddWithValueSafe("@inf29a41_pcat", inf29a.inf29a41_pcat);
                    sqlCmd.Parameters.AddWithValue("@adduser", inf29a.adduser);
                    sqlCmd.Parameters.AddWithValue("@adddate", inf29a.adddate);

                    int id = (int)sqlCmd.ExecuteScalar();
                    inf29a.id = id;
                }

            }

            return inf29aList;
        }


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
                    saf21a.[saf21a02_seq],
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
