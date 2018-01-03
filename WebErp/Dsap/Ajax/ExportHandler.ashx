<%@ WebHandler Language="C#" Class="ExportHandler" %>

using System;
using System.Web;
using System.Collections.Generic;
using OfficeOpenXml;
using OfficeOpenXml.Style;
using ErpBaseLibrary.DB;
using System.Data.SqlClient;
using Newtonsoft.Json;
using System.Linq;
using System.IO;
using ICSharpCode.SharpZipLib.Zip;
using ICSharpCode.SharpZipLib.Core;
public class ExportHandler : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {


        var Companystr = context.Request.Params["Company"];
        var FilterOptionstr = context.Request.Params["FilterOption"];
        if (Companystr == null || FilterOptionstr == null)
        {
            throw new Exception("Export file failed.");
        }

        var CompanyList = JsonConvert.DeserializeObject<List<Company>>(HttpUtility.UrlDecode(Companystr));
        var FilterOption = JsonConvert.DeserializeObject<FilterOption>(HttpUtility.UrlDecode(FilterOptionstr));
        
        //壓縮檔案用
        MemoryStream outputMemStream = new MemoryStream();
        ZipOutputStream zipStream = new ZipOutputStream(outputMemStream);
        zipStream.SetLevel(3); //0-9, 9 being the highest level of compression

        foreach (var Company in CompanyList) {
            var Listdata = GetCompanysaf20Data(FilterOption, Company.Code);
            var excel = new ExcelPackage();
            var sheet = excel.Workbook.Worksheets.Add(Company.Name);
            var title = 1;
            if (Company.Code == "2004")
            {
                //sheet.Cells[title, 1].Value = "序號";
                //sheet.Cells[title, 2].Value = "客戶";
                //sheet.Cells[title, 3].Value = "";
                //sheet.Cells[title, 4].Value = "";
                //sheet.Cells[title, 5].Value = "手機";
                //sheet.Cells[title, 6].Value = "姓名";
                //sheet.Cells[title, 7].Value = "";
                //sheet.Cells[title, 8].Value = "地址";
                //sheet.Cells[title, 9].Value = "";
                //sheet.Cells[title, 10].Value = "";
                //sheet.Cells[title, 11].Value = "";
                //sheet.Cells[title, 12].Value = "";
                //sheet.Cells[title, 13].Value = "";
                //sheet.Cells[title, 14].Value = "品名";
                //sheet.Cells[title, 15].Value = "";
                //sheet.Cells[title, 16].Value = "";
                title = 0;
                for (int i = 0; i < Listdata.Count; i++)
                {
                    var data = Listdata[i];
                    sheet.Cells[title + i + 1, 1].Value = data.RowId;
                    sheet.Cells[title + i + 1, 2].Value = data.Cuscod;
                    sheet.Cells[title + i + 1, 3].Value = "";
                    sheet.Cells[title + i + 1, 4].Value = "";
                    sheet.Cells[title + i + 1, 5].Value = data.Cell;
                    sheet.Cells[title + i + 1, 6].Value = data.Name;
                    sheet.Cells[title + i + 1, 7].Value = "";
                    sheet.Cells[title + i + 1, 8].Value = data.Address;
                    sheet.Cells[title + i + 1, 9].Value = "";
                    sheet.Cells[title + i + 1, 10].Value = "";
                    sheet.Cells[title + i + 1, 11].Value = "";
                    sheet.Cells[title + i + 1, 12].Value = "";
                    sheet.Cells[title + i + 1, 13].Value = "";
                    sheet.Cells[title + i + 1, 14].Value = data.PsName;
                    sheet.Cells[title + i + 1, 15].Value = "";
                    sheet.Cells[title + i + 1, 16].Value = "";
                }

            }
            else
            {

                sheet.Cells[title, 1].Value = "序號";
                sheet.Cells[title, 2].Value = "姓名";
                sheet.Cells[title, 3].Value = "地址";
                sheet.Cells[title, 4].Value = "手機";
                sheet.Cells[title, 5].Value = "電話";
                sheet.Cells[title, 6].Value = "數量";
                sheet.Cells[title, 7].Value = "品名";
                sheet.Cells[title, 8].Value = "代收款";

                for (int i = 0; i < Listdata.Count; i++)
                {
                    var data = Listdata[i];
                    sheet.Cells[title + i + 1, 1].Value = data.RowId;
                    sheet.Cells[title + i + 1, 2].Value = data.Name;
                    sheet.Cells[title + i + 1, 3].Value = data.Address;
                    sheet.Cells[title + i + 1, 4].Value = data.Cell;
                    sheet.Cells[title + i + 1, 5].Value = data.Tel01;
                    sheet.Cells[title + i + 1, 6].Value = data.Ordqty;
                    sheet.Cells[title + i + 1, 7].Value = data.PsName;
                    sheet.Cells[title + i + 1, 8].Value = data.Money;
                }


            }
            FitExcelColumnWidth(sheet);
            //拿到csv檔 壓縮進同一個zip
            byte[] byteData = excel.GetAsByteArray();
            var msFormXml = new MemoryStream(byteData);
            ZipEntry xmlEntry = new ZipEntry(String.Format("cnf1002_fileorder_{0}{1}.csv", Company.Code, DateTime.Now.ToString("yyyyMMdd")));
            xmlEntry.DateTime = DateTime.Now;
            zipStream.PutNextEntry(xmlEntry);
            StreamUtils.Copy(msFormXml, zipStream, new byte[4096]);
            zipStream.CloseEntry();
        }
        
