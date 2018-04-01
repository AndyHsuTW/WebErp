<%@ WebHandler Language="C#" Class="GetData" %>

using System;
using System.Web;
using WebERPLibrary;
using Newtonsoft.Json;
public class GetData : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        //context.Response.Write("Hello World");
        var Filters= JsonConvert.DeserializeObject<Dsap02005.Filters>(context.Request.Params["Filters"]);
        var datalist = Dsap02005.GetData(Filters);
        context.Response.Write(JsonConvert.SerializeObject(datalist));
       
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}