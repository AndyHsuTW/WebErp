<%@ WebHandler Language="C#" Class="Inf20Print" %>

using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using System.Web;
using Dinp02301;
using ErpBaseLibrary.DB;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.pdf.draw;

public class Inf20Print : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        Cnf07 printBcode = context.Session["printBcode"] as Cnf07;
        List<int> inf20IdList = context.Session["printItems"] as List<int>;
        var tmpFile = context.Request.QueryString["session"];

        context.Session.Remove("printBcode");
        context.Session.Remove("printItems");

        if (String.IsNullOrEmpty(tmpFile) && (inf20IdList == null || inf20IdList.Count == 0))
        {
            return;
        }
        if (inf20IdList != null && inf20IdList.Count > 0)
        {
            var printRows = GetPrintRows(inf20IdList);
            StartPrint(printBcode == null ? "" : printBcode.cnf0703_bfname, printRows, tmpFile);
        }
        var filePath = Path.Combine(Path.GetTempPath() + @"PrintFileTemp\", tmpFile);
        if (!File.Exists(filePath))
        {
            context.Response.StatusCode = (int)HttpStatusCode.NotFound;
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

    public static void StartPrint(string title, List<PrintRow> printRows, string tmpFile)
    {
        iTextSharp.text.io.StreamUtil.AddToResourceSearch(System.Reflection.Assembly.Load("iTextAsian"));
        var baseFont = BaseFont.CreateFont("MHei-Medium", "UniCNS-UCS2-H", BaseFont.NOT_EMBEDDED);
        var headFont = new Font(baseFont, 14);
        var contentFont = new Font(baseFont, 9);
        var doc = new Document(PageSize.A4);
        if (!Directory.Exists(Path.GetTempPath() + @"PrintFileTemp\"))
        {
            Directory.CreateDirectory(Path.GetTempPath() + @"PrintFileTemp\");
        }
        var output = new FileStream(Path.Combine(Path.GetTempPath() + @"PrintFileTemp\", tmpFile), FileMode.Create);
        var writer = PdfWriter.GetInstance(doc, output);
        PrintHeaderFooter pageEventHandler = new PrintHeaderFooter();
        pageEventHandler.Title = !String.IsNullOrEmpty(title) ? title : " ";
        pageEventHandler.ProgramCode = "Dinp02001";
        pageEventHandler.ReportCode = "Dinp02001r";

        writer.PageEvent = pageEventHandler;
        doc.SetMargins(36, 36, 36 + 14 * 4, 36);

        doc.Open();
        PdfPTable contentTable = new PdfPTable(pageEventHandler.FieldList1.Length);
        contentTable.WidthPercentage = 100;
        contentTable.SetWidths(pageEventHandler.FieldList1.Select(o => (float)o.Length).ToArray());
        for (int i = 0; i < printRows.Count; i++)
        {
            var printRow = printRows[i];
            PdfPCell inf20a01_docno = new PdfPCell(new Phrase(printRow.inf20a01_docno, contentFont));
            inf20a01_docno.Border = Rectangle.NO_BORDER;
            contentTable.AddCell(inf20a01_docno);
            PdfPCell inf2006_bname = new PdfPCell(new Phrase(printRow.inf2006_mcode + "/" + printRow.inf2006_bname, contentFont));
            inf2006_bname.Border = Rectangle.NO_BORDER;
            contentTable.AddCell(inf2006_bname);
            PdfPCell inf20a31_true_date = new PdfPCell(new Phrase(Convert.ToDateTime(printRow.inf20a31_true_date).ToString("yyyy/MM/dd"), contentFont));
            inf20a31_true_date.Border = Rectangle.NO_BORDER;
            contentTable.AddCell(inf20a31_true_date);
            PdfPCell inf20a04_pcode = new PdfPCell(new Phrase((printRow.inf20a04_pcode == "" ? printRow.inf20a04_shoes_code : printRow.inf20a04_pcode), contentFont));
            inf20a04_pcode.Border = Rectangle.NO_BORDER;
            contentTable.AddCell(inf20a04_pcode);
            PdfPCell inf20a38_product_name = new PdfPCell(new Phrase(printRow.inf20a38_product_name, contentFont));
            inf20a38_product_name.Border = Rectangle.NO_BORDER;
            contentTable.AddCell(inf20a38_product_name);
            PdfPCell inf20a16_punit = new PdfPCell(new Phrase(printRow.inf20a16_punit, contentFont));
            inf20a16_punit.Border = Rectangle.NO_BORDER;
            contentTable.AddCell(inf20a16_punit);
            PdfPCell inf2053_account_type = new PdfPCell(new Phrase(printRow.inf2053_account_type, contentFont));
            inf2053_account_type.Border = Rectangle.NO_BORDER;
            inf2053_account_type.HorizontalAlignment = Element.ALIGN_RIGHT;
            contentTable.AddCell(inf2053_account_type);
            PdfPCell inf20a06_qty = new PdfPCell(new Phrase(printRow.inf20a06_qty, contentFont));
            inf20a06_qty.Border = Rectangle.NO_BORDER;
            inf20a06_qty.HorizontalAlignment = Element.ALIGN_RIGHT;
            contentTable.AddCell(inf20a06_qty);
            PdfPCell inf20a12_dis_qty = new PdfPCell(new Phrase(printRow.inf20a12_dis_qty, contentFont));
            inf20a12_dis_qty.Border = Rectangle.NO_BORDER;
            inf20a12_dis_qty.HorizontalAlignment = Element.ALIGN_RIGHT;
            contentTable.AddCell(inf20a12_dis_qty);
            PdfPCell inf20a07_ocost = new PdfPCell(new Phrase(printRow.inf20a07_ocost, contentFont));
            inf20a07_ocost.Border = Rectangle.NO_BORDER;
            inf20a07_ocost.HorizontalAlignment = Element.ALIGN_RIGHT;
            contentTable.AddCell(inf20a07_ocost);
            PdfPCell inf20a58_cost_notax = new PdfPCell(new Phrase(printRow.inf20a58_cost_notax, contentFont));
            inf20a58_cost_notax.Border = Rectangle.NO_BORDER;
            inf20a58_cost_notax.HorizontalAlignment = Element.ALIGN_RIGHT;
            
            PdfPCell inf20a40_one_amt = new PdfPCell(new Phrase(printRow.inf20a40_one_amt, contentFont));
            inf20a40_one_amt.Border = Rectangle.NO_BORDER;
            inf20a40_one_amt.HorizontalAlignment = Element.ALIGN_RIGHT;
            
            contentTable.AddCell(inf20a40_one_amt);
        }
        
            doc.Add(contentTable);

            //DottedLineSeparator separator = new DottedLineSeparator();
            //separator.Gap = 2f;
            //doc.Add(separator);

            //PdfPTable summaryTable = new PdfPTable(8);
            //summaryTable.WidthPercentage = 100;

            //PdfPCell costSumTitleCell = new PdfPCell(new Phrase("進價總額:", contentFont));
            //costSumTitleCell.Border = Rectangle.NO_BORDER;
            //costSumTitleCell.HorizontalAlignment = Element.ALIGN_LEFT;
            //summaryTable.AddCell(costSumTitleCell);
            //PdfPCell costSumCell = new PdfPCell(new Phrase(printRows.Sum(o=>o.inf20a07_ocost).ToString("0"), contentFont));
            //costSumCell.Border = Rectangle.NO_BORDER;
            //costSumCell.HorizontalAlignment = Element.ALIGN_CENTER;
            //summaryTable.AddCell(costSumCell);
            //PdfPCell retailSumTitleCell = new PdfPCell(new Phrase("售價總額:", contentFont));
            //retailSumTitleCell.Border = Rectangle.NO_BORDER;
            //retailSumTitleCell.HorizontalAlignment = Element.ALIGN_CENTER;
            //summaryTable.AddCell(retailSumTitleCell);
            //PdfPCell retailSumCell = new PdfPCell(new Phrase(printRows.Sum(o => o.inf29a09_oretail_one).ToString("0"), contentFont));
            //retailSumCell.Border = Rectangle.NO_BORDER;
            //retailSumCell.HorizontalAlignment = Element.ALIGN_CENTER;
            //summaryTable.AddCell(retailSumCell);
            //PdfPCell priceSumTitleCell = new PdfPCell(new Phrase("單價總額:", contentFont));
            //priceSumTitleCell.Border = Rectangle.NO_BORDER;
            //priceSumTitleCell.HorizontalAlignment = Element.ALIGN_CENTER;
            //summaryTable.AddCell(priceSumTitleCell);
            //PdfPCell priceSumCell =
            //    new PdfPCell(
            //        new Phrase(
            //            printRows.Sum(o => Convert.ToDouble(o.inf29a39_price == "" ? "0" : o.inf29a39_price))
            //                     .ToString("0"), contentFont));
            //priceSumCell.Border = Rectangle.NO_BORDER;
            //priceSumCell.HorizontalAlignment = Element.ALIGN_CENTER;
            //summaryTable.AddCell(priceSumCell);
            //PdfPCell qtySumTitleCell = new PdfPCell(new Phrase("筆數:", contentFont));
            //qtySumTitleCell.Border = Rectangle.NO_BORDER;
            //qtySumTitleCell.HorizontalAlignment = Element.ALIGN_CENTER;
            //summaryTable.AddCell(qtySumTitleCell);
            //PdfPCell qtySumCell =
            //    new PdfPCell(new Phrase(Convert.ToString(printRows.Sum(o => (int) o.inf29a13_sold_qty)), contentFont));
            //qtySumCell.Border = Rectangle.NO_BORDER;
            //qtySumCell.HorizontalAlignment = Element.ALIGN_CENTER;
            //summaryTable.AddCell(qtySumCell);
            //doc.Add(summaryTable);
            
            doc.Close();
        
    }
    
    
    private class PrintHeaderFooter : PdfPageEventHelper
    {
        public string Title { get; set; }
        public string ProgramCode { get; set; }
        public string ReportCode { get; set; }
        public DateTime PrintTime { get; set; }

        public string[] FieldList1 = new string[] { "單據編號", "廠商代號/簡稱", "進貨日期", "商品條碼", "商品名稱", "付款別", "單位", "稅別", "進貨量", "贈品量", "含稅進價", "未稅進價", "金額小計" };

        private PdfContentByte _pdfContent;
        private BaseFont _baseFont;
        private Font _headFont;
        private Font _contentFont;

        public override void OnOpenDocument(PdfWriter writer, Document document)
        {
            try
            {
                _pdfContent = writer.DirectContent;
                iTextSharp.text.io.StreamUtil.AddToResourceSearch(System.Reflection.Assembly.Load("iTextAsian"));
                _baseFont = BaseFont.CreateFont("MHei-Medium", "UniCNS-UCS2-H", BaseFont.NOT_EMBEDDED);
                _headFont = new Font(_baseFont, 14);
                _contentFont = new Font(_baseFont, 9);

                PrintTime = DateTime.Now;
            }
            catch (DocumentException de)
            {
            }
            catch (System.IO.IOException ioe)
            {
            }
        }

        public override void OnEndPage(PdfWriter writer, Document document)
        {
            base.OnEndPage(writer, document);
            // 列印每頁都固定顯示的頁首
            int pageNo = writer.PageNumber;
            Rectangle pageSize = document.PageSize;
            float headerHeight = 0;

            // 頁首:公司名稱
            PdfPTable titleTable = new PdfPTable(1);
            titleTable.TotalWidth = pageSize.Width - document.LeftMargin - document.RightMargin;
            titleTable.ExtendLastRow = false;
            PdfPCell titleCell = new PdfPCell(new Phrase(this.Title, _headFont));
            titleCell.Border = Rectangle.NO_BORDER;
            titleCell.HorizontalAlignment = Element.ALIGN_CENTER;
            titleTable.AddCell(titleCell);
            titleTable.WriteSelectedRows(0, -1, pageSize.GetLeft(document.LeftMargin),
                                         pageSize.GetTop(36), _pdfContent);
            //            titleTable.CalculateHeights();
            headerHeight += titleTable.TotalHeight;

            // 頁首:程式代號 + 頁次
            PdfPTable headTable = new PdfPTable(2);
            headTable.TotalWidth = pageSize.Width - document.LeftMargin - document.RightMargin;
            headTable.SetWidths(new float[] { 8, 2 });
            headTable.ExtendLastRow = false;
            PdfPCell programCodeCell = new PdfPCell(new Phrase("程式代號:" + ProgramCode, _contentFont));
            programCodeCell.Border = Rectangle.NO_BORDER;
            programCodeCell.HorizontalAlignment = Element.ALIGN_LEFT;
            headTable.AddCell(programCodeCell);

            PdfPCell pageNumCell = new PdfPCell(new Phrase("頁次:" + pageNo, _contentFont));
            pageNumCell.Border = Rectangle.NO_BORDER;
            pageNumCell.HorizontalAlignment = Element.ALIGN_LEFT;
            headTable.AddCell(pageNumCell);

            // 頁首:報表代號 + 列印日期
            PdfPCell reportCodeCell = new PdfPCell(new Phrase("報表代號:" + ReportCode, _contentFont));
            reportCodeCell.Border = Rectangle.NO_BORDER;
            reportCodeCell.HorizontalAlignment = Element.ALIGN_LEFT;
            headTable.AddCell(reportCodeCell);

            PdfPCell dateCell = new PdfPCell(new Phrase("列印日期:" + PrintTime.ToString("yyyy/MM/dd"), _contentFont));
            dateCell.Border = Rectangle.NO_BORDER;
            dateCell.HorizontalAlignment = Element.ALIGN_LEFT;
            headTable.AddCell(dateCell);

            headTable.WriteSelectedRows(0, -1, pageSize.GetLeft(document.LeftMargin),
                                        pageSize.GetTop(36 + headerHeight),
                                        _pdfContent);
            headerHeight += headTable.TotalHeight;
            //頁首: 輸出inf29報表各欄位
            PdfPTable fieldsTable = new PdfPTable(FieldList1.Length);
            fieldsTable.TotalWidth = pageSize.Width - document.LeftMargin - document.RightMargin;

            fieldsTable.SetWidths(FieldList1.Select(o => (float)o.Length).ToArray());
            fieldsTable.ExtendLastRow = false;

            for (int i = 0; i < FieldList1.Length; i++)
            {
                PdfPCell fieldCell = new PdfPCell(new Phrase(FieldList1[i], _contentFont));
                fieldCell.Border = Rectangle.BOTTOM_BORDER;
                fieldCell.HorizontalAlignment = Element.ALIGN_CENTER;
                fieldsTable.AddCell(fieldCell);
            }
            //for (int i = 0; i < FieldList2.Length; i++)
            //{
            //    PdfPCell fieldCell = new PdfPCell(new Phrase(FieldList2[i], _contentFont));
            //    fieldCell.Border = Rectangle.BOTTOM_BORDER;
            //    fieldCell.HorizontalAlignment = Element.ALIGN_CENTER;
            //    fieldsTable.AddCell(fieldCell);
            //}
            fieldsTable.WriteSelectedRows(0, -1, pageSize.GetLeft(document.LeftMargin),
                                        pageSize.GetTop(36 + headerHeight), _pdfContent);
            headerHeight += fieldsTable.TotalHeight;

        }
    }
    public List<PrintRow> GetPrintRows(List<int> idList)
    {
        var inf20IdList = idList;
        var printRows = new List<PrintRow>();
        using (var conn = new SqlConnection(MyConnStringList.AzureGoodeasy))
        {
            conn.Open();
            var cmd = conn.CreateCommand();
            cmd.CommandText = String.Format(@"
            select 
                * 
            from dbo.inf20 
            LEFT JOIN dbo.inf29
                ON inf29.inf2001_docno = inf29a.inf20a01_docno
            where inf20a01_docno in (
                SELECT 
                    inf2001_docno
                FROM inf20
                WHERE id IN({0})
            )", string.Join(",", inf20IdList));
            using (var rd = cmd.ExecuteReader())
            {
                if (rd.Read())
                {
                    while (rd.Read())
                    {
                        var printRow = new PrintRow();

                        printRow.inf20a01_docno = rd["inf20a01_docno"].ToString();
                        printRow.inf2006_mcode = rd["inf2006_mcode"].ToString();
                        printRow.inf2006_bname = rd["inf2006_bname"].ToString();
                        printRow.inf20a07_ocost = rd["inf20a07_ocost"].ToString();
                        printRow.inf20a58_cost_notax = rd["inf20a58_cost_notax"].ToString();
                        printRow.inf20a38_product_name = rd["inf20a38_product_name"].ToString();
                        printRow.inf20a04_pcode = rd["inf20a04_pcode"].ToString();
                        printRow.inf20a04_shoes_code = rd["inf20a04_shoes_code"].ToString();
                        printRow.inf2053_account_type = rd["inf2053_account_type"].ToString();
                        printRow.inf20a30_allow_date = rd["inf20a30_allow_date"].ToString();
                        printRow.inf20a31_true_date = rd["inf20a31_true_date"].ToString();
                        printRow.inf20a12_dis_qty = rd["inf20a12_dis_qty"].ToString();
                        printRow.inf20a13_r_dis_qty = rd["inf20a13_r_dis_qty"].ToString();
                        printRow.inf20a40_one_amt = rd["inf20a40_one_amt"].ToString();
                        printRow.inf20a01_docno = rd["inf20a01_docno"].ToString();
                        printRows.Add(printRow);
                    }
                }
            }


        }

        return printRows;
    }

    public class PrintRow
    {
        /// <summary>
        /// 單據編號
        /// </summary>
        public string inf20a01_docno { get; set; }
        /// <summary>
        /// 廠商代碼
        /// </summary>
        public string inf2006_mcode { get; set; }

        /// <summary>
        /// 廠商簡稱
        /// </summary>
        public string inf2006_bname { get; set; }

        /// <summary>
        /// 原幣值進價;含稅進(單)價
        /// </summary>
        public string inf20a07_ocost { get; set; }

        /// <summary>
        /// 未稅進價
        /// </summary>
        public string inf20a58_cost_notax { get; set; }

        /// <summary>
        /// 品名
        /// </summary>
        public string inf20a38_product_name { get; set; }
        /// <summary>
        /// 商品條碼
        /// </summary>
        public string inf20a04_pcode { get; set; }
        /// <summary>
        /// 鞋型代號
        /// </summary>
        public string inf20a04_shoes_code { get; set; }
        /// <summary>
        /// 付款別
        /// </summary>
        public string inf2053_account_type { get; set; }

        /// <summary>
        /// 預交日期
        /// </summary>
        public string inf20a30_allow_date { get; set; }
        /// <summary>
        /// 實際到貨日期
        /// </summary>
        public string inf20a31_true_date { get; set; }
        /// <summary>
        /// 需贈量
        /// </summary>
        public string inf20a12_dis_qty { get; set; }
        /// <summary>
        /// 已贈量
        /// </summary>
        public string inf20a13_r_dis_qty { get; set; }
        /// <summary>
        /// 小計金額
        /// </summary>
        public string inf20a40_one_amt { get; set; }

        /// <summary>
        /// 採購種類;1=含稅,其他都是未稅
        /// </summary>
        public string inf2036_code { get; set; }

        /// <summary>
        /// 進貨單位
        /// </summary>
        public string inf20a16_punit { get; set; }
        /// <summary>
        /// 訂購數量
        /// </summary>
        public string inf20a06_qty { get; set; }
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}