<%@ WebHandler Language="C#" Class="Inf20Handler" %>

using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using DCNP005;
using Dinp02301;
using ErpBaseLibrary.DB;
using Newtonsoft.Json;

public class Inf20Handler : IHttpHandler
{
    /// <summary>
    /// Request.Form["act"]
    /// </summary>
    public string Action { get; set; }
    /// <summary>
    /// Request.Form["data"]
    /// </summary>
    public string Data { get; set; }
    /// <summary>
    /// Request.Form["inf29fields"]
    /// </summary>
    public string Inf20Fields { get; set; }
    /// <summary>
    /// Request.Form["inf29afields"]
    /// </summary>
    public string Inf20aFields { get; set; }
    /// <summary>
    /// Request.Form["printBcode"]
    /// </summary>
    public string PrintBcode { get; set; }
    /// <summary>
    /// Request.Form["user"]
    /// </summary>
    public string User { get; set; }
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        this.Action = context.Request.Form["act"];
        this.Data = context.Request.Form["data"];
        this.PrintBcode = context.Request.Form["printBcode"];
        this.User = context.Request.Form["user"];

        if (this.Action == null) return;
        switch (this.Action.ToLower())
        {
            case "get":
                {
                    var filterOption = JsonConvert.DeserializeObject<FilterOption>(this.Data);
                    var inf20List = Search(filterOption);
                    context.Response.ContentType = "text/plain";
                    context.Response.Write(JsonConvert.SerializeObject(inf20List));

                    return;
                }
                break;
            case "getdetail":
                {
                    var inf20aList = GetList(this.Data);
                    context.Response.ContentType = "text/plain";
                    context.Response.Write(JsonConvert.SerializeObject(inf20aList));
                    return;
                }
                break;
            case "del":
                {

                    var Re = Delete(this.Data);

                    context.Response.ContentType = "text/plain";
                    context.Response.Write(Re);
                    return;
                }
                break;
            case "export":
                {
                    var inf20FieldNameList = JsonConvert.DeserializeObject<Cnf05[]>(this.Inf20Fields);
                    var inf20aFieldNameList = JsonConvert.DeserializeObject<Cnf05[]>(this.Inf20aFields);

                    List<int> inf20IdList = JsonConvert.DeserializeObject<List<int>>(this.Data);

                    context.Session["in20ExportFields"] = inf20FieldNameList;
                    context.Session["in20aExportFields"] = inf20aFieldNameList;
                    context.Session["exportItems"] = inf20IdList;
                    context.Session["exportExcelVersion"] = 2003;
                }
                break;
            case "print":
                {
                    List<int> inf29IdList = JsonConvert.DeserializeObject<List<int>>(this.Data);
                    context.Session["printItems"] = inf29IdList;
                    if (this.PrintBcode != null)
                    {
                        context.Session["printBcode"] = JsonConvert.DeserializeObject<Cnf07>(this.PrintBcode);
                    }

                    context.Response.Write(Guid.NewGuid().ToString());
                    return;
                }
                break;

        }
        context.Response.ContentType = "text/plain";
        context.Response.Write("ok");

    }

    public static string Delete(string docno)
    {
        if (String.IsNullOrEmpty(docno))
        {
            throw new ArgumentNullException("docno");
        }

        using (var conn = new SqlConnection(MyConnStringList.AzureGoodeasy))
        {
            conn.Open();

            var cmd = conn.CreateCommand();
            var transaction = conn.BeginTransaction();
            cmd.Transaction = transaction;
            try
            {


                cmd.CommandText = @"
           --backup to inf20ad
            INSERT INTO [dbo].[inf20ad]
           ([inf20a00_inf20id]
           ,[status]
           ,[inf20a01_docno]
           ,[inf20a02_seq]
           ,[inf20a04_pcode]
           ,[inf20a04_shoes_code]
           ,[inf20a05_mcode]
           ,[inf20a06_qty]
           ,[inf20a07_ocost]
           ,[inf20a07_cost]
           ,[inf20a08_oretail]
           ,[inf20a08_retail]
           ,[inf20a09_sub_amt]
           ,[inf20a10_dis_flag]
           ,[inf20a10_dis_rate]
           ,[inf20a11_nrec_qty]
           ,[inf20a11_halfway_qty]
           ,[inf20a12_dis_qty]
           ,[inf20a13_r_dis_qty]
           ,[inf20a14_remark]
           ,[inf20a15_stock_key]
           ,[inf20a16_punit]
           ,[inf20a17_runit]
           ,[inf20a18_pqty]
           ,[inf20a19_pay_term]
           ,[inf20a20_factor1]
           ,[inf20a21_factor2]
           ,[inf20a22_ship_qty]
           ,[inf20a23_ship_docno]
           ,[inf20a23_box_qty]
           ,[inf20a23_qty]
           ,[inf20a24_tax]
           ,[inf20a25_rec_sub]
           ,[inf20a26_tax_bay]
           ,[inf20a27_order_sum]
           ,[inf20a28_lc_date]
           ,[inf20a29_magazine_no]
           ,[inf20a30_allow_date]
           ,[inf20a31_true_date]
           ,[inf20a32_dell_qty]
           ,[inf20a32_dell_date]
           ,[inf20a33_order_no]
           ,[inf20a33_status]
           ,[inf20a34_materiel_no]
           ,[inf20a35_frequency]
           ,[inf20a36_currency]
           ,[inf20a37_exchnge_rate]
           ,[inf20a38_product_name]
           ,[inf20a39_odds_amt]
           ,[inf20a40_one_amt]
           ,[inf20a41_tax]
           ,[inf20a42_reply_qty]
           ,[inf20a43_reply_no]
           ,[inf20a44_reply]
           ,[inf20a45_flag1]
           ,[inf20a46_pcat]
           ,[inf20a47_psupply]
           ,[inf20a48_un_no]
           ,[inf20a49_qty]
           ,[inf20a50_vcode]
           ,[inf20a51_payto]
           ,[inf20a52_docno_type]
           ,[inf20a53_docno_date]
           ,[inf20a54_docno_seq]
           ,[inf20a55_seqno]
           ,[inf20a56_note]
           ,[inf20a57_pclass]
           ,[remark]
           ,[adduser]
           ,[adddate]
           ,[moduser]
           ,[moddate]
           ,[verifyuser]
           ,[verifydate])
     SELECT 
	 [inf20a00_inf20id]
           ,[status]
           ,[inf20a01_docno]
           ,[inf20a02_seq]
           ,[inf20a04_pcode]
           ,[inf20a04_shoes_code]
           ,[inf20a05_mcode]
           ,[inf20a06_qty]
           ,[inf20a07_ocost]
           ,[inf20a07_cost]
           ,[inf20a08_oretail]
           ,[inf20a08_retail]
           ,[inf20a09_sub_amt]
           ,[inf20a10_dis_flag]
           ,[inf20a10_dis_rate]
           ,[inf20a11_nrec_qty]
           ,[inf20a11_halfway_qty]
           ,[inf20a12_dis_qty]
           ,[inf20a13_r_dis_qty]
           ,[inf20a14_remark]
           ,[inf20a15_stock_key]
           ,[inf20a16_punit]
           ,[inf20a17_runit]
           ,[inf20a18_pqty]
           ,[inf20a19_pay_term]
           ,[inf20a20_factor1]
           ,[inf20a21_factor2]
           ,[inf20a22_ship_qty]
           ,[inf20a23_ship_docno]
           ,[inf20a23_box_qty]
           ,[inf20a23_qty]
           ,[inf20a24_tax]
           ,[inf20a25_rec_sub]
           ,[inf20a26_tax_bay]
           ,[inf20a27_order_sum]
           ,[inf20a28_lc_date]
           ,[inf20a29_magazine_no]
           ,[inf20a30_allow_date]
           ,[inf20a31_true_date]
           ,[inf20a32_dell_qty]
           ,[inf20a32_dell_date]
           ,[inf20a33_order_no]
           ,[inf20a33_status]
           ,[inf20a34_materiel_no]
           ,[inf20a35_frequency]
           ,[inf20a36_currency]
           ,[inf20a37_exchnge_rate]
           ,[inf20a38_product_name]
           ,[inf20a39_odds_amt]
           ,[inf20a40_one_amt]
           ,[inf20a41_tax]
           ,[inf20a42_reply_qty]
           ,[inf20a43_reply_no]
           ,[inf20a44_reply]
           ,[inf20a45_flag1]
           ,[inf20a46_pcat]
           ,[inf20a47_psupply]
           ,[inf20a48_un_no]
           ,[inf20a49_qty]
           ,[inf20a50_vcode]
           ,[inf20a51_payto]
           ,[inf20a52_docno_type]
           ,[inf20a53_docno_date]
           ,[inf20a54_docno_seq]
           ,[inf20a55_seqno]
           ,[inf20a56_note]
           ,[inf20a57_pclass]
           ,[remark]
           ,[adduser]
           ,[adddate]
           ,[moduser]
           ,[moddate]
           ,[verifyuser]
           ,[verifydate]
		   from [dbo].[inf20a] 
		   where inf20a.inf20a01_docno] =@docno

            --Delete inf20a
            Delete [dbo].[inf20a] where inf20a.inf20a01_docno] =@docno


           --backup to inf20dd
            INSERT INTO [dbo].[inf20d]
           ([inf2001_docno]
           ,[status]
           ,[inf2001_bcode]
           ,[inf2002_docno_type]
           ,[inf2002_docno_date]
           ,[inf2002_docno_seq]
           ,[inf2004_batch]
           ,[inf2005_vcode]
           ,[inf2005_bname]
           ,[inf2006_mcode]
           ,[inf2006_bname]
           ,[inf2007_code_status]
           ,[inf2008_pay_term]
           ,[inf2009_order_date]
           ,[inf2010_eff_date]
           ,[inf2010_start_date]
           ,[inf2010_end_date]
           ,[inf2011_shipto]
           ,[inf2011_bname]
           ,[inf2012_payto]
           ,[inf2013_qrder_pickup]
           ,[inf2014_mailflag]
           ,[inf2015_dis_rate]
           ,[inf2016_lest_rec_date]
           ,[inf2017_income_amt]
           ,[inf2018_income_tax]
           ,[inf2019_income_total]
           ,[inf2020_apr_empid]
           ,[inf2021_apr_date]
           ,[inf2022_cmp_empid]
           ,[inf2023_cmp_date]
           ,[inf2024_currency]
           ,[inf2025_exchnge_rate]
           ,[inf2026_buy_yymm]
           ,[inf2027_buy_place]
           ,[inf2028_bom]
           ,[inf2029_cancel_date]
           ,[inf2030_cancel_qty]
           ,[inf2031_po_no]
           ,[inf2032_size_code]
           ,[inf2033_delivery_place]
           ,[inf2034_pay_yymm]
           ,[inf2035_buy_dept]
           ,[inf2036_code]
           ,[inf2037_recid]
           ,[inf2038_odds_amt]
           ,[inf2039_one_amt]
           ,[inf2040_payto]
           ,[inf2041_bname]
           ,[inf2042_project_no]
           ,[inf2043_tel01]
           ,[inf2043_tel02]
           ,[inf2044_bname]
           ,[inf2045_tel03]
           ,[inf2046_time]
           ,[inf2047_tax]
           ,[inf2048_apply_no]
           ,[inf2048_apply_bot]
           ,[inf2049_docno_type]
           ,[inf2049_docno_date]
           ,[inf2049_docno_seq]
           ,[inf2050_park_depot]
           ,[inf2051_advance]
           ,[inf2052_inv_no]
           ,[inf2053_account_type]
           ,[inf2054_harbor]
           ,[remark]
           ,[adduser]
           ,[adddate]
           ,[moduser]
           ,[moddate]
           ,[verifyuser]
           ,[verifydate])
          select 
		    [inf2001_docno]
           ,[status]
           ,[inf2001_bcode]
           ,[inf2002_docno_type]
           ,[inf2002_docno_date]
           ,[inf2002_docno_seq]
           ,[inf2004_batch]
           ,[inf2005_vcode]
           ,[inf2005_bname]
           ,[inf2006_mcode]
           ,[inf2006_bname]
           ,[inf2007_code_status]
           ,[inf2008_pay_term]
           ,[inf2009_order_date]
           ,[inf2010_eff_date]
           ,[inf2010_start_date]
           ,[inf2010_end_date]
           ,[inf2011_shipto]
           ,[inf2011_bname]
           ,[inf2012_payto]
           ,[inf2013_qrder_pickup]
           ,[inf2014_mailflag]
           ,[inf2015_dis_rate]
           ,[inf2016_lest_rec_date]
           ,[inf2017_income_amt]
           ,[inf2018_income_tax]
           ,[inf2019_income_total]
           ,[inf2020_apr_empid]
           ,[inf2021_apr_date]
           ,[inf2022_cmp_empid]
           ,[inf2023_cmp_date]
           ,[inf2024_currency]
           ,[inf2025_exchnge_rate]
           ,[inf2026_buy_yymm]
           ,[inf2027_buy_place]
           ,[inf2028_bom]
           ,[inf2029_cancel_date]
           ,[inf2030_cancel_qty]
           ,[inf2031_po_no]
           ,[inf2032_size_code]
           ,[inf2033_delivery_place]
           ,[inf2034_pay_yymm]
           ,[inf2035_buy_dept]
           ,[inf2036_code]
           ,[inf2037_recid]
           ,[inf2038_odds_amt]
           ,[inf2039_one_amt]
           ,[inf2040_payto]
           ,[inf2041_bname]
           ,[inf2042_project_no]
           ,[inf2043_tel01]
           ,[inf2043_tel02]
           ,[inf2044_bname]
           ,[inf2045_tel03]
           ,[inf2046_time]
           ,[inf2047_tax]
           ,[inf2048_apply_no]
           ,[inf2048_apply_bot]
           ,[inf2049_docno_type]
           ,[inf2049_docno_date]
           ,[inf2049_docno_seq]
           ,[inf2050_park_depot]
           ,[inf2051_advance]
           ,[inf2052_inv_no]
           ,[inf2053_account_type]
           ,[inf2054_harbor]
           ,[remark]
           ,[adduser]
           ,[adddate]
           ,[moduser]
           ,[moddate]
           ,[verifyuser]
           ,[verifydate] 
		   from [dbo].[inf20]
		   where  inf20.[inf2001_docno]=@docno

            --Delete inf20
            Delete [dbo].[inf20]where  inf20.[inf2001_docno]=@docno";
                cmd.Parameters.AddWithValue("@docno", docno);
                cmd.ExecuteNonQuery();
                transaction.Commit();
                return "ok";


            }
            catch (Exception e)
            {
                transaction.Rollback();
                return e.ToString();
            }

        }

        //return "ok";
    }

    public static List<Inf20a> GetList(string docno)
    {
        if (String.IsNullOrEmpty(docno))
        {
            throw new ArgumentNullException("docno");
        }
        var inf20aList = new List<Inf20a>();

        using (var conn = new SqlConnection(MyConnStringList.AzureGoodeasy))
        {
            conn.Open();
            var cmd = conn.CreateCommand();
            cmd.CommandText = "select * from [dbo].[inf20a] where inf20a01_docno=@docno";
            cmd.Parameters.AddWithValue("@docno", docno);
            using (var rd = cmd.ExecuteReader())
            {
                if (rd.HasRows)
                {
                    while (rd.Read())
                    {
                        var inf20a = new Inf20a();
                        inf20a.id = rd["id"].ToString();
                        inf20a.inf20a00_inf20id = rd["id"].ToString();
                        inf20a.inf20a01_docno = rd["inf20a01_docno"].ToString();
                        inf20a.inf20a02_seq = rd["inf20a02_seq"].ToString();
                        inf20a.inf20a04_pcode = rd["inf20a02_seq"].ToString();
                        inf20a.inf20a05_mcode = rd["inf20a02_seq"].ToString();
                        inf20a.inf20a06_qty = rd["inf20a06_qty"].ToString();
                        inf20a.inf20a16_punit = rd["inf20a16_punit"].ToString();
                        inf20a.inf20a38_product_name = rd["inf20a16_punit"].ToString();
                        inf20a.inf20a40_one_amt = rd["inf20a16_punit"].ToString();
                        inf20a.inf20a57_pclass = rd["inf20a57_pclass"].ToString();
                        inf20a.inf20a04_shoes_code = rd["inf20a04_shoes_code"].ToString();
                        inf20a.remark = rd["remark"].ToString();
                        inf20aList.Add(inf20a);
                    }
                }
            }
        }

        return inf20aList;
    }

    public List<Inf20> Search(FilterOption filterOption)
    {
        var inf20List = new List<Inf20>();
        using (var conn = new SqlConnection(MyConnStringList.AzureGoodeasy))
        {
            conn.Open();
            var SQLFilter = "";
            using (var cmd = conn.CreateCommand())
            {
                if (filterOption != null)
                {
                    //關鍵字
                    if (!String.IsNullOrEmpty(filterOption.KeyWord))
                    {
                        List<int> idList = new List<int>();
                        cmd.CommandText = "Inf29_FindStringInTable";
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.AddWithValue("@stringToFind", filterOption.KeyWord);

                        using (var sqlReader = cmd.ExecuteReader())
                        {
                            if (sqlReader.HasRows)
                            {
                                while (sqlReader.Read())
                                {
                                    idList.Add(sqlReader.GetInt32(0));
                                }
                            }
                        }
                        filterOption.idList = idList;
                        cmd.CommandType = CommandType.Text;
                        cmd.Parameters.Clear();

                    }

                    if (filterOption.idList != null && filterOption.idList.Count > 0)
                    {
                        SQLFilter += String.Format(@" AND (inf20.id IN({0}))", String.Join(",", filterOption.idList));
                    }
                    //採購日期
                    if (filterOption.OrderDate_Start != null)
                    {

                        SQLFilter += @" AND @OrderDate_Start<=inf20.inf2009_order_date";
                        cmd.Parameters.AddWithValue("@OrderDate_Start", filterOption.OrderDate_Start);
                    }

                    if (filterOption.OrderDate_End != null)
                    {



                        SQLFilter += @" AND inf20.inf2009_order_date<@OrderDate_End";
                        cmd.Parameters.AddWithValue("@OrderDate_End", Convert.ToDateTime(filterOption.OrderDate_End).AddDays(1).ToString("yyyy/MM/dd"));
                    }
                    //商品編號
                    if (!string.IsNullOrEmpty(filterOption.Pcode_Start))
                    {

                        SQLFilter += @" AND EXISTS( select 1 from Inf20a where inf20a04_pcode>=@Pcode_Start and Inf20a.inf20a00_inf20id=inf20.id)";
                        cmd.Parameters.AddWithValue("@Pcode_Start", filterOption.Pcode_Start);
                    }

                    if (!string.IsNullOrEmpty(filterOption.Pcode_End))
                    {

                        SQLFilter += @" AND EXISTS( select 1 from Inf20a where inf20a04_pcode<=@Pcode_Start and Inf20a.inf20a00_inf20id=inf20.id)";
                        cmd.Parameters.AddWithValue("@Pcode_End", filterOption.Pcode_End);
                    }

                    //產品貨號
                    if (!string.IsNullOrEmpty(filterOption.Pclass_Start))
                    {

                        SQLFilter += @" AND EXISTS( select 1 from Inf20a where  inf20a57_pclass>=@Pclass_Start and Inf20a.inf20a00_inf20id=inf20.id)";
                        cmd.Parameters.AddWithValue("@Pclass_Start", filterOption.Pclass_Start);
                    }

                    if (!string.IsNullOrEmpty(filterOption.Pclass_End))
                    {

                        SQLFilter += @" AND EXISTS( select 1 from Inf20a where inf20a57_pclass<=@Pclass_End and Inf20a.inf20a00_inf20id=inf20.id)";
                        cmd.Parameters.AddWithValue("@Pclass_End", filterOption.Pclass_End);
                    }


                    //廠商代號
                    if (!string.IsNullOrEmpty(filterOption.Mcode_Start))
                    {

                        SQLFilter += @" AND inf20.inf2006_mcode>=@Mcode_Start";
                        cmd.Parameters.AddWithValue("@Mcode_Start", filterOption.Mcode_Start);
                    }

                    if (!string.IsNullOrEmpty(filterOption.Mcode_End))
                    {

                        SQLFilter += @" AND inf20.inf2006_mcode<=@Mcode_End";
                        cmd.Parameters.AddWithValue("@Mcode_End", filterOption.Mcode_End);
                    }

                    //公司代號
                    if (filterOption.Bcode_Start!=null);
                    {

                        SQLFilter += @" AND inf20.inf2001_bcode>=@Bcode_Start";
                        cmd.Parameters.AddWithValue("@Bcode_Start", filterOption.Bcode_Start.cnf0701_bcode);
                    }

                    if (filterOption.Bcode_End != null)
                    {

                        SQLFilter += @" AND inf20.inf2001_bcode<=@Bcode_End";
                        cmd.Parameters.AddWithValue("@Bcode_End", filterOption.Bcode_End.cnf0701_bcode);
                    }

                    //新增日期
                    if (filterOption.AddDate_Start != null)
                    {

                        SQLFilter += @" AND inf20.adddate>=@AddDate_Start";
                        cmd.Parameters.AddWithValue("@AddDate_Start", filterOption.AddDate_Start);
                    }
                    if (filterOption.AddDate_End != null)
                    {

                        SQLFilter += @" AND inf20.adddate<@AddDate_End";
                        cmd.Parameters.AddWithValue("@AddDate_End", Convert.ToDateTime(filterOption.AddDate_End).AddDays(1).ToString("yyyy/MM/dd"));
                    }

                    //採購單號
                    if (!string.IsNullOrEmpty(filterOption.Docno_Type_Start))
                    {
                        var inf2001_docno_Start = filterOption.Docno_Type_Start +
                                              (filterOption.Docno_Date_Start == null
                                                  ? default(DateTime)
                                                  : filterOption.Docno_Date_Start.Value).ToString("yyyyMMdd") +
                                              filterOption.Docno_seq_Start;
                        SQLFilter += @" AND inf20.inf2001_docno>=@inf2001_docnoStart";
                        cmd.Parameters.AddWithValue("@inf2001_docnoStart", inf2001_docno_Start);
                    }

                    if (!string.IsNullOrEmpty(filterOption.Docno_Type_End))
                    {
                        var inf2001_docno_End = filterOption.Docno_Type_End +
                                                  (filterOption.Docno_Date_End == null
                                                      ? default(DateTime)
                                                      : filterOption.Docno_Date_End.Value).ToString("yyyyMMdd") +
                                                  filterOption.Docno_seq_End;
                        SQLFilter += @" AND inf20.inf2001_docno<=@inf2001_docno_End";
                        cmd.Parameters.AddWithValue("@inf2001_docno_End", inf2001_docno_End);
                    }

                }

                cmd.CommandText = String.Format("select * from [dbo].[inf20] where (1=1) {0}", SQLFilter);
                using (var rd = cmd.ExecuteReader())
                {
                    if (rd.Read())
                    {
                        while (rd.Read())
                        {
                            var inf20 = new Inf20();
                            inf20.id = rd["id"].ToString();
                            inf20.inf2001_docno = rd["inf2001_docno"].ToString();
                            inf20.inf2001_bcode = rd["inf2001_bcode"].ToString();
                            inf20.inf2006_mcode = rd["inf2006_mcode"].ToString();
                            inf20.inf2006_bname = rd["inf2006_bname"].ToString();
                            inf20.inf2044_bname = rd["inf2044_bname"].ToString();
                            inf20.adduser = rd["adduser"].ToString();
                            inf20List.Add(inf20);

                        }

                    }

                }





            }





        }


        return inf20List;

    }

    public class Inf20
    {
        /// <summary>
        /// 主key值
        /// </summary>
        public string id { get; set; }

        /// <summary>
        /// 單據編號
        /// </summary>
        public string inf2001_docno { get; set; }

        /// <summary>
        /// 公司代號
        /// </summary>
        public string inf2001_bcode { get; set; }


        /// <summary>
        /// 單據分類編號
        /// </summary>
        public string inf2002_docno_type { get; set; }

        /// <summary>
        /// 異動單號_日期
        /// </summary>
        public string inf2002_docno_date { get; set; }

        /// <summary>
        /// 異動單號_流水號
        /// </summary>
        public string inf2002_docno_seq { get; set; }

        /// <summary>
        /// 批號
        /// </summary>
        public string inf2004_batch { get; set; }

        /// <summary>
        /// 代送商代碼
        /// </summary>
        public string inf2005_vcode { get; set; }

        /// <summary>
        /// 代送商簡稱
        /// </summary>
        public string inf2005_bname { get; set; }

        /// <summary>
        /// 廠商代碼
        /// </summary>
        public string inf2006_mcode { get; set; }

        /// <summary>
        /// 廠商簡稱
        /// </summary>
        public string inf2006_bname { get; set; }

        /// <summary>
        /// 採購(訂貨)日期
        /// </summary>
        public string inf2009_order_date { get; set; }


        /// <summary>
        /// 小計金額
        /// </summary>
        public string inf2039_one_amt { get; set; }

        /// <summary>
        /// 廠商聯絡人姓名
        /// </summary>
        public string inf2044_bname { get; set; }

        /// <summary>
        /// 新增日期
        /// </summary>
        public string adddate { get; set; }

        /// <summary>
        /// 新增者
        /// </summary>
        public string adduser { get; set; }

        /// <summary>
        /// 採購單表身檔
        /// </summary>
        public List<Inf20a> Inf20aList { get; set; }
    }
    public class Inf20a
    {
        /// <summary>
        /// 主key值
        /// </summary>
        public string id { get; set; }

        /// <summary>
        /// 表頭檔主鍵值
        /// </summary>
        public string inf20a00_inf20id { get; set; }

        /// <summary>
        /// 單據編號
        /// </summary>
        public string inf20a01_docno { get; set; }

        /// <summary>
        /// 序號
        /// </summary>
        public string inf20a02_seq { get; set; }

        /// <summary>
        /// 商品條碼
        /// </summary>
        public string inf20a04_pcode { get; set; }

        /// <summary>
        /// 鞋型代號
        /// </summary>
        public string inf20a04_shoes_code { get; set; }

        /// <summary>
        /// 廠商代碼
        /// </summary>
        public string inf20a05_mcode { get; set; }


        ///<summary>
        /// 訂購數量
        /// </summary>
        public string inf20a06_qty { get; set; }

        /// <summary>
        /// 小計金額
        /// </summary>
        public string inf20a40_one_amt { get; set; }

        /// <summary>
        /// 商品貨號
        /// </summary>
        public string inf20a57_pclass { get; set; }

        /// <summary>
        /// 商品名稱
        /// </summary>
        public string inf20a38_product_name { get; set; }

        /// <summary>
        /// 進貨單位
        /// </summary>
        public string inf20a16_punit { get; set; }

        /// <summary>
        /// 備註
        /// </summary>
        public string remark { get; set; }
    }

    public class FilterOption
    {   /// <summary>
        /// 採購日期
        /// </summary>
        public DateTime? OrderDate_Start { get; set; }
        public DateTime? OrderDate_End { get; set; }

        /// <summary>
        /// 商品編號
        /// </summary>
        public string Pcode_Start { get; set; }
        public string Pcode_End { get; set; }

        /// <summary>
        /// 產品貨號
        /// </summary>
        public string Pclass_Start { get; set; }
        public string Pclass_End { get; set; }

        /// <summary>
        /// 廠商代號
        /// </summary>
        public string Mcode_Start { get; set; }
        public string Mcode_End { get; set; }

        /// <summary>
        /// 新增日期
        /// </summary>
        public DateTime? AddDate_Start { get; set; }
        public DateTime? AddDate_End { get; set; }

        /// <summary>
        /// 採購單號
        /// </summary>
        public string Docno_Type_Start { get; set; }
        public DateTime? Docno_Date_Start { get; set; }
        public string Docno_seq_Start { get; set; }

        /// <summary>
        /// 採購單號
        /// </summary>
        public string Docno_Type_End { get; set; }
        public DateTime? Docno_Date_End { get; set; }
        public string Docno_seq_End { get; set; }

        /// <summary>
        /// 公司代號
        /// </summary>
        public Cnf07 Bcode_Start { get; set; }
        public Cnf07 Bcode_End { get; set; }

        /// <summary>
        /// 關鍵字
        /// </summary>
        public string KeyWord { get; set; }

        /// <summary>
        /// 採購數量
        /// </summary>
        public string Qty { get; set; }

        public List<int> idList { get; set; }
    }
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}