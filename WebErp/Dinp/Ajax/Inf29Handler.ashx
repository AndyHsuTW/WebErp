<%@ WebHandler Language="C#" Class="Inf29Handler" %>

using System;
using System.Collections.Generic;
using System.Web;
using System.Web.SessionState;
using Dinp02301;
using DCNP005;
using Newtonsoft.Json;

public class Inf29Handler : IHttpHandler, IRequiresSessionState
{

    /// <summary>
    /// Request.Form["act"]
    /// </summary>
    public string Action { get; set; }
    /// <summary>
    /// Request.Form["data"]
    /// </summary>
    public string Data { get; set; }
    /// <summary>
    /// Request.Form["inf29fields"]
    /// </summary>
    public string Inf29Fields { get; set; }
    /// <summary>
    /// Request.Form["inf29afields"]
    /// </summary>
    public string Inf29aFields { get; set; }
    
    public void ProcessRequest (HttpContext context) {
        this.Action = context.Request.Form["act"];
        this.Data = context.Request.Form["data"];
        this.Inf29Fields = context.Request.Form["inf29fields"];
        this.Inf29aFields = context.Request.Form["inf29afields"];
        

        if (this.Action == null) return;
        switch (this.Action.ToLower())
        {
            case "save":
                {
                    Inf29 inf29Item = JsonConvert.DeserializeObject<Inf29>(this.Data);

                    Inf29.AddItem(inf29Item);
                    Inf29a.AddItem(inf29Item, inf29Item.Inf29aList);
                    inf29Item.Inf29aList = null;
                    context.Response.ContentType = "text/plain";
                    context.Response.Write(JsonConvert.SerializeObject(inf29Item));
                    return;
                }
                break;
            case "get":
                {
                    Inf29.FilterOption filterOption = new Inf29.FilterOption();
                    var inf29List = Inf29.Search(filterOption);
                    context.Response.ContentType = "text/plain";
                    context.Response.Write(JsonConvert.SerializeObject(inf29List));
                    return;
                }
                break;
            case "getdetail":
                {
                    var inf29aList = Inf29a.GetList(this.Data);
                    context.Response.ContentType = "text/plain";
                    context.Response.Write(JsonConvert.SerializeObject(inf29aList));
                    return;
                }
                break;
            case "del":
                {
                    bool success = false;
                    Inf29a.Delete(this.Data);
                    Inf29.Delete(this.Data);
                    
                    context.Response.ContentType = "text/plain";
                    context.Response.Write("ok");
                    return;
                }
                break;
            case "export":
                {
                    var inf29FieldNameList = JsonConvert.DeserializeObject<Cnf05[]>(this.Inf29Fields);
                    var inf29aFieldNameList = JsonConvert.DeserializeObject<Cnf05[]>(this.Inf29aFields);

                    List<int> inf29IdList = JsonConvert.DeserializeObject<List<int>>(this.Data);

                    context.Session["in29ExportFields"] = inf29FieldNameList;
                    context.Session["in29aExportFields"] = inf29aFieldNameList;
                    context.Session["exportItems"] = inf29IdList;
                    context.Session["exportExcelVersion"] = 2003;
                }
                break;
            default:
                {

                }
                break;
        }
        context.Response.ContentType = "text/plain";
        context.Response.Write("ok");
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}