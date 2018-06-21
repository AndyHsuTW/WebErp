<%@ WebHandler Language="C#" Class="GetExchangeInfo" %>

using System;
using System.Web;
using Dinp02301;
using Newtonsoft.Json;

public class GetExchangeInfo : IHttpHandler
{

    /// <summary>
    /// 幣別代號
    /// Request.Params["exchangeCode"]
    /// </summary>
    public string ExchangeCode { get; set; }
    
    public void ProcessRequest (HttpContext context)
    {
        this.ExchangeCode = context.Request.Params["exchangeCode"];
        
        var exchangeInfo = Cnf14.GetData(this.ExchangeCode);
        
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(exchangeInfo));
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}