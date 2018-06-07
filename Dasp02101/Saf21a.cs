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
        public int saf21a02_seq { get; set; }
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
        public string saf21a01_docno { get; set; }
        public string saf21a12_tax_type { get; set; }
        public int saf21a39_total_price;
        public int saf21a55_cost;
        public int saf21a61_chng_price;
        public int saf21a62_chg_sub;
        public decimal saf21a63_chg_tax;
        public int saf21a64_chg_sum;
        public decimal saf21a49_odds_amt;
        public DateTime adddate;
        public string adduser;
        public string moduser;
        public string moddate;
        public bool beenMod;




        public static List<Saf21a> AddItem(Saf21 saf21, List<Saf21a> saf21aList, bool isEdit)
        {
            if (isEdit)
            {
                List<Saf21a> lsSaf21a = Saf21a.GetList(saf21.saf2101_docno);
                List<Saf21a> needDeleteItem = new List<Saf21a>();
                foreach(Saf21a s in lsSaf21a)
                {
                    if(saf21aList.FindAll(x => x.id == s.id).Count == 0)
                    {
                        needDeleteItem.Add(s);
                    }
                }
                List<Saf21a> needAddItem = saf21aList.Where(x => x.id == 0).ToList();
                List<Saf21a> needUpdateItem = saf21aList.Where(x => x.beenMod).ToList();
                foreach (var s in needUpdateItem)
                {
                    Saf21a.Update(s);
                }
                saf21.id = Saf21.getId(saf21.saf2101_docno);
                if (needAddItem.Count > 0)
                {
                    Saf21a.AddItem(saf21, needAddItem, false);
                }
                if (needDeleteItem.Count > 0)
                {
                    foreach (var s in needDeleteItem)
                    {
                        Saf21a.Delete(s.id.ToString(), "id");
                    }
                }

            } else
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
    INSERT INTO [dbo].[saf21a]
           ([saf21a00_saf21id]
           ,[status]
           ,[saf21a01_docno]
           ,[saf21a02_seq]
           ,[saf21a02_pcode]
           ,[saf21a03_relative_no]
           ,[saf21a07_colorno]
           ,[saf21a11_unit_price]
           ,[saf21a12_tax_type]
           ,[saf21a13_tax]
           ,[saf21a16_total_qty]
           ,[saf21a17_add_qty]
           ,[saf21a18_adj_qty]
           ,[saf21a30_sug_price]
           ,[saf21a37_utax_price]
           ,[saf21a38_discount]
           ,[saf21a39_total_price]
           ,[saf21a41_product_name]
           ,[saf21a43_runit]
           ,[saf21a46_nrec_qty]
           ,[saf21a49_odds_amt]
           ,[saf21a50_one_amt]
           ,[saf21a51_gift_qty]
           ,[saf21a52_byself_qty]
           ,[saf21a54_graphy]
           ,[saf21a55_cost]
           ,[saf21a56_box_qty]
           ,[saf21a57_qty]
           ,[saf21a58_note]
           ,[saf21a59_halfway_qty]
           ,[saf21a60_flag1]
           ,[saf21a61_chng_price]
           ,[saf21a62_chg_sub]
           ,[saf21a63_chg_tax]
           ,[saf21a64_chg_sum]
           ,[remark]
           ,[adduser]
           ,[adddate]
           ,[moduser]
           ,[moddate]
           ,[saf21a72_first1]
           ,[saf21a73_first2]
           ,[saf21a74_first3]
           ,[saf21a75_first4]
           ,[saf21a76_first5]
           ,[saf21a77_first6]
           ,[saf21a78_firsta]
           ,[saf21a78_firstb]
           ,[saf21a78_firstc]
           ,[saf21a78_firstd]
           ,[saf21a78_firste]
           ,[saf21a78_firstf])
OUTPUT INSERTED.ID
     VALUES
           (@saf21a00_saf21id
           ,''
           ,@saf21a01_docno
           ,@saf21a02_seq
           ,@saf21a02_pcode
           ,@saf21a03_relative_no
           ,''
           ,@saf21a11_unit_price
           ,@saf21a12_tax_type
           ,@saf21a13_tax
           ,@saf21a16_total_qty
           ,0
           ,0
           ,0
           ,@saf21a37_utax_price
           ,100
           ,@saf21a39_total_price
           ,@saf21a41_product_name
           ,@saf21a43_runit
           ,0
           ,0
           ,@saf21a50_one_amt
           ,0
           ,0
           ,''
           ,@saf21a55_cost
           ,@saf21a56_box_qty
           ,@saf21a57_qty
           ,''
           ,0
           ,''
           ,@saf21a61_chng_price
           ,@saf21a62_chg_sub
           ,@saf21a63_chg_tax
           ,@saf21a64_chg_sum
           ,@remark
           ,@adduser
           ,@adddate
           ,''
           ,null
           ,null
           ,null
           ,null
           ,null
           ,null
           ,null
           ,null
           ,null
           ,null
           ,null
           ,null
           ,null)";

                    foreach (var saf21a in saf21aList)
                    {
                        sqlCmd.Parameters.Clear();
                        sqlCmd.Parameters.AddWithValue("@saf21a00_saf21id", saf21.id);
                        sqlCmd.Parameters.AddWithValue("@saf21a01_docno", saf21.saf2101_docno);
                        sqlCmd.Parameters.AddWithValue("@saf21a02_seq", saf21a.saf21a02_seq);
                        sqlCmd.Parameters.AddWithValue("@saf21a02_pcode", saf21a.saf21a02_pcode);
                        sqlCmd.Parameters.AddWithValue("@saf21a03_relative_no", saf21a.saf21a03_relative_no);
                        sqlCmd.Parameters.AddWithValue("@saf21a11_unit_price", saf21a.saf21a11_unit_price);
                        sqlCmd.Parameters.AddWithValue("@saf21a12_tax_type", saf21a.saf21a12_tax_type);
                        sqlCmd.Parameters.AddWithValue("@saf21a13_tax", saf21a.saf21a13_tax);
                        sqlCmd.Parameters.AddWithValue("@saf21a16_total_qty", saf21a.saf21a16_total_qty);
                        sqlCmd.Parameters.AddWithValue("@saf21a37_utax_price", saf21a.saf21a37_utax_price);
                        sqlCmd.Parameters.AddWithValue("@saf21a39_total_price", saf21a.saf21a39_total_price);
                        sqlCmd.Parameters.AddWithValue("@saf21a41_product_name", saf21a.saf21a41_product_name);
                        sqlCmd.Parameters.AddWithValue("@saf21a43_runit", saf21a.saf21a43_runit);
                        sqlCmd.Parameters.AddWithValue("@saf21a50_one_amt", saf21a.saf21a50_one_amt);
                        sqlCmd.Parameters.AddWithValue("@saf21a55_cost", saf21a.saf21a55_cost);
                        sqlCmd.Parameters.AddWithValue("@saf21a56_box_qty", saf21a.saf21a56_box_qty);
                        sqlCmd.Parameters.AddWithValue("@saf21a57_qty", saf21a.saf21a57_qty);
                        sqlCmd.Parameters.AddWithValue("@saf21a61_chng_price", saf21a.saf21a61_chng_price);
                        sqlCmd.Parameters.AddWithValue("@saf21a62_chg_sub", saf21a.saf21a62_chg_sub);
                        sqlCmd.Parameters.AddWithValue("@saf21a63_chg_tax", saf21a.saf21a63_chg_tax);
                        sqlCmd.Parameters.AddWithValue("@saf21a64_chg_sum", saf21a.saf21a64_chg_sum);
                        sqlCmd.Parameters.AddWithValue("@remark", saf21a.remark);
                        sqlCmd.Parameters.AddWithValue("@adduser", saf21a.adduser);
                        sqlCmd.Parameters.AddWithValue("@adddate", saf21a.adddate);

                        /*sqlCmd.Parameters.AddWithValue("@inf29a00_inf29id", inf29.id);
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
                        */
                        int id = (int)sqlCmd.ExecuteScalar();
                        saf21a.id = id;
                    }

                }
            }
            

            return saf21aList;
        }
        public static int GetLastSeq(string docno)
        {
            var seq = -1;

            using (var conn = new SqlConnection { ConnectionString = MyConnStringList.AzureGoodeasy })
            using (var sqlCmd = conn.CreateCommand())
            {
                conn.Open();
                sqlCmd.CommandText = @"
        SELECT TOP 1 saf21a02_seq
            FROM [saf21a]
        WHERE saf21a01_docno = @saf21a01_docno
        ORDER BY saf21a02_seq DESC
        ";
                sqlCmd.Parameters.AddWithValue("@saf21a01_docno", docno);

                using (var sqlReader = sqlCmd.ExecuteReader())
                {
                    if (sqlReader.HasRows)
                    {
                        if (sqlReader.Read())
                        {
                            seq = Convert.ToInt32(sqlReader["saf21a02_seq"]);
                        }
                    }
                }
            }
            return seq;
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
                    select *

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
                            saf21a.saf21a02_seq = Convert.ToInt32(sqlReader["saf21a02_seq"]);
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
                            saf21a.saf21a12_tax_type = Convert.ToString(sqlReader["saf21a12_tax_type"]);
                            saf21a.saf21a13_tax = Convert.ToInt32(sqlReader["saf21a13_tax"]);
                            saf21a.saf21a11_unit_price = Convert.ToInt32(sqlReader["saf21a11_unit_price"]);
                            saf21a.saf21a49_odds_amt = Convert.ToDecimal(sqlReader["saf21a49_odds_amt"]);
                            saf21a.saf21a50_one_amt = Convert.ToInt32(sqlReader["saf21a50_one_amt"]);
                            saf21a.remark = Convert.ToString(sqlReader["remark"]);
                            saf21a.adduser = Convert.ToString(sqlReader["adduser"]);
                            saf21a.adddate = Convert.ToDateTime(sqlReader["adddate"]);
                            saf21a.moduser = Convert.ToString(sqlReader["moduser"]);
                            saf21a.moddate = Convert.ToString(sqlReader["moddate"]);


                            saf21aList.Add(saf21a);
                        }
                    }
                }
            }
            return saf21aList;
        }
        public static bool Delete(string value, string byCoulmnName)
        {
            if (String.IsNullOrEmpty(value))
            {
                throw new ArgumentNullException("value");
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
                    sqlCmd.Parameters.AddWithValue("@value", value);
                    //backup to inf29d
                    sqlCmd.CommandText = @"

     INSERT INTO [dbo].[saf21ad]
           ([saf21ad00_saf21id]
           ,[status]
           ,[saf21ad01_docno]
           ,[saf21ad02_seq]
           ,[saf21ad02_pcode]
           ,[saf21ad03_relative_no]
           ,[saf21ad07_colorno]
           ,[saf21ad11_unit_price]
           ,[saf21ad12_tax_type]
           ,[saf21ad13_tax]
           ,[saf21ad16_total_qty]
           ,[saf21ad17_add_qty]
           ,[saf21ad18_adj_qty]
           ,[saf21ad30_sug_price]
           ,[saf21ad37_utax_price]
           ,[saf21ad38_discount]
           ,[saf21ad39_total_price]
           ,[saf21ad41_product_name]
           ,[saf21ad43_runit]
           ,[saf21ad46_nrec_qty]
           ,[saf21ad49_odds_amt]
           ,[saf21ad50_one_amt]
           ,[saf21ad51_gift_qty]
           ,[saf21ad52_byself_qty]
           ,[saf21ad54_graphy]
           ,[saf21ad55_cost]
           ,[saf21ad56_box_qty]
           ,[saf21ad57_qty]
           ,[saf21ad58_note]
           ,[saf21ad59_halfway_qty]
           ,[saf21ad60_flag1]
           ,[saf21ad61_chng_price]
           ,[saf21ad62_chg_sub]
           ,[saf21ad63_chg_tax]
           ,[saf21ad64_chg_sum]
           ,[remark]
           ,[adduser]
           ,[adddate]
           ,[moduser]
           ,[moddate]
           ,[saf21ad72_first1]
           ,[saf21ad73_first2]
           ,[saf21ad74_first3]
           ,[saf21ad75_first4]
           ,[saf21ad76_first5]
           ,[saf21ad77_first6]
           ,[saf21ad78_firsta]
           ,[saf21ad78_firstb]
           ,[saf21ad78_firstc]
           ,[saf21ad78_firstd]
           ,[saf21ad78_firste]
           ,[saf21ad78_firstf])
        SELECT [saf21a00_saf21id]
      ,[status]
      ,[saf21a01_docno]
      ,[saf21a02_seq]
      ,[saf21a02_pcode]
      ,[saf21a03_relative_no]
      ,[saf21a07_colorno]
      ,[saf21a11_unit_price]
      ,[saf21a12_tax_type]
      ,[saf21a13_tax]
      ,[saf21a16_total_qty]
      ,[saf21a17_add_qty]
      ,[saf21a18_adj_qty]
      ,[saf21a30_sug_price]
      ,[saf21a37_utax_price]
      ,[saf21a38_discount]
      ,[saf21a39_total_price]
      ,[saf21a41_product_name]
      ,[saf21a43_runit]
      ,[saf21a46_nrec_qty]
      ,[saf21a49_odds_amt]
      ,[saf21a50_one_amt]
      ,[saf21a51_gift_qty]
      ,[saf21a52_byself_qty]
      ,[saf21a54_graphy]
      ,[saf21a55_cost]
      ,[saf21a56_box_qty]
      ,[saf21a57_qty]
      ,[saf21a58_note]
      ,[saf21a59_halfway_qty]
      ,[saf21a60_flag1]
      ,[saf21a61_chng_price]
      ,[saf21a62_chg_sub]
      ,[saf21a63_chg_tax]
      ,[saf21a64_chg_sum]
      ,[remark]
      ,[adduser]
      ,[adddate]
      ,[moduser]
      ,[moddate]
      ,[saf21a72_first1]
      ,[saf21a73_first2]
      ,[saf21a74_first3]
      ,[saf21a75_first4]
      ,[saf21a76_first5]
      ,[saf21a77_first6]
      ,[saf21a78_firsta]
      ,[saf21a78_firstb]
      ,[saf21a78_firstc]
      ,[saf21a78_firstd]
      ,[saf21a78_firste]
      ,[saf21a78_firstf]
  FROM [dbo].[saf21a]
        WHERE 1 = 1";
                    if(byCoulmnName == "saf21a01_docno")
                    {
                        sqlCmd.CommandText += " and saf21a.saf21a01_docno = @value";
                    }
                    if(byCoulmnName == "id")
                    {
                        sqlCmd.CommandText += " and saf21a.id = @value";
                    }

                    count = sqlCmd.ExecuteNonQuery();
                    if (count <= 0)
                    {
                        throw new Exception(String.Format("Backup Saf21a fail on '{0}'", value));
                    }
                    //delete after backup success
                    sqlCmd.CommandText = @"
        DELETE FROM saf21a
        WHERE 1 = 1";
                    if (byCoulmnName == "saf21a01_docno")
                    {
                        sqlCmd.CommandText += " and saf21a.saf21a01_docno = @value";
                    }
                    if (byCoulmnName == "id")
                    {
                        sqlCmd.CommandText += " and saf21a.id = @value";
                    }

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
        public static void Update(Saf21a updateItem)
        {
            using (var conn = new SqlConnection { ConnectionString = MyConnStringList.AzureGoodeasy })
            using (var sqlCmd = conn.CreateCommand())
            {
                conn.Open();

                SqlTransaction transaction = conn.BeginTransaction();
                sqlCmd.Transaction = transaction;

                try
                {
                    sqlCmd.CommandText = @"UPDATE [dbo].[saf21a]
                       SET 
                          [saf21a02_pcode] = @saf21a02_pcode
                          ,[saf21a03_relative_no] = @saf21a03_relative_no
                          ,[saf21a11_unit_price] = @saf21a11_unit_price
                          ,[saf21a12_tax_type] = @saf21a12_tax_type
                          ,[saf21a13_tax] = @saf21a13_tax
                          ,[saf21a16_total_qty] = @saf21a16_total_qty
                          ,[saf21a37_utax_price] = @saf21a37_utax_price
                          ,[saf21a39_total_price] = @saf21a39_total_price
                          ,[saf21a41_product_name] = @saf21a41_product_name
                          ,[saf21a43_runit] = @saf21a43_runit
                          ,[saf21a49_odds_amt] = @saf21a49_odds_amt
                          ,[saf21a50_one_amt] = @saf21a50_one_amt
                          ,[saf21a55_cost] = @saf21a55_cost
                          ,[saf21a56_box_qty] = @saf21a56_box_qty
                          ,[saf21a57_qty] = @saf21a57_qty
                          ,[saf21a61_chng_price] = @saf21a61_chng_price
                          ,[saf21a62_chg_sub] = @saf21a62_chg_sub
                          ,[saf21a63_chg_tax] = @saf21a63_chg_tax
                          ,[saf21a64_chg_sum] = @saf21a64_chg_sum
                          ,[remark] = @remark
                          ,[moduser] = @moduser
                          ,[moddate] = @moddate
                     WHERE id = @id";
                    sqlCmd.Parameters.AddWithValue("@saf21a02_pcode", updateItem.saf21a02_pcode);
                    sqlCmd.Parameters.AddWithValue("@saf21a03_relative_no", updateItem.saf21a03_relative_no);
                    sqlCmd.Parameters.AddWithValue("@saf21a11_unit_price", updateItem.saf21a11_unit_price);
                    sqlCmd.Parameters.AddWithValue("@saf21a12_tax_type", updateItem.saf21a12_tax_type);
                    sqlCmd.Parameters.AddWithValue("@saf21a13_tax", updateItem.saf21a13_tax);
                    sqlCmd.Parameters.AddWithValue("@saf21a16_total_qty", updateItem.saf21a16_total_qty);
                    sqlCmd.Parameters.AddWithValue("@saf21a37_utax_price", updateItem.saf21a37_utax_price);
                    sqlCmd.Parameters.AddWithValue("@saf21a39_total_price", updateItem.saf21a39_total_price);
                    sqlCmd.Parameters.AddWithValue("@saf21a41_product_name", updateItem.saf21a41_product_name);
                    sqlCmd.Parameters.AddWithValue("@saf21a43_runit", updateItem.saf21a43_runit);
                    sqlCmd.Parameters.AddWithValue("@saf21a49_odds_amt", updateItem.saf21a49_odds_amt);
                    sqlCmd.Parameters.AddWithValue("@saf21a50_one_amt", updateItem.saf21a50_one_amt);
                    sqlCmd.Parameters.AddWithValue("@saf21a55_cost", updateItem.saf21a55_cost);
                    sqlCmd.Parameters.AddWithValue("@saf21a56_box_qty", updateItem.saf21a56_box_qty);
                    sqlCmd.Parameters.AddWithValue("@saf21a57_qty", updateItem.saf21a57_qty);
                    sqlCmd.Parameters.AddWithValue("@saf21a61_chng_price", updateItem.saf21a61_chng_price);
                    sqlCmd.Parameters.AddWithValue("@saf21a62_chg_sub", updateItem.saf21a62_chg_sub);
                    sqlCmd.Parameters.AddWithValue("@saf21a63_chg_tax", updateItem.saf21a63_chg_tax);
                    sqlCmd.Parameters.AddWithValue("@saf21a64_chg_sum", updateItem.saf21a64_chg_sum);
                    sqlCmd.Parameters.AddWithValue("@remark", updateItem.remark);
                    sqlCmd.Parameters.AddWithValue("@moduser", updateItem.moduser);
                    sqlCmd.Parameters.AddWithValue("@moddate", updateItem.moddate);
                    sqlCmd.Parameters.AddWithValue("@id", updateItem.id);
                    sqlCmd.ExecuteNonQuery();

                    transaction.Commit();
                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    throw;
                }
            }
        }
    }
}
