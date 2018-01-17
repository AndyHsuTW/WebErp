<%@ WebHandler Language="C#" Class="ImportExcels" %>

using System;
using System.Web;
using System.IO;
using OfficeOpenXml;
using OfficeOpenXml.Style;
public class ImportExcels : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
       // context.Response.Write("Hello World");

        HttpFileCollection files = context.Request.Files;

        for (int i = 0; i < files.Count; i++)
        {
            HttpPostedFile file = files[i];
            string fname = context.Server.MapPath("~/Dsap92501/uploads/" + file.FileName);
            file.SaveAs(fname);
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}