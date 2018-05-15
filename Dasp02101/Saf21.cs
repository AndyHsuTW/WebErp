using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ErpBaseLibrary.DB;
using System.Data;

namespace Dsap02101
{
    public class Saf21
    {
        #region properties from database

        public int id { get; set; }

        public string saf2101_docno { get; set; }

        public string saf2101_bcode { get; set; }

        public string saf2101_docno_type { get; set; }

        public DateTime saf2101_docno_date { get; set; }

        public int saf2101_docno_orderno { get; set; }

        public DateTime saf2106_order_date { get; set; }

        public string saf2108_customer_code { get; set; }

        public string saf2109_salesid { get; set; }

        public DateTime saf2110_del_date { get; set; }

        public string saf2114_payment { get; set; }

        public string saf2115_period { get; set; }

        public string saf2120_ls_po_no { get; set; }

        public DateTime saf2121_last_del_date { get; set; }

        public string saf2122_agent { get; set; }

        public string saf2123_delivery_place_no { get; set; }

        public string saf2124_blandid { get; set; }

        public double saf2125_po_type { get; set; }

        public string saf2126_print_times { get; set; }

        public string saf2127_delivery_type { get; set; }

        public string saf2128_currency { get; set; }

        public double saf2129_exchange_rate { get; set; }

        public string saf2131_faxno { get; set; }
        public DateTime saf2132_yyyymm { get; set; }
        public int saf2133_seq2 { get; set; }
        public DateTime saf2134_p_po_time { get; set; }
        public string saf2135_rec_customer_code { get; set; }
        public string saf2136_customer_order_no { get; set; }
        public int saf2139_total_price { get; set; }
        public string saf2140_bcode { get; set; }
        public string saf2140_docno_type { get; set; }
        public DateTime saf2140_docno_date { get; set; }
        public int saf2140_docno_seq { get; set; }
        public string saf2142_delivery_place { get; set; }
        public string saf2144_bcode { get; set; }
        public string saf2145_open_id { get; set; }
        public string saf2145_docno_type { get; set; }
        public DateTime saf2145_docno_date { get; set; }
        public int saf2145_docno_orderno { get; set; }
        public string saf2147_recid { get; set; }
        public string saf2148_magazine_no { get; set; }
        public string saf2153_delivery_id { get; set; }
        public string saf2156_take_no { get; set; }
        public string saf2159_way { get; set; }
        public string remark { get; set; }
        public string adduser { get; set; }
        public DateTime adddate { get; set; }
        public string moduser { get; set; }
        public DateTime moddate { get; set; }
        public string verifyuser { get; set; }
        public DateTime verifydate { get; set; }
        public string cmf0103_bname { get; set; }
        public string taf1002_firstname { get; set; }
        public int taf1019_tel1 { get; set; }
        public int taf1031_cellphone { get; set; }

        #endregion



        public class FilterOption
        {
            /// <summary>
            /// 訂單日期
            /// </summary>
            public DateTime? saf2106_order_date_start { get; set; }
            public DateTime? saf2106_order_date_end { get; set; }

            /// <summary>
            /// 商品編號
            /// </summary>
            public string saf21a02_pcode_start { get; set; }
            public string saf21a02_pcode_end { get; set; }

            /// <summary>
            /// 產品貨號
            /// </summary>
            public string saf21a03_relative_no_start { get; set; }
            public string saf21a03_relative_no_end { get; set; }

            /// <summary>
            /// 客戶代號
            /// </summary>
            public string saf2108_customer_code_start { get; set; }
            public string saf2108_customer_code_end { get; set; }

            /// <summary>
            /// 新增日期
            /// </summary>
            public DateTime? adddate_start { get; set; }
            public DateTime? adddate_end { get; set; }

            /// <summary>
            /// 訂單單號
            /// </summary>
            public string saf2101_docno_type_start { get; set; }
            public string saf2101_docno_type_end { get; set; }

            /// <summary>
            /// 訂單單號
            /// </summary>
            public DateTime? saf2101_docno_date_start { get; set; }
            public DateTime? saf2101_docno_date_end { get; set; }

