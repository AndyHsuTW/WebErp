<%@ WebHandler Language="C#" Class="D_pcodeHandler" %>

using System;
using System.Web;
using Newtonsoft.Json;
using ErpBaseLibrary.DB;
using System.Data.SqlClient;
using System.Collections.Generic;
using Dsap02101;
using WebERPLibrary;
public class D_pcodeHandler : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";


        var FilterOptionstr = context.Request.Params["filterOption"];
        var FilterOption = JsonConvert.DeserializeObject<Saf21.FilterOption>(FilterOptionstr);
        var StartRow = context.Request.Params["StartRow"] ?? "0";

        var List = Saf21.Search(FilterOption);



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