<%@ WebHandler Language="C#" Class="GetProductInfo" %>

using System;
using System.Web;
using System.Linq;
using Newtonsoft.Json;
using WebERPLibrary;

public class GetProductInfo : IHttpHandler {

    /// <summary>
    /// 商品條碼
    /// Request.Params["pcode"]
    /// </summary>
    public string Pcode { get; set; }
    
    public void ProcessRequest (HttpContext context)
    {

        this.Pcode = context.Request.Params["pcode"];
        
        D_pcodefilterOption filterOption = new D_pcodefilterOption();
        filterOption.Pcode = this.Pcode;
        
        var productList = D_pcode.GetDpcode(filterOption, "0");
        if (productList == null || productList.Count == 0)
        {
            filterOption = new D_pcodefilterOption();
            filterOption.RelativeNo_start = this.Pcode;
            productList = D_pcode.GetDpcode(filterOption, "0");
        }
        
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(productList.FirstOrDefault()));
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}