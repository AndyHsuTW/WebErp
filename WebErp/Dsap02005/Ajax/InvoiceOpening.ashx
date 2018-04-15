<%@ WebHandler Language="C#" Class="InvoiceOpening" %>

using System;
using System.Web;
using WebERPLibrary;
using Newtonsoft.Json;
using System.Collections.Generic;
public class InvoiceOpening : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";


        var datalist = JsonConvert.DeserializeObject<List<Dsap02005.OrderData>>(context.Request.Params["datalist"]);

        var loginUserName = context.Request.Params["loginUserName"];
        var result = Dsap02005.InvoiceOpening(datalist, loginUserName);

        context.Response.Write(result);
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}