using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DCNP005;
using ErpBaseLibrary.DB;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using NPOI.XSSF.UserModel;

namespace Dinp02301
{
    /// <summary>
    /// 各類單據異動主檔
    /// </summary>
    public class Inf29
    {
        #region properties from database

        public int id { get; set; }


        public string inf2901_docno { get; set; }

        public string inf2901_bcode { get; set; }

        public string inf2902_docno_type { get; set; }

        public DateTime inf2902_docno_date { get; set; }

        public int inf2902_docno_seq { get; set; }

        public string inf2903_customer_code { get; set; }

        public DateTime inf2904_pro_date { get; set; }

        public string inf2906_ref_no_type { get; set; }

        public DateTime? inf2906_ref_no_date { get; set; }

        public int inf2906_ref_no_seq { get; set; }

        public string inf2906_wherehouse { get; set; }

        public string inf2910_in_reason { get; set; }

        public string inf2914_inv_eff { get; set; }

        public string inf2916_apr_empid { get; set; }
        
        public string inf2952_project_no { get; set; }

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
        /// Get value by property name
        /// </summary>
        /// <param name="src"></param>
        /// <param name="propName"></param>
        /// <returns></returns>
        public static void SetPropValue(object src, string propName, object value)
        {
            src.GetType().GetProperty(propName).SetValue(src, value);
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
                return inf2906_ref_no_type + inf2906_ref_no_date.Value.ToString("yyyyMMdd") +
                       inf2906_ref_no_seq.ToString("0000");
            }
        }

        public string Inf2910InReasonName { get; set; }

        public string Inf2903CustomerCodeName { get; set; }

        public class FilterOption
        {
            public string keyword { get; set; }

        }

