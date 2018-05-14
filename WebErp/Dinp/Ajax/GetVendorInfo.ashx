<%@ WebHandler Language="C#" Class="GetVendorInfo" %>

using System;
using System.Linq;
using System.Web;
using Dinp02101;
using Newtonsoft.Json;

/// <summary>
/// 取得廠商資訊
/// </summary>
public class GetVendorInfo : IHttpHandler {

    /// <summary>
    /// 廠商代碼
    /// </summary>
    public string VCode { get; set; }
    
    public void ProcessRequest (HttpContext context) {

        this.VCode = context.Request.Params["vCode"];

        context.Response.ContentType = "text/plain";

        var venderInfo = Inf03.GetInf03(this.VCode).FirstOrDefault();
        if (venderInfo != null)
        {
            context.Response.Write(JsonConvert.SerializeObject(venderInfo));
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }


}