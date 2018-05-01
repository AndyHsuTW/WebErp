<%@ WebHandler Language="C#" Class="Inf20Export" %>

using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.IO;
using System.Web;
using System.Web.SessionState;
using Dinp02301;
using DCNP005;
using ErpBaseLibrary.DB;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using NPOI.XSSF.UserModel;


public class Inf20Export : IHttpHandler, IRequiresSessionState
{

    public void ProcessRequest(HttpContext context)
    {
        Cnf05[] inf20FieldList = context.Session["in20ExportFields"] as Cnf05[];
        Cnf05[] inf20aFieldList = context.Session["in20aExportFields"] as Cnf05[];

        List<int> inf20IdList = context.Session["exportItems"] as List<int>;
        int excelVersion = (int)context.Session["exportExcelVersion"];

        context.Session.Remove("in20ExportFields");
        context.Session.Remove("in20aExportFields");
        context.Session.Remove("exportItems");
        context.Session.Remove("exportExcelVersion");

        if (inf20IdList == null)
        {
            throw new Exception("Export file failed.");
        }

        var inf20rows = GetExportItems(inf20FieldList, inf20aFieldList, inf20IdList);
        //        var inf20aList = Inf20a.GetExportItems(inf20aFieldList, inf20IdList);

        var excel = ExportExcelNpoi(inf20FieldList, inf20aFieldList, inf20rows, excelVersion);
        //        excel = Inf20a.ExportExcelNpoi(inf20aFieldList, inf20aList, excelVersion, excel);

        byte[] excelBinary = null;
        using (MemoryStream ms = new MemoryStream())
        {
            excel.Write(ms);
            excelBinary = ms.ToArray();
        }

        var fileNameFull = String.Format("Export_{0}.{1}", DateTime.Now.ToString("yyyyMMdd"),
                                         excelVersion == 2003 ? "xls" : "xlsx");

        var strContentDisposition = String.Format("{0}; filename=\"{1}\"", "attachment",
                                 HttpUtility.UrlEncode(fileNameFull, System.Text.Encoding.UTF8));

        context.Response.AppendHeader("Content-Disposition", strContentDisposition); // 檔案名稱
        context.Response.AppendHeader("Content-Length", excelBinary.Length.ToString());
        context.Response.BinaryWrite(excelBinary);
    }

    public static IWorkbook ExportExcelNpoi(Cnf05[] inf20FieldInfoList, Cnf05[] inf20aFieldInfoList,List<ExportItemRow> inf20Rows, int excelVersion)
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
        
        var sheet = workbook.CreateSheet("Sheet1");
        var headRowIndex = 0;
        var headRow = sheet.CreateRow(headRowIndex++);
        var headRow2 = sheet.CreateRow(headRowIndex++);
        //Inf20 head
        for (var i = 0; i < inf20FieldInfoList.Length; i++)
        {
            var row1Cell = headRow.CreateCell(i);
            row1Cell.CellStyle = cellStyle;
            row1Cell.SetCellValue(inf20FieldInfoList[i].cnf0503_fieldname_tw);
            var row2Cell = headRow2.CreateCell(i);
            row2Cell.CellStyle = cellStyle;
            row2Cell.SetCellValue(inf20FieldInfoList[i].cnf0502_field);
        }
        //Inf20a head
        for (var i = 0; i < inf20aFieldInfoList.Length; i++)
        {
            var row1Cell = headRow.CreateCell(i + inf20FieldInfoList.Length);
            row1Cell.CellStyle = cellStyle;
            row1Cell.SetCellValue(inf20aFieldInfoList[i].cnf0503_fieldname_tw);
            var row2Cell = headRow2.CreateCell(i + inf20FieldInfoList.Length);
            row2Cell.CellStyle = cellStyle;
            row2Cell.SetCellValue(inf20aFieldInfoList[i].cnf0502_field);
        }
        var lastInf20Id = "";
        var isSameInf20 = false;
        for (var i = 0; i < inf20Rows.Count; i++)
        {
            var excelRow = sheet.CreateRow(i + headRowIndex);
            var inf20row = inf20Rows[i];
            var currentInf20id = inf20row.GetInf20Id();

            isSameInf20 = lastInf20Id == currentInf20id;
            if (!isSameInf20)
            {
                lastInf20Id = currentInf20id;
            }
            //inf20
            for (var j = 0; j < inf20FieldInfoList.Length; j++)
            {
                var excelCell = excelRow.CreateCell(j);
                excelCell.CellStyle = cellStyle;
                // not to write same row data for inf20, but only draw border
                if (!isSameInf20)
                {
                    var val = inf20row["inf20_" + inf20FieldInfoList[j].cnf0502_field];
                    excelCell.SetCellValue(val != null ? val.ToString() : "");
                    if (val is DateTime)
                    {
                        excelCell.SetCellValue(((DateTime)val).ToString("yyyy/MM/dd"));
                    }
                }
            }
            //inf20a
            for (var j = 0; j < inf20aFieldInfoList.Length; j++)
            {
                var val = inf20row["inf20a_" + inf20aFieldInfoList[j].cnf0502_field];
                var excelCell = excelRow.CreateCell(j + inf20FieldInfoList.Length);
                excelCell.CellStyle = cellStyle;
                excelCell.SetCellValue(val != null ? val.ToString() : "");
                if (val is DateTime)
                {
                    excelCell.SetCellValue(((DateTime)val).ToString("yyyy/MM/dd"));
                }
            }
        }

