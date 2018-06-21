using DCNP005;
using ErpBaseLibrary.DB;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using NPOI.XSSF.UserModel;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;

namespace Dinp02101
{
    /// <summary>
    /// 各類單據異動主檔
    /// </summary>
    public class Inf29
    {
        #region properties from database
        public int id { get; set; }

        public string inf2901_bcode { get; set; }

        public string inf2901_docno { get; set; }

        public string inf2964_src_docno { get; set; }

        public decimal? inf2911_sub_amt { get; set; }

        public string Ccode { get; set; }

        public string inf2902_docno_type { get; set; }

        public DateTime inf2902_docno_date { get; set; }

        public int inf2902_docno_seq { get; set; }

        public string inf2903_customer_code { get; set; }

        public string inf2903_customer_name { get; set; }

        public string inf2904_pro_date { get; set; }

        public string inf2921_pmonth { get; set; }

        public string inf2906_ref_no_type { get; set; }

        public DateTime? inf2906_ref_no_date { get; set; }

        public int inf2906_ref_no_seq { get; set; }

        public string inf2906_wherehouse { get; set; }

        public string inf2910_in_reason { get; set; }

        public string inf2914_inv_eff { get; set; }

        public string inf2916_apr_empid { get; set; }
        
        public string inf2952_project_no { get; set; }

        public string inf2928_currency { get; set; }

        public double inf2929_exchange_rate { get; set; }

        public decimal inf2951_allowances { get; set; }

        public string remark { get; set; }

        public string adduser { get; set; }

        public DateTime? adddate { get; set; }

        public string moduser { get; set; }

        public DateTime? moddate { get; set; }

        #endregion

        /// <summary>
        /// 顯示"數量"欄位
        /// </summary>
        public double Qty { get; set; }

        public class FilterOption
        {
            /// <summary>
            /// 進貨日期
            /// </summary>
            public DateTime? inf2904_pro_date_start { get; set; }
            public DateTime? inf2904_pro_date_end { get; set; }

            /// <summary>
            /// 商品編號
            /// </summary>
            public string inf29a05_pcode_start { get; set; }
            public string inf29a05_pcode_end { get; set; }

            /// <summary>
            /// 產品貨號
            /// </summary>
            public string inf29a05_shoes_code_start { get; set; }
            public string inf29a05_shoes_code_end { get; set; }

            /// <summary>
            /// 倉庫代號
            /// </summary>
            public string inf2906_wherehouse_start { get; set; }
            public string inf2906_wherehouse_end { get; set; }

            /// <summary>
            /// 異動代碼
            /// </summary>
            public string inf2910_in_reason_start { get; set; }
            public string inf2910_in_reason_end { get; set; }

            /// <summary>
            /// 廠商代號
            /// </summary>
            public string inf2909_vcode_start { get; set; }
            public string inf2909_vcode_end { get; set; }

            /// <summary>
            /// 新增日期
            /// </summary>
            public DateTime? adddate_start { get; set; }
            public DateTime? adddate_end { get; set; }

            /// <summary>
            /// 公司代號
            /// </summary>
            public string inf2935_bcode_start { get; set; }
            public string inf2935_bcode_end { get; set; }

            /// <summary>
            /// 採購單號
            /// </summary>
            public string inf2964_src_docno { get; set; }

            public int id { get; set; }

            public List<int> idList { get; set; }

            public string keyword { get; set; }
        }

        public List<Inf29a> Inf29aList { get; set; }

        /// <summary>
        /// Get value by property name
        /// </summary>
        /// <param name="src"></param>
        /// <param name="propName"></param>
        /// <returns></returns>
        public static object GetPropValue(object src, string propName)
        {
            return src.GetType().GetProperty(propName).GetValue(src, null);
        }

        /// <summary>
        /// inf2902_docno_type + inf2902_docno_date + inf2902_docno_seq
        /// </summary>
        public string Inf2902DocNoShort
        {
            get
            {
                if (String.IsNullOrEmpty(inf2902_docno_type))
                {
                    return "";
                }
                return inf2902_docno_type + inf2902_docno_date.ToString("yyyyMMdd") + inf2902_docno_seq.ToString("0000");
            }
        }

        /// <summary>
        /// inf2906_ref_no_type + inf2906_ref_no_date + inf2906_ref_no_seq
        /// </summary>
        public string Inf2906RefNo
        {
            get
            {
                if (String.IsNullOrEmpty(inf2906_ref_no_type))
                {
                    return "";
                }
                return inf2906_ref_no_type + (inf2906_ref_no_date == null
                                                  ? default(DateTime)
                                                  : inf2906_ref_no_date.Value).ToString("yyyyMMdd") +
                       inf2906_ref_no_seq.ToString("0000");
            }
        }

        public string Inf2910InReasonName { get; set; }

        public string Inf2903CustomerCodeName { get; set; }

