<%@ WebHandler Language="C#" Class="ImportExcels" %>

using System;
using System.Web;
using System.IO;
using OfficeOpenXml;
using OfficeOpenXml.Style;
using System.Collections.Generic;
public class ImportExcels : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        // context.Response.Write("Hello World");

     
        Uploadfile(context);

    }


    public void Uploadfile(HttpContext context)
    {
        var DateTime = context.Request.QueryString["DateTime"];
        HttpFileCollection files = context.Request.Files;
        //建立uploads資料夾
        var uploadsRoot = context.Server.MapPath("~/Dsap92501/uploads/");
        var uploadsDirectory = uploadsRoot + DateTime.Replace("/", string.Empty);
        if (Directory.Exists(uploadsDirectory))
        {
            string[] oldfiles = Directory.GetFiles(uploadsDirectory);
            foreach (string file in oldfiles)
            {
                File.Delete(file);
            }
            Directory.Delete(uploadsDirectory);
        }

        Directory.CreateDirectory(uploadsDirectory);

        //建立convert資料夾
        var convertRoot = context.Server.MapPath("~/Dsap92501/convert/");
        var convertDirectory = convertRoot + DateTime.Replace("/", string.Empty);
        if (Directory.Exists(convertDirectory))
        {
            string[] oldfiles = Directory.GetFiles(convertDirectory);
            foreach (string file in oldfiles)
            {
                File.Delete(file);
            }
            Directory.Delete(convertDirectory);
        }
        Directory.CreateDirectory(convertDirectory);



        for (int i = 0; i < files.Count; i++)
        {
            HttpPostedFile file = files[i];


            var uploadsPath = uploadsDirectory + "\\" + file.FileName;



            file.SaveAs(uploadsPath);
            var excelTextFormat = new ExcelTextFormat();
            bool firstRowIsHeader = false;
            excelTextFormat.Delimiter = ',';
            excelTextFormat.EOL = "\r";

            if (file.FileName.ToLower().IndexOf(".xlsx") > -1)
            {
                file.SaveAs(convertDirectory + "\\" + file.FileName);

            }
            else if (file.FileName.ToLower().IndexOf(".csv") > -1)
            {
                //避免編碼問題
                var str = File.ReadAllText(uploadsPath, System.Text.Encoding.Default);
                File.WriteAllText(uploadsPath, str, System.Text.Encoding.BigEndianUnicode);
                
                
                var csvFileInfo = new FileInfo(uploadsPath);
                var excelFileInfo = new FileInfo(convertDirectory + "\\" + file.FileName.Replace(".csv", ".xlsx"));
                using (ExcelPackage package = new ExcelPackage(excelFileInfo))
                {
                    ExcelWorksheet worksheet = package.Workbook.Worksheets.Add("sheet");
                    worksheet.Cells["A1"].LoadFromText(csvFileInfo, excelTextFormat, OfficeOpenXml.Table.TableStyles.None, firstRowIsHeader);
                    package.Save();
                }
            }
            else if (file.FileName.ToLower().IndexOf(".xls") > -1)
            {
                var xlsFileInfo = new FileInfo(uploadsPath);
                var excelFileInfo = new FileInfo(convertDirectory + "\\" + file.FileName.Replace(".xls", ".xlsx"));
                using (ExcelPackage package = new ExcelPackage(excelFileInfo))
                {
                    ExcelWorksheet worksheet = package.Workbook.Worksheets.Add("sheet");
                    worksheet.Cells["A1"].LoadFromText(xlsFileInfo, excelTextFormat, OfficeOpenXml.Table.TableStyles.None, firstRowIsHeader);
                    package.Save();
                }
            }

        }




    }
    
    public class saf25FileInfo
    {
        public string FileName { get; set; }
        public string CompanyName { get; set; }
        public List<saf25> saf25 = new List<saf25>();


    }

    public class ErrorInfo
    {
        public string column { get; set; }
        public string messenge { get; set; }
    }

    public class saf25
    {
        public string saf2501_cuscode { get; set; }//客戶代號
        public string saf2502_seq { get; set; }//檔號
        public string saf2503_ord_no { get; set; }//訂單編號
        public string saf2504_ord_date { get; set; }//訂單日期
        public string saf2505_ord_remark { get; set; }//訂單備註
        public string saf2506_ord_status { get; set; }//訂單狀態
        public string saf2507_ord_class { get; set; }//訂單類別
        public string saf2508_ord_plan { get; set; }//訂購方案
        public string saf2509_ord_shop { get; set; }//訂單館別
        public string saf2510_ord_name { get; set; }//訂購人姓名
        public string saf2511_ord_cell { get; set; }//訂購人手機
        public string saf2512_ord_tel01 { get; set; }//訂購人電話1
        public string saf2513_ord_tel02 { get; set; }//訂購人電話2
        public string saf2514_rec_name { get; set; }//收件人姓名
        public string saf2515_rec_cell { get; set; }//收件人手機
        public string saf2516_rec_tel01 { get; set; }//收件人電話1
        public string saf2517_rec_tel02 { get; set; }//收件人電話2
        public string saf2518_rec_zip { get; set; }//收件人郵遞區號
        public string saf2519_rec_address { get; set; }//收件人地址
        public string saf2520_dis_date { get; set; }//約定配送日
        public string saf2521_dis_time { get; set; }//配送時段
        public string saf2522_dis_demand { get; set; }//客戶配送需求
        public string saf2523_ship_date { get; set; }//出貨日期
        public string saf2524_ship_remark { get; set; }//出貨備註
        public string saf2525_ship_condi { get; set; }//出貨條件
        public string saf2526_ship_status { get; set; }//出貨狀態
        public string saf2527_ship_no { get; set; }//出貨單號
        public string saf2528_fre_no { get; set; }//貨運單號
        public string saf2529_logis_no { get; set; }//物流代號
        public string saf2530_logis_comp { get; set; }//物流公司名稱
        public string saf2531_psname { get; set; }//商品名稱
        public string saf2532_pname { get; set; }//品項規格
        public string saf2533_pspec { get; set; }//品號
        public string saf2534_ship_pname { get; set; }//應出貨品項規格
        public string saf2535_ptpye { get; set; }//商品類型
        public string saf2536_pcode_v { get; set; }//商品原廠編號
        public string saf2537_pcode { get; set; }//單名編號
        public string saf2538_inv_no { get; set; }//發票號碼
        public string saf2539_inv_date { get; set; }//發票日期
        public string saf2540_ship_qty { get; set; }//應出貨數
        public string saf2541_ord_qty { get; set; }//數量
        public string saf2542_groups { get; set; }//組數
        public string saf2543_cancel_qty { get; set; }//取消數量
        public string saf2544_cost { get; set; }//進價(含稅)
        public string saf2545_cost_sub { get; set; }//成本小計
        public string saf2546_mana_fee { get; set; }//運費/管理費
        public string saf2547_price { get; set; }//單價(售價)
        public string saf2548_price_sub { get; set; }//金額小計
        public string saf2549_paymt_date { get; set; }//付款時間
        public string saf2550_paymt_way { get; set; }//付款方式
        public string saf2551_paymt_status { get; set; }//付款狀態
        public string saf2552_return { get; set; }//退貨管理
        public string saf2553_gifts { get; set; }//贈品
        public string saf2554_identifier { get; set; }//個人識別碼
        public string saf2555_chg_price { get; set; }//群組變價商品
        public string saf2556_leave_msg { get; set; }//客戶留言
        public string saf2557_open_no { get; set; }//拆單編號
        public string saf2558_trans_yn { get; set; }//是否轉檔
        public string saf2559_option_case { get; set; }//任選案件
        public string saf2560_unit { get; set; }//單位
        public string saf2561_option { get; set; }//選項
        public string saf2562_warehs_date { get; set; }//預計入庫日期
        public string saf2563_county { get; set; }//縣市別
        public string saf2564_post_box { get; set; }//郵政信箱
        public string saf2565_chg_notes { get; set; }//換貨註記
        public string saf2566_warm { get; set; }//溫層
        public string saf2567_carton_spec { get; set; }//外箱規格
        public string saf2568_vendor_no { get; set; }//廠商廠編
        public string saf2569_vendor_name { get; set; }//廠商簡稱
        public string saf2570_activity { get; set; }//搭配活動


    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}