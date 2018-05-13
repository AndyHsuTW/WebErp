<%@ WebHandler Language="C#" Class="Saf20Handler" %>

using System;
using System.Collections.Generic;
using System.IO;
using System.Web;
using System.Linq;
using System.Web.SessionState;
using Dinp02401;
using DCNP005;
using Newtonsoft.Json;

public class Saf20Handler : IHttpHandler, IRequiresSessionState
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
    /// Request.Form["Saf20fields"]
    /// </summary>
    public string Saf20Fields { get; set; }
    /// <summary>
    /// Request.Form["Saf20afields"]
    /// </summary>
    public string Saf20aFields { get; set; }

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
        this.Saf20Fields = context.Request.Form["Saf20fields"];
        this.Saf20aFields = context.Request.Form["Saf20afields"];
        this.PrintBcode = context.Request.Form["printBcode"];
        this.User = context.Request.Form["user"];
        
        if (this.Action == null) return;
        switch (this.Action.ToLower())
        {
            case "save":
                {
                    Saf20 Saf20Item = JsonConvert.DeserializeObject<Saf20>(this.Data);

                    Saf20.AddItem(Saf20Item);
                    Saf20a.AddItem(Saf20Item, Saf20Item.Saf20aList);
                    Saf20Item.Saf20aList = null;
                    context.Response.ContentType = "text/plain";
                    context.Response.Write(JsonConvert.SerializeObject(Saf20Item));
                    return;
                }
                break;
            case "get":
                {
                    Saf20.FilterOption filterOption = JsonConvert.DeserializeObject<Saf20.FilterOption>(this.Data);
                    var Saf20List = Saf20.Search(filterOption);
                    context.Response.ContentType = "text/plain";
                    context.Response.Write(JsonConvert.SerializeObject(Saf20List));
                    return;
                }
                break;
            case "getdetail":
                {
                    var Saf20aList = Saf20a.GetList(this.Data);
                    context.Response.ContentType = "text/plain";
                    context.Response.Write(JsonConvert.SerializeObject(Saf20aList));
                    return;
                }
                break;
            case "del":
                {
                    bool success = false;
                    Saf20a.Delete(this.Data);
                    Saf20.Delete(this.Data);
                    
                    context.Response.ContentType = "text/plain";
                    context.Response.Write("ok");
                    return;
                }
                break;
            case "export":
                {
                    var Saf20FieldNameList = JsonConvert.DeserializeObject<Cnf05[]>(this.Saf20Fields);
                    var Saf20aFieldNameList = JsonConvert.DeserializeObject<Cnf05[]>(this.Saf20aFields);

                    List<int> Saf20IdList = JsonConvert.DeserializeObject<List<int>>(this.Data);

                    context.Session["in29ExportFields"] = Saf20FieldNameList;
                    context.Session["in29aExportFields"] = Saf20aFieldNameList;
                    context.Session["exportItems"] = Saf20IdList;
                    context.Session["exportExcelVersion"] = 2003;
                }
                break;
            case "print":
                {
                    List<int> Saf20IdList = JsonConvert.DeserializeObject<List<int>>(this.Data);
                    context.Session["printItems"] = Saf20IdList;
                    if (this.PrintBcode != null)
                    {
                        context.Session["printBcode"] = JsonConvert.DeserializeObject<Cnf07>(this.PrintBcode);
                    }
                    
                    context.Response.Write(Guid.NewGuid().ToString());
                    return; 
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
                    List<Saf20.ImportItemRow> Saf20List = null;
                    using (MemoryStream stream = new MemoryStream(b))
                    {
                        Saf20List = Saf20.ParseFromExcelNpoi(stream, name.EndsWith("xlsx") ? 2007 : 2003);
                    }
                    if (Saf20List != null && Saf20List.Count > 0)
                    {
                        var lastRowId = -1;
                        Saf20 currentSaf20 = null;
                        for (var i = 0; i < Saf20List.Count; i++)
                        {
                            var Saf20Row = Saf20List[i];
                            var currentRowId = Saf20Row.GetMasterRowId();
                            try
                            {
                                if (currentRowId != lastRowId)
                                {
                                    lastRowId = currentRowId;
                                    // get only Saf20 fields
                                    var Saf20 = new Saf20.ImportItemRow(Saf20Row.Where(
                                        o =>
                                        o.Key.StartsWith("Saf20", StringComparison.OrdinalIgnoreCase) &&
                                        !o.Key.StartsWith("Saf20a", StringComparison.OrdinalIgnoreCase))
                                                                                .ToDictionary(o => o.Key, o => o.Value));
                                    Saf20.adduser = this.User;
                                    Saf20.adddate = now;
                                        
                                    int Saf20Id = Saf20.AddItem(Saf20);
                                    if (Saf20Id < 0)
                                    {
                                        throw new Exception("Import fail");
                                    }
                                    currentSaf20 = Saf20.Search(new Saf20.FilterOption
                                        {
                                            id = Saf20Id
                                        }).FirstOrDefault();
                                }
                                // get only Saf20a fields
                                {
                                    var Saf20a = new Saf20.ImportItemRow(Saf20Row.Where(
                                        o =>
                                        o.Key.StartsWith("Saf20a", StringComparison.OrdinalIgnoreCase))
                                                                                 .ToDictionary(o => o.Key, o => o.Value));
                                    Saf20a.adduser = this.User;
                                    Saf20a.adddate = now;
                                    
                                    int id = Saf20a.AddItem(currentSaf20, Saf20a);
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