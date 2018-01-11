<%@ WebHandler Language="C#" Class="D_pcodeHandler" %>

using System;
using System.Web;
using Newtonsoft.Json;
using ErpBaseLibrary.DB;
using System.Data.SqlClient;
using System.Collections.Generic;
using WebERPLibrary;
public class D_pcodeHandler : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";

        
        var FilterOptionstr = context.Request.Params["filterOption"];
        var FilterOption = JsonConvert.DeserializeObject<D_pcodefilterOption>(HttpUtility.UrlDecode(FilterOptionstr));
        var StartRow = context.Request.Params["StartRow"] ?? "0";

        var List = D_pcode.GetDpcode(FilterOption, StartRow);
        
       

        context.Response.Write(JsonConvert.SerializeObject(List));

    }

  
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}