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
using WebERPLibrary;
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

        var CompanyList = JsonConvert.DeserializeObject<List<WebERPLibrary.Company>>(HttpUtility.UrlDecode(Companystr));
        var FilterOption = JsonConvert.DeserializeObject<WebERPLibrary.FilterOption>(HttpUtility.UrlDecode(FilterOptionstr));
        
        //壓縮檔案用
        MemoryStream outputMemStream = new MemoryStream();
        ZipOutputStream zipStream = new ZipOutputStream(outputMemStream);
        zipStream.SetLevel(3); //0-9, 9 being the highest level of compression
        var time = DateTime.Now.ToString("yyyyMMddHHmm");
        foreach (var Company in CompanyList) {
            
            var Listdata = Dsap92001.GetCompanysaf20Data(FilterOption, Company.Code);

            byte[] byteData = Dsap92001.GetExcelData(Listdata, Company);
            var msFormXml = new MemoryStream(byteData);
            ZipEntry xmlEntry = new ZipEntry(String.Format("{0}{1}.csv", Company.Code, DateTime.Parse(FilterOption.StartDate).ToString("yyyyMMdd")));
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
        var fileName = String.Format("出貨資料匯出_{0}.zip", time);
        var strContentDisposition = String.Format("{0}; filename=\"{1}\"", "attachment", HttpUtility.UrlEncode(fileName, System.Text.Encoding.UTF8));
        context.Response.AppendHeader("Content-Disposition", strContentDisposition); // 檔案名稱
        context.Response.AppendHeader("Content-Length", byteArray.Length.ToString());
        context.Response.ContentType = "application/octet-stream";
        context.Response.BinaryWrite(byteArray);

    }
    

    
 
    

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}