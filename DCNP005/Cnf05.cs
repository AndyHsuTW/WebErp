using System;
using System.Collections.Generic;
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

namespace DCNP005
{
    public class Cnf05
    {
        #region properties

        public int id { get; set; }

        public string status { get; set; }

        public string cnf0501_file { get; set; }

        public string cnf0502_field { get; set; }

        public string cnf0503_fieldname_tw { get; set; }

        public string cnf0504_fieldname_cn { get; set; }

        public string cnf0505_fieldname_en { get; set; }

        public string cnf0506_program { get; set; }

        public string remark { get; set; }

        public string adduser { get; set; }

        public DateTime? adddate { get; set; }

        public string moduser { get; set; }

        public DateTime? moddate { get; set; }

        #endregion

        public static object GetPropValue(object src, string propName)
        {
            return src.GetType().GetProperty(propName).GetValue(src, null);
        }

        public class FilterOption
        {
            public string keyword { get; set; }
            public string cnf0501_file_start { get; set; }
            public string cnf0501_file_end { get; set; }
            public string cnf0506_program_start { get; set; }
            public string cnf0506_program_end { get; set; }
            public string cnf0502_field_start { get; set; }
            public string cnf0502_field_end { get; set; }
            public DateTime? adddate_start { get; set; }
            public DateTime? adddate_end { get; set; }
        }

        public static Cnf05 AddItem(Cnf05 cnf05)
        {
            if (cnf05 == null)
            {
                throw new ArgumentNullException("cnf05");
            }
            if (String.IsNullOrEmpty(cnf05.cnf0501_file))
            {
                throw new Exception("檔案代號不可以是空白");
            }
            if (String.IsNullOrEmpty(cnf05.cnf0502_field))
            {
                throw new Exception("欄位名稱不可以是空白");
            }
            if (String.IsNullOrEmpty(cnf05.cnf0503_fieldname_tw))
            {
                throw new Exception("中文說明不可以是空白");
            }
            using (var conn = new SqlConnection {ConnectionString = MyConnStringList.AzureGoodeasy})
            using (var sqlCmd = conn.CreateCommand())
            {
                conn.Open();
                sqlCmd.CommandText = @"
    INSERT INTO [dbo].[cnf05]
           ([cnf0501_file]
           ,[cnf0502_field]
           ,[cnf0503_fieldname_tw]
           ,[cnf0504_fieldname_cn]
           ,[cnf0505_fieldname_en]
           ,[cnf0506_program]
           ,[remark]
           ,[adduser]
           ,[adddate])
    OUTPUT INSERTED.ID
     VALUES
           (@cnf0501_file
           ,@cnf0502_field
           ,@cnf0503_fieldname_tw
           ,@cnf0504_fieldname_cn
           ,@cnf0505_fieldname_en
           ,@cnf0506_program
           ,@remark
           ,@adduser
           ,@adddate)
";
                sqlCmd.Parameters.AddWithValue("@cnf0501_file", cnf05.cnf0501_file);
                sqlCmd.Parameters.AddWithValue("@cnf0502_field", cnf05.cnf0502_field);
                sqlCmd.Parameters.AddWithValue("@cnf0503_fieldname_tw", cnf05.cnf0503_fieldname_tw);
                sqlCmd.Parameters.AddWithValue("@cnf0504_fieldname_cn", cnf05.cnf0504_fieldname_cn);
                sqlCmd.Parameters.AddWithValue("@cnf0505_fieldname_en", cnf05.cnf0505_fieldname_en);
                sqlCmd.Parameters.AddWithValue("@cnf0506_program", cnf05.cnf0506_program);
                sqlCmd.Parameters.AddWithValueSafe("@remark", cnf05.remark??"");
                sqlCmd.Parameters.AddWithValue("@adduser", cnf05.adduser);
                sqlCmd.Parameters.AddWithValueSafe("@adddate", cnf05.adddate);

                int id = (int)sqlCmd.ExecuteScalar();
                cnf05.id = id;
            }

            return cnf05;
        }

