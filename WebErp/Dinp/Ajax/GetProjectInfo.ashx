<%@ WebHandler Language="C#" Class="GetProjectInfo" %>

using System;
using System.Web;
using Dinp02301;
using Newtonsoft.Json;

public class GetProjectInfo : IHttpHandler {

    /// <summary>
    /// 公司代號
    /// Request.Params["bcode"]
    /// </summary>
    public string Bcode { get; set; }
    /// <summary>
    /// 專案代號
    /// Request.Params["projectNo"]
    /// </summary>
    public string ProjectNo { get; set; }

    public void ProcessRequest (HttpContext context)
    {
        this.Bcode = context.Request.Params["bcode"];
        this.ProjectNo = context.Request.Params["projectNo"];

        var gaf04 = Gaf04.GetData(this.Bcode, this.ProjectNo);
        
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(gaf04));
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}