        for (var i = 0; i < inf20FieldInfoList.Length + inf20aFieldInfoList.Length; i++)
        {
            sheet.AutoSizeColumn(i);
        }
        return workbook;
    }

    public static List<ExportItemRow> GetExportItems(Cnf05[] inf20FieldInfoList, Cnf05[] inf20aFieldInfoList,List<int> inf20IdList)
    {
        var inf20Rows = new List<ExportItemRow>();
        if (inf20IdList == null || inf20IdList.Count == 0)
        {
            return inf20Rows;
        }
        var inf20FieldNamesSql = String.Join(", ",
            inf20FieldInfoList.Select(
                o => "inf20." + o.cnf0502_field + " as Inf20_" + o.cnf0502_field));
        var inf20aFieldNamesSql = inf20aFieldInfoList.Length > 0
            ? "," +
              String.Join(", ",
                  inf20aFieldInfoList.Select(o => "inf20a." + o.cnf0502_field + " as Inf20a_" + o.cnf0502_field))
            : "";
        var idListSql = String.Join("','", inf20IdList);

        using (var conn = new SqlConnection(MyConnStringList.AzureGoodeasy))
        {
            conn.Open();
            var cmd = conn.CreateCommand();
            cmd.CommandText = String.Format(@"
        SELECT inf20.id as ExportKey
        ,{0}
        {1}
          FROM [dbo].[inf20] inf20
          LEFT JOIN [inf20a] inf20a
          ON inf20.inf2001_docno = inf20a.inf20a01_docno
        WHERE inf20.id IN('{2}') ", inf20FieldNamesSql, inf20aFieldNamesSql, idListSql);

            using (var rd =cmd.ExecuteReader())
            {
                if (rd.HasRows)
                {
                    while (rd.Read())
                    {
                        var inf20Row = new ExportItemRow(Convert.ToString(rd["ExportKey"]));
                        foreach (var fieldInfo in inf20FieldInfoList)
                        {
                            var data = rd["inf20_" + fieldInfo.cnf0502_field];
                            inf20Row.Add("inf20_" + fieldInfo.cnf0502_field, data);
                        }
                        foreach (var fieldInfo in inf20aFieldInfoList)
                        {
                            var data = rd["inf20a_" + fieldInfo.cnf0502_field];
                            inf20Row.Add("inf20a_" + fieldInfo.cnf0502_field, data);
                        }
                        inf20Rows.Add(inf20Row);
                    }
                }

            }
            
            

        }

        return inf20Rows;
    }
    public class ExportItemRow : Dictionary<string, object>
    {
        public ExportItemRow(string inf20Id)
        {
            this.Add("ExportRowMasterId", inf20Id);
        }

        public string GetInf20Id()
        {
            return this["ExportRowMasterId"] as string;
        }
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}