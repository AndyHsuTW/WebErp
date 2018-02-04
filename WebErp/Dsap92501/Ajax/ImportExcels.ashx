<%@ WebHandler Language="C#" Class="ImportExcels" %>

using System;
using System.Web;
using System.IO;
using System.Collections.Generic;
using Newtonsoft.Json;
using System.Text.RegularExpressions;
using System.Data.SqlClient;
using WebERPLibrary;
public class ImportExcels : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        // context.Response.Write("Hello World");
        Uploadfile(context);
        var OrderTime = context.Request.QueryString["DateTime"];
        var uploadsRoot = context.Server.MapPath("~/Dsap92501/uploads/");
        var uploadsDirectory = uploadsRoot + OrderTime.Replace("/", string.Empty);
        HttpPostedFile file = context.Request.Files[0];
        var uploadsPath = uploadsDirectory + "\\" + file.FileName;
        var strFileName = file.FileName;
        var saf25FileInfo = new saf25FileInfo();
        var result = WebERPLibrary.Dsap92501.ImportExcels(uploadsPath, strFileName, OrderTime);
        context.Response.Write(JsonConvert.SerializeObject(result));  
    }

    public void Uploadfile(HttpContext context)
    {
        var DateTime = context.Request.QueryString["DateTime"];
        HttpFileCollection files = context.Request.Files;
        //建立uploads資料夾
        var uploadsRoot = context.Server.MapPath("~/Dsap92501/uploads/");
        var uploadsDirectory = uploadsRoot + DateTime.Replace("/", string.Empty);
        while (!Directory.Exists(uploadsDirectory))
        {
            Directory.CreateDirectory(uploadsDirectory);
        }
        for (int i = 0; i < files.Count; i++)
        {
            HttpPostedFile file = files[i];
            var uploadsPath = uploadsDirectory + "\\" + file.FileName;

            file.SaveAs(uploadsPath);

        }
    }
    
   
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}