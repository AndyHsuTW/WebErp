using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ErpBaseLibrary.DB;

namespace Dinp02301
{
    public class Inf29a
    {
        #region properties from database

        public int id { get; set; }

        public string inf29a01_docno { get; set; }

        public string inf29a01_bcode { get; set; }

        public string inf29a02_docno_type { get; set; }

        public string inf29a02_docno_date { get; set; }

        public string inf29a02_docno_seq { get; set; }

        public int inf29a02_seq { get; set; }

        public string inf29a04_sizeno { get; set; }

        public string inf29a05_pcode { get; set; }

        public string inf29a05_shoes_code { get; set; }

        public double inf29a10_ocost_one { get; set; }

        public double inf29a10_cost_one { get; set; }

        public double inf29a11_dis_rate { get; set; }

        public double inf29a12_sub_amt { get; set; }

        public double inf29a13_sold_qty { get; set; }

        public string inf29a14_trn_type { get; set; }

        public string inf29a17_runit { get; set; }

        public double inf29a26_box_qty { get; set; }

        public string inf29a31_currency { get; set; }

        public double inf29a32_exchange_rate { get; set; }

        public string inf29a33_product_name { get; set; }

        public double inf29a36_odds_amt { get; set; }

        public double inf29a38_one_amt { get; set; }

        public double inf29a39_price { get; set; }

        public double inf29a40_tax { get; set; }

        public string inf29a41_pcat { get; set; }

        public string remark { get; set; }

        public string adduser { get; set; }

        public DateTime? adddate { get; set; }

        public string moduser { get; set; }

        public DateTime? moddate { get; set; }

        #endregion


