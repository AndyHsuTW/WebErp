using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ErpBaseLibrary.DB;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using NPOI.XSSF.UserModel;
using OfficeOpenXml;
using OfficeOpenXml.Style;


namespace DINP015
{
    /// <summary>
    /// Inf15 的摘要描述
    /// </summary>
    public class Inf15
    {
        #region properties from database
        /// <summary>
        /// Key
        /// </summary>
        public int? id { get; set; }
        /// <summary>
        /// 類型 ""->公司 1->客戶
        /// </summary>
        public string status { get; set; }
        /// <summary>
        /// 公司代號
        /// </summary>
        public string inf1501_bcode { get; set; }
        /// <summary>
        /// 客戶代號
        /// </summary>
        public string inf1501_ccode { get; set; }
        /// <summary>
        /// 系統代號
        /// </summary>
        public string inf1502_app { get; set; }
        /// <summary>
        /// 結帳年月
        /// </summary>
        public string inf1502_pmonth { get; set; }
        /// <summary>
        /// 結帳別 1->月末結帳 2->月中結帳
        /// </summary>
        public string inf1502_close_type { get; set; }
        /// <summary>
        /// 序號
        /// </summary>
        public string inf1502_seq { get; set; }
        /// <summary>
        /// 結帳開始日期
        /// </summary>
        public string inf1503_beg_date { get; set; }
        /// <summary>
        /// 結帳結束日期
        /// </summary>
        public string inf1504_end_date { get; set; }
        /// <summary>
        /// 本次結轉日期
        /// </summary>
        public string inf1505_this_date { get; set; }
        /// <summary>
        /// 上次結轉日期
        /// </summary>
        public string inf1506_last_date { get; set; }
        /// <summary>
        /// 帳銷數可否為負值 1->可 2->不可
        /// </summary>
        public string inf1507_sal_flag1 { get; set; }
        /// <summary>
        /// 庫存計算狀態 1->電腦盤點 2->人工盤點 1->人工加電腦盤點 
        /// </summary>
        public string inf1508_inv_flag2 { get; set; }
        /// <summary>
        /// 單據是否有異動 不用填
        /// </summary>
        public string inf1509_pas_flag3 { get; set; }
        /// <summary>
        /// 關帳狀態 0->未關帳 1->關帳 2->完全關帳 
        /// </summary>
        public string inf1510_clo_flag4 { get; set; }
        /// <summary>
        /// 結轉狀態 1->是 2->否
        /// </summary>
        public string inf1511_trx_flag5 { get; set; }
        /// <summary>
        /// 過帳碼 ""->尚未過帳 Y->己過帳
        /// </summary>
        public string inf1511_rev_flag6 { get; set; }
        /// <summary>
        /// 發票寄出日期
        /// </summary>
        public string inf1512_inv_date { get; set; }
        /// <summary>
        /// 備註
        /// </summary>
        public string remark { get; set; }
        public string adduser { get; set; }
        public string adddate { get; set; }
        public string moduser { get; set; }
        public string moddate { get; set; }
        #endregion

        public Inf15()
        {
            //
            // TODO: 在這裡新增建構函式邏輯
            //
        }

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

        public class FilterOption
        {
            public string keyword { get; set; }
            /// <summary>
            /// 結帳日期 開始 YYYY/MM
            /// </summary>
            public string inf1503_beg_date { get; set; }
            /// <summary>
            /// 結帳日期 結束 YYYY/MM
            /// </summary>
            public string inf1504_end_date { get; set; }
            /// <summary>
            /// 系統代號 開始
            /// </summary>
            public string inf1502_app_start { get; set; }
            /// <summary>
            /// 系統代號 結束
            /// </summary>
            public string inf1502_app_end { get; set; }
            /// <summary>
            /// 公司代號 開始
            /// </summary>
            public string inf1501_bcode_start { get; set; }
            /// <summary>
            /// 公司代號 結束
            /// </summary>
            public string inf1501_bcode_end { get; set; }
            public List<int> idList { get; set; }
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
        /// 取得最後一筆資料的預設日期
        /// </summary>
        /// <returns>Inf15</returns>
        public static Inf15 GetLastData()
        {
            Inf15 inf15 = new Inf15();
            DataSet ds = GetDataSet(MyConnStringList.AzureGoodeasy, "select id from [dbo].[inf15]");
            if (ds.Tables[0].Rows.Count > 0)
            {
                DataSet tmpds = GetDataSet(MyConnStringList.AzureGoodeasy, "select top 1 * from inf15 order by id desc ");
                DateTime m_BegDate = new DateTime();
                DateTime m_EndDate = new DateTime();
                DateTime m_ThisDate = new DateTime();
                DateTime m_LastDate = new DateTime();
                DateTime.TryParse(tmpds.Tables[0].Rows[0]["inf1504_end_date"].ToString(), out m_EndDate);
                m_BegDate = m_EndDate.AddDays(1);
                m_EndDate = m_BegDate.AddDays(30);
                m_ThisDate = m_EndDate.AddDays(1);
                m_LastDate = m_BegDate;
                inf15.inf1503_beg_date = m_BegDate.ToString("yyyy/MM/dd");
                inf15.inf1504_end_date = m_EndDate.ToString("yyyy/MM/dd");
                inf15.inf1505_this_date = m_ThisDate.ToString("yyyy/MM/dd");
                inf15.inf1506_last_date = m_LastDate.ToString("yyyy/MM/dd");

                return inf15;
            }

            return null;
        }

