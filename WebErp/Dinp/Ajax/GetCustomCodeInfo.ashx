<%@ WebHandler Language="C#" Class="GetCustomCodeInfo" %>

using System;
using System.Web;
using Dinp02301;
using Newtonsoft.Json;

/// <summary>
/// 異動單位會因為異動代碼之不同而讀不同的檔案
/// </summary>
public class GetCustomCodeInfo : IHttpHandler {

    public string InReasonCh02 { get; set; }

    public string CustomCode { get; set; }
    
    public void ProcessRequest (HttpContext context)
    {
        this.InReasonCh02 = context.Request.Params["inReasonCh02"];
        this.CustomCode = context.Request.Params["customCode"];

        object customCodeInfo = null;
        switch (this.InReasonCh02)
        {
            case "cmf01":
                customCodeInfo = Cmf01.GetData(this.CustomCode);
                break;
            case "cnf07":
                break;
            case "inf03":
                break;
            case "taf10":
                break;
            case "cnf10":
                break;
        }
        
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(customCodeInfo));
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}