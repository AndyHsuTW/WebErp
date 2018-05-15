<%@ WebHandler Language="C#" Class="GetCustomCodeInfo" %>

using System;
using System.Web;
using Newtonsoft.Json;
using Dsap02101;

public class GetCustomCodeInfo : IHttpHandler {
    public string customcode { get; set; }
    public void ProcessRequest (HttpContext context) {
        this.customcode = context.Request.Params["customCode"];
        context.Response.ContentType = "text/plain";
        var test = Cmf01.GetCustomerCodeName(this.customcode);
        context.Response.Write(JsonConvert.SerializeObject(test));

    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}