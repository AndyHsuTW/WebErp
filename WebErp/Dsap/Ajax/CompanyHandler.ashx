<%@ WebHandler Language="C#" Class="CompanyHandler" %>
using System;
using System.Web;
using Newtonsoft.Json;
using ErpBaseLibrary.DB;
using System.Data.SqlClient;
using System.Collections.Generic;
using WebERPLibrary;
public class CompanyHandler : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        var List = Dsap92001.GetCompanyList();
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