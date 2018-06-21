using ErpBaseLibrary.DB;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;

namespace Dinp02101
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

        public double inf29a09_retail_one { get; set; }

        public double inf29a09_oretail_one { get; set; }

        public double inf29a10_ocost_one { get; set; }

        public double inf29a10_cost_one { get; set; }

        public decimal inf29a10_cost_one0 { get; set; }

        public double inf29a11_dis_rate { get; set; }

        public double inf29a12_sub_amt { get; set; }

        public double inf29a13_sold_qty { get; set; }

        public int inf29a24_retrn_qty { get; set; }

        public int inf29a16_gift_qty { get; set; }

        public int inf29a06_qty { get; set; }

        public string inf29a14_trn_type { get; set; }

        public string inf29a17_runit { get; set; }

        public double inf29a26_box_qty { get; set; }

        //public string inf29a31_currency { get; set; }

        //public double inf29a32_exchange_rate { get; set; }

        public string inf0164_dividend { get; set; }

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

            try
            {
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
               ,[inf29a05_pcode]
               ,[inf29a05_shoes_code]
               ,[inf29a33_product_name]
               ,[inf29a17_runit]
               ,[inf29a10_cost_one0]
               ,[inf29a10_ocost_one]
               ,[inf29a40_tax]
               ,[inf29a13_sold_qty]
               ,[inf29a24_retrn_qty]
               ,[inf29a16_gift_qty]
               ,[inf29a26_box_qty]
               ,[inf29a10_cost_one]
               ,[inf29a06_qty]
               ,[inf29a38_one_amt]
               ,[remark]
               ,[adduser]
               ,[adddate])
    OUTPUT INSERTED.ID
         VALUES
               (
               @inf29a00_inf29id
               ,@inf29a01_docno
               ,@inf29a02_seq
               ,@inf29a05_pcode
               ,@inf29a05_shoes_code
               ,@inf29a33_product_name
               ,@inf29a17_runit
               ,@inf29a10_cost_one0
               ,@inf29a10_ocost_one
               ,@inf29a40_tax
               ,@inf29a13_sold_qty
               ,@inf29a24_retrn_qty
               ,@inf29a16_gift_qty
               ,@inf29a26_box_qty
               ,@inf29a10_cost_one
               ,@inf29a06_qty
               ,@inf29a38_one_amt
               ,@remark
               ,@adduser
               ,@adddate  ) ";

                    foreach (var inf29a in inf29aList)
                    {
                        sqlCmd.Parameters.Clear();

                        sqlCmd.Parameters.AddWithValue("@inf29a00_inf29id", inf29.id);
                        sqlCmd.Parameters.AddWithValue("@inf29a01_docno", inf29.inf2901_docno);
                        sqlCmd.Parameters.AddWithValue("@inf29a02_seq", inf29a.inf29a02_seq);
                        sqlCmd.Parameters.AddWithValueSafe("@inf29a05_pcode", inf29a.inf29a05_pcode);
                        sqlCmd.Parameters.AddWithValueSafe("@inf29a05_shoes_code", inf29a.inf29a05_shoes_code);
                        sqlCmd.Parameters.AddWithValueSafe("@inf29a33_product_name", inf29a.inf29a33_product_name);
                        sqlCmd.Parameters.AddWithValueSafe("@inf29a17_runit", inf29a.inf29a17_runit);
                        sqlCmd.Parameters.AddWithValueSafe("@inf29a10_cost_one0", inf29a.inf29a10_cost_one0);
                        sqlCmd.Parameters.AddWithValueSafe("@inf29a10_ocost_one", inf29a.inf29a10_ocost_one);
                        sqlCmd.Parameters.AddWithValueSafe("@inf29a40_tax", inf29a.inf29a40_tax);
                        sqlCmd.Parameters.AddWithValueSafe("@inf29a13_sold_qty", inf29a.inf29a13_sold_qty);
                        sqlCmd.Parameters.AddWithValueSafe("@inf29a24_retrn_qty", inf29a.inf29a24_retrn_qty);
                        sqlCmd.Parameters.AddWithValueSafe("@inf29a16_gift_qty", inf29a.inf29a16_gift_qty);
                        sqlCmd.Parameters.AddWithValueSafe("@inf29a26_box_qty", inf29a.inf29a26_box_qty);
                        sqlCmd.Parameters.AddWithValueSafe("@inf29a10_cost_one", inf29a.inf29a10_cost_one);//大單位換算值
                        sqlCmd.Parameters.AddWithValueSafe("@inf29a06_qty", inf29a.inf29a06_qty);
                        sqlCmd.Parameters.AddWithValueSafe("@inf29a38_one_amt", inf29a.inf29a38_one_amt);
                        sqlCmd.Parameters.AddWithValueSafe("@remark", inf29a.remark);
                        sqlCmd.Parameters.AddWithValue("@adduser", inf29a.adduser ?? "");
                        sqlCmd.Parameters.AddWithValue("@adddate", inf29a.adddate);

                        int id = (int)sqlCmd.ExecuteScalar();
                        inf29a.id = id;
                    }

                }
            }
            catch (Exception ex)
            {

            }

            return inf29aList;
        }

        public static int AddItem(Inf29 inf29, Inf29.ImportItemRow inf29aRow)
        {
            if (inf29aRow == null || inf29aRow.Count == 0)
            {
                throw new ArgumentNullException("inf29aRow");
            }

            var lastSeq = GetLastSeq(inf29.inf2901_docno);
            int inf29a02_seq = ++lastSeq;

            var fields = inf29aRow.Keys.ToArray();
            string fieldNamesSql = String.Join(", ", fields);
            string paramsFieldsSql = String.Join(",@", fields);  

            using (var conn = new SqlConnection { ConnectionString = MyConnStringList.AzureGoodeasy })
            using (var sqlCmd = conn.CreateCommand())
            {
                conn.Open();
                sqlCmd.CommandText = String.Format(@"
    INSERT INTO [dbo].[inf29a]
            (
            [inf29a00_inf29id]
            ,[inf29a01_docno]
            ,[inf29a02_seq]
            ,adduser
            ,adddate
            ,{0} )
    OUTPUT INSERTED.ID
         VALUES
            (
            @inf29a00_inf29id
            ,@inf29a01_docno
            ,@inf29a02_seq
            ,@adduser
            ,@adddate
            ,@{1}  ) ", fieldNamesSql, paramsFieldsSql);

                sqlCmd.Parameters.AddWithValue("@inf29a00_inf29id", inf29.id);
                sqlCmd.Parameters.AddWithValue("@inf29a01_docno", inf29.inf2901_docno);
                sqlCmd.Parameters.AddWithValue("@inf29a02_seq", inf29a02_seq);
                sqlCmd.Parameters.AddWithValueSafe("@adduser", inf29aRow.adddate);
                sqlCmd.Parameters.AddWithValue("@adddate", inf29aRow.adddate);

                foreach (var field in fields)
                {
                    sqlCmd.Parameters.AddWithValueSafe("@" + field, inf29aRow[field]);
                }

                int id = (int)sqlCmd.ExecuteScalar();

                return id;
            }

        }

        public static int GetLastSeq(string docno)
        {
            var seq = -1;

            using (var conn = new SqlConnection { ConnectionString = MyConnStringList.AzureGoodeasy })
            using (var sqlCmd = conn.CreateCommand())
            {
                conn.Open();
                sqlCmd.CommandText = @"
        SELECT TOP 1 inf29a02_seq
            FROM [inf29a]
        WHERE inf29a01_docno = @inf29a01_docno
        ORDER BY inf29a02_seq DESC
        ";
                sqlCmd.Parameters.AddWithValue("@inf29a01_docno", docno);

                using (var sqlReader = sqlCmd.ExecuteReader())
                {
                    if (sqlReader.HasRows)
                    {
                        if (sqlReader.Read())
                        {
                            seq = Convert.ToInt32(sqlReader["inf29a02_seq"]);
                        }
                    }
                }
            }
            return seq;
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

                sqlCmd.CommandText = String.Format(@"select inf29a00_inf29id,
                                                           inf29a01_docno,
                                                           inf29a02_seq,
                                                           inf29a05_pcode,
                                                           inf29a33_product_name,
                                                           inf29a05_shoes_code,
                                                           inf29a17_runit,
                                                           inf29a10_cost_one0,
                                                           inf29a10_ocost_one,
                                                           inf29a40_tax,
                                                           inf29a13_sold_qty,
                                                           inf29a24_retrn_qty,
                                                           inf29a16_gift_qty,
                                                           inf29a26_box_qty,
                                                           inf29a10_cost_one,
                                                           inf29a06_qty,
                                                           inf29a38_one_amt,
                                                           remark,
                                                           adduser,
                                                           adddate
                                                      from inf29a
                                                     WHERE inf29a01_docno = @docno");
                sqlCmd.Parameters.AddWithValue("@docno", docno);

                using (var sqlReader = sqlCmd.ExecuteReader())
                {
                    if (sqlReader.HasRows)
                    {
                        while (sqlReader.Read())
                        {
                            Inf29a inf29a = new Inf29a();
                            inf29a.inf29a02_seq = Convert.ToInt32(sqlReader["inf29a02_seq"]);
                            inf29a.inf29a05_pcode = Convert.ToString(sqlReader["inf29a05_pcode"]);
                            inf29a.inf29a05_shoes_code = Convert.ToString(sqlReader["inf29a05_shoes_code"]);
                            inf29a.inf29a33_product_name = Convert.ToString(sqlReader["inf29a33_product_name"]);
                            inf29a.inf29a17_runit = Convert.ToString(sqlReader["inf29a17_runit"]);
                            inf29a.inf29a10_cost_one0 = Convert.ToDecimal(sqlReader["inf29a10_cost_one0"]);
                            inf29a.inf29a10_ocost_one = Convert.ToDouble(sqlReader["inf29a10_ocost_one"]);
                            inf29a.inf29a40_tax = Convert.ToDouble(sqlReader["inf29a40_tax"]);
                            inf29a.inf29a13_sold_qty = Convert.ToDouble(sqlReader["inf29a13_sold_qty"]);
                            inf29a.inf29a24_retrn_qty = Convert.ToInt32(sqlReader["inf29a24_retrn_qty"]);
                            inf29a.inf29a16_gift_qty = Convert.ToInt32(sqlReader["inf29a16_gift_qty"]);
                            inf29a.inf29a26_box_qty = Convert.ToDouble(sqlReader["inf29a26_box_qty"]);
                            inf29a.inf29a10_cost_one = Convert.ToDouble(sqlReader["inf29a10_cost_one"]);
                            inf29a.inf29a06_qty = Convert.ToInt32(sqlReader["inf29a06_qty"]);
                            inf29a.inf29a38_one_amt = Convert.ToDouble(sqlReader["inf29a38_one_amt"]);
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
            int count = 0;
            using (var conn = new SqlConnection { ConnectionString = MyConnStringList.AzureGoodeasy })
            using (var sqlCmd = conn.CreateCommand())
            {
                conn.Open();

                SqlTransaction transaction = conn.BeginTransaction();
                sqlCmd.Transaction = transaction;

                try
                {
                    sqlCmd.Parameters.AddWithValue("@docno", docno);
                    //backup to inf29d
                    sqlCmd.CommandText = @"

     INSERT INTO [dbo].[inf29ad]
           ([inf29ad00_inf29id]
           ,[status]
           ,[inf29ad01_docno]
           ,[inf29ad02_seq]
           ,[inf29ad04_sizeno]
           ,[inf29ad05_pcode]
           ,[inf29ad05_shoes_code]
           ,[inf29ad06_qty]
           ,[inf29ad06_manufa_no]
           ,[inf29ad07_mid_flag]
           ,[inf29ad071_mid_date]
           ,[inf29ad08_mcode]
           ,[inf29ad09_oretail_one]
           ,[inf29ad09_retail_one]
           ,[inf29ad09_oretail_second]
           ,[inf29ad09_retail_second]
           ,[inf29ad09_oretail_third]
           ,[inf29ad09_retail_third]
           ,[inf29ad10_ocost_one]
           ,[inf29ad10_cost_one]
           ,[inf29ad10_cost_one0]
           ,[inf29ad10_ocost_second]
           ,[inf29ad10_cost_second]
           ,[inf29ad10_cost_second0]
           ,[inf29ad10_ocost_third]
           ,[inf29ad10_cost_third]
           ,[inf29ad10_cost_third0]
           ,[inf29ad11_dis_rate]
           ,[inf29ad12_sub_amt]
           ,[inf29ad13_sold_qty]
           ,[inf29ad14_trn_type]
           ,[inf29ad15_tran_date]
           ,[inf29ad16_gift_qty]
           ,[inf29ad17_runit]
           ,[inf29ad18_pro_date]
           ,[inf29ad19_vcode]
           ,[inf29ad20_pay_term]
           ,[inf29ad21_billto]
           ,[inf29ad22_tax_flag]
           ,[inf29ad23_batch]
           ,[inf29ad23_batch_mm]
           ,[inf29ad23_batch_att]
           ,[inf29ad24_retrn_qty]
           ,[inf29ad25_byself_qty]
           ,[inf29ad26_box_qty]
           ,[inf29ad27_sale_commission]
           ,[inf29ad28_inchoate_qty]
           ,[inf29ad29_gui]
           ,[inf29ad30_apply_qty]
           ,[inf29ad30_back_qty]
           ,[inf29ad31_currency]
           ,[inf29ad32_exchange_rate]
           ,[inf29ad33_product_name]
           ,[inf29ad35_bcode]
           ,[inf29ad35_open_id]
           ,[inf29ad35_docno_type]
           ,[inf29ad35_docno_date]
           ,[inf29ad35_docno_orderno]
           ,[inf29ad35_docno_seq]
           ,[inf29ad36_odds_amt]
           ,[inf29ad36_odds_amt0]
           ,[inf29ad37_magazine_no]
           ,[inf29ad38_one_amt]
           ,[remark]
           ,[adduser]
           ,[adddate]
           ,[moduser]
           ,[moddate]
           ,[verifyuser]
           ,[verifydate]
           ,[inf29ad39_price]
           ,[inf29ad39_trn_status]
           ,[inf29ad40_tax]
           ,[inf29ad41_pcat]
           ,[inf29ad41_manufa_date]
           ,[inf29ad42_expire_date]
           ,[inf29ad43_note]
           ,[inf29ad44_dqty]
           ,[inf29ad45_damt]
           ,[inf29ad46_orderno]
           ,[inf29ad47_yymm]
           ,[inf29ad47_word]
           ,[inf29ad47_buy_startno]
           ,[inf29ad47_buy_endno]
           ,[inf29ad48_way])
        SELECT 
          [inf29a00_inf29id]
          ,[status]
          ,[inf29a01_docno]
          ,[inf29a02_seq]
          ,[inf29a04_sizeno]
          ,[inf29a05_pcode]
          ,[inf29a05_shoes_code]
          ,[inf29a06_qty]
          ,[inf29a06_manufa_no]
          ,[inf29a07_mid_flag]
          ,[inf29a071_mid_date]
          ,[inf29a08_mcode]
          ,[inf29a09_oretail_one]
          ,[inf29a09_retail_one]
          ,[inf29a09_oretail_second]
          ,[inf29a09_retail_second]
          ,[inf29a09_oretail_third]
          ,[inf29a09_retail_third]
          ,[inf29a10_ocost_one]
          ,[inf29a10_cost_one]
          ,[inf29a10_cost_one0]
          ,[inf29a10_ocost_second]
          ,[inf29a10_cost_second]
          ,[inf29a10_cost_second0]
          ,[inf29a10_ocost_third]
          ,[inf29a10_cost_third]
          ,[inf29a10_cost_third0]
          ,[inf29a11_dis_rate]
          ,[inf29a12_sub_amt]
          ,[inf29a13_sold_qty]
          ,[inf29a14_trn_type]
          ,[inf29a15_tran_date]
          ,[inf29a16_gift_qty]
          ,[inf29a17_runit]
          ,[inf29a18_pro_date]
          ,[inf29a19_vcode]
          ,[inf29a20_pay_term]
          ,[inf29a21_billto]
          ,[inf29a22_tax_flag]
          ,[inf29a23_batch]
          ,[inf29a23_batch_mm]
          ,[inf29a23_batch_att]
          ,[inf29a24_retrn_qty]
          ,[inf29a25_byself_qty]
          ,[inf29a26_box_qty]
          ,[inf29a27_sale_commission]
          ,[inf29a28_inchoate_qty]
          ,[inf29a29_gui]
          ,[inf29a30_apply_qty]
          ,[inf29a30_back_qty]
          ,[inf29a31_currency]
          ,[inf29a32_exchange_rate]
          ,[inf29a33_product_name]
          ,[inf29a35_bcode]
          ,[inf29a35_open_id]
          ,[inf29a35_docno_type]
          ,[inf29a35_docno_date]
          ,[inf29a35_docno_orderno]
          ,[inf29a35_docno_seq]
          ,[inf29a36_odds_amt]
          ,[inf29a36_odds_amt0]
          ,[inf29a37_magazine_no]
          ,[inf29a38_one_amt]
          ,[remark]
          ,[adduser]
          ,[adddate]
          ,[moduser]
          ,[moddate]
          ,[verifyuser]
          ,[verifydate]
          ,[inf29a39_price]
          ,[inf29a39_trn_status]
          ,[inf29a40_tax]
          ,[inf29a41_pcat]
          ,[inf29a41_manufa_date]
          ,[inf29a42_expire_date]
          ,[inf29a43_note]
          ,[inf29a44_dqty]
          ,[inf29a45_damt]
          ,[inf29a46_orderno]
          ,[inf29a47_yymm]
          ,[inf29a47_word]
          ,[inf29a47_buy_startno]
          ,[inf29a47_buy_endno]
          ,[inf29a48_way]
      FROM [inf29a] 
        WHERE inf29a.inf29a01_docno = @docno";

                    count = sqlCmd.ExecuteNonQuery();
                    if (count <= 0)
                    {
                        throw new Exception(String.Format("Backup Inf29a fail on '{0}'", docno));
                    }
                    //delete after backup success
                    sqlCmd.CommandText = @"
        DELETE FROM inf29a
        WHERE inf29a01_docno = @docno ";

                    count = sqlCmd.ExecuteNonQuery();

                    transaction.Commit();
                }
                catch (Exception)
                {
                    transaction.Rollback();
                    throw;
                }
            }
            return count > 0;
        }

    }
}
