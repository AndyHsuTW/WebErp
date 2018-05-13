<%@ WebHandler Language="C#" Class="GetPoInfo" %>

using System;
using System.Globalization;
using System.Web;
using Dinp02101;
using Newtonsoft.Json;

public class GetPoInfo : IHttpHandler {

    /// <summary>
    /// Request.QueryString["docnoType"]
    /// </summary>
    public string DocnoType { get; set; }
    /// <summary>
    /// Request.QueryString["docnoDate"]
    /// </summary>
    public string DocnoDate { get; set; }
    /// <summary>
    /// Request.QueryString["docnoSeq"]
    /// </summary>
    public string DocnoSeq { get; set; }
    
    public void ProcessRequest (HttpContext context)
    {
        this.DocnoType = context.Request.QueryString["docnoType"];
        this.DocnoDate = context.Request.QueryString["docnoDate"];
        this.DocnoSeq = context.Request.QueryString["docnoSeq"];

        var docNoDate = DateTime.ParseExact(DocnoDate, "yyyyMMdd", CultureInfo.InvariantCulture);
        var docNoSeq = Convert.ToInt32(DocnoSeq);

        var inf20 = Inf20.GetInf20(DocnoType, docNoDate, docNoSeq);
        inf20.Inf20aList = Inf20a.GetInf20aList(inf20.inf2001_docno);
        
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(inf20));
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}