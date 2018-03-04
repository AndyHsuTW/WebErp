<%@ WebHandler Language="C#" Class="Inf29Handler" %>

using System;
using System.Collections.Generic;
using System.IO;
using System.Web;
using System.Linq;
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

    /// <summary>
    /// Request.Form["printBcode"]
    /// </summary>
    public string PrintBcode { get; set; }

    /// <summary>
    /// Request.Form["user"]
    /// </summary>
    public string User { get; set; }
    
    public void ProcessRequest (HttpContext context) {
        this.Action = context.Request.Form["act"];
        this.Data = context.Request.Form["data"];
        this.Inf29Fields = context.Request.Form["inf29fields"];
        this.Inf29aFields = context.Request.Form["inf29afields"];
        this.PrintBcode = context.Request.Form["printBcode"];
        this.User = context.Request.Form["user"];
        
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
                    Inf29.FilterOption filterOption = JsonConvert.DeserializeObject<Inf29.FilterOption>(this.Data);
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
            case "print":
                {
                    List<int> inf29IdList = JsonConvert.DeserializeObject<List<int>>(this.Data);
                    context.Session["printItems"] = inf29IdList;
                    if (this.PrintBcode != null)
                    {
                        context.Session["printBcode"] = JsonConvert.DeserializeObject<Cnf07>(this.PrintBcode);
                    }
                }
                break;
            case "import":
                {
                    var now = DateTime.Now;
                    var name = context.Request.Files[0].FileName;
                    byte[] b = new byte[context.Request.Files[0].InputStream.Length];
                    if (b.Length == 0)
                    {
                        throw new Exception("File can not be empty");
                    }
                    context.Request.Files[0].InputStream.Read(b, 0, b.Length);
                    List<Inf29.ImportItemRow> inf29List = null;
                    using (MemoryStream stream = new MemoryStream(b))
                    {
                        inf29List = Inf29.ParseFromExcelNpoi(stream, name.EndsWith("xlsx") ? 2007 : 2003);
                    }
                    if (inf29List != null && inf29List.Count > 0)
                    {
                        var lastRowId = -1;
                        Inf29 currentInf29 = null;
                        for (var i = 0; i < inf29List.Count; i++)
                        {
                            var inf29Row = inf29List[i];
                            var currentRowId = inf29Row.GetMasterRowId();
                            try
                            {
                                if (currentRowId != lastRowId)
                                {
                                    lastRowId = currentRowId;
                                    // get only inf29 fields
                                    var inf29 = new Inf29.ImportItemRow(inf29Row.Where(
                                        o =>
                                        o.Key.StartsWith("inf29", StringComparison.OrdinalIgnoreCase) &&
                                        !o.Key.StartsWith("inf29a", StringComparison.OrdinalIgnoreCase))
                                                                                .ToDictionary(o => o.Key, o => o.Value));
                                    inf29.adduser = this.User;
                                    inf29.adddate = now;
                                        
                                    int inf29Id = Inf29.AddItem(inf29);
                                    if (inf29Id < 0)
                                    {
                                        throw new Exception("Import fail");
                                    }
                                    currentInf29 = Inf29.Search(new Inf29.FilterOption
                                        {
                                            id = inf29Id
                                        }).FirstOrDefault();
                                }
                                // get only inf29a fields
                                {
                                    var inf29a = new Inf29.ImportItemRow(inf29Row.Where(
                                        o =>
                                        o.Key.StartsWith("inf29a", StringComparison.OrdinalIgnoreCase))
                                                                                 .ToDictionary(o => o.Key, o => o.Value));
                                    inf29a.adduser = this.User;
                                    inf29a.adddate = now;
                                    
                                    int id = Inf29a.AddItem(currentInf29, inf29a);
                                }

                            }
                            catch (Exception ex)
                            {
                                context.Response.ContentType = "text/plain";
                                context.Response.Write(String.Format("{0}, 請檢查第{1}列", ex.Message, i + 3));
                                return;
                            }
                        }
                    }
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