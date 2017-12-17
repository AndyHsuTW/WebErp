<%@ WebHandler Language="C#" Class="Cnf05Export" %>

using System;
using System.Collections.Generic;
using System.Web;
using System.Web.SessionState;
using DCNP005;

public class Cnf05Export : IHttpHandler, IRequiresSessionState
{
    
    public void ProcessRequest (HttpContext context) {

        string[] fieldNameList = context.Session["exportFields"] as string[];
        List<Cnf05> cnf05List = context.Session["exportItems"] as List<Cnf05>;
        context.Session["exportFields"] = null;
        context.Session["exportItems"] = null;
        if (fieldNameList == null || cnf05List == null)
        {
            throw new Exception("Export file failed.");
        }
        var excel = Cnf05.Export(fieldNameList, cnf05List);
        var byteData = excel.GetAsByteArray();
        var fileNameFull = String.Format("Export_{0}.xlsx", DateTime.Now.ToString("yyyyMMdd"));

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