        public static Cnf05 UpdateItem(Cnf05 cnf05)
        {
            if (cnf05 == null)
            {
                throw new ArgumentNullException("cnf05");
            }
            using (var conn = new SqlConnection { ConnectionString = MyConnStringList.AzureGoodeasy })
            using (var sqlCmd = conn.CreateCommand())
            {
                conn.Open();
                sqlCmd.CommandText = @"
UPDATE [dbo].[cnf05]
   SET [cnf0501_file] = @cnf0501_file
      ,[cnf0502_field] = @cnf0502_field
      ,[cnf0503_fieldname_tw] = @cnf0503_fieldname_tw
      ,[cnf0504_fieldname_cn] = @cnf0504_fieldname_cn
      ,[cnf0505_fieldname_en] = @cnf0505_fieldname_en
      ,[cnf0506_program] = @cnf0506_program
      ,[remark] = @remark
      ,[adduser] = @adduser
      ,[adddate] = @adddate
      ,[moduser] = @moduser
      ,[moddate] = @moddate
 WHERE id=@id
";
                sqlCmd.Parameters.AddWithValue("@id", cnf05.id);
                sqlCmd.Parameters.AddWithValue("@cnf0501_file", cnf05.cnf0501_file);
                sqlCmd.Parameters.AddWithValue("@cnf0502_field", cnf05.cnf0502_field);
                sqlCmd.Parameters.AddWithValue("@cnf0503_fieldname_tw", cnf05.cnf0503_fieldname_tw);
                sqlCmd.Parameters.AddWithValue("@cnf0504_fieldname_cn", cnf05.cnf0504_fieldname_cn);
                sqlCmd.Parameters.AddWithValue("@cnf0505_fieldname_en", cnf05.cnf0505_fieldname_en);
                sqlCmd.Parameters.AddWithValue("@cnf0506_program", cnf05.cnf0506_program);
                sqlCmd.Parameters.AddWithValueSafe("@remark", cnf05.remark);
                sqlCmd.Parameters.AddWithValue("@adduser", cnf05.adduser);
                sqlCmd.Parameters.AddWithValueSafe("@adddate", cnf05.adddate);
                sqlCmd.Parameters.AddWithValue("@moduser", cnf05.moduser);
                sqlCmd.Parameters.AddWithValueSafe("@moddate", cnf05.moddate);

                var count = sqlCmd.ExecuteNonQuery();
                if (count < 1)
                {
                    return null;
                }
            }

            return cnf05;
        }

        public static List<Cnf05> BatchUpdateItem(List<Cnf05> cnf05List)
        {
            if (cnf05List == null || cnf05List.Count == 0)
            {
                throw new ArgumentNullException("cnf05List");
            }
            using (var conn = new SqlConnection { ConnectionString = MyConnStringList.AzureGoodeasy })
            using (var sqlCmd = conn.CreateCommand())
            {
                conn.Open();

                var count = 0;

                foreach (var cnf05 in cnf05List)
                {
                    sqlCmd.CommandText = @"
UPDATE [dbo].[cnf05]
   SET [cnf0506_program] = @cnf0506_program
      ,[moduser] = @moduser
      ,[moddate] = @moddate
 WHERE id=@id
";
                    sqlCmd.Parameters.Clear();
                    sqlCmd.Parameters.AddWithValue("@id", cnf05.id);
                    sqlCmd.Parameters.AddWithValue("@cnf0506_program", cnf05.cnf0506_program);
                    sqlCmd.Parameters.AddWithValue("@moduser", cnf05.moduser);
                    sqlCmd.Parameters.AddWithValueSafe("@moddate", cnf05.moddate);

                    count += sqlCmd.ExecuteNonQuery();
                }
                
                if (count < cnf05List.Count)
                {
                    return null;
                }
            }

            return cnf05List;
        }

