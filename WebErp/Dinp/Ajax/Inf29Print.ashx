<%@ WebHandler Language="C#" Class="Inf29Print" %>

using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.SessionState;
using DCNP005;
using Dinp02301;
using Dinp02301.Print;
using iTextSharp.text;
using iTextSharp.text.pdf;

public class Inf29Print : IHttpHandler, IRequiresSessionState
{
    
    public void ProcessRequest (HttpContext context)
    {
        Cnf07 printBcode = context.Session["printBcode"] as Cnf07;
        List<int> inf29IdList = context.Session["printItems"] as List<int>;

//        context.Session.Remove("printBcode");
//        context.Session.Remove("printItems");
        
        if (inf29IdList == null || inf29IdList.Count == 0)
        {
            return;
        }

        var printRows = PrintRow.GetPrintRows(inf29IdList);
        var printData = PrintHelper.StartPrint(printBcode, printRows);

        context.Response.ContentType = "application/pdf";
        context.Response.OutputStream.Write(printData, 0, (int)printData.Length);
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}