        zipStream.IsStreamOwner = false;
        zipStream.Close();

        outputMemStream.Position = 0;

        byte[] byteArray = outputMemStream.ToArray();

        context.Response.Clear();
        var fileName = String.Format("cnf1002_fileorder_{0}.zip", DateTime.Now.ToString("yyyyMMdd"));
        var strContentDisposition = String.Format("{0}; filename=\"{1}\"", "attachment", HttpUtility.UrlEncode(fileName, System.Text.Encoding.UTF8));
        context.Response.AppendHeader("Content-Disposition", strContentDisposition); // 檔案名稱
        context.Response.AppendHeader("Content-Length", byteArray.Length.ToString());
        context.Response.ContentType = "application/octet-stream";
        context.Response.BinaryWrite(byteArray);

    }
    

    
    public List<saf20Data> GetCompanysaf20Data(FilterOption FilterOption, string Code)
    {
        var List = new List<saf20Data>();
        using (var conn = new SqlConnection(MyConnStringList.AzureGoodeasy))
        {
            conn.Open();
            var cmd = conn.CreateCommand();
            cmd.CommandText = @"
           SELECT 
	            ROW_NUMBER() OVER(ORDER BY saf2023_ship_date) AS RowId,
	            saf2001_cuscode as Cuscod,
	            saf2014_rec_name as Name,
	            saf2019_rec_address as Address,
	            saf2015_rec_cell as Cell,
	            saf2016_rec_tel01 as Tel01,
	            saf20a41_ord_qty as Ordqty,
	            saf20a31_psname  as PsName,
	            saf2090_col_money as Money 
            FROM [dbo].[saf20] saf20
            inner join  [dbo].[saf20a] saf20a on saf20.saf2002_serial=saf20a.saf20a02_serial
            where 
                saf2029_logis_no=@code and 
                @startdate<= Convert(varchar(10),saf2023_ship_date,111) and 
                Convert(varchar(10),saf2023_ship_date,111)<= @enddate";
            cmd.Parameters.AddWithValue("@code", Code);
            cmd.Parameters.AddWithValue("@startdate", FilterOption.StartDate);
            cmd.Parameters.AddWithValue("@enddate", FilterOption.EndDate);
            using (var rd = cmd.ExecuteReader())
            {
                if (rd.HasRows)
                {
                    while (rd.Read())
                    {
                        List.Add(new saf20Data()
                        {
                            RowId = rd["RowId"].ToString(),
                            Cuscod = rd["Cuscod"].ToString(),
                            Name = rd["Name"].ToString(),
                            Address = rd["Address"].ToString(),
                            Cell = rd["Cell"].ToString(),
                            Tel01 = rd["Tel01"].ToString(),
                            Ordqty = rd["Ordqty"].ToString(),
                            PsName = rd["PsName"].ToString(),
                            Money = rd["Money"].ToString(),
                        });

                    }
                }
            }
        }


        return List;
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
    public class FilterOption
    {
        public string StartDate { get; set; }
        public string EndDate { get; set; }
    }
    public class saf20Data
    {
        public string RowId { get; set; }
        public string Cuscod { get; set; }
        public string Name { get; set; }
        public string Address { get; set; }
        public string Cell { get; set; }
        public string Tel01 { get; set; }
        public string Ordqty { get; set; }
        public string PsName { get; set; }
        public string Money { get; set; }
    }

    public class Company
    {
        public string Name { get; set; }
        public string Code { get; set; }
    }
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}