        public static List<Inf29a> AddItem(Inf29 inf29, List<Inf29a> inf29aList)
        {
            if (inf29aList == null || inf29aList.Count==0)
            {
                throw new ArgumentNullException("inf29aList");
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
               ,[inf29a10_ocost_one]
               ,[inf29a10_cost_one]
               ,[inf29a11_dis_rate]
               ,[inf29a12_sub_amt]
               ,[inf29a13_sold_qty]
               ,[inf29a14_trn_type]
               ,[inf29a17_runit]
               ,[inf29a26_box_qty]
               ,[inf29a31_currency]
               ,[inf29a32_exchange_rate]
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
               ,@inf29a10_ocost_one
               ,@inf29a10_cost_one
               ,@inf29a11_dis_rate
               ,@inf29a12_sub_amt
               ,@inf29a13_sold_qty
               ,@inf29a14_trn_type
               ,@inf29a17_runit
               ,@inf29a26_box_qty
               ,@inf29a31_currency
               ,@inf29a32_exchange_rate
               ,@inf29a33_product_name
               ,@inf29a36_odds_amt
               ,@inf29a38_one_amt
               ,@inf29a39_price
               ,@inf29a40_tax
               ,@inf29a41_pcat
               ,@adduser
               ,@adddate  ) ";

                foreach (var inf29a in inf29aList)
                {
                    sqlCmd.Parameters.Clear();

                    sqlCmd.Parameters.AddWithValue("@inf29a00_inf29id", inf29.id);
                    sqlCmd.Parameters.AddWithValue("@inf29a01_docno", inf29.inf2901_docno);
                    sqlCmd.Parameters.AddWithValue("@inf29a02_seq", inf29a.inf29a02_seq);
                    sqlCmd.Parameters.AddWithValueSafe("@inf29a04_sizeno", inf29a.inf29a04_sizeno);
                    sqlCmd.Parameters.AddWithValueSafe("@inf29a05_pcode", inf29a.inf29a05_pcode);
                    sqlCmd.Parameters.AddWithValueSafe("@inf29a05_shoes_code", inf29a.inf29a05_shoes_code);
                    sqlCmd.Parameters.AddWithValueSafe("@inf29a10_ocost_one", inf29a.inf29a10_ocost_one);
                    sqlCmd.Parameters.AddWithValueSafe("@inf29a10_cost_one", inf29a.inf29a10_cost_one);
                    sqlCmd.Parameters.AddWithValueSafe("@inf29a11_dis_rate", inf29a.inf29a11_dis_rate);
                    sqlCmd.Parameters.AddWithValueSafe("@inf29a12_sub_amt", inf29a.inf29a12_sub_amt);
                    sqlCmd.Parameters.AddWithValueSafe("@inf29a13_sold_qty", inf29a.inf29a13_sold_qty);
                    sqlCmd.Parameters.AddWithValueSafe("@inf29a14_trn_type", inf29a.inf29a14_trn_type);
                    sqlCmd.Parameters.AddWithValueSafe("@inf29a17_runit", inf29a.inf29a17_runit);
                    sqlCmd.Parameters.AddWithValueSafe("@inf29a26_box_qty", inf29a.inf29a26_box_qty);
                    sqlCmd.Parameters.AddWithValueSafe("@inf29a31_currency", inf29a.inf29a31_currency);
                    sqlCmd.Parameters.AddWithValueSafe("@inf29a32_exchange_rate", inf29a.inf29a32_exchange_rate);
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

        public static List<Inf29a> GetList(string docno)
        {
            if (String.IsNullOrEmpty(docno))
            {
                throw new ArgumentNullException("docno");
            }

            List<Inf29a> inf29aList = new List<Inf29a>();

            using (var conn = new SqlConnection { ConnectionString = MyConnStringList.AzureGoodeasy })
            using (var sqlCmd = conn.CreateCommand())
            {
                conn.Open();

                sqlCmd.CommandText = String.Format(@"
        SELECT [inf29a02_seq]
               ,[inf29a04_sizeno]
               ,[inf29a05_pcode]
               ,[inf29a05_shoes_code]
               ,[inf29a10_ocost_one]
               ,[inf29a10_cost_one]
               ,[inf29a11_dis_rate]
               ,[inf29a12_sub_amt]
               ,[inf29a13_sold_qty]
               ,[inf29a14_trn_type]
               ,[inf29a17_runit]
               ,[inf29a26_box_qty]
               ,[inf29a31_currency]
               ,[inf29a32_exchange_rate]
               ,[inf29a33_product_name]
               ,[inf29a36_odds_amt]
               ,[inf29a38_one_amt]
               ,[inf29a39_price]
               ,[inf29a40_tax]
               ,[inf29a41_pcat]
               ,[remark]
               ,[adduser]
               ,[adddate]
        FROM inf29a
        WHERE inf29a01_docno = @docno
");
                sqlCmd.Parameters.AddWithValue("@docno", docno);

                using (var sqlReader = sqlCmd.ExecuteReader())
                {
                    if (sqlReader.HasRows)
                    {
                        while (sqlReader.Read())
                        {
                            Inf29a inf29a = new Inf29a();
                            inf29a.inf29a02_seq = Convert.ToInt32(sqlReader["inf29a02_seq"]);
                            inf29a.inf29a04_sizeno = Convert.ToString(sqlReader["inf29a04_sizeno"]);
                            inf29a.inf29a05_pcode = Convert.ToString(sqlReader["inf29a05_pcode"]);
                            inf29a.inf29a05_shoes_code = Convert.ToString(sqlReader["inf29a05_shoes_code"]);
                            inf29a.inf29a10_ocost_one = Convert.ToDouble(sqlReader["inf29a10_ocost_one"]);
                            inf29a.inf29a10_cost_one = Convert.ToDouble(sqlReader["inf29a10_cost_one"]);
                            inf29a.inf29a11_dis_rate = Convert.ToDouble(sqlReader["inf29a11_dis_rate"]);
                            inf29a.inf29a12_sub_amt = Convert.ToDouble(sqlReader["inf29a12_sub_amt"]);
                            inf29a.inf29a13_sold_qty = Convert.ToDouble(sqlReader["inf29a13_sold_qty"]);
                            inf29a.inf29a14_trn_type = Convert.ToString(sqlReader["inf29a14_trn_type"]);
                            inf29a.inf29a17_runit = Convert.ToString(sqlReader["inf29a17_runit"]);
                            inf29a.inf29a26_box_qty = Convert.ToDouble(sqlReader["inf29a26_box_qty"]);
                            inf29a.inf29a31_currency = Convert.ToString(sqlReader["inf29a31_currency"]);
                            inf29a.inf29a32_exchange_rate = Convert.ToDouble(sqlReader["inf29a32_exchange_rate"]);
                            inf29a.inf29a33_product_name = Convert.ToString(sqlReader["inf29a33_product_name"]);
                            inf29a.inf29a36_odds_amt = Convert.ToDouble(sqlReader["inf29a36_odds_amt"]);
                            inf29a.inf29a38_one_amt = Convert.ToDouble(sqlReader["inf29a38_one_amt"]);
                            inf29a.inf29a39_price = Convert.ToDouble(sqlReader["inf29a39_price"]);
                            inf29a.inf29a40_tax = Convert.ToDouble(sqlReader["inf29a40_tax"]);
                            inf29a.inf29a41_pcat = Convert.ToString(sqlReader["inf29a41_pcat"]);
                            inf29a.remark = Convert.ToString(sqlReader["remark"]);
                            inf29a.adduser = Convert.ToString(sqlReader["adduser"]);
                            inf29a.adddate = Convert.ToDateTime(sqlReader["adddate"]);

                            inf29aList.Add(inf29a);
                        }
                    }
                }
            }
            return inf29aList;
        }

        public static bool Delete(string docno)
        {
            if (String.IsNullOrEmpty(docno))
            {
                throw new ArgumentNullException("docno");
            }

            using (var conn = new SqlConnection { ConnectionString = MyConnStringList.AzureGoodeasy })
            using (var sqlCmd = conn.CreateCommand())
            {
                conn.Open();
                sqlCmd.CommandText = @"
        DELETE FROM inf29a
        WHERE inf29a01_docno = @docno
";
                sqlCmd.Parameters.AddWithValue("@docno", docno);

                int count = sqlCmd.ExecuteNonQuery();
                return count > 0;
            }
        }
    }
}
