<%@ WebHandler Language="C#" Class="Inf29Handler" %>

using System;
using System.Web;
using Dinp02301;
using Newtonsoft.Json;

public class Inf29Handler : IHttpHandler {

    /// <summary>
    /// Request.Form["act"]
    /// </summary>
    public string Action { get; set; }
    /// <summary>
    /// Request.Form["data"]
    /// </summary>
    public string Data { get; set; }
    
    
    
    public void ProcessRequest (HttpContext context) {
        this.Action = context.Request.Form["act"];
        this.Data = context.Request.Form["data"];

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