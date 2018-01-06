<%@ WebHandler Language="C#" Class="D_pcodeHandler" %>

using System;
using System.Web;

public class D_pcodeHandler : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        
        
        //context.Response.Write("Hello World");
    }


    public class filterOption {
        public string Mcode { get; set; }
        public string RelativeNo_start { get; set; }
        public string RelativeNo_end { get; set; }
        public string Pcode { get; set; }
        public string Psname { get; set; }
        public string Keyword { get; set; }
        public string Retail_start { get; set; }
        public string Retail_end { get; set; }
    
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}