        /// <summary>
        /// Return true if success.
        /// </summary>
        /// <param name="idList"></param>
        /// <returns></returns>
        public static bool DeleteItem(params int[] idList)
        {
            if (idList == null || idList.Length==0)
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
                sqlCmd.CommandText = String.Format(@"
    Delete from [dbo].[cnf05]
    WHERE id IN ({0})
", inClause);

                var count = sqlCmd.ExecuteNonQuery();
                
            }
            return true;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="file">[cnf0501_file]</param>
        /// <param name="field">[cnf0502_field]</param>
        /// <returns></returns>
        public static bool DeleteItemByUniqueColumns(string file, string field)
        {
            if (String.IsNullOrEmpty(file) || String.IsNullOrEmpty(field))
            {
                return false;
            }
            using (var conn = new SqlConnection { ConnectionString = MyConnStringList.AzureGoodeasy })
            using (var sqlCmd = conn.CreateCommand())
            {

                conn.Open();
                sqlCmd.CommandText = String.Format(@"
    Delete from [dbo].[cnf05]
    WHERE cnf0501_file = @cnf0501_file
    AND cnf0502_field = @cnf0502_field");
                sqlCmd.Parameters.AddWithValue("@cnf0501_file", file);
                sqlCmd.Parameters.AddWithValue("@cnf0502_field", field);

                var count = sqlCmd.ExecuteNonQuery();
                if (count == 0) return false;
            }
            return true;
        }

        public static List<Cnf05> Search(FilterOption filterOption)
        {
            List<Cnf05> cnf05List = new List<Cnf05>();

            using (var conn = new SqlConnection { ConnectionString = MyConnStringList.AzureGoodeasy })
            using (var sqlCmd = conn.CreateCommand())
            {
                conn.Open();
                var keywordFilter = "";
                var cnf0501FileFilter = "";
                var cnf0506ProgramFilter = "";
                var addDateFilter = "";

                if (filterOption != null)
                {
                    if (!String.IsNullOrEmpty(filterOption.keyword))
                    {
                        keywordFilter = String.Format(@" AND (
cnf0501_file like @Keyword 
OR cnf0502_field like @Keyword 
OR cnf0503_fieldname_tw like @Keyword 
OR cnf0504_fieldname_cn like @Keyword 
OR cnf0505_fieldname_en like @Keyword 
OR cnf0506_program like @Keyword 
OR remark like @Keyword 
OR adduser like @Keyword 
OR adddate like @Keyword 
OR moduser like @Keyword 
OR moddate like @Keyword 

)");
                        sqlCmd.Parameters.AddWithValue("@Keyword", "%" + filterOption.keyword + "%");
                    }
                    if (!String.IsNullOrEmpty(filterOption.cnf0501_file_start))
                    {
                        cnf0501FileFilter = String.Format(@" AND (
[cnf0501_file] >= @cnf0501FileStart 
AND [cnf0501_file] <= @cnf0501FileEnd 
)");
                        sqlCmd.Parameters.AddWithValue("@cnf0501FileStart", filterOption.cnf0501_file_start);
                        sqlCmd.Parameters.AddWithValue("@cnf0501FileEnd",
                                                       String.IsNullOrEmpty(filterOption.cnf0501_file_end)
                                                           ? filterOption.cnf0501_file_start
                                                           : filterOption.cnf0501_file_end);
                    }
                    if (!String.IsNullOrEmpty(filterOption.cnf0506_program_start))
                    {
                        cnf0506ProgramFilter = String.Format(@" AND (
[cnf0506_program] >= @cnf0506ProgramStart 
AND [cnf0506_program] <= @cnf0506ProgramEnd 
)");
                        sqlCmd.Parameters.AddWithValue("@cnf0506ProgramStart", filterOption.cnf0506_program_start);
                        sqlCmd.Parameters.AddWithValue("@cnf0506ProgramEnd",
                                                       String.IsNullOrEmpty(filterOption.cnf0506_program_end)
                                                           ? filterOption.cnf0506_program_start
                                                           : filterOption.cnf0506_program_end);
                    }
                    if (!String.IsNullOrEmpty(filterOption.cnf0502_field_start))
                    {
                        cnf0506ProgramFilter = String.Format(@" AND (
[cnf0502_field] >= @Cnf0502FieldStart 
AND [cnf0502_field] <= @Cnf0502FieldEnd 
)");
                        sqlCmd.Parameters.AddWithValue("@Cnf0502FieldStart", filterOption.cnf0502_field_start);
                        sqlCmd.Parameters.AddWithValue("@Cnf0502FieldEnd",
                                                       String.IsNullOrEmpty(filterOption.cnf0502_field_end)
                                                           ? filterOption.cnf0502_field_start
                                                           : filterOption.cnf0502_field_end);
                    }
                    if (filterOption.adddate_start!=null)
                    {
                        addDateFilter = String.Format(@" AND (
[adddate]>= @adddateStart 
AND [adddate] <= @adddateEnd 
)");
                        sqlCmd.Parameters.AddWithValue("@adddateStart", filterOption.adddate_start);
                        sqlCmd.Parameters.AddWithValue("@adddateEnd", filterOption.adddate_end ?? filterOption.adddate_start);
                    }
                }
                sqlCmd.CommandText = String.Format(@"
SELECT [id]
      ,[status]
      ,[cnf0501_file]
      ,[cnf0502_field]
      ,[cnf0503_fieldname_tw]
      ,[cnf0504_fieldname_cn]
      ,[cnf0505_fieldname_en]
      ,[cnf0506_program]
      ,[remark]
      ,[adduser]
      ,[adddate]
      ,[moduser]
      ,[moddate]
  FROM [dbo].[cnf05]
WHERE 1=1
{0}
{1}
{2}
{3}
 ", addDateFilter, cnf0501FileFilter, cnf0506ProgramFilter, keywordFilter);

                using (var sqlReader = sqlCmd.ExecuteReader())
                {
                    if (sqlReader.HasRows)
                    {
                        while (sqlReader.Read())
                        {
                            Cnf05 cnf05 = new Cnf05();
                            cnf05.id = Convert.ToInt32(sqlReader["id"]);
                            cnf05.status = Convert.ToString(sqlReader["status"]);
                            cnf05.cnf0501_file = Convert.ToString(sqlReader["cnf0501_file"]);
                            cnf05.cnf0502_field = Convert.ToString(sqlReader["cnf0502_field"]);
                            cnf05.cnf0503_fieldname_tw = Convert.ToString(sqlReader["cnf0503_fieldname_tw"]);
                            cnf05.cnf0504_fieldname_cn = Convert.ToString(sqlReader["cnf0504_fieldname_cn"]);
                            cnf05.cnf0505_fieldname_en = Convert.ToString(sqlReader["cnf0505_fieldname_en"]);
                            cnf05.cnf0506_program = Convert.ToString(sqlReader["cnf0506_program"]);
                            cnf05.remark = Convert.ToString(sqlReader["remark"]);
                            cnf05.adduser = Convert.ToString(sqlReader["adduser"]);
                            cnf05.adddate = Convert.ToDateTime(sqlReader["adddate"]);
                            cnf05.moduser = Convert.ToString(sqlReader["moduser"]);
                            cnf05.moddate = DBNull.Value == sqlReader["moddate"]
                                                ? (DateTime?) null
                                                : Convert.ToDateTime(sqlReader["moddate"]);

                            cnf05List.Add(cnf05);
                        }
                    }
                }
            }
            return cnf05List;
        }

        public static List<Cnf05> ParseFromExcel(Stream stream,string user)
        {
            List<Cnf05> cnf05List = new List<Cnf05>();

            using (ExcelPackage ep = new ExcelPackage(stream))
            {
                ExcelWorksheet sheet = ep.Workbook.Worksheets[1];
                int startRowNumber = sheet.Dimension.Start.Row + 1; // skip title
                int endRowNumber = sheet.Dimension.End.Row;
                int startColumn = sheet.Dimension.Start.Column; 
                int endColumn = sheet.Dimension.End.Column; 

                for (int i = startRowNumber; i <= endRowNumber; i++)
                {
                    Cnf05 cnf05 = new Cnf05();
                    for (int j = startColumn; j <= endColumn; j++)
                    {
                        var data = sheet.Cells[i, j].Text;
                        if (j == 1)
                        {
                            cnf05.cnf0501_file = data;
                        }
                        else if (j == 2)
                        {
                            cnf05.cnf0502_field = data;
                        }
                        else if (j == 3)
                        {
                            cnf05.cnf0503_fieldname_tw = data;
                        }
                        else if (j ==4)
                        {
                            cnf05.cnf0504_fieldname_cn = data;
                        }
                        else if (j == 5)
                        {
                            cnf05.cnf0505_fieldname_en = data;
                        }
                        else if (j == 6)
                        {
                            cnf05.cnf0506_program = data;
                        }
                        else if (j == 7)
                        {
                            cnf05.remark = data;
                        }
                    }
                    cnf05.adddate = Convert.ToDateTime(DateTime.Now.ToString("yyyy-MM-dd"));
                    cnf05.adduser = user;
                    cnf05List.Add(cnf05);
                }
            }
            return cnf05List;
        }

        public static ExcelPackage Export(string[] fieldName, List<Cnf05> cnf05List)
        {
            var excel = new ExcelPackage();
            var sheet = excel.Workbook.Worksheets.Add("Sheet1");
            var title = 1;

            for (var i = 0; i < fieldName.Length; i++)
            {
                if (String.Equals("cnf0501_file", fieldName[i]))
                {
                    sheet.Cells[title, i + 1].Value = "檔案代號";
                }
                else if (String.Equals("cnf0502_field", fieldName[i]))
                {
                    sheet.Cells[title, i + 1].Value = "欄位名稱";
                }
                else if (String.Equals("cnf0503_fieldname_tw", fieldName[i]))
                {
                    sheet.Cells[title, i + 1].Value = "中文說明-繁體";
                }
                else if (String.Equals("cnf0506_program", fieldName[i]))
                {
                    sheet.Cells[title, i + 1].Value = "程式代號";
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
                else if (String.Equals("cnf0504_fieldname_cn", fieldName[i]))
                {
                    sheet.Cells[title, i + 1].Value = "中文說明-簡體";
                }
                else if (String.Equals("cnf0505_fieldname_en", fieldName[i]))
                {
                    sheet.Cells[title, i + 1].Value = "英文說明";
                }
            }
            for (int i = 0; i < cnf05List.Count; i++)
            {
                Cnf05 cnf05Item = cnf05List[i];
                for (var j = 0; j < fieldName.Length; j++)
                {
                    sheet.Cells[i + 1 + title, j + 1].Value = Cnf05.GetPropValue(cnf05Item, fieldName[j]);
                    if (sheet.Cells[i + 1 + title, j + 1].Value is DateTime)
                    {
                        sheet.Cells[i + 1 + title, j + 1].Style.Numberformat.Format = "yyyy/MM/dd";
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

    }
}