            /// <summary>
            /// 訂單單號
            /// </summary>
            public int? saf2101_docno_orderno_start { get; set; }
            public int? saf2101_docno_orderno_end { get; set; }

            /// <summary>
            /// 公司代號
            /// </summary>
            public string saf2101_bcode_start { get; set; }
            public string saf2101_bcode_end { get; set; }

            public string keyword { get; set; }
            /// <summary>
            /// 顯示"數量"欄位
            /// </summary>
            public double? Qty { get; set; }
        }

        public List<Saf21a> Saf21aList { get; set; }

        public static List<Saf21> Search(FilterOption filterOption)
        {

            List<Saf21> saf21List = new List<Saf21>();



            using (var conn = new SqlConnection { ConnectionString = MyConnStringList.AzureGoodeasy })
            using (var sqlCmd = conn.CreateCommand())
            {
                conn.Open();
                var idFilter = "";
                var idListFilter = "";
                var saf2106OrderDateFilter = "";
                var saf21a02PcodeFilter = "";
                var saf21a03RelativeNoFilter = "";
                var inf2906RefFilter = "";
                var saf2108CustomerCodeFilter = "";
                var saf2101DocnoTypeFilter = "";
                var saf2101DocnoDateFilter = "";
                var saf2101DocnoOrdernoFilter = "";
                var saf2101BcodeFilter = "";
                var adddateFilter = "";
                var QtyFilter = "";
                if (filterOption != null)
                {
                    if (!String.IsNullOrEmpty(filterOption.keyword))
                    {
                        List<int> idList = new List<int>();
                        sqlCmd.CommandText = "Saf21_FindStringInTable";
                        sqlCmd.CommandType = CommandType.StoredProcedure;

                        sqlCmd.Parameters.AddWithValue("@stringToFind", filterOption.keyword);

                        using (var sqlReader = sqlCmd.ExecuteReader())
                        {
                            if (sqlReader.HasRows)
                            {
                                while (sqlReader.Read())
                                {
                                    idList.Add(sqlReader.GetInt32(0));
                                }
                            }
                        }
                        sqlCmd.CommandType = CommandType.Text;
                        sqlCmd.Parameters.Clear();
                    }
                    if (filterOption.saf2106_order_date_start != null)
                    {
                        saf2106OrderDateFilter = String.Format(@" AND (
                            saf21.[saf2106_order_date] >= @saf2106OrderDateStart 
                            AND saf21.[saf2106_order_date] <= @saf2106_order_date_end 
                            )");
                        sqlCmd.Parameters.AddWithValue("@saf2106OrderDateStart", filterOption.saf2106_order_date_start);
                        sqlCmd.Parameters.AddWithValue("@saf2106_order_date_end", filterOption.saf2106_order_date_end == null ?
                                                        filterOption.saf2106_order_date_start : filterOption.saf2106_order_date_end);
                    }
                    if (!String.IsNullOrEmpty(filterOption.saf21a02_pcode_start))
                    {
                        saf21a02PcodeFilter = String.Format(@" AND (
                            saf21a.[saf21a02_pcode] >= @saf21a02PCodeStart 
                            AND saf21a.[saf21a02_pcode] <= @saf21a02PCodeEnd 
                            )");
                        sqlCmd.Parameters.AddWithValue("@saf21a02PCodeStart", filterOption.saf21a02_pcode_start);
                        sqlCmd.Parameters.AddWithValue("@saf21a02PCodeEnd",
                                                       String.IsNullOrEmpty(filterOption.saf21a02_pcode_end)
                                                           ? filterOption.saf21a02_pcode_start
                                                           : filterOption.saf21a02_pcode_end);
                    }
                    if (filterOption.saf21a03_relative_no_start != null)
                    {
                        saf21a03RelativeNoFilter = String.Format(@" AND (
                            saf21a.[saf21a03_relative_no] >= @saf21a03RelativeNoStart 
                            AND saf21a.[saf21a03_relative_no] <= @saf21a03RelativeNoEnd 
                            )");
                        sqlCmd.Parameters.AddWithValue("@saf21a03RelativeNoStart", filterOption.saf21a03_relative_no_start);
                        sqlCmd.Parameters.AddWithValue("@saf21a03RelativeNoEnd",
                                                       String.IsNullOrEmpty(filterOption.saf21a03_relative_no_end)
                                                           ? filterOption.saf21a02_pcode_start
                                                           : filterOption.saf21a03_relative_no_end);
                    }
                    if (!String.IsNullOrEmpty(filterOption.saf2108_customer_code_start))
                    {
                        saf2108CustomerCodeFilter = String.Format(@" AND (
                            saf21.[saf2108_customer_code] >= @saf2108CustomerCodeStart 
                            AND saf21.[saf2108_customer_code] <= @saf2108CustomerCodeEnd 
                            )");
                        sqlCmd.Parameters.AddWithValue("@saf2108CustomerCodeStart", filterOption.saf2108_customer_code_start);
                        sqlCmd.Parameters.AddWithValue("@saf2108CustomerCodeEnd",
                                                        String.IsNullOrEmpty(filterOption.saf2108_customer_code_end)
                                                           ? filterOption.saf2108_customer_code_start
                                                           : filterOption.saf2108_customer_code_end);
                    }
                    if (!String.IsNullOrEmpty(filterOption.saf2101_docno_type_start))
                    {
                        saf2101DocnoTypeFilter = String.Format(@" AND (
                            saf21.[saf2101_docno_type] >= @saf2101DocnoTypeStart 
                            AND saf21.[saf2101_docno_type] <= @saf2101DocnoTypeEnd
                            )");
                        sqlCmd.Parameters.AddWithValue("@saf2101DocnoTypeStart", filterOption.saf2101_docno_type_start);
                        sqlCmd.Parameters.AddWithValue("@saf2101DocnoTypeEnd",
                                                        String.IsNullOrEmpty(filterOption.saf2101_docno_type_end)
                                                           ? filterOption.saf2101_docno_type_start
                                                           : filterOption.saf2101_docno_type_end);
                    }
                    if (filterOption.saf2101_docno_date_start != null)
                    {
                        saf2101DocnoDateFilter = String.Format(@" AND (
                            saf21.[saf2101_docno_date] >= @saf2101DocnoDateStart 
                            AND saf21.[saf2101_docno_date] <= @saf2101DocnoDateEnd 
                            )");
                        sqlCmd.Parameters.AddWithValue("@saf2101DocnoDateStart", filterOption.saf2101_docno_date_start);
                        sqlCmd.Parameters.AddWithValue("@saf2101DocnoDateEnd",
                                                       filterOption.saf2101_docno_date_end == null
                                                           ? filterOption.saf2101_docno_date_start
                                                           : filterOption.saf2101_docno_date_end);
                    }
                    if (filterOption.saf2101_docno_orderno_start > 0)
                    {
                        saf2101DocnoOrdernoFilter = String.Format(@" AND (
                            saf21.[saf2101_docno_orderno] >= @saf2101DocnoOrdernoStart 
                            AND saf21.[saf2101_docno_orderno] <= @saf2101DocnoOrdernoEnd 
                            )");
                        sqlCmd.Parameters.AddWithValue("@saf2101DocnoOrdernoStart", filterOption.saf2101_docno_orderno_start);
                        sqlCmd.Parameters.AddWithValue("@saf2101DocnoOrdernoEnd",
                                                      filterOption.saf2101_docno_orderno_end < 0 || filterOption.saf2101_docno_orderno_end == null
                                                           ? filterOption.saf2101_docno_orderno_start
                                                           : filterOption.saf2101_docno_orderno_end);
                    }
                    if (!String.IsNullOrEmpty(filterOption.saf2101_bcode_start))
                    {
                        saf2101BcodeFilter = String.Format(@" AND (
                            saf21.[saf2101_bcode] >= @saf2101BcodeStart 
                            AND saf21.[saf2101_bcode] <= @saf2101BcodeEnd 
                            )");
                        sqlCmd.Parameters.AddWithValue("@saf2101BcodeStart", filterOption.saf2101_bcode_start);
                        sqlCmd.Parameters.AddWithValue("@saf2101BcodeEnd",
                                                       String.IsNullOrEmpty(filterOption.saf2101_bcode_end)
                                                           ? filterOption.saf2101_bcode_start
                                                           : filterOption.saf2101_bcode_end);
                    }
                    if (filterOption.adddate_start != null)
                    {
                        adddateFilter = String.Format(@" AND (
                            saf21.[adddate] >= @AddDateStart
                            AND saf21.[adddate] <= @AddDateEnd 
                            )");
                        sqlCmd.Parameters.AddWithValue("@AddDateStart", filterOption.adddate_start);
                        sqlCmd.Parameters.AddWithValue("@AddDateEnd",
                                                       filterOption.adddate_end == null
                                                           ? filterOption.adddate_start
                                                           : filterOption.adddate_end);
                    }
                    if (filterOption.Qty > 0)
                    {
                        QtyFilter = String.Format(@" AND (
                            saf21aa.[qty] >= @Qty
                            )");
                        sqlCmd.Parameters.AddWithValue("@Qty", filterOption.Qty);
                    }


                }

                sqlCmd.CommandText = String.Format(@"
        SELECT saf21.id,
			   saf21.[saf2133_seq2]
			  ,saf21.[saf2101_docno]
              ,saf21.[saf2101_docno_type],
			   saf21.[saf2101_docno_date],
			   saf21.[saf2106_order_date]
              ,saf21.[saf2139_total_price]
              ,saf21.[saf2108_customer_code]
              ,cmf01.[cmf0103_bname]
              ,saf21.[saf2147_recid]
			  ,taf10.[taf1002_firstname]
              ,taf10.[taf1019_tel1]
              ,taf10.[taf1031_cellphone]
			  ,saf21aa.qty
			  ,saf21a.remark

          FROM [dbo].[saf21] 
        LEFT JOIN dbo.cmf01
            ON cmf01.cmf0102_cuscode = saf21.saf2108_customer_code
		LEFT JOIN dbo.taf10
			on taf10.taf1001_empid = saf21.saf2147_recid
        left join dbo.saf21a
            on saf21a.saf21a01_docno = saf21.saf2101_docno
		left join (select max(saf21a.saf21a16_total_qty) as qty, saf21a.saf21a01_docno from dbo.saf21a  GROUP  BY  saf21a.saf21a01_docno) as saf21aa
			on saf21aa.saf21a01_docno = saf21.saf2101_docno
        WHERE 1=1
        {0}
        {1}
        {2}
        {3}
        {4}
        {5}
        {6}
        {7}
        {8}
        {9}
        {10}
        {11}
        {12}", idFilter,
                saf2106OrderDateFilter,
                saf21a02PcodeFilter,
                saf21a03RelativeNoFilter,
                inf2906RefFilter,
                saf2108CustomerCodeFilter,
                saf2101DocnoTypeFilter,
                saf2101DocnoDateFilter,
                saf2101DocnoOrdernoFilter,
                saf2101BcodeFilter,
                adddateFilter,
                QtyFilter,
                idListFilter
                );

                using (var sqlReader = sqlCmd.ExecuteReader())
                {
                    if (sqlReader.HasRows)
                    {
                        while (sqlReader.Read())
                        {
                            Saf21 saf21 = new Saf21();
                            saf21.id = Convert.ToInt32(sqlReader["id"]);
                            saf21.saf2133_seq2 = Convert.ToInt32(sqlReader["saf2133_seq2"]);
                            saf21.saf2101_docno = Convert.ToString(sqlReader["saf2101_docno"]);
                            saf21.saf2101_docno_date = Convert.ToDateTime(sqlReader["saf2101_docno_date"]);
                            //try { saf21.saf2101_docno_orderno = Convert.ToInt32(sqlReader["saf2101_docno_orderno"]); }catch(Exception e) { var a = e.Message; }
                            saf21.saf2101_docno_type = Convert.ToString(sqlReader["saf2101_docno_type"]);
                            saf21.saf2106_order_date = Convert.ToDateTime(sqlReader["saf2106_order_date"]);
                            saf21.saf2139_total_price = Convert.ToInt32(sqlReader["saf2139_total_price"]);
                            saf21.saf2108_customer_code = Convert.ToString(sqlReader["saf2108_customer_code"]);
                            saf21.cmf0103_bname = Convert.ToString(sqlReader["cmf0103_bname"]);
                            saf21.taf1002_firstname = Convert.ToString(sqlReader["taf1002_firstname"]);
                            saf21.taf1019_tel1 = Convert.ToInt32(sqlReader["taf1019_tel1"]);
                            saf21.taf1031_cellphone = Convert.ToInt32(sqlReader["taf1031_cellphone"]);
                            saf21.remark = Convert.ToString(sqlReader["remark"]);




                            saf21List.Add(saf21);
                        }
                    }
                }
            }
            return saf21List;
        }
        public static Saf21 AddItem(Saf21 saf21)
        {
            if (saf21 == null)
            {
                throw new ArgumentNullException("saf21");
            }

            var lastDocSeq = GetLastDocnoSeq(saf21.saf2101_docno_type, saf21.saf2101_docno_date);
            saf21.saf2101_docno_orderno = ++lastDocSeq;

            saf21.saf2101_docno = saf21.saf2101_docno + saf21.saf2101_docno_type+
                                  saf21.saf2101_docno_date.ToString("yyyyMMdd") +
                                  saf21.saf2101_docno_orderno.ToString("0000");

            using (var conn = new SqlConnection { ConnectionString = MyConnStringList.AzureGoodeasy })
            using (var sqlCmd = conn.CreateCommand())
            {
                conn.Open();
                sqlCmd.CommandText = @"
    INSERT INTO [dbo].[saf21]
           ([saf2101_docno]
           ,[status]
           ,[saf2101_bcode]
           ,[saf2101_docno_type]
           ,[saf2101_docno_date]
           ,[saf2101_docno_orderno]
           ,[saf2106_order_date]
           ,[saf2108_customer_code]
           ,[saf2109_salesid]
           ,[saf2110_del_date]
           ,[saf2114_payment]
           ,[saf2115_period]
           ,[saf2120_ls_po_no]
           ,[saf2121_last_del_date]
           ,[saf2122_agent]
           ,[saf2123_delivery_place_no]
           ,[saf2124_blandid]
           ,[saf2125_po_type]
           ,[saf2126_print_times]
           ,[saf2127_delivery_type]
           ,[saf2128_currency]
           ,[saf2129_exchange_rate]
           ,[saf2131_faxno]
           ,[saf2132_yyyymm]
           ,[saf2133_seq2]
           ,[saf2134_p_po_time]
           ,[saf2135_rec_customer_code]
           ,[saf2136_customer_order_no]
           ,[saf2139_total_price]
           ,[saf2140_bcode]
           ,[saf2140_docno_type]
           ,[saf2140_docno_date]
           ,[saf2140_docno_seq]
           ,[saf2142_delivery_place]
           ,[saf2144_bcode]
           ,[saf2145_open_id]
           ,[saf2145_docno_type]
           ,[saf2145_docno_date]
           ,[saf2145_docno_orderno]
           ,[saf2147_recid]
           ,[saf2148_magazine_no]
           ,[saf2153_delivery_id]
           ,[saf2156_take_no]
           ,[saf2159_way]
           ,[remark])
     OUTPUT INSERTED.ID
     VALUES
           (@saf2101_docno
           ,''
           ,@saf2101_bcode
           ,@saf2101_docno_type
           ,@saf2101_docno_date
           ,@saf2101_docno_orderno
           ,@saf2106_order_date
           ,@saf2108_customer_code
           ,''
           ,null
           ,@saf2114_payment
           ,''
           ,''
           ,null
           ,''
           ,''
           ,''
           ,''
           ,''
           ,''
           ,@saf2128_currency
           ,@saf2129_exchange_rate
           ,''
           ,null
           ,0
           ,@saf2134_p_po_time
           ,@saf2108_customer_code
           ,''
           ,@saf2139_total_price
           ,''
           ,''
           ,null
           ,0
           ,''
           ,''
           ,''
           ,''
           ,null
           ,0
           ,@saf2147_recid
           ,''
           ,''
           ,''
           ,''
           ,@remark);";
                sqlCmd.Parameters.AddWithValue("@saf2101_docno", saf21.saf2101_docno);
                sqlCmd.Parameters.AddWithValue("@saf2101_bcode", saf21.saf2101_bcode);
                sqlCmd.Parameters.AddWithValue("@saf2101_docno_type", saf21.saf2101_docno_type);
                sqlCmd.Parameters.AddWithValue("@saf2101_docno_date", saf21.saf2101_docno_date);
                sqlCmd.Parameters.AddWithValue("@saf2101_docno_orderno", saf21.saf2101_docno_orderno);
                sqlCmd.Parameters.AddWithValue("@saf2106_order_date", saf21.saf2106_order_date);
                sqlCmd.Parameters.AddWithValueSafe("@saf2108_customer_code", saf21.saf2108_customer_code);
                sqlCmd.Parameters.AddWithValue("@saf2114_payment", saf21.saf2114_payment);
                sqlCmd.Parameters.AddWithValue("@saf2128_currency", saf21.saf2128_currency);
                sqlCmd.Parameters.AddWithValue("@saf2129_exchange_rate", saf21.saf2129_exchange_rate);
                sqlCmd.Parameters.AddWithValue("@saf2139_total_price", saf21.saf2139_total_price);
                sqlCmd.Parameters.AddWithValue("@saf2147_recid", saf21.saf2147_recid);
                sqlCmd.Parameters.AddWithValue("@remark", saf21.remark);
                sqlCmd.Parameters.AddWithValueSafe("@saf2134_p_po_time", saf21.saf2134_p_po_time);

                /*sqlCmd.Parameters.AddWithValue("@inf2901_docno", inf29.inf2901_docno);
                sqlCmd.Parameters.AddWithValue("@inf2901_bcode", inf29.inf2901_bcode);
                sqlCmd.Parameters.AddWithValue("@inf2902_docno_type", inf29.inf2902_docno_type);
                sqlCmd.Parameters.AddWithValue("@inf2902_docno_date", inf29.inf2902_docno_date);
                sqlCmd.Parameters.AddWithValue("@inf2902_docno_seq", inf29.inf2902_docno_seq);
                sqlCmd.Parameters.AddWithValueSafe("@inf2903_customer_code", inf29.inf2903_customer_code);
                sqlCmd.Parameters.AddWithValueDatetimeSafe("@inf2904_pro_date", inf29.inf2904_pro_date);
                sqlCmd.Parameters.AddWithValueSafe("@inf2906_wherehouse", inf29.inf2906_wherehouse);
                sqlCmd.Parameters.AddWithValueSafe("@inf2906_ref_no_type", inf29.inf2906_ref_no_type);
                sqlCmd.Parameters.AddWithValueSafe("@inf2906_ref_no_date", inf29.inf2906_ref_no_date);
                sqlCmd.Parameters.AddWithValueSafe("@inf2906_ref_no_seq", inf29.inf2906_ref_no_seq);
                sqlCmd.Parameters.AddWithValueSafe("@inf2910_in_reason", inf29.inf2910_in_reason);
                sqlCmd.Parameters.AddWithValueSafe("@inf2911_sub_amt", inf29.Inf29aList.Sum(o => o.inf29a38_one_amt));
                sqlCmd.Parameters.AddWithValueSafe("@inf2914_inv_eff", inf29.inf2914_inv_eff);
                sqlCmd.Parameters.AddWithValueSafe("@inf2916_apr_empid", inf29.inf2916_apr_empid);
                sqlCmd.Parameters.AddWithValueSafe("@inf2952_project_no", inf29.inf2952_project_no);
                sqlCmd.Parameters.AddWithValue("@inf2928_currency", inf29.inf2928_currency);
                sqlCmd.Parameters.AddWithValue("@inf2929_exchange_rate", inf29.inf2929_exchange_rate);
                sqlCmd.Parameters.AddWithValueSafe("@remark", inf29.remark);
                sqlCmd.Parameters.AddWithValue("@adduser", inf29.adduser);
                sqlCmd.Parameters.AddWithValue("@adddate", inf29.adddate);
                */
                var id = (int)sqlCmd.ExecuteScalar();
                saf21.id = id;
            }

            return saf21;
        }
        /*public static int AddItem(ImportItemRow inf29Row)
        {
            if (inf29Row == null)
            {
                throw new ArgumentNullException("inf29Row");
            }

            var lastDocSeq = GetLastDocnoSeq(inf29Row["inf2902_docno_type"].ToString(), Convert.ToDateTime(inf29Row["inf2902_docno_date"]));

            int inf2902_docno_seq = ++lastDocSeq;

            string inf2901_docno = inf29Row["inf2901_bcode"].ToString() + inf29Row["inf2902_docno_type"].ToString() +
                                   Convert.ToDateTime(inf29Row["inf2902_docno_date"]).ToString("yyyyMMdd") +
                                   inf2902_docno_seq.ToString("0000");

            var fields = inf29Row.Keys.ToArray();
            string fieldNamesSql = String.Join(", ", fields);
            string paramsFieldsSql = String.Join(",@", fields);

            using (var conn = new SqlConnection { ConnectionString = MyConnStringList.AzureGoodeasy })
            using (var sqlCmd = conn.CreateCommand())
            {
                conn.Open();
                sqlCmd.CommandText = String.Format(@"
    INSERT INTO [dbo].[inf29]
        (
        inf2901_docno
        ,inf2902_docno_seq
        ,adduser
        ,adddate
        ,{0})
    OUTPUT INSERTED.ID
        VALUES
        (
        @inf2901_docno
        ,@inf2902_docno_seq
        ,@adduser
        ,@adddate
        ,@{1} ) ", fieldNamesSql, paramsFieldsSql);

                sqlCmd.Parameters.AddWithValueSafe("@inf2901_docno", inf2901_docno);
                sqlCmd.Parameters.AddWithValueSafe("@inf2902_docno_seq", inf2902_docno_seq);
                sqlCmd.Parameters.AddWithValueSafe("@adduser", inf29Row.adduser);
                sqlCmd.Parameters.AddWithValue("@adddate", inf29Row.adddate);

                foreach (var field in fields)
                {
                    sqlCmd.Parameters.AddWithValueSafe("@" + field, inf29Row[field]);
                }

                int id = (int)sqlCmd.ExecuteScalar();
                return id;
            }
        }*/

        public static int GetLastDocnoSeq(string docnoType, DateTime docnoDate)
        {
            var seq = -1;

            using (var conn = new SqlConnection { ConnectionString = MyConnStringList.AzureGoodeasy })
            using (var sqlCmd = conn.CreateCommand())
            {
                conn.Open();
                sqlCmd.CommandText = @"
        SELECT TOP 1 saf2101_docno_orderno
            FROM [saf21]
        WHERE saf2101_docno_type = @docnoType
        AND saf2101_docno_date = @docnoDate
        ORDER BY saf2101_docno_orderno DESC
        ";
                sqlCmd.Parameters.AddWithValue("@docnoType", docnoType);
                sqlCmd.Parameters.AddWithValue("@docnoDate", docnoDate);

                using (var sqlReader = sqlCmd.ExecuteReader())
                {
                    if (sqlReader.HasRows)
                    {
                        if (sqlReader.Read())
                        {
                            seq = Convert.ToInt32(sqlReader["saf2101_docno_orderno"]);
                        }
                    }
                }
            }
            return seq;
        }
    }
}
