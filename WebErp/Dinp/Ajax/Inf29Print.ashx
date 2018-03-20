<%@ WebHandler Language="C#" Class="Inf29Print" %>

using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using System.Web;
using System.Web.SessionState;
using Dinp02301;
using iTextSharp.Print;

public class Inf29Print : IHttpHandler, IRequiresSessionState
{
    
    public void ProcessRequest (HttpContext context)
    {
        Cnf07 printBcode = context.Session["printBcode"] as Cnf07;
        List<int> inf29IdList = context.Session["printItems"] as List<int>;
        var tmpFile = context.Request.QueryString["session"];

        context.Session.Remove("printBcode");
        context.Session.Remove("printItems");
        
        if (String.IsNullOrEmpty(tmpFile) && (inf29IdList == null || inf29IdList.Count == 0))
        {
            return;
        }
        if (inf29IdList != null && inf29IdList.Count > 0)
        {
            var printRows = PrintRow.GetPrintRows(inf29IdList);
            PrintHelper.StartPrint(printBcode == null ? "" : printBcode.cnf0703_bfname, printRows, tmpFile);
        }
        var filePath = Path.Combine(Path.GetTempPath() + @"PrintFileTemp\", tmpFile);
        if (!File.Exists(filePath))
        {
            context.Response.StatusCode = (int) HttpStatusCode.NotFound;
            return;
        }
        context.Response.ContentType = "application/pdf";
        context.Response.TransmitFile(Path.Combine(Path.GetTempPath() + @"PrintFileTemp\", tmpFile));
        // 刪除已輸出的檔案
        Task.Delay(30000).ContinueWith(task =>
            {
                try
                {
                    FileInfo removeFile = new FileInfo(Path.Combine(Path.GetTempPath() + @"PrintFileTemp\", tmpFile));
                    if (removeFile.Exists)
                    {
                        removeFile.Delete();
                    }
                    DirectoryInfo tempDir = new DirectoryInfo(Path.GetTempPath());
                    var oldFiles = tempDir.GetFiles().Where(o => (DateTime.Now - o.CreationTime).Days > 1);
                    foreach (FileInfo oldFile in oldFiles)
                    {
                        oldFile.Delete();
                    }
                }
                catch
                {
                }
            });
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}