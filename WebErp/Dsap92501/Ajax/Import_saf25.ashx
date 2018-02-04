<%@ WebHandler Language="C#" Class="Import_saf25" %>

using System;
using System.Web;
using System.Collections.Generic;
using Newtonsoft.Json;
using WebERPLibrary;
public class Import_saf25 : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        //context.Response.Write("Hello World");
        var List = JsonConvert.DeserializeObject<List<saf25FileInfo>>(context.Request.Params["List"]);
        var user = context.Request.Params["Loginuser"]??"";

        var msg = WebERPLibrary.Dsap92501.Import_saf25(List, user);


        context.Response.Write(JsonConvert.SerializeObject(msg));
        
        
    }
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
   

}