        public static Inf15 AddItem(Inf15 inf15)
        {
            if (inf15 == null)
            {
                throw new ArgumentNullException("inf15");
            }
            //Status 空白=公司  1=客戶
            if (String.IsNullOrEmpty(inf15.status))
            {
                if (String.IsNullOrEmpty(inf15.inf1501_bcode))
                {
                    throw new Exception("公司代號不可以是空白");
                }
            }
            else if (inf15.status == "1")
            {
                if (String.IsNullOrEmpty(inf15.inf1501_ccode))
                {
                    throw new Exception("客戶代號不可以是空白");
                }
            }

            if (String.IsNullOrEmpty(inf15.inf1502_app))
            {
                throw new Exception("系統代號不可以是空白");
            }

            if (inf15.inf1502_pmonth == "")
            {
                throw new Exception("結帳年月不可以是空白");
            }

            if (String.IsNullOrEmpty(inf15.inf1502_close_type))
            {
                throw new Exception("請選擇結帳區間");
            }

            if (String.IsNullOrEmpty(inf15.inf1502_seq))
            {
                throw new Exception("請輸入序號");
            }

            DataSet ds = GetDataSet(MyConnStringList.AzureGoodeasy, "select * from [dbo].[inf15]");
            DateTime m_BegDate = new DateTime();
            DateTime m_EndDate = new DateTime();
            DateTime m_ThisDate = new DateTime();
            DateTime m_LastDate = new DateTime();
            if (ds.Tables[0].Rows.Count == 0)
            {
                DateTime.TryParse(inf15.inf1503_beg_date, out m_BegDate);
                DateTime.TryParse(inf15.inf1504_end_date, out m_EndDate);
                m_ThisDate = m_EndDate.AddDays(1);
                m_LastDate = m_BegDate;
                inf15.inf1503_beg_date = m_BegDate.ToString("yyyy/MM/dd HH:mm:ss");
                inf15.inf1504_end_date = m_EndDate.ToString("yyyy/MM/dd HH:mm:ss");
                DateTime.TryParse(inf15.inf1505_this_date, out m_ThisDate);
                DateTime.TryParse(inf15.inf1506_last_date, out m_LastDate);
                inf15.inf1505_this_date = m_ThisDate.ToString("yyyy/MM/dd HH:mm:ss");
                inf15.inf1506_last_date = m_LastDate.ToString("yyyy/MM/dd HH:mm:ss");
            }
            else
            {
                string m_TmpEndDate = ds.Tables[0].Rows[ds.Tables[0].Rows.Count - 1]["inf1504_end_date"].ToString().Trim();
                DateTime.TryParse(m_TmpEndDate, out m_EndDate);
                m_BegDate = m_EndDate.AddDays(1);
                m_LastDate = m_BegDate;
                inf15.inf1503_beg_date = m_BegDate.ToString("yyyy/MM/dd HH:mm:ss");
                DateTime.TryParse(inf15.inf1504_end_date, out m_EndDate);
                m_ThisDate = m_EndDate.AddDays(1);
                inf15.inf1504_end_date = m_EndDate.ToString("yyyy/MM/dd HH:mm:ss");
                inf15.inf1505_this_date = m_ThisDate.ToString("yyyy/MM/dd HH:mm:ss");
                inf15.inf1506_last_date = m_LastDate.ToString("yyyy/MM/dd HH:mm:ss");
            }
            using (var conn = new SqlConnection { ConnectionString = MyConnStringList.AzureGoodeasy })
            using (var sqlCmd = conn.CreateCommand())
            {
                conn.Open();
                sqlCmd.CommandText = @"
    INSERT INTO [dbo].[inf15]
           ([status]
           ,[inf1501_bcode]
           ,[inf1502_app]
           ,[inf1502_pmonth]
           ,[inf1502_close_type]
           ,[inf1502_seq]
           ,[inf1503_beg_date]
           ,[inf1504_end_date]
           ,[inf1505_this_date]
           ,[inf1506_last_date]
           ,[inf1507_sal_flag1]
           ,[inf1508_inv_flag2]
           ,[inf1509_pas_flag3]
           ,[inf1510_clo_flag4]
           ,[inf1511_trx_flag5]
           ,[inf1511_rev_flag6]
           ,[inf1512_inv_date]
           ,[remark]
           ,[adduser]
           ,[adddate])
    OUTPUT INSERTED.ID
     VALUES
           (@status
           ,@inf1501_bcode
           ,@inf1502_app
           ,@inf1502_pmonth
           ,@inf1502_close_type
           ,@inf1502_seq
           ,@inf1503_beg_date
           ,@inf1504_end_date
           ,@inf1505_this_date
           ,@inf1506_last_date
           ,@inf1507_sal_flag1
           ,@inf1508_inv_flag2
           ,@inf1509_pas_flag3
           ,@inf1510_clo_flag4
           ,@inf1511_trx_flag5
           ,@inf1511_rev_flag6
           ,@inf1512_inv_date
           ,@remark
           ,@adduser
           ,@adddate    ) ";
                sqlCmd.Parameters.AddWithValue("@status", inf15.status);
                sqlCmd.Parameters.AddWithValue("@inf1501_bcode", inf15.status == "" ? inf15.inf1501_bcode : inf15.inf1501_ccode);
                sqlCmd.Parameters.AddWithValue("@inf1502_app", inf15.inf1502_app);
                sqlCmd.Parameters.AddWithValue("@inf1502_pmonth", DateTime.Parse(inf15.inf1502_pmonth).ToString("yyyy/MM/dd HH:mm:ss"));
                sqlCmd.Parameters.AddWithValue("@inf1502_close_type", inf15.inf1502_close_type);
                sqlCmd.Parameters.AddWithValue("@inf1502_seq", inf15.inf1502_seq);
                sqlCmd.Parameters.AddWithValue("@inf1503_beg_date", DateTime.Parse(inf15.inf1503_beg_date).ToString("yyyy/MM/dd HH:mm:ss"));
                sqlCmd.Parameters.AddWithValue("@inf1504_end_date", DateTime.Parse(inf15.inf1504_end_date).ToString("yyyy/MM/dd HH:mm:ss"));
                sqlCmd.Parameters.AddWithValue("@inf1505_this_date", DateTime.Parse(inf15.inf1505_this_date).ToString("yyyy/MM/dd HH:mm:ss"));
                sqlCmd.Parameters.AddWithValue("@inf1506_last_date", DateTime.Parse(inf15.inf1506_last_date).ToString("yyyy/MM/dd HH:mm:ss"));
                sqlCmd.Parameters.AddWithValue("@inf1507_sal_flag1", inf15.inf1507_sal_flag1);
                sqlCmd.Parameters.AddWithValue("@inf1508_inv_flag2", inf15.inf1508_inv_flag2);
                sqlCmd.Parameters.AddWithValue("@inf1509_pas_flag3", inf15.inf1509_pas_flag3 ?? "");
                sqlCmd.Parameters.AddWithValue("@inf1510_clo_flag4", inf15.inf1510_clo_flag4);
                sqlCmd.Parameters.AddWithValue("@inf1511_trx_flag5", inf15.inf1511_trx_flag5);
                sqlCmd.Parameters.AddWithValueSafe("@inf1511_rev_flag6", inf15.inf1511_rev_flag6 ?? "");
                sqlCmd.Parameters.AddWithValue("@inf1512_inv_date", DateTime.Parse(inf15.inf1512_inv_date).ToString("yyyy/MM/dd HH:mm:ss"));
                sqlCmd.Parameters.AddWithValueSafe("@remark", inf15.remark ?? "");
                sqlCmd.Parameters.AddWithValue("@adduser", inf15.adduser ?? "");
                sqlCmd.Parameters.AddWithValueSafe("@adddate", DateTime.Parse(inf15.adddate).ToString("yyyy/MM/dd HH:mm:ss"));

                int id = (int)sqlCmd.ExecuteScalar();
                inf15.id = id;
            }

            return inf15;
        }

