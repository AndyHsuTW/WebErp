<%@ WebHandler Language="C#" Class="GetExportFields" %>

using System;
using System.Web;
using DCNP005;
using Newtonsoft.Json;

/// <summary>
/// 讀 cnf05 取得Inf29, Inf29a可匯出欄位
/// </summary>
public class GetExportFields : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        var inf29Fields = Cnf05.Search(new Cnf05.FilterOption
        {
            cnf0501_file_start = "inf29",
            cnf0501_file_end = "inf29"
        });
        var inf29aFields = Cnf05.Search(new Cnf05.FilterOption
        {
            cnf0501_file_start = "inf29a",
            cnf0501_file_end = "inf29a"
        });
        object[] fields = new object[2];
        fields[0] = inf29Fields;
        fields[1] = inf29aFields;
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(fields));
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}