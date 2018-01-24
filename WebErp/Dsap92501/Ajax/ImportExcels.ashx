<%@ WebHandler Language="C#" Class="ImportExcels" %>

using System;
using System.Web;
using System.IO;
using OfficeOpenXml;
using OfficeOpenXml.Style;
public class ImportExcels : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        // context.Response.Write("Hello World");

        HttpFileCollection files = context.Request.Files;

        for (int i = 0; i < files.Count; i++)
        {
            HttpPostedFile file = files[i];

            var uploadsRoot = context.Server.MapPath("~/Dsap92501/uploads/");
            var uploadsPath = uploadsRoot + file.FileName;

            var convertRoot = context.Server.MapPath("~/Dsap92501/convert/");

            file.SaveAs(uploadsPath);
            var excelTextFormat = new ExcelTextFormat();
            bool firstRowIsHeader = false;
            excelTextFormat.Delimiter = ',';
            excelTextFormat.EOL = "\r";

            if (file.FileName.ToLower().IndexOf(".xlsx") > -1)
            {
                file.SaveAs(convertRoot + file.FileName);

            }
            else if (file.FileName.ToLower().IndexOf(".csv") > -1)
            {

                var csvFileInfo = new FileInfo(uploadsPath);
                var excelFileInfo = new FileInfo(convertRoot + file.FileName.Replace(".csv", ".xlsx"));
                using (ExcelPackage package = new ExcelPackage(excelFileInfo))
                {
                    ExcelWorksheet worksheet = package.Workbook.Worksheets.Add("sheet");
                    worksheet.Cells["A1"].LoadFromText(csvFileInfo, excelTextFormat, OfficeOpenXml.Table.TableStyles.Medium25, firstRowIsHeader);
                    package.Save();
                }
            }
            else if (file.FileName.ToLower().IndexOf(".xls") > -1)
            {
                var xlsFileInfo = new FileInfo(uploadsPath);
                var excelFileInfo = new FileInfo(convertRoot + file.FileName.Replace(".xls", ".xlsx"));
                using (ExcelPackage package = new ExcelPackage(excelFileInfo))
                {
                    ExcelWorksheet worksheet = package.Workbook.Worksheets.Add("sheet");
                    worksheet.Cells["A1"].LoadFromText(xlsFileInfo, excelTextFormat, OfficeOpenXml.Table.TableStyles.Medium25, firstRowIsHeader);
                    package.Save();
                }
            }

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