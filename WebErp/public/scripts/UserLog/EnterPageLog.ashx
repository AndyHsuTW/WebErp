<%@ WebHandler Language="C#" Class="EnterPageLog" %>

using System;
using System.Web;
using LogHelper;
public class EnterPageLog : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        var user = context.Request.Form["user"];
        var programno = context.Request.Form["programno"];
        var result = UserLog.EnterPageLog(user, programno);
        context.Response.Write(result);
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}