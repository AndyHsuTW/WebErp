<%@ WebHandler Language="C#" Class="Inf15Handler" %>

using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.SessionState;
using Newtonsoft.Json;
using DINP015;

public class Inf15Handler   : IHttpHandler, IRequiresSessionState {
    /// <summary>
    /// Request.Form["act"]
    /// </summary>
    public string Action { get; set; }
    /// <summary>
    /// Request.Form["data"]
    /// </summary>
    public string Data { get; set; }
    /// <summary>
    /// Request.Form["type"]
    /// </summary>
    public string Type { get; set; }
    /// <summary>
    /// Request.Form["fields"]
    /// </summary>
    public string FieldNames { get; set; }

    /// <summary>
    /// Request.Params["user"]
    /// </summary>
    public string User { get; set; }
    public void ProcessRequest (HttpContext context)
    {
        this.Action = context.Request.Form["act"];
        this.Data = context.Request.Form["data"];
        this.Type = context.Request.Form["type"];
        this.FieldNames = context.Request.Form["fields"];
        this.User = context.Request.Params["user"];

        if (context.Request.Files.Count > 0)
        {
            this.Action = "import";
        }

        if (this.Action == null) return;
        switch (this.Action.ToLower())
        {
            case "last":
                {
                    var inf15List = Inf15.GetLastData();
                    context.Response.ContentType = "text/plain";
                    context.Response.Write(JsonConvert.SerializeObject(inf15List));
                    return;
                }
            case "add":
                {
                    try
                    {
                        Inf15 inf15 = JsonConvert.DeserializeObject<Inf15>(this.Data);
                        var newItem = Inf15.AddItem(inf15);
                        if (newItem == null)
                        {
                            throw new Exception("Add Inf15 fail.");
                        }
                        context.Response.ContentType = "text/plain";
                        context.Response.Write(JsonConvert.SerializeObject(newItem));
                    }
                    catch (SqlException ex)
                    {
                        if (ex.Message.Contains("insert duplicate key"))
                        {
                            context.Response.ContentType = "text/plain";
                            context.Response.Write("insert duplicate key");
                        }
                        else
                        {
                            throw;
                        }
                    }

                    return;
                }
            case "get":
                {
                    Inf15.FilterOption filterOption = JsonConvert.DeserializeObject<Inf15.FilterOption>(this.Data);
                    var inf15List = Inf15.Search(filterOption);
                    context.Response.ContentType = "text/plain";
                    context.Response.Write(JsonConvert.SerializeObject(inf15List));
                    return;
                }
            case "update":
                {
                    Inf15 inf15 = JsonConvert.DeserializeObject<Inf15>(this.Data);
                    var newItem = Inf15.UpdateItem(inf15);
                    if (newItem == null)
                    {
                        throw new Exception("Update Inf15 fail.");
                    }
                }
                break;
            //case "batchupdate":
            //    {
            //        List<Inf15> inf15List = JsonConvert.DeserializeObject<List<Inf15>>(this.Data);
            //        var newItem = Inf15.BatchUpdateItem(inf15List);
            //        if (newItem == null)
            //        {
            //            Inf15.FilterOption a;
            //            throw new Exception("BatchUpdate inf15List fail.");
            //        }
            //    }
            //    break;
            case "del":
                {
                    var success = false;
                    if (String.Equals("list", this.Type))
                    {
                        success = Inf15.DeleteItem(JsonConvert.DeserializeObject<int[]>(this.Data));
                    }
                    else
                    {
                        success = Inf15.DeleteItem(Convert.ToInt32(this.Data));
                    }

                    if (!success)
                    {
                        context.Response.ContentType = "text/plain";
                        context.Response.Write("fail");
                        return;
                    }
                }
                break;
            case "export":
                {
                    var fieldNameList = JsonConvert.DeserializeObject<string[]>(this.FieldNames);
                    List<Inf15> inf15List = JsonConvert.DeserializeObject<List<Inf15>>(this.Data);
                    context.Session["exportFields"] = fieldNameList;
                    context.Session["exportItems"] = inf15List;
                    context.Session["exportExcelVersion"] = 2003;
                }
                break;
            //case "import":
            //    {
            //        byte[] b = new byte[context.Request.Files[0].InputStream.Length];
            //        if (b.Length == 0)
            //        {
            //            throw new Exception("File can not be empty");
            //        }
            //        context.Request.Files[0].InputStream.Read(b, 0, b.Length);
            //        List<Inf15> inf15List = null;
            //        using (MemoryStream stream = new MemoryStream(b))
            //        {
            //            inf15List = Inf15.ParseFromExcel(stream, this.User);
            //        }
            //        if (inf15List != null && inf15List.Count > 0)
            //        {
            //            for (var i = 0; i < inf15List.Count;i++ )
            //            {
            //                var inf15 = inf15List[i];
            //                //re-add item on processing import data
            //                try
            //                {
            //                    //Inf15.DeleteItemByUniqueColumns(inf15.cnf1501_file, inf15.inf1502_field);
            //                    Inf15.AddItem(inf15);
            //                }
            //                catch (Exception ex)
            //                {
            //                    context.Response.ContentType = "text/plain";
            //                    context.Response.Write(String.Format("{0}, 請檢查第{1}列", ex.Message, i + 1));
            //                    return;
            //                }
            //            }
            //        }
            //    }
            //    break;
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