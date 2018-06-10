<%@ WebHandler Language="C#" Class="D_CustomerHandler" %>

using System;
using System.Web;

public class D_CustomerHandler : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        context.Response.Write("Hello World");
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}