        public static Inf15 UpdateItem(Inf15 inf15)
        {
            if (inf15 == null)
            {
                throw new ArgumentNullException("inf15");
            }
            using (var conn = new SqlConnection { ConnectionString = MyConnStringList.AzureGoodeasy })
            using (var sqlCmd = conn.CreateCommand())
            {
                conn.Open();
                sqlCmd.CommandText = @"
UPDATE [dbo].[inf15]
   SET [status] = @status 
      ,[inf1501_bcode] = @inf1501_bcode
      ,[inf1502_app] = @inf1502_app
      ,[inf1502_pmonth] = @inf1502_pmonth
      ,[inf1502_close_type] = @inf1502_close_type
      ,[inf1502_seq] = @inf1502_seq
      ,[inf1503_beg_date] = @inf1503_beg_date
      ,[inf1504_end_date] = @inf1504_end_date
      ,[inf1505_this_date] = @inf1505_this_date
      ,[inf1506_last_date] = @inf1506_last_date
      ,[inf1507_sal_flag1] = @inf1507_sal_flag1
      ,[inf1508_inv_flag2] = @inf1508_inv_flag2
      ,[inf1509_pas_flag3] = @inf1509_pas_flag3
      ,[inf1510_clo_flag4] = @inf1510_clo_flag4
      ,[inf1511_trx_flag5] = @inf1511_trx_flag5
      ,[inf1511_rev_flag6] = @inf1511_rev_flag6
      ,[inf1512_inv_date] = @inf1512_inv_date
      ,[remark] = @remark
      ,[moduser] = @moduser
      ,[moddate] = @moddate
 WHERE id=@id
";

                sqlCmd.Parameters.AddWithValue("@id", inf15.id);
                sqlCmd.Parameters.AddWithValue("@status", inf15.status);
                sqlCmd.Parameters.AddWithValue("@inf1501_bcode", inf15.status == "" ? inf15.inf1501_bcode : inf15.inf1501_ccode);
                sqlCmd.Parameters.AddWithValue("@inf1502_app", inf15.inf1502_app);
                sqlCmd.Parameters.AddWithValue("@inf1502_pmonth", DateTime.Parse(inf15.inf1502_pmonth).ToString("yyyy/MM/dd HH:mm:ss"));
                sqlCmd.Parameters.AddWithValue("@inf1502_close_type", inf15.inf1502_close_type);
                sqlCmd.Parameters.AddWithValue("@inf1502_seq", inf15.inf1502_seq);
                sqlCmd.Parameters.AddWithValue("@inf1503_beg_date", DateTime.Parse(inf15.inf1503_beg_date).ToString("yyyy/MM/dd HH:mm:ss"));
                sqlCmd.Parameters.AddWithValue("@inf1504_end_date", DateTime.Parse(inf15.inf1504_end_date).ToString("yyyy/MM/dd HH:mm:ss"));
                sqlCmd.Parameters.AddWithValue("@inf1505_this_date", DateTime.Parse(inf15.inf1505_this_date).ToString("yyyy/MM/dd HH:mm:ss"));
                sqlCmd.Parameters.AddWithValue("@inf1506_last_date", DateTime.Parse(inf15.inf1506_last_date).ToString("yyyy/MM/dd HH:mm:ss"));
                sqlCmd.Parameters.AddWithValue("@inf1507_sal_flag1", inf15.inf1507_sal_flag1);
                sqlCmd.Parameters.AddWithValue("@inf1508_inv_flag2", inf15.inf1508_inv_flag2);
                sqlCmd.Parameters.AddWithValue("@inf1509_pas_flag3", inf15.inf1509_pas_flag3 ?? "");
                sqlCmd.Parameters.AddWithValue("@inf1510_clo_flag4", inf15.inf1510_clo_flag4);
                sqlCmd.Parameters.AddWithValue("@inf1511_trx_flag5", inf15.inf1511_trx_flag5);
                sqlCmd.Parameters.AddWithValueSafe("@inf1511_rev_flag6", inf15.inf1511_rev_flag6 ?? "");
                sqlCmd.Parameters.AddWithValue("@inf1512_inv_date", DateTime.Parse(inf15.inf1512_inv_date).ToString("yyyy/MM/dd HH:mm:ss"));
                sqlCmd.Parameters.AddWithValueSafe("@remark", inf15.remark ?? "");
                sqlCmd.Parameters.AddWithValue("@moduser", inf15.moduser ?? "");
                sqlCmd.Parameters.AddWithValueSafe("@moddate", DateTime.Parse(inf15.moddate).ToString("yyyy/MM/dd HH:mm:ss"));

                var count = sqlCmd.ExecuteNonQuery();
                if (count < 1)
                {
                    return null;
                }
            }

            return inf15;
        }

