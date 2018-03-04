<%@ WebHandler Language="C#" Class="GetCustomCodeInfo" %>

using System;
using System.Threading;
using System.Web;
using Dinp02301;
using Newtonsoft.Json;

/// <summary>
/// 異動單位會因為異動代碼之不同而讀不同的檔案
/// </summary>
public class GetCustomCodeInfo : IHttpHandler {

    public string InReason { get; set; }

    public string CustomCode { get; set; }
    
    public void ProcessRequest (HttpContext context)
    {
        this.InReason = context.Request.Params["inReason"];
        this.CustomCode = context.Request.Params["customCode"];
        
        context.Response.ContentType = "text/plain";
        context.Response.Write(Inf29.GetCustomerCodeName(this.InReason, this.CustomCode));
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}