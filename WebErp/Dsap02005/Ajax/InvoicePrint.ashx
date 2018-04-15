<%@ WebHandler Language="C#" Class="InvoicePrint" %>

using System;
using System.Web;
using WebERPLibrary;
using Newtonsoft.Json;
using System.Collections.Generic;
public class InvoicePrint : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        var time = DateTime.Now.ToString("yyyyMMddHHmm");
        var datalist = JsonConvert.DeserializeObject<List<Dsap02005.OrderData>>(HttpUtility.UrlDecode(context.Request.Params["datalist"]));

        var loginUserName = HttpUtility.UrlDecode(context.Request.Params["loginUserName"]);
        var byteArray = Dsap02005.InvoicePrint(datalist, loginUserName);

        context.Response.Clear();
        var fileName = String.Format("發票_{0}.zip", time);
        var strContentDisposition = String.Format("{0}; filename=\"{1}\"", "attachment", HttpUtility.UrlEncode(fileName, System.Text.Encoding.UTF8));
        context.Response.AppendHeader("Content-Disposition", strContentDisposition); // 檔案名稱
        context.Response.AppendHeader("Content-Length", byteArray.Length.ToString());
        context.Response.ContentType = "application/octet-stream";
        context.Response.BinaryWrite(byteArray);
        
        
      
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}