        public static string GetCustomerCodeName(string inReason, string cuscode)
        {
            string customCodeInfo = null;

            if (String.IsNullOrEmpty(inReason))
            {
                throw new ArgumentNullException("inReason");
            }
            if (String.IsNullOrEmpty(cuscode))
            {
                throw new ArgumentNullException("cuscode");
            }

            using (var conn = new SqlConnection { ConnectionString = MyConnStringList.AzureGoodeasy })
            using (var sqlCmd = conn.CreateCommand())
            {
                conn.Open();

                sqlCmd.CommandText = String.Format(@"
        SELECT (
			--客戶資料
            CASE WHEN cnf10.cnf1004_char02='cmf01' THEN
                (
                    SELECT TOP 1 cmf0103_bname
                    FROM cmf01
                    WHERE cmf0102_cuscode = @Cuscode
                )
				--公司資料
				WHEN cnf10.cnf1004_char02='cnf07' THEN
                (
                    SELECT TOP 1 cnf0702_bname
                    FROM cnf07
                    WHERE cnf0701_bcode = @Cuscode
                )
				--廠商資料
				WHEN cnf10.cnf1004_char02='inf03' THEN
                (
                    SELECT TOP 1 inf0302_bname
                    FROM inf03
                    WHERE inf0302_mcode = @Cuscode
                )
				--客戶資料
				WHEN cnf10.cnf1004_char02='taf10' THEN
                (
                    SELECT TOP 1 taf1004_cname
                    FROM taf10
                    WHERE taf1001_empid = @Cuscode
                )
				--異動單位
				WHEN cnf10.cnf1004_char02='cnf10' THEN
                (
                    SELECT TOP 1 cnf1003_char01
                    FROM cnf10
                    WHERE cnf1002_fileorder = @Cuscode
					AND cnf1001_filetype = 'S35'
                )
            ELSE
                ''
			END
            ) AS Inf2903CustomerCodeName
              
          FROM [cnf10] 
          WHERE cnf10.cnf1002_fileorder = @InReason 
          AND cnf10.cnf1001_filetype='S15' ");

                sqlCmd.Parameters.AddWithValue("@InReason", inReason);
                sqlCmd.Parameters.AddWithValue("@Cuscode", cuscode);

                using (var sqlReader = sqlCmd.ExecuteReader())
                {
                    if (sqlReader.HasRows)
                    {
                        if (sqlReader.Read())
                        {

                            customCodeInfo = Convert.ToString(sqlReader["Inf2903CustomerCodeName"]);
                        }
                    }
                }
            }
            return customCodeInfo;
        }

        /// <summary>
        /// Create SQL_STORED_PROCEDURE if not exists
        /// </summary>
        public static void CreateKeywordSP()
        {
            using (var conn = new SqlConnection { ConnectionString = MyConnStringList.AzureGoodeasy })
            using (var sqlCmd = conn.CreateCommand())
            {
                conn.Open();

                sqlCmd.CommandText = String.Format(@"
    SELECT TOP 1 1 from sys.objects where type_desc = 'SQL_STORED_PROCEDURE' AND name = 'Inf29_FindStringInTable' ");

                int cnt = 0;
                using (var sqlReader = sqlCmd.ExecuteReader())
                {
                    if (sqlReader.HasRows)
                    {
                        if (sqlReader.Read())
                        {
                            cnt = sqlReader.GetInt32(0);
                        }
                    }
                }
                if (cnt < 1)
                {
                    sqlCmd.CommandText = String.Format(@"
        CREATE PROCEDURE Inf29_FindStringInTable 
	        -- Add the parameters for the stored procedure here
	         @stringToFind VARCHAR(100)
        AS
        BEGIN
	        -- SET NOCOUNT ON added to prevent extra result sets from
	        -- interfering with SELECT statements.
	        SET NOCOUNT ON;

            BEGIN TRY
	           DECLARE @sqlCommand varchar(max) = 'SELECT id FROM [Inf29] WHERE ' 
	   
	           SELECT @sqlCommand = @sqlCommand + '[' + COLUMN_NAME + '] LIKE ''%' + @stringToFind + '%'' OR '
	           FROM INFORMATION_SCHEMA.COLUMNS 
	           WHERE  TABLE_NAME = 'Inf29' 
	           AND DATA_TYPE IN ('char','nchar','ntext','nvarchar','text','varchar')

	           SET @sqlCommand = left(@sqlCommand,len(@sqlCommand)-3)
	           EXEC (@sqlCommand)
	           PRINT @sqlCommand
	        END TRY

	        BEGIN CATCH 
	           PRINT 'There was an error. Check to make sure object exists.'
	           PRINT error_message()
	        END CATCH 
        END
        ;  ");

                    sqlCmd.ExecuteNonQuery();
                }
               
            }
        }

        public static DataSet GetDataSet(string ConnectionString, string SQL)
        {
            SqlConnection conn = new SqlConnection(ConnectionString);
            SqlDataAdapter da = new SqlDataAdapter();
            SqlCommand cmd = conn.CreateCommand();
            cmd.CommandText = SQL;
            da.SelectCommand = cmd;
            DataSet ds = new DataSet();

            conn.Open();
            da.Fill(ds);
            conn.Close();

            return ds;
        }

        /// <summary>
        /// 取得最後一筆資料的進貨單單號 SI+yyyyMMdd+0001
        /// </summary>
        /// <returns>Inf15</returns>
        public static string GetLastDocNoData()
        {
            Inf29 inf29 = new Inf29();
            DataSet ds = GetDataSet(MyConnStringList.AzureGoodeasy, "select count(*) from [dbo].[inf29] where inf2901_docno like 'SI" + DateTime.Now.ToString("yyyyMMdd") + "%'");
            if (ds.Tables[0].Rows.Count > 0)
            {
                return "SI" + DateTime.Now.ToString("yyyyMMdd") + (int.Parse(ds.Tables[0].Rows[0][0].ToString()) + 1).ToString("0000");
            }

            return "SI" + DateTime.Now.ToString("yyyyMMdd") + "0001";
        }


        public static List<Inf29> Search(FilterOption filterOption)
        {

            List<Inf29> inf29List = new List<Inf29>();

            using (var conn = new SqlConnection { ConnectionString = MyConnStringList.AzureGoodeasy })
            using (var sqlCmd = conn.CreateCommand())
            {
                conn.Open();
                var idFilter = "";
                var idListFilter = "";
                //var keywordFilter = "";
                var inf29ProDateFilter = "";
                var inf29PcodeFilter = "";
                var inf29ShoesCodeFilter = "";
                var inf29WherehouseFilter = "";
                var inf29InReasonFilter = "";
                var inf29VCodeFilter = "";
                var inf29AddDateFilter = "";
                var inf29BcodeFilter = "";
                var inf29SrcdocnoFilter = "";
                if (filterOption != null)
                {
                    if (!String.IsNullOrEmpty(filterOption.keyword))
                    {
                        List<int> idList = new List<int>();
                        sqlCmd.CommandText = "Inf29_FindStringInTable";
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
                        filterOption.idList = idList;
                        sqlCmd.CommandType = CommandType.Text;
                        sqlCmd.Parameters.Clear();
                    }
                    if (filterOption.idList != null && filterOption.idList.Count > 0)
                    {
                        idListFilter = String.Format(@" AND (inf29.id IN({0}))", String.Join(",", filterOption.idList));
                    }
                    if (filterOption.id > 0)
                    {
                        idFilter = String.Format(@" AND (inf29.id = @id )");
                        sqlCmd.Parameters.AddWithValue("@id", filterOption.id);
                    }
                    //進貨日期
                    if (filterOption.inf2904_pro_date_start != null)
                    {
                        inf29ProDateFilter += @" AND @inf2904_pro_date_start<=inf29.inf2904_pro_date";
                        sqlCmd.Parameters.AddWithValue("@inf2904_pro_date_start", Convert.ToDateTime(filterOption.inf2904_pro_date_start).ToString("yyyy/MM/dd"));
                    }
                    if (filterOption.inf2904_pro_date_end != null)
                    {
                        inf29ProDateFilter += @" AND @inf2904_pro_date_end>=inf29.inf2904_pro_date";
                        sqlCmd.Parameters.AddWithValue("@inf2904_pro_date_end", Convert.ToDateTime(filterOption.inf2904_pro_date_end).ToString("yyyy/MM/dd"));
                    }

                    //商品編號
                    if (!string.IsNullOrEmpty(filterOption.inf29a05_pcode_start))
                    {
                        inf29PcodeFilter += @" AND @inf29a05_pcode_start<=inf29a.inf29a05_pcode";
                        sqlCmd.Parameters.AddWithValue("@inf29a05_pcode_start", filterOption.inf29a05_pcode_start);
                    }
                    if (!string.IsNullOrEmpty(filterOption.inf29a05_pcode_end))
                    {
                        inf29PcodeFilter += @" AND @inf29a05_pcode_end>=inf29a.inf29a05_pcode";
                        sqlCmd.Parameters.AddWithValue("@inf29a05_pcode_end", filterOption.inf29a05_pcode_end);
                    }

                    //產品貨號
                    if (!string.IsNullOrEmpty(filterOption.inf29a05_shoes_code_start))
                    {
                        inf29ShoesCodeFilter += @" AND inf29a.inf29a05_shoes_code<=@inf29a05_shoes_code_start";
                        sqlCmd.Parameters.AddWithValue("@inf29a05_shoes_code_start", filterOption.inf29a05_shoes_code_start);
                    }
                    if (!string.IsNullOrEmpty(filterOption.inf29a05_shoes_code_end))
                    {
                        inf29ShoesCodeFilter += @" AND inf29a.inf29a05_shoes_code>=@inf29a05_shoes_code_end";
                        sqlCmd.Parameters.AddWithValue("@inf29a05_shoes_code_end", filterOption.inf29a05_shoes_code_end);
                    }

                    //倉庫代號
                    if (!string.IsNullOrEmpty(filterOption.inf2906_wherehouse_start))
                    {
                        inf29WherehouseFilter += @" AND inf29.inf2906_wherehouse<=@inf2906_wherehouse_start";
                        sqlCmd.Parameters.AddWithValue("@inf2906_wherehouse_start", filterOption.inf2906_wherehouse_start);
                    }
                    if (!string.IsNullOrEmpty(filterOption.inf2906_wherehouse_end))
                    {
                        inf29WherehouseFilter += @" AND inf29.inf2906_wherehouse>=@inf2906_wherehouse_end";
                        sqlCmd.Parameters.AddWithValue("@inf2906_wherehouse_end", filterOption.inf2906_wherehouse_end);
                    }

                    //異動代碼
                    if (!string.IsNullOrEmpty(filterOption.inf2910_in_reason_start))
                    {
                        inf29InReasonFilter += @" AND inf29.inf2910_in_reason<=@inf2910_in_reason_start";
                        sqlCmd.Parameters.AddWithValue("@inf2910_in_reason_start", filterOption.inf2910_in_reason_start);
                    }
                    if (!string.IsNullOrEmpty(filterOption.inf2910_in_reason_end))
                    {
                        inf29InReasonFilter += @" AND inf29.inf2910_in_reason>=@inf2910_in_reason_end";
                        sqlCmd.Parameters.AddWithValue("@inf2910_in_reason_end", filterOption.inf2910_in_reason_end);
                    }

                    //廠商代號
                    if (!string.IsNullOrEmpty(filterOption.inf2909_vcode_start))
                    {
                        inf29VCodeFilter += @" AND inf29.inf2909_vcode<=@inf2909_vcode_start";
                        sqlCmd.Parameters.AddWithValue("@inf2909_vcode_start", filterOption.inf2909_vcode_start);
                    }
                    if (!string.IsNullOrEmpty(filterOption.inf2909_vcode_end))
                    {
                        inf29VCodeFilter += @" AND inf29.inf2909_vcode>=@inf2909_vcode_end";
                        sqlCmd.Parameters.AddWithValue("@inf2909_vcode_end", filterOption.inf2909_vcode_end);
                    }

                    //新增日期

                    if (filterOption.adddate_start != null)
                    {
                        inf29AddDateFilter += @" AND inf29.adddate<=@AddDate_Start";
                        sqlCmd.Parameters.AddWithValue("@AddDate_Start", filterOption.adddate_start);
                    }
                    if (filterOption.adddate_end != null)
                    {

                        inf29AddDateFilter += @" AND inf29.adddate>=@adddate_end";
                        sqlCmd.Parameters.AddWithValue("@adddate_end", filterOption.adddate_end);
                    }

                    //公司代碼
                    if (!string.IsNullOrEmpty(filterOption.inf2935_bcode_start))
                    {
                        inf29BcodeFilter += @" AND inf29.inf2935_bcode>=@inf2935_bcode_start";
                        sqlCmd.Parameters.AddWithValue("@inf2935_bcode_start", filterOption.inf2935_bcode_start);
                    }

                    if (!string.IsNullOrEmpty(filterOption.inf2935_bcode_end))
                    {
                        inf29BcodeFilter += @" AND @inf2935_bcode_end>=inf29.inf2935_bcode";
                        sqlCmd.Parameters.AddWithValue("@inf2935_bcode_end", filterOption.inf2935_bcode_end);
                    }

                    //來源單據
                    if (!string.IsNullOrEmpty(filterOption.inf2964_src_docno))
                    {
                        inf29SrcdocnoFilter += @" AND inf29.inf2964_src_docno = @inf2964_src_docno";
                        sqlCmd.Parameters.AddWithValue("@inf2964_src_docno", filterOption.inf2964_src_docno);
                    }
                    sqlCmd.CommandText = String.Format(@"SELECT DISTINCT inf29.id,
                                                                        inf29.inf2904_pro_date,
                                                                        inf29.inf2921_pmonth,
                                                                        inf29.inf2901_docno,
                                                                        inf29.inf2964_src_docno,
                                                                        inf29.inf2911_sub_amt,
                                                                        inf29.inf2901_bcode,
                                                                        inf29.inf2903_customer_code,
				                                                        cmf01.cmf0103_bname inf2903_customer_name,
                                                                        inf29.remark,
                                                                        inf29.adduser,
                                                                        inf29.adddate,
                                                                        inf29.moduser,
                                                                        inf29.moddate,
                                                                        cnf10.cnf1004_char02 -- For inf2903_customer_code data source
                                                                       ,
                                                                        (
                                                                        --客戶資料
                                                                        CASE
                                                                          WHEN cnf10.cnf1004_char02 = 'cmf01' THEN
                                                                           (SELECT TOP 1 cmf0103_bname
                                                                              FROM cmf01
                                                                             WHERE cmf0102_cuscode = inf29.inf2903_customer_code)
                                                                        --公司資料
                                                                          WHEN cnf10.cnf1004_char02 = 'cnf07' THEN
                                                                           (SELECT TOP 1 cnf0702_bname
                                                                              FROM cnf07
                                                                             WHERE cnf0701_bcode = inf29.inf2903_customer_code)
                                                                        --廠商資料
                                                                          WHEN cnf10.cnf1004_char02 = 'inf03' THEN
                                                                           (SELECT TOP 1 inf0302_bname
                                                                              FROM inf03
                                                                             WHERE inf0302_mcode = inf29.inf2903_customer_code)
                                                                        --客戶資料
                                                                          WHEN cnf10.cnf1004_char02 = 'taf10' THEN
                                                                           (SELECT TOP 1 taf1004_cname
                                                                              FROM taf10
                                                                             WHERE taf1001_empid = inf29.inf2903_customer_code)
                                                                        --異動單位
                                                                          WHEN cnf10.cnf1004_char02 = 'cnf10' THEN
                                                                           (SELECT TOP 1 cnf1003_char01
                                                                              FROM cnf10
                                                                             WHERE cnf1002_fileorder = inf29.inf2903_customer_code
                                                                               AND cnf1001_filetype = 'S35')
                                                                          ELSE
                                                                           ''
                                                                        END) AS Inf2903CustomerCodeName,
                                                                        inf2904_pro_date,
                                                                        inf2906_wherehouse,
                                                                        inf2906_ref_no_type,
                                                                        inf2906_ref_no_date,
                                                                        inf2906_ref_no_seq,
                                                                        inf2910_in_reason,
                                                                        inf2916_apr_empid,
                                                                        cnf10.cnf1003_char01 as Inf2910InReasonName,
                                                                        inf2952_project_no,
                                                                        inf2928_currency,
                                                                        inf2929_exchange_rate,
                                                                        inf2951_allowances,
                                                                        (SELECT SUM(inf29a13_sold_qty)
                                                                           FROM inf29a
                                                                          WHERE inf29a.inf29a01_docno = inf29.inf2901_docno) AS QTY
                                                          FROM inf29
                                                          LEFT JOIN inf29a
                                                            ON inf29.inf2901_docno = inf29a.inf29a01_docno
                                                          LEFT JOIN cnf10
                                                            ON cnf10.cnf1002_fileorder = inf29.inf2910_in_reason
                                                           AND cnf10.cnf1001_filetype = 'S15'
                                                          LEFT JOIN cnf07
                                                            ON cnf07.cnf0701_bcode = inf29.inf2901_bcode
                                                          LEFT JOIN cmf01
	                                                        ON cmf01.cmf0102_cuscode = inf29.inf2903_customer_code
                                                         WHERE 1 = 1 {0} {1} {2} {3} {4} {5} {6} {7} {8} {9} {10} {11}", idFilter, inf29ProDateFilter, inf29ProDateFilter, inf29PcodeFilter, inf29ShoesCodeFilter, inf29WherehouseFilter, inf29InReasonFilter, inf29VCodeFilter, inf29AddDateFilter, inf29BcodeFilter, inf29SrcdocnoFilter, idListFilter);
                    using (var sqlReader = sqlCmd.ExecuteReader())
                    {
                        if (sqlReader.HasRows)
                        {
                            while (sqlReader.Read())
                            {
                                Inf29 inf29 = new Inf29();
                                inf29.id = Convert.ToInt32(sqlReader["id"]);
                                inf29.inf2901_bcode = sqlReader["inf2901_bcode"].ToString().Trim();
                                inf29.inf2904_pro_date = string.IsNullOrEmpty(Convert.ToString(sqlReader["inf2904_pro_date"])) ? "" : DateTime.Parse(Convert.ToString(sqlReader["inf2904_pro_date"])).ToString("yyyy/MM/dd");
                                inf29.inf2921_pmonth = string.IsNullOrEmpty(Convert.ToString(sqlReader["inf2921_pmonth"])) ? "" : DateTime.Parse(Convert.ToString(sqlReader["inf2921_pmonth"])).ToString("yyyy/MM");
                                inf29.inf2906_wherehouse = sqlReader["inf2906_wherehouse"].ToString().Trim();
                                inf29.inf2903_customer_code = sqlReader["inf2903_customer_code"].ToString().Trim();
                                inf29.inf2928_currency = sqlReader["inf2928_currency"].ToString().Trim();
                                inf29.inf2929_exchange_rate = Convert.ToDouble(sqlReader["inf2929_exchange_rate"].ToString().Trim());
                                inf29.inf2951_allowances = Convert.ToDecimal(sqlReader["inf2951_allowances"].ToString().Trim());
                                inf29.inf2901_docno = sqlReader["Inf2901_docno"].ToString().Trim();
                                inf29.inf2964_src_docno = sqlReader["inf2964_src_docno"].ToString().Trim();
                                inf29.inf2911_sub_amt = string.IsNullOrEmpty(Convert.ToString(sqlReader["inf2911_sub_amt"])) ? 0 : decimal.Parse(Convert.ToString(sqlReader["inf2911_sub_amt"]));
                                inf29.inf2903_customer_code = sqlReader["inf2903_customer_code"].ToString().Trim();
                                inf29.inf2903_customer_name = sqlReader["inf2903_customer_name"].ToString().Trim();
                                inf29.remark = sqlReader["remark"].ToString().Trim();
                                inf29.adduser = sqlReader["adduser"].ToString().Trim();
                                inf29.adddate = string.IsNullOrEmpty(Convert.ToString(sqlReader["adddate"])) ? (DateTime?)null : DateTime.Parse(Convert.ToString(sqlReader["adddate"]));
                                inf29.moduser = sqlReader["moduser"].ToString().Trim();
                                inf29.moddate = string.IsNullOrEmpty(Convert.ToString(sqlReader["moddate"])) ? (DateTime?)null : DateTime.Parse(Convert.ToString(sqlReader["moddate"]));
                                inf29List.Add(inf29);
                            }
                        }
                    }
                }
                return inf29List;
            }
        }

        public static List<ExportItemRow> GetExportItems(Cnf05[] inf29FieldInfoList, Cnf05[] inf29aFieldInfoList, List<int> inf29IdList)
        {

            List<ExportItemRow> inf29Rows = new List<ExportItemRow>();

            if (inf29IdList == null || inf29IdList.Count == 0)
            {
                return inf29Rows;
            }
            string inf29FieldNamesSql = String.Join(", ",
                                                    inf29FieldInfoList.Select(
                                                        o => "inf29." + o.cnf0502_field + " as Inf29_" + o.cnf0502_field));
            string inf29aFieldNamesSql = inf29aFieldInfoList.Length > 0
                                             ? "," +
                                               String.Join(", ",
                                                           inf29aFieldInfoList.Select(o => "inf29a." + o.cnf0502_field + " as Inf29a_" + o.cnf0502_field))
                                             : "";

            string idListSql = String.Join("','", inf29IdList);

            using (var conn = new SqlConnection { ConnectionString = MyConnStringList.AzureGoodeasy })
            using (var sqlCmd = conn.CreateCommand())
            {
                conn.Open();

                sqlCmd.CommandText = String.Format(@"
        SELECT inf29.id as ExportKey
        ,{0}
        {1}
          FROM [dbo].[inf29] inf29
          LEFT JOIN [inf29a] inf29a
          ON inf29.inf2901_docno = inf29a.inf29a01_docno
        WHERE inf29.id IN('{2}') ", inf29FieldNamesSql, inf29aFieldNamesSql, idListSql);

                using (var sqlReader = sqlCmd.ExecuteReader())
                {
                    if (sqlReader.HasRows)
                    {
                        while (sqlReader.Read())
                        {
                            //ExportKey to know duplicated inf29 rows
                            ExportItemRow inf29Row = new ExportItemRow(Convert.ToString(sqlReader["ExportKey"]));
                            foreach (var fieldInfo in inf29FieldInfoList)
                            {
                                var data = sqlReader["inf29_" + fieldInfo.cnf0502_field];
                                inf29Row.Add("inf29_" + fieldInfo.cnf0502_field, data);
                            }
                            foreach (var fieldInfo in inf29aFieldInfoList)
                            {
                                var data = sqlReader["inf29a_" + fieldInfo.cnf0502_field];
                                inf29Row.Add("inf29a_" + fieldInfo.cnf0502_field, data);
                            }
                            inf29Rows.Add(inf29Row);
                        }
                    }
                }
            }
            return inf29Rows;
        }

        public static int GetLastDocnoSeq(string docnoType, DateTime docnoDate)
        {
            var seq = -1;

            using (var conn = new SqlConnection { ConnectionString = MyConnStringList.AzureGoodeasy })
            using (var sqlCmd = conn.CreateCommand())
            {
                conn.Open();
                sqlCmd.CommandText = @"
        SELECT TOP 1 inf2902_docno_seq
            FROM [inf29]
        WHERE inf2902_docno_type = @docnoType
        AND inf2902_docno_date = @docnoDate
        ORDER BY inf2902_docno_seq DESC
        ";
                sqlCmd.Parameters.AddWithValue("@docnoType", docnoType);
                sqlCmd.Parameters.AddWithValue("@docnoDate", docnoDate);

                using (var sqlReader = sqlCmd.ExecuteReader())
                {
                    if (sqlReader.HasRows)
                    {
                        if (sqlReader.Read())
                        {
                            seq = Convert.ToInt32(sqlReader["inf2902_docno_seq"]);
                        }
                    }
                }
            }
            return seq;
        }

        public static Inf29 AddItem(Inf29 inf29)
        {
            if (inf29 == null)
            {
                throw new ArgumentNullException("inf29");
            }

            try
            {
                using (var conn = new SqlConnection { ConnectionString = MyConnStringList.AzureGoodeasy })
                using (var sqlCmd = conn.CreateCommand())
                {
                    conn.Open();
                    sqlCmd.CommandText = @"
    INSERT INTO [dbo].[inf29]
               ([inf2901_docno]
               ,[inf2901_bcode]
               ,[inf2909_vcode]
               ,[inf2903_customer_code]
               ,[inf2904_pro_date]
               ,[inf2921_pmonth]
               ,[inf2906_wherehouse]
               ,[inf2964_src_docno]
               ,[inf2928_currency]
               ,[inf2911_sub_amt]
               ,[inf2929_exchange_rate]
               ,[inf2951_allowances]
               ,[inf2910_in_reason]
               ,[remark]
               ,[adduser]
               ,[adddate])
    OUTPUT INSERTED.ID
         VALUES
               (@inf2901_docno
               ,@inf2901_bcode
               ,@inf2903_customer_code
               ,@inf2903_customer_code
               ,@inf2904_pro_date
               ,@inf2921_pmonth
               ,@inf2906_wherehouse
               ,@inf2964_src_docno
               ,@inf2928_currency
               ,@inf2911_sub_amt
               ,@inf2929_exchange_rate
               ,@inf2951_allowances
               ,100
               ,@remark
               ,@adduser
               ,@adddate    ) ";

                    DateTime m_ProDate = new DateTime();
                    DateTime m_MonthDate = new DateTime();
                    DateTime.TryParse(inf29.inf2904_pro_date, out m_ProDate);
                    DateTime.TryParse(inf29.inf2921_pmonth, out m_MonthDate);
                    sqlCmd.Parameters.AddWithValue("@inf2901_docno", inf29.inf2901_docno);
                    sqlCmd.Parameters.AddWithValue("@inf2901_bcode", inf29.inf2901_bcode);
                    sqlCmd.Parameters.AddWithValue("@inf2903_customer_code", inf29.inf2903_customer_code);
                    sqlCmd.Parameters.AddWithValueDatetimeSafe("@inf2904_pro_date", m_ProDate);
                    sqlCmd.Parameters.AddWithValueDatetimeSafe("@inf2921_pmonth", m_MonthDate);
                    sqlCmd.Parameters.AddWithValue("@inf2906_wherehouse", inf29.inf2906_wherehouse);
                    sqlCmd.Parameters.AddWithValue("@inf2964_src_docno", inf29.inf2964_src_docno);
                    sqlCmd.Parameters.AddWithValue("@inf2928_currency", inf29.inf2928_currency);
                    sqlCmd.Parameters.AddWithValue("@inf2911_sub_amt", inf29.Inf29aList.Sum(o => o.inf29a38_one_amt));
                    sqlCmd.Parameters.AddWithValue("@inf2929_exchange_rate", inf29.inf2929_exchange_rate);
                    sqlCmd.Parameters.AddWithValue("@inf2951_allowances", inf29.inf2951_allowances);
                    sqlCmd.Parameters.AddWithValueSafe("@remark", inf29.remark);
                    sqlCmd.Parameters.AddWithValueSafe("@adduser", inf29.adduser ?? "");
                    sqlCmd.Parameters.AddWithValue("@adddate", inf29.adddate);

                    int id = (int)sqlCmd.ExecuteScalar();
                    inf29.id = id;
                }
            }
            catch (Exception ex)
            {

            }

            return inf29;
        }

        public static int AddItem(ImportItemRow inf29Row)
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
                sqlCmd.Parameters.AddWithValue("@docno", docno);

                try
                {
                    //backup to inf29d
                    sqlCmd.CommandText = @"
INSERT INTO [dbo].[inf29d]
           ([inf29d01_docno]
           ,[status]
           ,[inf29d01_bcode]
           ,[inf29d02_docno_type]
           ,[inf29d02_docno_date]
           ,[inf29d02_docno_seq]
           ,[inf29d03_customer_code]
           ,[inf29d04_pro_date]
           ,[inf29d05_trn_type]
           ,[inf29d06_wherehouse]
           ,[inf29d06_ref_no_type]
           ,[inf29d06_ref_no_date]
           ,[inf29d06_ref_no_seq]
           ,[inf29d07_ref_no1_type]
           ,[inf29d07_ref_no1_date]
           ,[inf29d07_ref_no1_seq]
           ,[inf29d08_guino]
           ,[inf29d08_guino_e]
           ,[inf29d09_vcode]
           ,[inf29d10_in_reason]
           ,[inf29d11_sub_amt]
           ,[inf29d12_dis_amt]
           ,[inf29d13_pay_term]
           ,[inf29d14_inv_eff]
           ,[inf29d15_apr_date]
           ,[inf29d16_apr_empid]
           ,[inf29d17_pro_status]
           ,[inf29d18_trn_status]
           ,[inf29d19_sub_cost]
           ,[inf29d20_sales_no]
           ,[inf29d21_pmonth]
           ,[inf29d22_costkind]
           ,[inf29d23_shipria]
           ,[inf29d24_apply_date]
           ,[inf29d25_batch]
           ,[inf29d26_last_date]
           ,[inf29d27_mcode]
           ,[inf29d28_currency]
           ,[inf29d29_exchange_rate]
           ,[inf29d30_user_docno]
           ,[inf29d31_manufa_docno]
           ,[inf29d32_trans_code]
           ,[inf29d33_delivery_no]
           ,[inf29d33_rec_customer_code]
           ,[inf29d34_delivery_place_no]
           ,[inf29d34_delivery_place]
           ,[inf29d35_bcode]
           ,[inf29d35_open_id]
           ,[inf29d35_docno_type]
           ,[inf29d35_docno_date]
           ,[inf29d35_docno_orderno]
           ,[inf29d35_docno_seq]
           ,[inf29d35_total]
           ,[inf29d36_tax_type]
           ,[inf29d36_format]
           ,[inf29d37_tax]
           ,[inf29d37_invoice_class]
           ,[inf29d38_ar_code]
           ,[inf29d39_ar_yymm]
           ,[inf29d40_inv_code]
           ,[inf29d41_inv_yymm]
           ,[inf29d42_depno]
           ,[inf29d43_code_status]
           ,[inf29d44_bcode]
           ,[inf29d44_docno_type]
           ,[inf29d44_docno_date]
           ,[inf29d44_docno_seq]
           ,[inf29d44_language]
           ,[inf29d45_recid]
           ,[inf29d46_sign_date]
           ,[inf29d47_sign_empid]
           ,[inf29d48_odds_amt]
           ,[inf29d48_odds_amt0]
           ,[inf29d49_incidental_amt]
           ,[inf29d50_dis_rate]
           ,[inf29d51_allowances]
           ,[inf29d52_project_no]
           ,[inf29d53_apply_no]
           ,[inf29d54_apply_bot]
           ,[inf29d55_sal_rate]
           ,[inf29d56_pay_term1]
           ,[inf29d57_pay_term2]
           ,[inf29d58_pay_term3]
           ,[inf29d59_pay_term4]
           ,[inf29d60_pay_term5]
           ,[inf29d61_park_depot]
           ,[inf29d62_advance]
           ,[inf29d63_note]
           ,[remark]
           ,[adduser]
           ,[adddate]
           ,[moduser]
           ,[moddate]
           ,[verifyuser]
           ,[verifydate])
        SELECT TOP 1 
              [inf2901_docno]
              ,[status]
              ,[inf2901_bcode]
              ,[inf2902_docno_type]
              ,[inf2902_docno_date]
              ,[inf2902_docno_seq]
              ,[inf2903_customer_code]
              ,[inf2904_pro_date]
              ,[inf2905_trn_type]
              ,[inf2906_wherehouse]
              ,[inf2906_ref_no_type]
              ,[inf2906_ref_no_date]
              ,[inf2906_ref_no_seq]
              ,[inf2907_ref_no1_type]
              ,[inf2907_ref_no1_date]
              ,[inf2907_ref_no1_seq]
              ,[inf2908_guino]
              ,[inf2908_guino_e]
              ,[inf2909_vcode]
              ,[inf2910_in_reason]
              ,[inf2911_sub_amt]
              ,[inf2912_dis_amt]
              ,[inf2913_pay_term]
              ,[inf2914_inv_eff]
              ,[inf2915_apr_date]
              ,[inf2916_apr_empid]
              ,[inf2917_pro_status]
              ,[inf2918_trn_status]
              ,[inf2919_sub_cost]
              ,[inf2920_sales_no]
              ,[inf2921_pmonth]
              ,[inf2922_costkind]
              ,[inf2923_shipria]
              ,[inf2924_apply_date]
              ,[inf2925_batch]
              ,[inf2926_last_date]
              ,[inf2927_mcode]
              ,[inf2928_currency]
              ,[inf2929_exchange_rate]
              ,[inf2930_user_docno]
              ,[inf2931_manufa_docno]
              ,[inf2932_trans_code]
              ,[inf2933_delivery_no]
              ,[inf2933_rec_customer_code]
              ,[inf2934_delivery_place_no]
              ,[inf2934_delivery_place]
              ,[inf2935_bcode]
              ,[inf2935_open_id]
              ,[inf2935_docno_type]
              ,[inf2935_docno_date]
              ,[inf2935_docno_orderno]
              ,[inf2935_docno_seq]
              ,[inf2935_total]
              ,[inf2936_tax_type]
              ,[inf2936_format]
              ,[inf2937_tax]
              ,[inf2937_invoice_class]
              ,[inf2938_ar_code]
              ,[inf2939_ar_yymm]
              ,[inf2940_inv_code]
              ,[inf2941_inv_yymm]
              ,[inf2942_depno]
              ,[inf2943_code_status]
              ,[inf2944_bcode]
              ,[inf2944_docno_type]
              ,[inf2944_docno_date]
              ,[inf2944_docno_seq]
              ,[inf2944_language]
              ,[inf2945_recid]
              ,[inf2946_sign_date]
              ,[inf2947_sign_empid]
              ,[inf2948_odds_amt]
              ,[inf2948_odds_amt0]
              ,[inf2949_incidental_amt]
              ,[inf2950_dis_rate]
              ,[inf2951_allowances]
              ,[inf2952_project_no]
              ,[inf2953_apply_no]
              ,[inf2954_apply_bot]
              ,[inf2955_sal_rate]
              ,[inf2956_pay_term1]
              ,[inf2957_pay_term2]
              ,[inf2958_pay_term3]
              ,[inf2959_pay_term4]
              ,[inf2960_pay_term5]
              ,[inf2961_park_depot]
              ,[inf2962_advance]
              ,[inf2963_note]
              ,[remark]
              ,[adduser]
              ,[adddate]
              ,[moduser]
              ,[moddate]
              ,[verifyuser]
              ,[verifydate]
          FROM [dbo].[inf29]
          WHERE inf29.inf2901_docno = @docno ";

                    count = sqlCmd.ExecuteNonQuery();
                    if (count <= 0)
                    {
                        throw new Exception(String.Format("Backup Inf29 fail on '{0}'", docno));
                    }

                    //delete after backup success
                    sqlCmd.CommandText = @"
        DELETE FROM inf29
        WHERE inf2901_docno = @docno ";

                    count = sqlCmd.ExecuteNonQuery();
                    transaction.Commit();
                }
                catch (Exception)
                {
                    transaction.Rollback();

                    throw;
                }

                return count > 0;
            }
        }

        public static List<ImportItemRow> ParseFromExcelNpoi(Stream stream, int excelVersion)
        {
            var now = DateTime.Now;
            List<ImportItemRow> importItemList = new List<ImportItemRow>();

            IWorkbook workbook = (excelVersion == 2003 ? (IWorkbook) new HSSFWorkbook(stream) : new XSSFWorkbook(stream));
            ISheet sheet = workbook.GetSheetAt(0);

            int startRowNumber = 1; // skip title
            int endRowNumber = sheet.LastRowNum;
            // read table fields
            List<string> inf29Fields = new List<string>();

            {
                IRow excelRow = sheet.GetRow(startRowNumber++);

                int startColumn = 0;
                int endColumn = excelRow.LastCellNum;

                for (int j = startColumn; j < endColumn; j++)
                {
                    ICell excelCell = excelRow.GetCell(j);
                    var data = excelCell == null ? null : excelCell.ToString();
                    inf29Fields.Add(data);
                }
            }
            //ImportKey to know same inf29 rows
            var lastRowId = 0;

            for (int i = startRowNumber; i <= endRowNumber; i++)
            {
                ImportItemRow inf29row = new ImportItemRow();

                IRow excelRow = sheet.GetRow(i);
                int startColumn = 0;
                int endColumn = excelRow.LastCellNum;
                for (int j = startColumn; j < endColumn; j++)
                {
                    ICell excelCell = excelRow.GetCell(j);
                    var data = excelCell == null ? null : excelCell.ToString();
                    var fieldId = inf29Fields[j];
                    if (!String.IsNullOrEmpty(data) && !fieldId.StartsWith("inf29a", StringComparison.OrdinalIgnoreCase) &&
                        fieldId.StartsWith("inf29", StringComparison.OrdinalIgnoreCase))
                    {
                        lastRowId = i;
                    }
                    if (!inf29row.ContainsKey(inf29Fields[j]))
                    {
                        inf29row.Add(inf29Fields[j], data);
                    }
                }
                inf29row.SetMasterRowId(lastRowId);

                importItemList.Add(inf29row);
            }
            return importItemList;
        }

        public static IWorkbook ExportExcelNpoi(Cnf05[] inf29FieldInfoList, Cnf05[] inf29aFieldInfoList,
                                                List<ExportItemRow> inf29Rows, int excelVersion)
        {
            IWorkbook workbook = null;

            if (excelVersion == 2003)
            {
                workbook = new HSSFWorkbook();
            }
            else
            {
                workbook = new XSSFWorkbook();
            }
            var cellStyle = workbook.CreateCellStyle();
            cellStyle.BorderTop = BorderStyle.Thin;
            cellStyle.BorderBottom = BorderStyle.Thin;
            cellStyle.BorderLeft = BorderStyle.Thin;
            cellStyle.BorderRight = BorderStyle.Thin;

            ISheet sheet = workbook.CreateSheet("Sheet1");
            int headRowIndex = 0;
            IRow headRow = sheet.CreateRow(headRowIndex++);
            IRow headRow2 = sheet.CreateRow(headRowIndex++);

            //Inf29 head
            for (var i = 0; i < inf29FieldInfoList.Length; i++)
            {
                var row1Cell = headRow.CreateCell(i);
                row1Cell.CellStyle = cellStyle;
                row1Cell.SetCellValue(inf29FieldInfoList[i].cnf0503_fieldname_tw);
                var row2Cell = headRow2.CreateCell(i);
                row2Cell.CellStyle = cellStyle;
                row2Cell.SetCellValue(inf29FieldInfoList[i].cnf0502_field);
            }
            //Inf29a head
            for (var i = 0; i < inf29aFieldInfoList.Length; i++)
            {
                var row1Cell = headRow.CreateCell(i + inf29FieldInfoList.Length);
                row1Cell.CellStyle = cellStyle;
                row1Cell.SetCellValue(inf29aFieldInfoList[i].cnf0503_fieldname_tw);
                var row2Cell = headRow2.CreateCell(i + inf29FieldInfoList.Length);
                row2Cell.CellStyle = cellStyle;
                row2Cell.SetCellValue(inf29aFieldInfoList[i].cnf0502_field);
            }

            var lastInf29Id = "";
            bool isSameInf29 = false;

            for (int i = 0; i < inf29Rows.Count; i++)
            {
                IRow excelRow = sheet.CreateRow(i + headRowIndex);
                ExportItemRow inf29row = inf29Rows[i];
                var currentInf29id = inf29row.GetInf29Id();
                
                isSameInf29 = lastInf29Id == currentInf29id;
                if (!isSameInf29)
                {
                    lastInf29Id = currentInf29id;
                }
                //inf29
                for (var j = 0; j < inf29FieldInfoList.Length; j++)
                {
                    var excelCell = excelRow.CreateCell(j);
                    excelCell.CellStyle = cellStyle;
                    // not to write same row data for inf29, but only draw border
                    if (!isSameInf29)
                    {
                        var val = inf29row["inf29_" + inf29FieldInfoList[j].cnf0502_field];
                        excelCell.SetCellValue(val != null ? val.ToString() : "");
                        if (val is DateTime)
                        {
                            excelCell.SetCellValue(((DateTime)val).ToString("yyyy/MM/dd"));
                        }
                    }
                }
                //inf29a
                for (var j = 0; j <  inf29aFieldInfoList.Length; j++)
                {
                    var val = inf29row["inf29a_" + inf29aFieldInfoList[j].cnf0502_field];
                    var excelCell = excelRow.CreateCell(j + inf29FieldInfoList.Length);
                    excelCell.CellStyle = cellStyle;
                    excelCell.SetCellValue(val != null ? val.ToString() : "");
                    if (val is DateTime)
                    {
                        excelCell.SetCellValue(((DateTime) val).ToString("yyyy/MM/dd"));
                    }
                }
            }

            for (var i = 0; i < inf29FieldInfoList.Length + inf29aFieldInfoList.Length; i++)
            {
                sheet.AutoSizeColumn(i);
            }
            return workbook;
        }


        /// <summary>
        /// Wrapper for inf29 export item row. Must provide inf29 id to know duplicate data.
        /// </summary>
        public class ExportItemRow : Dictionary<string, object>
        {
            public ExportItemRow(string inf29Id)
            {
                this.Add("ExportRowMasterId", inf29Id);
            }

            public string GetInf29Id()
            {
                return this["ExportRowMasterId"] as string;
            }
        }

        public class ImportItemRow : Dictionary<string, object>
        {
            public string adduser { get; set; }
            public DateTime adddate { get; set; }

            public ImportItemRow()
            {
            }

            public ImportItemRow(Dictionary<string, object> row)
            {
                foreach (KeyValuePair<string, object> column in row)
                {
                    this.Add(column.Key, column.Value);
                }
            }

            public void SetMasterRowId(int inf29RowId)
            {
                if (!this.ContainsKey("ImportRowMasterId"))
                {
                    this.Add("ImportRowMasterId", inf29RowId);

                }
                else
                {
                    this["ImportRowMasterId"] = inf29RowId;
                }
            }

            public int GetMasterRowId()
            {
                return (int) this["ImportRowMasterId"];
            }
        }
    }
}
