using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.pdf.draw;

namespace Dinp02401.Print
{
    public class PrintHelper
    {
        /// <summary>
        /// Output printable file to the path of tmpFile. 
        /// </summary>
        /// <param name="title"></param>
        /// <param name="printRows"></param>
        /// <param name="tmpFile"></param>
        public static void StartPrint(string title, List<PrintRow> printRows,string tmpFile)
        {
            iTextSharp.text.io.StreamUtil.AddToResourceSearch(System.Reflection.Assembly.Load("iTextAsian"));
            BaseFont baseFont = BaseFont.CreateFont("MHei-Medium", "UniCNS-UCS2-H", BaseFont.NOT_EMBEDDED);
            Font headFont = new Font(baseFont, 14);
            Font contentFont = new Font(baseFont, 9);

            Document doc = new Document(PageSize.A4);
            if (!Directory.Exists(Path.GetTempPath() + @"PrintFileTemp\"))
            {
                Directory.CreateDirectory(Path.GetTempPath() + @"PrintFileTemp\");
            }
            var output = new FileStream(Path.Combine(Path.GetTempPath() + @"PrintFileTemp\", tmpFile), FileMode.Create);
            var writer = PdfWriter.GetInstance(doc, output);

            PrintHeaderFooter pageEventHandler = new PrintHeaderFooter();
            pageEventHandler.Title = !String.IsNullOrEmpty(title) ? title : " ";
            pageEventHandler.ProgramCode = "Dinp02401";
            pageEventHandler.ReportCode = "Dinp02401r";

            writer.PageEvent = pageEventHandler;
            doc.SetMargins(36, 36, 36 + 14 * 4, 36);

            doc.Open();

            PdfPTable contentTable = new PdfPTable(pageEventHandler.FieldList1.Length);
            contentTable.WidthPercentage = 100;
            contentTable.SetWidths(pageEventHandler.FieldList1.Select(o => (float)o.Length).ToArray());

            for (int i = 0; i < printRows.Count; i++)
            {
                var printRow = printRows[i];
                PdfPCell pcodeCell = new PdfPCell(new Phrase(printRow.inf29a05_pcode, contentFont));
                pcodeCell.Border = Rectangle.NO_BORDER;
                contentTable.AddCell(pcodeCell);
                PdfPCell productNameCell = new PdfPCell(new Phrase(printRow.inf29a33_product_name, contentFont));
                productNameCell.Border = Rectangle.NO_BORDER;
                contentTable.AddCell(productNameCell);
                PdfPCell unitCell = new PdfPCell(new Phrase(printRow.inf29a17_runit, contentFont));
                unitCell.Border = Rectangle.NO_BORDER;
                contentTable.AddCell(unitCell);
                PdfPCell customCodeNameCell = new PdfPCell(new Phrase(printRow.Inf2903CustomerCodeName, contentFont));
                customCodeNameCell.Border = Rectangle.NO_BORDER;
                contentTable.AddCell(customCodeNameCell);
                PdfPCell inReasonCell = new PdfPCell(new Phrase(printRow.Inf2910InReasonName, contentFont));
                inReasonCell.Border = Rectangle.NO_BORDER;
                contentTable.AddCell(inReasonCell);
                PdfPCell proDateCell = new PdfPCell(new Phrase(printRow.inf2904_pro_date.ToString("yyyy/MM/dd"), contentFont));
                proDateCell.Border = Rectangle.NO_BORDER;
                contentTable.AddCell(proDateCell);
                PdfPCell priceCell = new PdfPCell(new Phrase(printRow.inf29a39_price, contentFont));
                priceCell.Border = Rectangle.NO_BORDER;
                priceCell.HorizontalAlignment = Element.ALIGN_RIGHT;
                contentTable.AddCell(priceCell);
                PdfPCell costCell = new PdfPCell(new Phrase(printRow.inf29a10_ocost_one.ToString("0.00"), contentFont));
                costCell.Border = Rectangle.NO_BORDER;
                costCell.HorizontalAlignment = Element.ALIGN_RIGHT;
                contentTable.AddCell(costCell);
                PdfPCell retailCell = new PdfPCell(new Phrase(printRow.inf29a09_oretail_one.ToString("0"), contentFont));
                retailCell.Border = Rectangle.NO_BORDER;
                retailCell.HorizontalAlignment = Element.ALIGN_RIGHT;
                contentTable.AddCell(retailCell);
                PdfPCell qtyCell = new PdfPCell(new Phrase(printRow.inf29a13_sold_qty.ToString("0"), contentFont));
                qtyCell.Border = Rectangle.NO_BORDER;
                qtyCell.HorizontalAlignment = Element.ALIGN_RIGHT;
                contentTable.AddCell(qtyCell);
                PdfPCell totalPriceCell = new PdfPCell(new Phrase(printRow.TotalPrice.ToString("0"), contentFont));
                totalPriceCell.Border = Rectangle.NO_BORDER;
                totalPriceCell.HorizontalAlignment = Element.ALIGN_RIGHT;
                contentTable.AddCell(totalPriceCell);
            }
            doc.Add(contentTable);

            DottedLineSeparator separator = new DottedLineSeparator();
            separator.Gap = 2f;
            doc.Add(separator);

            PdfPTable summaryTable = new PdfPTable(8);
            summaryTable.WidthPercentage = 100;

            PdfPCell costSumTitleCell = new PdfPCell(new Phrase("進價總額:", contentFont));
            costSumTitleCell.Border = Rectangle.NO_BORDER;
            costSumTitleCell.HorizontalAlignment = Element.ALIGN_LEFT;
            summaryTable.AddCell(costSumTitleCell);
            PdfPCell costSumCell = new PdfPCell(new Phrase(printRows.Sum(o=>o.inf29a10_ocost_one).ToString("0"), contentFont));
            costSumCell.Border = Rectangle.NO_BORDER;
            costSumCell.HorizontalAlignment = Element.ALIGN_CENTER;
            summaryTable.AddCell(costSumCell);
            PdfPCell retailSumTitleCell = new PdfPCell(new Phrase("售價總額:", contentFont));
            retailSumTitleCell.Border = Rectangle.NO_BORDER;
            retailSumTitleCell.HorizontalAlignment = Element.ALIGN_CENTER;
            summaryTable.AddCell(retailSumTitleCell);
            PdfPCell retailSumCell = new PdfPCell(new Phrase(printRows.Sum(o => o.inf29a09_oretail_one).ToString("0"), contentFont));
            retailSumCell.Border = Rectangle.NO_BORDER;
            retailSumCell.HorizontalAlignment = Element.ALIGN_CENTER;
            summaryTable.AddCell(retailSumCell);
            PdfPCell priceSumTitleCell = new PdfPCell(new Phrase("單價總額:", contentFont));
            priceSumTitleCell.Border = Rectangle.NO_BORDER;
            priceSumTitleCell.HorizontalAlignment = Element.ALIGN_CENTER;
            summaryTable.AddCell(priceSumTitleCell);
            PdfPCell priceSumCell =
                new PdfPCell(
                    new Phrase(
                        printRows.Sum(o => Convert.ToDouble(o.inf29a39_price == "" ? "0" : o.inf29a39_price))
                                 .ToString("0"), contentFont));
            priceSumCell.Border = Rectangle.NO_BORDER;
            priceSumCell.HorizontalAlignment = Element.ALIGN_CENTER;
            summaryTable.AddCell(priceSumCell);
            PdfPCell qtySumTitleCell = new PdfPCell(new Phrase("筆數:", contentFont));
            qtySumTitleCell.Border = Rectangle.NO_BORDER;
            qtySumTitleCell.HorizontalAlignment = Element.ALIGN_CENTER;
            summaryTable.AddCell(qtySumTitleCell);
            PdfPCell qtySumCell =
                new PdfPCell(new Phrase(Convert.ToString(printRows.Sum(o => (int) o.inf29a13_sold_qty)), contentFont));
            qtySumCell.Border = Rectangle.NO_BORDER;
            qtySumCell.HorizontalAlignment = Element.ALIGN_CENTER;
            summaryTable.AddCell(qtySumCell);
            doc.Add(summaryTable);
            
            doc.Close();
        }

        private class PrintHeaderFooter : PdfPageEventHelper
        {
            public string Title { get; set; }
            public string ProgramCode { get; set; }
            public string ReportCode { get; set; }
            public DateTime PrintTime { get; set; }

            public string[] FieldList1 = new string[] { " 商品編號 ", " 產品名稱 ", "單位", "異動單位", " 異動原因 ", "異動日期", "單價", "原進價", "售價", "數量", "總 價" };

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
    }
}