        public static List<Inf29> Search(FilterOption filterOption)
        {
            List<Inf29> inf29List = new List<Inf29>();

            using (var conn = new SqlConnection { ConnectionString = MyConnStringList.AzureGoodeasy })
            using (var sqlCmd = conn.CreateCommand())
            {
                conn.Open();
                var keywordFilter = "";

                if (filterOption != null)
                {
                   
                }
                sqlCmd.CommandText = String.Format(@"
        SELECT inf29.[id]
              ,inf29.[inf2901_docno]
              ,inf29.[inf2902_docno_type]
              ,inf29.[inf2902_docno_date]
              ,inf29.[inf2902_docno_seq]
              ,inf29.[inf2903_customer_code]
        ,cnf10.cnf1004_char02-- For inf2903_customer_code data source
        ,  (
            CASE WHEN cnf10.cnf1004_char02='cmf01' THEN
                (
                    SELECT TOP 1 cmf0103_bname
                    FROM cmf01
                    WHERE cmf0102_cuscode = inf29.inf2903_customer_code
                )
            ELSE
                'NotFound'
			END
            ) AS Inf2903CustomerCodeName
              ,inf29.[inf2904_pro_date]
              ,inf29.[inf2906_wherehouse]
              ,inf29.[inf2906_ref_no_type]
              ,inf29.[inf2906_ref_no_date]
              ,inf29.[inf2906_ref_no_seq]
              ,inf29.[inf2910_in_reason]
        ,cnf10.[cnf1003_char01] as Inf2910InReasonName
              ,inf29.[inf2952_project_no]
              ,(
				  SELECT SUM([inf29a13_sold_qty]) FROM [inf29a]
				  WHERE inf29a.inf29a01_docno = inf29.inf2901_docno
			  ) AS QTY
              ,inf29.[remark]
              ,inf29.[adduser]
              ,inf29.[adddate]
              ,inf29.[moduser]
              ,inf29.[moddate]
          FROM [dbo].[inf29] inf29
        LEFT JOIN [cnf10] cnf10
            ON cnf10.cnf1002_fileorder = inf29.inf2910_in_reason AND cnf10.cnf1001_filetype='S15'
");

                using (var sqlReader = sqlCmd.ExecuteReader())
                {
                    if (sqlReader.HasRows)
                    {
                        while (sqlReader.Read())
                        {
                            Inf29 inf29 = new Inf29();
                            inf29.id = Convert.ToInt32(sqlReader["id"]);
                            inf29.inf2901_docno = Convert.ToString(sqlReader["inf2901_docno"]);
                            inf29.inf2902_docno_type = Convert.ToString(sqlReader["inf2902_docno_type"]);
                            inf29.inf2902_docno_date = Convert.ToDateTime(sqlReader["inf2902_docno_date"]);
                            inf29.inf2902_docno_seq = Convert.ToInt32(sqlReader["inf2902_docno_seq"]);
                            inf29.inf2903_customer_code = Convert.ToString(sqlReader["inf2903_customer_code"]);
                            inf29.inf2904_pro_date = Convert.ToDateTime(sqlReader["inf2904_pro_date"]);
                            inf29.inf2906_wherehouse = Convert.ToString(sqlReader["inf2906_wherehouse"]);
                            inf29.inf2906_ref_no_type = Convert.ToString(sqlReader["inf2906_ref_no_type"]);
                            inf29.inf2906_ref_no_date = DBNull.Value == sqlReader["inf2906_ref_no_date"]
                                                            ? (DateTime?) null
                                                            : Convert.ToDateTime(sqlReader["inf2906_ref_no_date"]);
                            inf29.inf2906_ref_no_seq = Convert.ToInt32(sqlReader["inf2906_ref_no_seq"]);
                            inf29.inf2910_in_reason = Convert.ToString(sqlReader["inf2910_in_reason"]);
                            inf29.inf2952_project_no = Convert.ToString(sqlReader["inf2952_project_no"]);
                            inf29.adduser = Convert.ToString(sqlReader["adduser"]);
                            inf29.adddate = DBNull.Value == sqlReader["adddate"]
                                                ? (DateTime?)null
                                                : Convert.ToDateTime(sqlReader["adddate"]);
                            inf29.moduser = Convert.ToString(sqlReader["moduser"]);
                            inf29.moddate = DBNull.Value == sqlReader["moddate"]
                                                ? (DateTime?)null
                                                : Convert.ToDateTime(sqlReader["moddate"]);
                            //TODO
                            inf29.Inf2910InReasonName = Convert.ToString(sqlReader["Inf2910InReasonName"]);
                            inf29.Inf2903CustomerCodeName = Convert.ToString(sqlReader["Inf2903CustomerCodeName"]);
                            inf29.Qty = DBNull.Value == sqlReader["Qty"]
                                                ? 0
                                                : Convert.ToDouble(sqlReader["Qty"]);

                            inf29List.Add(inf29);
                        }
                    }
                }
            }
            return inf29List;
        }

        public static List<Dictionary<string,object>> GetExportItems(Cnf05[] fieldInfoList, List<int> inf29IdList)
        {
            List<Dictionary<string, object>> inf29List = new List<Dictionary<string, object>>();

            if (fieldInfoList == null || fieldInfoList.Length == 0)
            {
                throw new ArgumentNullException("fieldInfoList");
            }
            string fieldNamesSql = String.Join(", ", fieldInfoList.Select(o => o.cnf0502_field));
            string idListSql = String.Join("','", inf29IdList);

            using (var conn = new SqlConnection { ConnectionString = MyConnStringList.AzureGoodeasy })
            using (var sqlCmd = conn.CreateCommand())
            {
                conn.Open();

                sqlCmd.CommandText = String.Format(@"
        SELECT {0}
          FROM [dbo].[inf29] 
        WHERE id IN('{1}') ", fieldNamesSql, idListSql);

                using (var sqlReader = sqlCmd.ExecuteReader())
                {
                    if (sqlReader.HasRows)
                    {
                        while (sqlReader.Read())
                        {
                            Dictionary<string, object> inf29 = new Dictionary<string, object>();

                            foreach (var fieldInfo in fieldInfoList)
                            {
                                var data = sqlReader[fieldInfo.cnf0502_field];
                                inf29.Add(fieldInfo.cnf0502_field,data);
                            }
                            inf29List.Add(inf29);
                        }
                    }
                }
            }
            return inf29List;
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
            
            var lastDocSeq = GetLastDocnoSeq(inf29.inf2902_docno_type, inf29.inf2902_docno_date);
            inf29.inf2902_docno_seq = ++lastDocSeq;

            inf29.inf2901_docno = inf29.inf2901_bcode + inf29.inf2902_docno_type +
                                  inf29.inf2902_docno_date.ToString("yyyyMMdd") +
                                  inf29.inf2902_docno_seq.ToString("0000");

            using (var conn = new SqlConnection { ConnectionString = MyConnStringList.AzureGoodeasy })
            using (var sqlCmd = conn.CreateCommand())
            {
                conn.Open();
                sqlCmd.CommandText = @"
    INSERT INTO [dbo].[inf29]
               ([inf2901_docno]
               ,[inf2901_bcode]
               ,[inf2902_docno_type]
               ,[inf2902_docno_date]
               ,[inf2902_docno_seq]
               ,[inf2903_customer_code]
               ,[inf2904_pro_date]
               ,[inf2906_wherehouse]
               ,[inf2906_ref_no_type]
               ,[inf2906_ref_no_date]
               ,[inf2906_ref_no_seq]
               ,[inf2910_in_reason]
               ,[inf2911_sub_amt]
               ,[inf2914_inv_eff]
               ,[inf2916_apr_empid]
               ,[inf2952_project_no]
               ,[remark]
               ,[adduser]
               ,[adddate])
    OUTPUT INSERTED.ID
         VALUES
               (@inf2901_docno
               ,@inf2901_bcode
               ,@inf2902_docno_type
               ,@inf2902_docno_date
               ,@inf2902_docno_seq
               ,@inf2903_customer_code
               ,@inf2904_pro_date
               ,@inf2906_wherehouse
               ,@inf2906_ref_no_type
               ,@inf2906_ref_no_date
               ,@inf2906_ref_no_seq
               ,@inf2910_in_reason
               ,@inf2911_sub_amt
               ,@inf2914_inv_eff
               ,@inf2916_apr_empid
               ,@inf2952_project_no
               ,@remark
               ,@adduser
               ,@adddate    ) ";

                sqlCmd.Parameters.AddWithValue("@inf2901_docno", inf29.inf2901_docno);
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
                sqlCmd.Parameters.AddWithValueSafe("@inf2911_sub_amt", inf29.Inf29aList.Sum(o=>o.inf29a38_one_amt));
                sqlCmd.Parameters.AddWithValueSafe("@inf2914_inv_eff", inf29.inf2914_inv_eff);
                sqlCmd.Parameters.AddWithValueSafe("@inf2916_apr_empid", inf29.inf2916_apr_empid);
                sqlCmd.Parameters.AddWithValueSafe("@inf2952_project_no", inf29.inf2952_project_no);
                sqlCmd.Parameters.AddWithValueSafe("@remark", inf29.remark);
                sqlCmd.Parameters.AddWithValue("@adduser", inf29.adduser);
                sqlCmd.Parameters.AddWithValue("@adddate", inf29.adddate);

                int id = (int)sqlCmd.ExecuteScalar();
                inf29.id = id;
            }

            return inf29;
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
        DELETE FROM inf29
        WHERE inf2901_docno = @docno
";
                sqlCmd.Parameters.AddWithValue("@docno", docno);

                int count = sqlCmd.ExecuteNonQuery();
                return count > 0;
            }
        }


        public static List<Inf29> ParseFromExcelNpoi(Stream stream, int excelVersion, string user)
        {
            List<Inf29> cnf05List = new List<Inf29>();
            IWorkbook workbook = (excelVersion == 2003 ? (IWorkbook)new HSSFWorkbook(stream) : new XSSFWorkbook(stream));
            ISheet sheet = workbook.GetSheetAt(0);

            int startRowNumber = 1; // skip title
            int endRowNumber = sheet.LastRowNum;

            for (int i = startRowNumber; i <= endRowNumber; i++)
            {
                IRow excelRow = sheet.GetRow(i);
                int startColumn = 0;
                int endColumn = excelRow.LastCellNum;
                Inf29 cnf05 = new Inf29();
                
            }
            return cnf05List;
        }


        public static IWorkbook ExportExcelNpoi(Cnf05[] fieldInfoList, List<Dictionary<string,object>> inf29List, int excelVersion)
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
            ISheet sheet = workbook.CreateSheet("Inf29");
            int headRowIndex = 0;
            IRow headRow = sheet.CreateRow(headRowIndex++);
            for (var i = 0; i < fieldInfoList.Length; i++)
            {
                headRow.CreateCell(i).SetCellValue(fieldInfoList[i].cnf0503_fieldname_tw);
            }
            IRow headRow2 = sheet.CreateRow(headRowIndex++);
            for (var i = 0; i < fieldInfoList.Length; i++)
            {
                headRow2.CreateCell(i).SetCellValue(fieldInfoList[i].cnf0502_field);
            }
            for (int i = 0; i < inf29List.Count; i++)
            {
                IRow excelRow = sheet.CreateRow(i + headRowIndex);
                Dictionary<string,object> inf29Item = inf29List[i];
                for (var j = 0; j < fieldInfoList.Length; j++)
                {
                    var val = inf29Item[fieldInfoList[j].cnf0502_field];
                    var excelCell = excelRow.CreateCell(j);
                    excelCell.SetCellValue(val != null ? val.ToString() : "");
                    if (val is DateTime)
                    {
                        excelCell.SetCellValue(((DateTime)val).ToString("yyyy/MM/dd"));
                    }
                }
            }

            for (var i = 0; i < fieldInfoList.Length; i++)
            {
                sheet.AutoSizeColumn(i);
            }
            return workbook;
        }

    }
}
