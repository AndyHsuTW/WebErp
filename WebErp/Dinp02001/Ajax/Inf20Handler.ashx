<%@ WebHandler Language="C#" Class="Inf20Handler" %>

using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using ErpBaseLibrary.DB;
using Newtonsoft.Json;

public class Inf20Handler : IHttpHandler
{
    /// <summary>
    /// Request.Form["act"]
    /// </summary>
    public string Action { get; set; }

    // <summary>
    /// Request.Form["data"]
    /// </summary>
    public string Data { get; set; }

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        this.Action = context.Request.Form["act"];
        this.Data = context.Request.Form["data"];
        if (this.Action == null) return;
        switch (this.Action.ToLower())
        {
            case "get":
                {
                    var filterOption = JsonConvert.DeserializeObject<FilterOption>(this.Data);



                    return;
                }
                break;


        }

    }

    public List<Inf20> Search(FilterOption filterOption)
    {
        var inf20List = new List<Inf20>();
        using (var conn = new SqlConnection(MyConnStringList.AzureGoodeasy))
        {
            conn.Open();
            var SQLFilter = "";
            using (var sqlCmd = conn.CreateCommand())
            {
                if (filterOption != null)
                {
                    //關鍵字
                    if (!String.IsNullOrEmpty(filterOption.KeyWord))
                    {
                        List<int> idList = new List<int>();
                        sqlCmd.CommandText = "Inf29_FindStringInTable";
                        sqlCmd.CommandType = CommandType.StoredProcedure;

                        sqlCmd.Parameters.AddWithValue("@stringToFind", filterOption.KeyWord);

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
                        filterOption.idList = idList;
                        sqlCmd.CommandType = CommandType.Text;
                        sqlCmd.Parameters.Clear();

                    }
                    
                    if (filterOption.idList != null && filterOption.idList.Count > 0)
                    {
                        SQLFilter += String.Format(@" AND (inf20.id IN({0}))", String.Join(",", filterOption.idList));
                    }
                    //採購日期
                    if (!string.IsNullOrEmpty(filterOption.OrderDate_Start))
                    {

                        SQLFilter += @" AND @OrderDate_Start<=inf20.inf2009_order_date";
                        sqlCmd.Parameters.AddWithValue("@OrderDate_Start", filterOption.OrderDate_Start);
                    }

                    if (!string.IsNullOrEmpty(filterOption.OrderDate_End))
                    {

                        
                        
                        SQLFilter += @" AND inf20.inf2009_order_date<@OrderDate_End";
                        sqlCmd.Parameters.AddWithValue("@OrderDate_End", Convert.ToDateTime(filterOption.OrderDate_End).AddDays(1).ToString("yyyy/MM/dd"));
                    }
                    //商品編號
                    if (!string.IsNullOrEmpty(filterOption.Pcode_Start))
                    {

                        SQLFilter += @" AND EXISTS( select 1 from Inf20a where inf20a04_pcode>=@Pcode_Start and Inf20a.inf20a00_inf20id=inf20.id)";
                        sqlCmd.Parameters.AddWithValue("@Pcode_Start", filterOption.Pcode_Start);
                    }

                    if (!string.IsNullOrEmpty(filterOption.Pcode_End))
                    {

                        SQLFilter += @" AND EXISTS( select 1 from Inf20a where inf20a04_pcode<=@Pcode_Start and Inf20a.inf20a00_inf20id=inf20.id)";
                        sqlCmd.Parameters.AddWithValue("@Pcode_End", filterOption.Pcode_End);
                    }

                    //產品貨號
                    if (!string.IsNullOrEmpty(filterOption.Pclass_Start))
                    {

                        SQLFilter += @" AND EXISTS( select 1 from Inf20a where  inf20a57_pclass>=@Pclass_Start and Inf20a.inf20a00_inf20id=inf20.id)";
                        sqlCmd.Parameters.AddWithValue("@Pclass_Start", filterOption.Pclass_Start);
                    }

                    if (!string.IsNullOrEmpty(filterOption.Pclass_End))
                    {

                        SQLFilter += @" AND EXISTS( select 1 from Inf20a where inf20a57_pclass<=@Pclass_End and Inf20a.inf20a00_inf20id=inf20.id)";
                        sqlCmd.Parameters.AddWithValue("@Pclass_End", filterOption.Pclass_End);
                    }


                    //廠商代號
                    if (!string.IsNullOrEmpty(filterOption.Mcode_Start))
                    {

                        SQLFilter += @" AND inf20.inf2006_mcode>=@Mcode_Start";
                        sqlCmd.Parameters.AddWithValue("@Mcode_Start", filterOption.Mcode_Start);
                    }

                    if (!string.IsNullOrEmpty(filterOption.Mcode_End))
                    {

                        SQLFilter += @" AND inf20.inf2006_mcode<=@Mcode_End";
                        sqlCmd.Parameters.AddWithValue("@Mcode_End", filterOption.Mcode_End);
                    }
                    //新增日期
                    if (!string.IsNullOrEmpty(filterOption.AddDate_Start))
                    {

                        SQLFilter += @" AND inf20.adddate<=@AddDate_Start";
                        sqlCmd.Parameters.AddWithValue("@AddDate_Start", filterOption.AddDate_Start);
                    }
                    if (!string.IsNullOrEmpty(filterOption.AddDate_End))
                    {

                        SQLFilter += @" AND inf20.adddate<@AddDate_End";
                        sqlCmd.Parameters.AddWithValue("@AddDate_End", Convert.ToDateTime(filterOption.AddDate_End).AddDays(1).ToString("yyyy/MM/dd"));
                    }

                    //採購單號
                    

                }

            }





        }


        return inf20List;

    }

    public class Inf20
    {
        public string id { get; set; }
        public string inf2001_bcode { get; set; }
        public string inf2002_docno_type { get; set; }
        public string inf2002_docno_date { get; set; }
        public string inf2002_docno_seq { get; set; }
        public string inf2006_mcode { get; set; }
        public string inf2006_bname { get; set; }
        public string inf2009_order_date { get; set; }
        public string adddate { get; set; }
        public List<Inf20a> Inf20aList { get; set; }
    }
    public class Inf20a
    {
        public string id { get; set; }
        public string inf20a00_inf20id { get; set; }
        public string inf20a01_docno { get; set; }
        public string inf20a02_seq { get; set; }
        public string inf20a06_qty { get; set; }

    }

    public class FilterOption
    {   /// <summary>
        /// 採購日期
        /// </summary>
        public string OrderDate_Start { get; set; }
        public string OrderDate_End { get; set; }

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
        public string AddDate_Start { get; set; }
        public string AddDate_End { get; set; }

        /// <summary>
        /// 採購單號
        /// </summary>
        public string Docno_Type_Start { get; set; }
        public string Docno_Date_Start { get; set; }
        public string Docno_seq_Start { get; set; }

        /// <summary>
        /// 採購單號
        /// </summary>
        public string Docno_Type_End { get; set; }
        public string Docno_Date_End { get; set; }
        public string Docno_seq_End { get; set; }

        /// <summary>
        /// 公司代號
        /// </summary>
        public string Bcode_Start { get; set; }
        public string Bcode_End { get; set; }

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