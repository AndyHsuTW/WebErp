<%@ WebHandler Language="C#" Class="Inf15Export" %>

using System;
using System.Collections.Generic;
using System.IO;
using System.Web;
using System.Web.SessionState;

using DINP015;
public class Inf15Export : IHttpHandler, IRequiresSessionState {
    
    public void ProcessRequest (HttpContext context) {

        string[] fieldNameList = context.Session["exportFields"] as string[];
        List<Inf15> inf15List = context.Session["exportItems"] as List<Inf15>;
        int excelVersion = (int)context.Session["exportExcelVersion"] ;
        
        context.Session["exportFields"] = null;
        context.Session["exportItems"] = null;
        context.Session["exportExcelVersion"] = null;
        
        if (fieldNameList == null || inf15List == null)
        {
            throw new Exception("Export file failed.");
        }
        var excel = Inf15.Export(fieldNameList, inf15List);
        var byteData = excel.GetAsByteArray();

        var fileNameFull = String.Format("Export_{0}.{1}", DateTime.Now.ToString("yyyyMMdd"),
                                         excelVersion == 2003 ? "xls" : "xlsx");

        var strContentDisposition = String.Format("{0}; filename=\"{1}\"", "attachment",
                                 HttpUtility.UrlEncode(fileNameFull, System.Text.Encoding.UTF8));

        context.Response.AppendHeader("Content-Disposition", strContentDisposition); // 檔案名稱
        context.Response.AppendHeader("Content-Length", byteData.Length.ToString());
        context.Response.BinaryWrite(byteData);
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}