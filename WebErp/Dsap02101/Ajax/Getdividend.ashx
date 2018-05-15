<%@ WebHandler Language="C#" Class="Getdividend" %>

using System;
using System.Web;
using Newtonsoft.Json;
using Dsap02101;

public class Getdividend : IHttpHandler {
    public string pcode { get; set; }

    public void ProcessRequest (HttpContext context) {
        this.pcode = context.Request.Params["pcode"];
        Inf01 model = Inf01.getDividend(this.pcode);
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(model));

    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}