        /// <summary>
        /// Return true if success.
        /// </summary>
        /// <param name="idList"></param>
        /// <returns></returns>
        public static bool DeleteItem(params int[] idList)
        {
            if (idList == null || idList.Length == 0)
            {
                throw new ArgumentNullException("idList");
            }
            using (var conn = new SqlConnection { ConnectionString = MyConnStringList.AzureGoodeasy })
            using (var sqlCmd = conn.CreateCommand())
            {
                string[] paramNames = idList.Select(
                    (s, i) => "@id" + i.ToString()).ToArray();

                string inClause = string.Join(",", paramNames);
                for (int i = 0; i < paramNames.Length; i++)
                {
                    sqlCmd.Parameters.AddWithValue(paramNames[i], idList[i]);
                }

                conn.Open();
                sqlCmd.CommandText = String.Format(@"INSERT INTO inf15d
                                                      (status,
                                                       inf1501_bcode,
                                                       inf1502_app,
                                                       inf1502_pmonth,
                                                       inf1502_close_type,
                                                       inf1502_seq,
                                                       inf1503_beg_date,
                                                       inf1504_end_date,
                                                       inf1505_this_date,
                                                       inf1506_last_date,
                                                       inf1507_sal_flag1,
                                                       inf1508_inv_flag2,
                                                       inf1509_pas_flag3,
                                                       inf1510_clo_flag4,
                                                       inf1511_trx_flag5,
                                                       inf1511_rev_flag6,
                                                       inf1511_rev_flag7,
                                                       inf1512_inv_date,
                                                       remark,
                                                       adduser,
                                                       adddate,
                                                       moduser,
                                                       moddate)
                                                      select status,
                                                             inf1501_bcode,
                                                             inf1502_app,
                                                             inf1502_pmonth,
                                                             inf1502_close_type,
                                                             inf1502_seq,
                                                             inf1503_beg_date,
                                                             inf1504_end_date,
                                                             inf1505_this_date,
                                                             inf1506_last_date,
                                                             inf1507_sal_flag1,
                                                             inf1508_inv_flag2,
                                                             inf1509_pas_flag3,
                                                             inf1510_clo_flag4,
                                                             inf1511_trx_flag5,
                                                             inf1511_rev_flag6,
                                                             inf1511_rev_flag7,
                                                             inf1512_inv_date,
                                                             remark,
                                                             adduser,
                                                             adddate,
                                                             moduser,
                                                             moddate
                                                        from inf15
                                                       where id in ({0})
                                                    ", inClause);
                sqlCmd.ExecuteNonQuery();
                sqlCmd.CommandText = String.Format(@"Delete from [dbo].[inf15]
                                                    WHERE id IN ({0})", inClause);

                sqlCmd.ExecuteNonQuery();

            }

            return true;
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
    SELECT TOP 1 1 from sys.objects where type_desc = 'SQL_STORED_PROCEDURE' AND name = 'Inf15_FindStringInTable' ");

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
        CREATE PROCEDURE Inf15_FindStringInTable 
	        -- Add the parameters for the stored procedure here
	         @stringToFind VARCHAR(100)
        AS
        BEGIN
	        -- SET NOCOUNT ON added to prevent extra result sets from
	        -- interfering with SELECT statements.
	        SET NOCOUNT ON;

            BEGIN TRY
	           DECLARE @sqlCommand varchar(max) = 'SELECT id FROM [Inf15] WHERE ' 
	   
	           SELECT @sqlCommand = @sqlCommand + '[' + COLUMN_NAME + '] LIKE ''%' + @stringToFind + '%'' OR '
	           FROM INFORMATION_SCHEMA.COLUMNS 
	           WHERE  TABLE_NAME = 'Inf15' 
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


        public static List<Inf15> Search(FilterOption filterOption)
        {
            List<Inf15> inf15List = new List<Inf15>();

            using (var conn = new SqlConnection { ConnectionString = MyConnStringList.AzureGoodeasy })
            using (var sqlCmd = conn.CreateCommand())
            {
                conn.Open();
                var keywordFilter = "";
                var inf15AccountDateFilter = "";
                var inf15AppFilter = "";
                var inf15BCodeFilter = "";
                if (filterOption != null)
                {
                    if (!String.IsNullOrEmpty(filterOption.keyword))
                    {
                        keywordFilter = String.Format(@" AND (
           inf1501_bcode like @Keyword 
           OR inf1502_app  like @Keyword 
           OR inf1502_pmonth  like @Keyword 
           OR inf1502_close_type  like @Keyword 
           OR inf1502_seq  like @Keyword 
           OR inf1503_beg_date  like @Keyword 
           OR inf1504_end_date  like @Keyword 
           OR inf1505_this_date  like @Keyword 
           OR inf1506_last_date  like @Keyword 
           OR inf1507_sal_flag1  like @Keyword 
           OR inf1508_inv_flag2  like @Keyword 
           OR inf1509_pas_flag3  like @Keyword 
           OR inf1510_clo_flag4  like @Keyword 
           OR inf1511_trx_flag5  like @Keyword 
           OR inf1511_rev_flag6  like @Keyword 
           OR inf1512_inv_date  like @Keyword 
           OR remark like @Keyword )");
                        sqlCmd.Parameters.AddWithValue("@Keyword", "%" + filterOption.keyword + "%");
                    }
                    //結帳年月
                    if (!string.IsNullOrEmpty(filterOption.inf1503_beg_date))
                    {
                        inf15AccountDateFilter += @" AND @CheckoutDate_Start<=CONVERT(char(7), inf15.inf1502_pmonth, 126)";
                        sqlCmd.Parameters.AddWithValue("@CheckoutDate_Start", Convert.ToDateTime(filterOption.inf1503_beg_date).ToString("yyyy-MM"));
                    }

                    if (!string.IsNullOrEmpty(filterOption.inf1504_end_date))
                    {
                        inf15AccountDateFilter += @" AND CONVERT(char(7), inf15.inf1502_pmonth, 126)<=@CheckoutDate_End";
                        sqlCmd.Parameters.AddWithValue("@CheckoutDate_End", Convert.ToDateTime(filterOption.inf1504_end_date).ToString("yyyy-MM"));
                    }
                    //系統代號
                    if (!string.IsNullOrEmpty(filterOption.inf1502_app_start))
                    {
                        inf15AppFilter += @" AND @App_Start<=inf15.inf1502_app";
                        sqlCmd.Parameters.AddWithValue("@App_Start", filterOption.inf1502_app_start);
                    }

                    if (!string.IsNullOrEmpty(filterOption.inf1502_app_end))
                    {
                        inf15AppFilter += @" AND inf15.inf1502_app<=@App_End";
                        sqlCmd.Parameters.AddWithValue("@App_End", filterOption.inf1502_app_end);
                    }

                    //公司代碼
                    if (!string.IsNullOrEmpty(filterOption.inf1501_bcode_start))
                    {
                        inf15BCodeFilter += @" AND inf15.status = ''";
                        inf15BCodeFilter += @" AND inf15.inf1501_bcode>=@Bcode_Start";
                        sqlCmd.Parameters.AddWithValue("@Bcode_Start", filterOption.inf1501_bcode_start);
                    }

                    if (!string.IsNullOrEmpty(filterOption.inf1501_bcode_end))
                    {
                        inf15BCodeFilter += @" AND inf15.status = ''";
                        inf15BCodeFilter += @" AND @Bcode_End<=inf15.inf1501_bcode";
                        sqlCmd.Parameters.AddWithValue("@Bcode_End", filterOption.inf1501_bcode_end);
                    }
                    sqlCmd.CommandText = String.Format(@"SELECT [id]
                                                            ,[status]
                                                            ,[inf1501_bcode]
                                                            ,[inf1502_app]
                                                            ,[inf1502_pmonth]
                                                            ,[inf1502_close_type]
                                                            ,[inf1502_seq]
                                                            ,[inf1503_beg_date]
                                                            ,[inf1504_end_date]
                                                            ,[inf1505_this_date]
                                                            ,[inf1506_last_date]
                                                            ,[inf1507_sal_flag1]
                                                            ,[inf1508_inv_flag2]
                                                            ,[inf1509_pas_flag3]
                                                            ,[inf1510_clo_flag4]
                                                            ,[inf1511_trx_flag5]
                                                            ,[inf1511_rev_flag6]
                                                            ,[inf1511_rev_flag7]
                                                            ,[inf1512_inv_date]
                                                            ,[remark]
                                                            ,[adduser]
                                                            ,[adddate]
                                                            ,[moduser]
                                                            ,[moddate]
                                                          FROM [dbo].[inf15]
                                                        WHERE 1=1
                                                        {0}
                                                        {1}
                                                        {2}
                                                        {3} ", inf15AccountDateFilter, inf15AppFilter, inf15BCodeFilter, keywordFilter);

                    using (var sqlReader = sqlCmd.ExecuteReader())
                    {
                        if (sqlReader.HasRows)
                        {
                            while (sqlReader.Read())
                            {
                                Inf15 inf15 = new Inf15();
                                inf15.id = Convert.ToInt32(sqlReader["id"]);
                                inf15.status = Convert.ToString(sqlReader["status"]);
                                inf15.inf1501_bcode = inf15.status == "" ? Convert.ToString(sqlReader["inf1501_bcode"]) : "";
                                inf15.inf1501_ccode = inf15.status == "1" ? Convert.ToString(sqlReader["inf1501_bcode"]) : "";
                                inf15.inf1502_app = Convert.ToString(sqlReader["inf1502_app"]);
                                inf15.inf1502_pmonth = string.IsNullOrEmpty(Convert.ToString(sqlReader["inf1502_pmonth"])) ? "" : DateTime.Parse(Convert.ToString(sqlReader["inf1502_pmonth"])).ToString("yyyy/MM");
                                inf15.inf1502_close_type = Convert.ToString(sqlReader["inf1502_close_type"]);
                                inf15.inf1502_seq = Convert.ToString(sqlReader["inf1502_seq"]);
                                inf15.inf1503_beg_date = string.IsNullOrEmpty(Convert.ToString(sqlReader["inf1503_beg_date"])) ? "" : DateTime.Parse(Convert.ToString(sqlReader["inf1503_beg_date"])).ToString("yyyy/MM/dd");
                                inf15.inf1504_end_date = string.IsNullOrEmpty(Convert.ToString(sqlReader["inf1504_end_date"])) ? "" : DateTime.Parse(Convert.ToString(sqlReader["inf1504_end_date"])).ToString("yyyy/MM/dd");
                                inf15.inf1505_this_date = string.IsNullOrEmpty(Convert.ToString(sqlReader["inf1505_this_date"])) ? "" : DateTime.Parse(Convert.ToString(sqlReader["inf1505_this_date"])).ToString("yyyy/MM/dd");
                                inf15.inf1506_last_date = string.IsNullOrEmpty(Convert.ToString(sqlReader["inf1506_last_date"])) ? "" : DateTime.Parse(Convert.ToString(sqlReader["inf1506_last_date"])).ToString("yyyy/MM/dd");
                                inf15.inf1507_sal_flag1 = Convert.ToString(sqlReader["inf1507_sal_flag1"]);
                                inf15.inf1508_inv_flag2 = Convert.ToString(sqlReader["inf1508_inv_flag2"]);
                                inf15.inf1509_pas_flag3 = Convert.ToString(sqlReader["inf1509_pas_flag3"]);
                                inf15.inf1510_clo_flag4 = Convert.ToString(sqlReader["inf1510_clo_flag4"]);
                                inf15.inf1511_trx_flag5 = Convert.ToString(sqlReader["inf1511_trx_flag5"]);
                                inf15.inf1511_rev_flag6 = Convert.ToString(sqlReader["inf1511_rev_flag6"]);
                                inf15.inf1512_inv_date = string.IsNullOrEmpty(Convert.ToString(sqlReader["inf1512_inv_date"])) ? "" : DateTime.Parse(Convert.ToString(sqlReader["inf1512_inv_date"])).ToString("yyyy/MM/dd");
                                inf15.remark = Convert.ToString(sqlReader["remark"]);
                                inf15.adduser = Convert.ToString(sqlReader["adduser"]);
                                inf15.adddate = string.IsNullOrEmpty(Convert.ToString(sqlReader["adddate"])) ? "" : DateTime.Parse(Convert.ToString(sqlReader["adddate"])).ToString("yyyy/MM/dd");
                                inf15.moduser = Convert.ToString(sqlReader["moduser"]);
                                inf15.moddate = string.IsNullOrEmpty(Convert.ToString(sqlReader["moddate"])) ? "" : DateTime.Parse(Convert.ToString(sqlReader["moddate"])).ToString("yyyy/MM/dd");

                                inf15List.Add(inf15);
                            }
                        }
                    }
                }
                return inf15List;
            }
        }

        public static string GetCompanyName(string BCode)
        {
            List<Cnf07> BcodeList = Cnf07.GetList();
            var item = BcodeList.Where(i => i.cnf0701_bcode == BCode).ToList().SingleOrDefault();
            return item == null ? "" : item.cnf0701_bcode + "-" + item.cnf0703_bfname;
        }

        public static string GetCustomerName(string CCode)
        {
            List<Cmf01> CcodeList = Cmf01.GetList();
            var item = CcodeList.Where(i => i.cmf0102_cuscode == CCode).ToList().SingleOrDefault();
            return item == null ? "" : item.cmf0102_cuscode + "-" + item.cmf0103_bname;
        }

        public static string GetAppName(string AppCode)
        {
            List<Cnf10> AppCodeList = Cnf10.GetList("000");
            var item = AppCodeList.Where(i => i.id == AppCode).ToList().SingleOrDefault();
            return item == null ? "" : item.cnf1002_fileorder + "-" + item.cnf1003_char01;
        }

        public static ExcelPackage Export(string[] fieldName, List<Inf15> inf15List)
        {
            var excel = new ExcelPackage();
            var sheet = excel.Workbook.Worksheets.Add("Sheet1");
            var title = 1;

            for (var i = 0; i < fieldName.Length; i++)
            {
                if (String.Equals("status", fieldName[i]))
                {
                    sheet.Cells[title, i + 1].Value = "狀態碼";
                }
                else if (String.Equals("inf1501_bcode", fieldName[i]))
                {
                    sheet.Cells[title, i + 1].Value = "代號";
                }
                else if (String.Equals("inf1502_app", fieldName[i]))
                {
                    sheet.Cells[title, i + 1].Value = "系統代號";
                }
                else if (String.Equals("inf1502_pmonth", fieldName[i]))
                {
                    sheet.Cells[title, i + 1].Value = "結帳年月";
                }
                else if (String.Equals("inf1502_close_type", fieldName[i]))
                {
                    sheet.Cells[title, i + 1].Value = "結帳別";
                }
                else if (String.Equals("inf1502_seq", fieldName[i]))
                {
                    sheet.Cells[title, i + 1].Value = "序號";
                }
                else if (String.Equals("inf1503_beg_date", fieldName[i]))
                {
                    sheet.Cells[title, i + 1].Value = "結帳開始日期";
                }
                else if (String.Equals("inf1504_end_date", fieldName[i]))
                {
                    sheet.Cells[title, i + 1].Value = "結帳結束日期";
                }
                else if (String.Equals("inf1505_this_date", fieldName[i]))
                {
                    sheet.Cells[title, i + 1].Value = "本次結轉日期";
                }
                else if (String.Equals("inf1506_last_date", fieldName[i]))
                {
                    sheet.Cells[title, i + 1].Value = "上次結轉日期";
                }
                else if (String.Equals("inf1507_sal_flag1", fieldName[i]))
                {
                    sheet.Cells[title, i + 1].Value = "帳銷數可否為負值";
                }
                else if (String.Equals("inf1508_inv_flag2", fieldName[i]))
                {
                    sheet.Cells[title, i + 1].Value = "庫存計算狀態";
                }
                else if (String.Equals("inf1509_pas_flag3", fieldName[i]))
                {
                    sheet.Cells[title, i + 1].Value = "單據是否有異動";
                }
                else if (String.Equals("inf1510_clo_flag4", fieldName[i]))
                {
                    sheet.Cells[title, i + 1].Value = "關帳狀態";
                }
                else if (String.Equals("inf1511_trx_flag5", fieldName[i]))
                {
                    sheet.Cells[title, i + 1].Value = "結轉狀態";
                }
                else if (String.Equals("inf1511_rev_flag6", fieldName[i]))
                {
                    sheet.Cells[title, i + 1].Value = "過帳碼";
                }
                else if (String.Equals("inf1512_inv_date", fieldName[i]))
                {
                    sheet.Cells[title, i + 1].Value = "發票寄出日期";
                }
                else if (String.Equals("remark", fieldName[i]))
                {
                    sheet.Cells[title, i + 1].Value = "備註";
                }
                else if (String.Equals("adddate", fieldName[i]))
                {
                    sheet.Cells[title, i + 1].Value = "新增日期";
                }
                else if (String.Equals("adduser", fieldName[i]))
                {
                    sheet.Cells[title, i + 1].Value = "新增者";
                }
                else if (String.Equals("moddate", fieldName[i]))
                {
                    sheet.Cells[title, i + 1].Value = "修改日期";
                }
                else if (String.Equals("moduser", fieldName[i]))
                {
                    sheet.Cells[title, i + 1].Value = "修改者";
                }
            }

            for (int i = 0; i < inf15List.Count; i++)
            {
                Inf15 inf15Item = inf15List[i];
                for (var j = 0; j < fieldName.Length; j++)
                {
                    if (String.Equals("status", fieldName[j]))
                    {
                        if (string.IsNullOrEmpty(inf15Item.status))
                        {
                            inf15Item.status = "公司";
                            inf15Item.inf1501_bcode = GetCompanyName(inf15Item.inf1501_bcode);
                        }
                        else if (inf15Item.status == "1")
                        {
                            inf15Item.status = "客戶";
                            inf15Item.inf1501_bcode = GetCustomerName(inf15Item.inf1501_ccode);
                        }
                        else
                        {
                            inf15Item.inf1501_bcode = "Unknow";
                            inf15Item.status = "Unknow";
                        }
                    }

                    if (String.Equals("inf1502_app", fieldName[j]))
                    {
                        inf15Item.inf1502_app = GetAppName(inf15Item.inf1502_app);
                    }

                    if (String.Equals("inf1502_close_type", fieldName[j]))
                    {
                        if (inf15Item.inf1502_close_type == "1")
                        {
                            inf15Item.inf1502_close_type = "月末結帳";
                        }
                        else if (inf15Item.inf1502_close_type == "2")
                        {
                            inf15Item.inf1502_close_type = "月中結帳";
                        }
                        else
                        {
                            inf15Item.inf1502_close_type = "Unknow";
                        }
                    }

                    if (String.Equals("inf1507_sal_flag1", fieldName[j]))
                    {
                        if (inf15Item.inf1507_sal_flag1 == "1")
                        {
                            inf15Item.inf1507_sal_flag1 = "可";
                        }
                        else if (inf15Item.inf1502_close_type == "2")
                        {
                            inf15Item.inf1507_sal_flag1 = "不可";
                        }
                        else
                        {
                            inf15Item.inf1507_sal_flag1 = "Unknow";
                        }
                    }

                    if (String.Equals("inf1508_inv_flag2", fieldName[j]))
                    {
                        if (inf15Item.inf1508_inv_flag2 == "1")
                        {
                            inf15Item.inf1508_inv_flag2 = "電腦盤點";
                        }
                        else if (inf15Item.inf1508_inv_flag2 == "2")
                        {
                            inf15Item.inf1508_inv_flag2 = "人工盤點";
                        }
                        else if (inf15Item.inf1508_inv_flag2 == "3")
                        {
                            inf15Item.inf1508_inv_flag2 = "人工加電腦盤點";
                        }
                        else
                        {
                            inf15Item.inf1508_inv_flag2 = "Unknow";
                        }
                    }

                    if (String.Equals("inf1510_clo_flag4", fieldName[j]))
                    {
                        if (inf15Item.inf1510_clo_flag4 == "0")
                        {
                            inf15Item.inf1510_clo_flag4 = "未關帳";
                        }
                        else if (inf15Item.inf1510_clo_flag4 == "1")
                        {
                            inf15Item.inf1510_clo_flag4 = "關帳";
                        }
                        else if (inf15Item.inf1510_clo_flag4 == "2")
                        {
                            inf15Item.inf1510_clo_flag4 = "完全關帳";
                        }
                        else
                        {
                            inf15Item.inf1510_clo_flag4 = "Unknow";
                        }

                    }

                    if (String.Equals("inf1511_trx_flag5", fieldName[j]))
                    {
                        if (inf15Item.inf1511_trx_flag5 == "1")
                        {
                            inf15Item.inf1511_trx_flag5 = "是";
                        }
                        else if (inf15Item.inf1511_trx_flag5 == "2")
                        {
                            inf15Item.inf1511_trx_flag5 = "否";
                        }
                        else
                        {
                            inf15Item.inf1511_trx_flag5 = "Unknow";
                        }
                    }
                    sheet.Cells[i + 1 + title, j + 1].Value = Inf15.GetPropValue(inf15Item, fieldName[j]);

                    if (sheet.Cells[i + 1 + title, j + 1].Value is DateTime)
                    {
                        if (String.Equals("inf1502_pmonth", fieldName[j]))
                        {
                            sheet.Cells[i + 1 + title, j + 1].Style.Numberformat.Format = "yyyy/MM";
                        }
                        else
                        {
                            sheet.Cells[i + 1 + title, j + 1].Style.Numberformat.Format = "yyyy/MM/dd";
                        }
                    }
                }
            }

            FitExcelColumnWidth(sheet);
            return excel;
        }

        private static void FitExcelColumnWidth(ExcelWorksheet sheet)
        {
            for (int k = 1; k <= sheet.Dimension.End.Column; k++)
            {
                // Get all column's cells
                ExcelRange columnCells = sheet.Cells[sheet.Dimension.Start.Row, k, sheet.Dimension.End.Row, k];

                int maxLength = 0;

                // Check what is the longest string and set the length
                foreach (var columnCell in columnCells)
                {
                    if (columnCell.Value != null)
                    {
                        if (columnCell.Value.ToString().Contains("\n"))
                        {
                            var tmpArray = columnCell.Value.ToString()
                                                        .Split(new string[] { "\n" }, StringSplitOptions.RemoveEmptyEntries);

                            foreach (var tmp in tmpArray)
                            {
                                if (maxLength < tmp.Length)
                                {
                                    maxLength = tmp.Length;
                                }
                            }
                        }
                        else
                        {
                            if (maxLength <
                                columnCell.Value.ToString().Replace("\n", "").Count(c => char.IsLetterOrDigit(c)))
                            {
                                maxLength =
                                    columnCell.Value.ToString().Replace("\n", "").Count(c => char.IsLetterOrDigit(c));
                            }
                        }
                    }
                }

                sheet.Column(k).Width = (maxLength + 2) * 1.2;
                // 2 is just an extra buffer for all that is not letter/digits.
            }

        }

        //public static List<Inf15> ParseFromExcelNpoi(Stream stream, int excelVersion, string user)
        //{
        //    List<Inf15> inf15List = new List<Inf15>();
        //    IWorkbook workbook = (excelVersion == 2003 ? (IWorkbook)new HSSFWorkbook(stream) : new XSSFWorkbook(stream));
        //    ISheet sheet = workbook.GetSheetAt(0);

        //    int startRowNumber = 1; // skip title
        //    int endRowNumber = sheet.LastRowNum;

        //    for (int i = startRowNumber; i <= endRowNumber; i++)
        //    {
        //        IRow excelRow = sheet.GetRow(i);
        //        int startColumn = 0;
        //        int endColumn = excelRow.LastCellNum;
        //        Inf15 inf15 = new Inf15();
        //        for (int j = startColumn; j <= endColumn; j++)
        //        {
        //            ICell excelCell = excelRow.GetCell(j);
        //            var data = excelCell == null ? null : excelCell.ToString();
        //            if (j == 1)
        //            {
        //                inf15.status = data;
        //            }
        //            else if (j == 2)
        //            {
        //                inf15.inf1501_bcode = data;
        //            }
        //            else if (j == 3)
        //            {
        //                inf15.inf1502_app = data;
        //            }
        //            else if (j == 4)
        //            {
        //                inf15.inf1502_pmonth = data;
        //            }
        //            else if (j == 5)
        //            {
        //                inf15.inf1502_close_type = data;
        //            }
        //            else if (j == 6)
        //            {
        //                inf15.inf1502_seq = data;
        //            }
        //            else if (j == 7)
        //            {
        //                inf15.inf1503_beg_date = data;
        //            }
        //            else if (j == 8)
        //            {
        //                inf15.inf1504_end_date = data;
        //            }
        //            else if (j == 9)
        //            {
        //                inf15.inf1505_this_date = data;
        //            }
        //            else if (j == 10)
        //            {
        //                inf15.inf1506_last_date = data;
        //            }
        //            else if (j == 11)
        //            {
        //                inf15.inf1507_sal_flag1 = data;
        //            }
        //            else if (j == 12)
        //            {
        //                inf15.inf1508_inv_flag2 = data;
        //            }
        //            else if (j == 13)
        //            {
        //                inf15.inf1509_pas_flag3 = data;
        //            }
        //            else if (j == 14)
        //            {
        //                inf15.inf1510_clo_flag4 = data;
        //            }
        //            else if (j == 15)
        //            {
        //                inf15.inf1511_trx_flag5 = data;
        //            }
        //            else if (j == 16)
        //            {
        //                inf15.inf1511_rev_flag6 = data;
        //            }
        //            else if (j == 17)
        //            {
        //                inf15.inf1512_inv_date = data;
        //            }
        //            else if (j == 18)
        //            {
        //                inf15.remark = data;
        //            }
        //        }
        //        inf15.adddate = Convert.ToDateTime(DateTime.Now.ToString("yyyy-MM-dd"));
        //        inf15.adduser = user;
        //        inf15List.Add(inf15);
        //    }
        //    return inf15List;
        //}


        //public static IWorkbook ExportNpoi(string[] fieldName, List<Inf15> inf15List, int excelVersion)
        //{
        //    IWorkbook workbook = null;
        //    if (excelVersion == 2003)
        //    {
        //        workbook = new HSSFWorkbook();
        //    }
        //    else
        //    {
        //        workbook = new XSSFWorkbook();
        //    }
        //    ISheet sheet = workbook.CreateSheet("Sheet1");

        //    IRow headRow = sheet.CreateRow(0);
        //    for (var i = 0; i < fieldName.Length; i++)
        //    {
        //        if (String.Equals("cnf0501_file", fieldName[i]))
        //        {
        //            headRow.CreateCell(i).SetCellValue("檔案代號");
        //        }
        //        else if (String.Equals("cnf0502_field", fieldName[i]))
        //        {
        //            headRow.CreateCell(i).SetCellValue("欄位名稱");
        //        }
        //        else if (String.Equals("cnf0503_fieldname_tw", fieldName[i]))
        //        {
        //            headRow.CreateCell(i).SetCellValue("中文說明-繁體");
        //        }
        //        else if (String.Equals("cnf0506_program", fieldName[i]))
        //        {
        //            headRow.CreateCell(i).SetCellValue("程式代號");
        //        }
        //        else if (String.Equals("adddate", fieldName[i]))
        //        {
        //            headRow.CreateCell(i).SetCellValue("新增日期");
        //        }
        //        else if (String.Equals("adduser", fieldName[i]))
        //        {
        //            headRow.CreateCell(i).SetCellValue("新增者");
        //        }
        //        else if (String.Equals("moddate", fieldName[i]))
        //        {
        //            headRow.CreateCell(i).SetCellValue("修改日期");
        //        }
        //        else if (String.Equals("moduser", fieldName[i]))
        //        {
        //            headRow.CreateCell(i).SetCellValue("修改者");
        //        }
        //        else if (String.Equals("cnf0504_fieldname_cn", fieldName[i]))
        //        {
        //            headRow.CreateCell(i).SetCellValue("中文說明-簡體");
        //        }
        //        else if (String.Equals("cnf0505_fieldname_en", fieldName[i]))
        //        {
        //            headRow.CreateCell(i).SetCellValue("英文說明");
        //        }
        //    }
        //    for (int i = 0; i < inf15List.Count; i++)
        //    {
        //        IRow excelRow = sheet.CreateRow(i + 1);
        //        Inf15 inf15Item = inf15List[i];
        //        for (var j = 0; j < fieldName.Length; j++)
        //        {
        //            var val = Inf15.GetPropValue(inf15Item, fieldName[j]);
        //            var excelCell = excelRow.CreateCell(j);
        //            excelCell.SetCellValue(val != null ? val.ToString() : "");
        //            if (val is DateTime)
        //            {
        //                excelCell.SetCellValue(((DateTime)val).ToString("yyyy/MM/dd"));
        //            }
        //        }
        //    }

        //    for (var i = 0; i < fieldName.Length; i++)
        //    {
        //        sheet.AutoSizeColumn(i);
        //    }
        //    return workbook;
        //}
    }
}