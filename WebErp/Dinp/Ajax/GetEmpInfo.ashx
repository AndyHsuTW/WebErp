<%@ WebHandler Language="C#" Class="GetEmpInfo" %>

using System;
using System.Web;
using Dinp02301;
using Newtonsoft.Json;

public class GetEmpInfo : IHttpHandler {

    /// <summary>
    /// 員工代號
    /// Request.Params["empId"]
    /// </summary>
    public string EmpId { get; set; }
    
    public void ProcessRequest (HttpContext context) {

        this.EmpId = context.Request.Params["empId"];
        var taf10 =  Taf10.GetData(this.EmpId);
        
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(taf10));
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}