<%@ WebHandler Language="C#" Class="GetPaymentInfo" %>

using System;
using System.Web;
using Newtonsoft.Json;
using Dsap02101;

public class GetPaymentInfo : IHttpHandler {
    public string paymentCode { get; set; }
    public void ProcessRequest (HttpContext context) {
        this.paymentCode = context.Request.Params["payment"];
        context.Response.ContentType = "text/plain";
        context.Response.Write(cnf10.getPaymentInfo(this.paymentCode));

    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}