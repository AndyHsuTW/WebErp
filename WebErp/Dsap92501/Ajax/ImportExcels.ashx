<%@ WebHandler Language="C#" Class="ImportExcels" %>

using System;
using System.Web;
using System.IO;
using OfficeOpenXml;
using OfficeOpenXml.Style;
using System.Collections.Generic;
using System.Text;
using System.Linq;
using System.Globalization;
using Newtonsoft.Json;
using System.Text.RegularExpressions;
public class ImportExcels : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        // context.Response.Write("Hello World");
        Uploadfile(context);

        var OrderTime = context.Request.QueryString["DateTime"];
        var uploadsRoot = context.Server.MapPath("~/Dsap92501/uploads/");
        var uploadsDirectory = uploadsRoot + OrderTime.Replace("/", string.Empty);
        var saf25FileInfo = new saf25FileInfo();

        HttpPostedFile file = context.Request.Files[0];
        var uploadsPath = uploadsDirectory + "\\" + file.FileName;
        var strFileName = file.FileName;


        if (file.FileName.ToUpper().Contains("MOMO.CSV"))
        {
            //處理CSV欄位的特殊符號
            CSVTool(uploadsPath);
            //CSV物件化
            var rowList = CSVtoObject(uploadsPath);
            //檔案名 跟公司名稱
            saf25FileInfo.FileName = file.FileName;
            saf25FileInfo.CompanyName = "MOMO";
            //物件化的CSV 轉成saf25格式(這裡依照每家的格式自訂義)
            MOMO_csvtosaf25(rowList, saf25FileInfo, OrderTime);
        }
        else if (file.FileName.ToUpper().Contains("PCHOME.CSV"))
        {
            CSVTool(uploadsPath);
            var rowList = CSVtoObject(uploadsPath);
            saf25FileInfo.FileName = file.FileName;
            saf25FileInfo.CompanyName = "PChome";
            Pchome_csvtosaf25(rowList, saf25FileInfo, OrderTime);
        }
        else if (strFileName.ToUpper().Contains("YAHOO") && strFileName.ToUpper().Contains(".CSV"))
        {
            CSVTool(uploadsPath);
            var rowList = CSVtoObject(uploadsPath);
            saf25FileInfo.FileName = strFileName;
            saf25FileInfo.CompanyName = "Yahoo";
            Yahoo_csvtosaf25(rowList, saf25FileInfo, OrderTime);
        }
        else if (strFileName.ToUpper().Contains("露天") && strFileName.ToUpper().Contains(".CSV"))
        {
            CSVTool(uploadsPath);
            var rowList = CSVtoObject(uploadsPath);
            saf25FileInfo.FileName = strFileName;
            saf25FileInfo.CompanyName = "露天";
            LuTien_csvtosaf25(rowList, saf25FileInfo, OrderTime);
        }
        else if (strFileName.ToUpper().Contains("聯合報") && strFileName.ToUpper().Contains(".CSV"))
        {
            var rowList = setPreWork(uploadsPath, strFileName, "聯合報", ref saf25FileInfo);
            LienHo_csvtosaf25(rowList, saf25FileInfo, OrderTime);
        }
        else if (strFileName.ToUpper().Contains("興奇") && strFileName.ToUpper().Contains(".CSV"))
        {
            var rowList = setPreWork(uploadsPath, strFileName, "興奇", ref saf25FileInfo);
            ShinQi_csvtosaf25(rowList, saf25FileInfo, OrderTime);
        }
        else if (strFileName.ToUpper().Contains("瘋狂賣客") && strFileName.ToUpper().Contains(".CSV"))
        {
            var rowList = setPreWork(uploadsPath, strFileName, "瘋狂賣客", ref saf25FileInfo);
            Crazy_csvtosaf25(rowList, saf25FileInfo, OrderTime);
        }
        else if (strFileName.ToUpper().Contains("鼎鼎") && strFileName.ToUpper().Contains(".CSV"))
        {
            var rowList = setPreWork(uploadsPath, strFileName, "鼎鼎", ref saf25FileInfo);
            DingDing_csvtosaf25(rowList, saf25FileInfo, OrderTime);
        }
        else if (strFileName.ToUpper().Contains("統一") && strFileName.ToUpper().Contains(".CSV"))
        {
            var rowList = setPreWork(uploadsPath, strFileName, "統一", ref saf25FileInfo);
            UniPresident_csvtosaf25(rowList, saf25FileInfo, OrderTime);
        }
        else if (strFileName.ToUpper().Contains("康迅") && strFileName.ToUpper().Contains(".CSV"))
        {
            var rowList = setPreWork(uploadsPath, strFileName, "康迅", ref saf25FileInfo);
            KS_csvtosaf25(rowList, saf25FileInfo, OrderTime);
        }
        else if (strFileName.ToUpper().Contains("夠麻吉") && strFileName.ToUpper().Contains(".CSV"))
        {
            var rowList = setPreWork(uploadsPath, strFileName, "夠麻吉", ref saf25FileInfo);
            Gomaji_csvtosaf25(rowList, saf25FileInfo, OrderTime);
        }
        else if (strFileName.ToUpper().Contains("神坊") && strFileName.ToUpper().Contains(".CSV"))
        {
            var rowList = setPreWork(uploadsPath, strFileName, "神坊", ref saf25FileInfo);
            ShenFang_csvtosaf25(rowList, saf25FileInfo, OrderTime);
        }
        else if (strFileName.ToUpper().Contains("松果") && strFileName.ToUpper().Contains(".CSV"))
        {
            var rowList = setPreWork(uploadsPath, strFileName, "松果", ref saf25FileInfo);
            SonGuo_csvtosaf25(rowList, saf25FileInfo, OrderTime);
        }
        else if (strFileName.ToUpper().Contains("東森") && strFileName.ToUpper().Contains(".CSV"))
        {
            var rowList = setPreWork(uploadsPath, strFileName, "東森", ref saf25FileInfo);
            ET_csvtosaf25(rowList, saf25FileInfo, OrderTime);
        }
        else if (strFileName.ToUpper().Contains("生活市集") && strFileName.ToUpper().Contains(".CSV"))
        {
            var rowList = setPreWork(uploadsPath, strFileName, "生活市集", ref saf25FileInfo);
            LifeMarket_csvtosaf25(rowList, saf25FileInfo, OrderTime);
        }
        else if (strFileName.ToUpper().Contains("台灣大哥大") && strFileName.ToUpper().Contains(".CSV"))
        {
            var rowList = setPreWork(uploadsPath, strFileName, "台灣大哥大", ref saf25FileInfo);
            TaiwanMobile_csvtosaf25(rowList, saf25FileInfo, OrderTime);
        }
        else if (strFileName.ToUpper().Contains("台塑") && strFileName.ToUpper().Contains(".CSV"))
        {
            var rowList = setPreWork(uploadsPath, strFileName, "台塑", ref saf25FileInfo);
            FormosaPlastics_csvtosaf25(rowList, saf25FileInfo, OrderTime);
        }
        else if (strFileName.ToUpper().Contains("17P") && strFileName.ToUpper().Contains(".CSV"))
        {
            //var rowList = setPreWork(uploadsPath, strFileName, "17P", ref saf25FileInfo);
            //SeventeenP_csvtosaf25(rowList, saf25FileInfo, OrderTime);
        }

        context.Response.Write(JsonConvert.SerializeObject(saf25FileInfo));
    }

    public List<List<string>> setPreWork(string p_uploadsPath,string p_FileName,string p_CompanyName,ref saf25FileInfo p_saf25FileInfo)
    {
        CSVTool(p_uploadsPath);
        var rowList = CSVtoObject(p_uploadsPath);
        p_saf25FileInfo.FileName = p_FileName;
        p_saf25FileInfo.CompanyName = p_CompanyName;
        return rowList;
    }

    public void SeventeenP_csvtosaf25(List<List<string>> rowList, saf25FileInfo saf25FileInfo, string OrderTime)
    {
        for (var j = 0; j < rowList.Count; j++)
        {
            var saf25 = new saf25();
            if (j == 0) continue;//跳過標題

            var row = rowList[j];
            if (string.IsNullOrEmpty(row[1].ToString())) continue;

            for (var k = 0; k < row.Count; k++)
            {
                var column = row[k];
                //A
                if (k == 0)
                {
                    saf25.saf2502_seq = column;
                }
                //B
                else if (k == 1)
                {
                    saf25.saf2503_ord_no = column;
                }
                //C
                else if (k == 2)
                {
                    saf25.saf2504_ord_date =  DateTimeTryParse(column, saf25FileInfo, j, k, true);
                }
                //D
                else if (k == 3)
                {
                    saf25.saf2514_rec_name = column;
                }
                //E
                else if (k == 4)
                {
                    saf25.saf2515_rec_cell = column;
                }
                //F
                else if (k == 5)
                {
                    saf25.saf2519_rec_address = column;
                }
                //G
                else if (k == 6)
                {
                    saf25.saf2531_psname = column;
                }
                //H
                else if (k == 7)
                {
                    saf25.saf2532_pname = column;
                }
                //I
                else if (k == 8)
                {
                    saf25.saf2522_dis_demand = column;
                }
                //J
                else if (k == 9)
                {

                    saf25.saf2558_trans_yn = column;
                }
                //K
                else if (k == 10)
                {
                    saf25.saf2526_ship_status = column;
                }
                //L  
                else if (k == 11)
                {
                    saf25.saf2520_dis_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                }
                //M
                else if (k == 12)
                {
                    saf25.saf2521_dis_time = column;
                }
                //N
                else if (k == 13)
                {
                    saf25.saf2510_ord_name = column;
                }
                //O
                else if (k == 14)
                {
                    saf25.saf2512_ord_tel01 = column;
                }
                //P
                else if (k == 15)
                {
                    saf25.saf2513_ord_tel02 = column;
                }
                //Q
                else if (k == 16)
                {
                    saf25.saf2511_ord_cell = column;
                }
                //R
                else if (k == 17)
                {
                    saf25.saf2514_rec_name = column;
                }
                //S
                else if (k == 18)
                {
                    saf25.saf2516_rec_tel01 = column;
                }
                //T
                else if (k == 19)
                {
                    saf25.saf2517_rec_tel02 = column;
                }
                //U
                else if (k == 20)
                {
                    saf25.saf2515_rec_cell = column;
                }
                //V
                else if (k == 21)
                {
                    saf25.saf2519_rec_address = column;
                }
                //W
                else if (k == 22)
                {
                    saf25.saf2505_ord_remark = column;
                }
                //X
                else if (k == 23)
                {
                    saf25.saf2559_option_case = column;
                }
                //Y
                else if (k == 24)
                {
                    saf25.saf2542_groups = column;
                }
                //Z
                else if (k == 25)
                {
                    saf25.saf2537_pcode = column;
                }
                //AA
                else if (k == 26)
                {
                    saf25.saf2531_psname = column;
                }
                //AB
                else if (k == 27)
                {
                    saf25.saf2532_pname = column;
                }
                //AC
                else if (k == 28)
                {
                    saf25.saf2536_pcode_v = column;
                }
                //AD
                else if (k == 29)
                {
                    saf25.saf2533_pspec = column;
                }
                //AE
                else if (k == 30)
                {
                    saf25.saf2560_unit = column;
                }
                //AF
                else if (k == 31)
                {
                    saf25.saf2547_price = DoubleTryParse(column, saf25FileInfo, j, k, false);
                }
                //AG
                else if (k == 32)
                {
                    saf25.saf2541_ord_qty = IntTryParse(column, saf25FileInfo, j, k, false);
                }
                //AH
                else if (k == 33)
                {
                    saf25.saf2548_price_sub = DoubleTryParse(column, saf25FileInfo, j, k, false);
                }
                //AI
                else if (k == 34)
                {
                    saf25.saf2544_cost = DoubleTryParse(column, saf25FileInfo, j, k, false);
                }
                //AJ
                else if (k == 35)
                {
                    saf25.saf2546_mana_fee = DoubleTryParse(column, saf25FileInfo, j, k, false);
                }
            }
            saf25FileInfo.saf25List.Add(saf25);
        }
    }

    public void FormosaPlastics_csvtosaf25(List<List<string>> rowList, saf25FileInfo saf25FileInfo, string OrderTime)
    {
        for (var j = 0; j < rowList.Count; j++)
        {
            var saf25 = new saf25();
            if (j == 0) continue;//跳過標題

            var row = rowList[j];
            if (string.IsNullOrEmpty(row[1].ToString())) continue;

            for (var k = 0; k < row.Count; k++)
            {
                var column = row[k];
                //A
                if (k == 0)
                {
                    saf25.saf2502_seq = column;
                }
                //B
                else if (k == 1)
                {
                    saf25.saf2503_ord_no = column;
                }
                //C
                else if (k == 2)
                {
                    saf25.saf2557_open_no = column;
                }
                //D
                else if (k == 3)
                {
                    saf25.saf2504_ord_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                }
                //E
                else if (k == 4)
                {
                    saf25.saf2507_ord_class = column;
                }
                //F
                else if (k == 5)
                {
                    saf25.saf2506_ord_status = column;
                }
                //G
                else if (k == 6)
                {
                    saf25.saf2550_paymt_way = column;
                }
                //H
                else if (k == 7)
                {
                    saf25.saf2551_paymt_status = column;
                }
                //I
                else if (k == 8)
                {
                    saf25.saf2522_dis_demand = column;
                }
                //J
                else if (k == 9)
                {

                    saf25.saf2558_trans_yn = column;
                }
                //K
                else if (k == 10)
                {
                    saf25.saf2526_ship_status = column;
                }
                //L  
                else if (k == 11)
                {
                    saf25.saf2520_dis_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                }
                //M
                else if (k == 12)
                {
                    saf25.saf2521_dis_time = column;
                }
                //N
                else if (k == 13)
                {
                    saf25.saf2510_ord_name = column;
                }
                //O
                else if (k == 14)
                {
                    saf25.saf2512_ord_tel01 = column;
                }
                //P
                else if (k == 15)
                {
                    saf25.saf2513_ord_tel02 = column;
                }
                //Q
                else if (k == 16)
                {
                    saf25.saf2511_ord_cell = column;
                }
                //R
                else if (k == 17)
                {
                    saf25.saf2514_rec_name = column;
                }
                //S
                else if (k == 18)
                {
                    saf25.saf2516_rec_tel01 = column;
                }
                //T
                else if (k == 19)
                {
                    saf25.saf2517_rec_tel02 = column;
                }
                //U
                else if (k == 20)
                {
                    saf25.saf2515_rec_cell = column;
                }
                //V
                else if (k == 21)
                {
                    saf25.saf2519_rec_address = column;
                }
                //W
                else if (k == 22)
                {
                    saf25.saf2505_ord_remark = column;
                }
                //X
                else if (k == 23)
                {
                    saf25.saf2559_option_case = column;
                }
                //Y
                else if (k == 24)
                {
                    saf25.saf2542_groups = column;
                }
                //Z
                else if (k == 25)
                {
                    saf25.saf2537_pcode = column;
                }
                //AA
                else if (k == 26)
                {
                    saf25.saf2531_psname = column;
                }
                //AB
                else if (k == 27)
                {
                    saf25.saf2532_pname = column;
                }
                //AC
                else if (k == 28)
                {
                    saf25.saf2536_pcode_v = column;
                }
                //AD
                else if (k == 29)
                {
                    saf25.saf2533_pspec = column;
                }
                //AE
                else if (k == 30)
                {
                    saf25.saf2560_unit = column;
                }
                //AF
                else if (k == 31)
                {
                    saf25.saf2547_price = DoubleTryParse(column, saf25FileInfo, j, k, false);
                }
                //AG
                else if (k == 32)
                {
                    saf25.saf2541_ord_qty = IntTryParse(column, saf25FileInfo, j, k, false);
                }
                //AH
                else if (k == 33)
                {
                    saf25.saf2548_price_sub = DoubleTryParse(column, saf25FileInfo, j, k, false);
                }
                //AI
                else if (k == 34)
                {
                    saf25.saf2544_cost = DoubleTryParse(column, saf25FileInfo, j, k, false);
                }
                //AJ
                else if (k == 35)
                {
                    saf25.saf2546_mana_fee = DoubleTryParse(column, saf25FileInfo, j, k, false);
                }
            }
            saf25FileInfo.saf25List.Add(saf25);
        }
    }

    public void TaiwanMobile_csvtosaf25(List<List<string>> rowList, saf25FileInfo saf25FileInfo, string OrderTime)
    {
        for (var j = 0; j < rowList.Count; j++)
        {
            var saf25 = new saf25();
            if (j == 0) continue;//跳過標題

            var row = rowList[j];
            if (string.IsNullOrEmpty(row[2].ToString())) continue;

            for (var k = 0; k < row.Count; k++)
            {
                var column = row[k];
                //A
                if (k == 0)
                {
                    saf25.saf2504_ord_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                }
                //B
                else if (k == 1)
                {
                    saf25.saf2527_ship_no = column;
                }
                //C
                else if (k == 2)
                {
                    saf25.saf2503_ord_no = column;
                }
                //D
                else if (k == 3)
                {
                    saf25.saf2522_dis_demand = column;
                }
                //E
                else if (k == 4)
                {
                    saf25.saf2529_logis_no = column;
                }
                //F
                else if (k == 5)
                {
                    saf25.saf2528_fre_no = column;
                }
                //G
                else if (k == 6)
                {
                    saf25.saf2537_pcode = column;
                }
                //H
                else if (k == 7)
                {
                    saf25.saf2536_pcode_v = column;
                }
                //I
                else if (k == 8)
                {
                    saf25.saf2531_psname = column;
                }
                //J
                else if (k == 9)
                {
                    saf25.saf2532_pname = column;
                }
                //K
                else if (k == 10)
                {
                    saf25.saf2553_gifts = column;
                }
                //L  
                else if (k == 11)
                {
                    saf25.saf2541_ord_qty =  IntTryParse(column, saf25FileInfo, j, k, false);
                }
                //M
                else if (k == 12)
                {
                    saf25.saf2544_cost =  DoubleTryParse(column, saf25FileInfo, j, k, false);
                }
                //N
                else if (k == 13)
                {
                    saf25.saf2545_cost_sub =  DoubleTryParse(column, saf25FileInfo, j, k, false);
                }
                //O
                else if (k == 14)
                {
                    saf25.saf2514_rec_name = column;
                }
                //P
                else if (k == 15)
                {
                    saf25.saf2516_rec_tel01 = column;
                }
                //Q
                else if (k == 16)
                {
                    saf25.saf2515_rec_cell = column;
                }
                //R
                else if (k == 17)
                {
                    saf25.saf2519_rec_address = column;
                }
                //S
                else if (k == 18)
                {
                    saf25.saf2538_inv_no = column;
                }
                //T
                else if (k == 19)
                {
                    saf25.saf2540_ship_qty = IntTryParse(column, saf25FileInfo, j, k, false);;
                }

            }
            saf25FileInfo.saf25List.Add(saf25);
        }
    }

    public void LifeMarket_csvtosaf25(List<List<string>> rowList, saf25FileInfo saf25FileInfo, string OrderTime)
    {
        for (var j = 0; j < rowList.Count; j++)
        {
            var saf25 = new saf25();
            if (j == 0) continue;//跳過標題

            var row = rowList[j];
            if (string.IsNullOrEmpty(row[0].ToString())) continue;

            for (var k = 0; k < row.Count; k++)
            {
                var column = row[k];
                //A
                if (k == 0)
                {
                    saf25.saf2503_ord_no = column;
                }
                //B
                else if (k == 1)
                {
                    saf25.saf2514_rec_name = column;
                }
                //C
                else if (k == 2)
                {
                    saf25.saf2519_rec_address = column;
                }
                //D
                else if (k == 3)
                {
                    saf25.saf2515_rec_cell = column;
                }
                //E
                else if (k == 4)
                {
                    saf25.saf2521_dis_time = column;
                }
                //F
                else if (k == 5)
                {
                    saf25.saf2531_psname = column;
                }
                //G
                else if (k == 6)
                {
                    saf25.saf2508_ord_plan = column;
                }
                //H
                else if (k == 7)
                {
                    saf25.saf2532_pname = column;
                }
                //I
                else if (k == 8)
                {
                    saf25.saf2505_ord_remark = column;
                }
                //J
                else if (k == 9)
                {
                    saf25.saf2549_paymt_date =  DateTimeTryParse(column, saf25FileInfo, j, k, true);
                }
                //K
                else if (k == 10)
                {
                    saf25.saf2552_return = column;
                }
            }
            saf25FileInfo.saf25List.Add(saf25);
        }
    }

    public void ET_csvtosaf25(List<List<string>> rowList, saf25FileInfo saf25FileInfo, string OrderTime)
    {
        for (var j = 0; j < rowList.Count; j++)
        {
            var saf25 = new saf25();
            if (j == 0) continue;//跳過標題

            var row = rowList[j];
            if (string.IsNullOrEmpty(row[2].ToString())) continue;

            for (var k = 0; k < row.Count; k++)
            {
                var column = row[k];
                //A
                if (k == 0)
                {
                    saf25.saf2502_seq = column;
                }
                //B
                else if (k == 1)
                {
                    saf25.saf2503_ord_no = column;
                }
                //C
                else if (k == 2)
                {
                    //saf25.saf2503_ord_no = column;
                }
                //D
                else if (k == 3)
                {
                    //saf25.saf2527_ship_no = column;
                }
                //E
                else if (k == 4)
                {
                    saf25.saf2506_ord_status = column;
                }
                //F
                else if (k == 5)
                {
                    saf25.saf2527_ship_no = column;
                }
                //G
                else if (k == 6)
                {
                    saf25.saf2537_pcode = column;
                }
                //H
                else if (k == 7)
                {
                    saf25.saf2531_psname = column;
                }
                //I
                else if (k == 8)
                {
                    saf25.saf2534_ship_pname = column;
                }
                //J
                else if (k == 9)
                {
                    saf25.saf2533_pspec = column;
                }
                //K
                else if (k == 10)
                {
                    saf25.saf2536_pcode_v = column;
                }
                //L  
                else if (k == 11)
                {
                    saf25.saf2507_ord_class = column;
                }
                //M
                else if (k == 12)
                {
                    saf25.saf2541_ord_qty =  IntTryParse(column, saf25FileInfo, j, k, false);
                }
                //N
                else if (k == 13)
                {
                    saf25.saf2547_price =  DoubleTryParse(column, saf25FileInfo, j, k, false);
                }
                //O
                else if (k == 14)
                {
                    saf25.saf2544_cost = DoubleTryParse(column, saf25FileInfo, j, k, false);
                }
                //P
                else if (k == 15)
                {
                    saf25.saf2514_rec_name = column;
                }
                //Q
                else if (k == 16)
                {
                    saf25.saf2515_rec_cell = column;
                }
                //R
                else if (k == 17)
                {
                    saf25.saf2516_rec_tel01 = column;
                }
                //S
                else if (k == 18)
                {
                    saf25.saf2519_rec_address = column;
                }
                //T
                else if (k == 19)
                {
                    saf25.saf2530_logis_comp = column;
                }
                //U
                else if (k == 20)
                {
                    saf25.saf2528_fre_no = column;
                }
                //V
                else if (k == 21)
                {
                    saf25.saf2523_ship_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                }
                //W
                else if (k == 22)
                {
                    saf25.saf2520_dis_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                }
                //X
                else if (k == 23)
                {
                    saf25.saf2521_dis_time = column;
                }
                //Y
                else if (k == 24)
                {
                    saf25.saf2505_ord_remark = column;
                }
                //Z
                else if (k == 25)
                {
                    saf25.saf2538_inv_no = column;
                }
                //AA
                else if (k == 26)
                {
                    saf25.saf2554_identifier = column;
                }
                //AB
                else if (k == 27)
                {
                    saf25.saf2539_inv_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                }
                //AC
                else if (k == 28)
                {
                    saf25.saf2553_gifts = column;
                }
                //AD
                else if (k == 29)
                {
                    saf25.saf2522_dis_demand = column;
                }
                //AE
                else if (k == 30)
                {
                    saf25.saf2562_warehs_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                }

            }
            saf25FileInfo.saf25List.Add(saf25);
        }
    }

    public void SonGuo_csvtosaf25(List<List<string>> rowList, saf25FileInfo saf25FileInfo, string OrderTime)
    {
        for (var j = 0; j < rowList.Count; j++)
        {
            var saf25 = new saf25();
            if (j == 0) continue;//跳過標題

            var row = rowList[j];
            if (string.IsNullOrEmpty(row[0].ToString())) continue;

            for (var k = 0; k < row.Count; k++)
            {
                var column = row[k];
                //A
                if (k == 0)
                {
                    saf25.saf2503_ord_no = column;
                }
                //B
                else if (k == 1)
                {
                    saf25.saf2549_paymt_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                }
                //C
                else if (k == 2)
                {
                    saf25.saf2510_ord_name = column;
                }
                //D
                else if (k == 3)
                {
                    saf25.saf2550_paymt_way = column;
                }
                //E
                else if (k == 4)
                {
                    //saf25.saf2523_ship_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                }
                //F
                else if (k == 5)
                {
                    //saf25.saf2531_psname = IntTryParse(column, saf25FileInfo, j, k, false);
                }
                //G
                else if (k == 6)
                {
                    saf25.saf2514_rec_name = column;
                }
                //H
                else if (k == 7)
                {
                    saf25.saf2515_rec_cell = column;
                }
                //I
                else if (k == 8)
                {
                    saf25.saf2519_rec_address = column;
                }
                //J
                else if (k == 9)
                {
                    saf25.saf2531_psname = column;
                }
                //K
                else if (k == 10)
                {
                    saf25.saf2537_pcode = column;
                }
                //L  
                else if (k == 11)
                {
                    saf25.saf2542_groups = column;
                }
                //M
                else if (k == 12)
                {
                    saf25.saf2547_price = DoubleTryParse(column, saf25FileInfo, j, k, false);
                }
                //N
                else if (k == 13)
                {
                    saf25.saf2540_ship_qty = IntTryParse(column, saf25FileInfo, j, k, false);
                }
                //O
                else if (k == 14)
                {
                    saf25.saf2561_option = column;
                }
                //P
                else if (k == 15)
                {
                    saf25.saf2541_ord_qty = IntTryParse(column, saf25FileInfo, j, k, false);
                }
            }
            saf25FileInfo.saf25List.Add(saf25);
        }
    }

    public void ShenFang_csvtosaf25(List<List<string>> rowList, saf25FileInfo saf25FileInfo, string OrderTime)
    {
        for (var j = 0; j < rowList.Count; j++)
        {
            var saf25 = new saf25();
            if (j == 0) continue;//跳過標題

            var row = rowList[j];
            if (string.IsNullOrEmpty(row[1].ToString())) continue;

            for (var k = 0; k < row.Count; k++)
            {
                var column = row[k];
                //A
                if (k == 0)
                {
                    saf25.saf2510_ord_name = column;
                }
                //B
                else if (k == 1)
                {
                    saf25.saf2503_ord_no = column;
                }
                //C
                else if (k == 2)
                {
                    saf25.saf2504_ord_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                }
                //D
                else if (k == 3)
                {
                    saf25.saf2537_pcode = column;
                }
                //E
                else if (k == 4)
                {
                    //saf25.saf2523_ship_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                }
                //F
                else if (k == 5)
                {
                    saf25.saf2531_psname = column;
                }
                //G
                else if (k == 6)
                {
                    saf25.saf2541_ord_qty = IntTryParse(column, saf25FileInfo, j, k, false);
                }
                //H
                else if (k == 7)
                {
                    saf25.saf2514_rec_name = column;
                }
                //I
                else if (k == 8)
                {
                    saf25.saf2518_rec_zip = column;
                }
                //J
                else if (k == 9)
                {
                    saf25.saf2519_rec_address = column;
                }
                //K
                else if (k == 10)
                {
                    saf25.saf2516_rec_tel01 = column;
                }
                //L  
                else if (k == 11)
                {
                    saf25.saf2517_rec_tel02 = column;
                }
                //M
                else if (k == 12)
                {
                    saf25.saf2515_rec_cell = column;
                }
                //N
                else if (k == 13)
                {
                    saf25.saf2544_cost = DoubleTryParse(column, saf25FileInfo, j, k, false);
                }
                //O
                else if (k == 14)
                {
                    saf25.saf2505_ord_remark = column;
                }
                //P
                else if (k == 15)
                {
                    saf25.saf2556_leave_msg = column;
                }
                //Q
                else if (k == 16)
                {
                    saf25.saf2524_ship_remark = column;
                }

            }
            saf25FileInfo.saf25List.Add(saf25);
        }
    }

    public void Gomaji_csvtosaf25(List<List<string>> rowList, saf25FileInfo saf25FileInfo, string OrderTime)
    {
        for (var j = 0; j < rowList.Count; j++)
        {
            var saf25 = new saf25();
            if (j == 0) continue;//跳過標題

            var row = rowList[j];
            if (string.IsNullOrEmpty(row[1].ToString())) continue;

            for (var k = 0; k < row.Count; k++)
            {
                var column = row[k];
                //A
                if (k == 0)
                {
                    saf25.saf2502_seq = column;
                }
                //B
                else if (k == 1)
                {
                    saf25.saf2537_pcode = column;
                }
                //C
                else if (k == 2)
                {
                    saf25.saf2503_ord_no = column;
                }
                //D
                else if (k == 3)
                {
                    saf25.saf2504_ord_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                }
                //E
                else if (k == 4)
                {
                    saf25.saf2523_ship_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                }
                //F
                else if (k == 5)
                {
                    saf25.saf2510_ord_name = column;
                }
                //G
                else if (k == 6)
                {
                    saf25.saf2514_rec_name = column;
                }
                //H
                else if (k == 7)
                {
                    saf25.saf2511_ord_cell = column;
                }
                //I
                else if (k == 8)
                {
                    saf25.saf2515_rec_cell = column;
                }
                //J
                else if (k == 9)
                {
                    saf25.saf2542_groups = column;
                }
                //K
                else if (k == 10)
                {
                    saf25.saf2531_psname = column;
                }
                //L  
                else if (k == 11)
                {
                    saf25.saf2519_rec_address = column;
                }
                //M
                else if (k == 12)
                {
                    saf25.saf2533_pspec = column;
                }
                //N
                else if (k == 13)
                {
                    saf25.saf2532_pname = column;
                }
                //O
                else if (k == 14)
                {
                    saf25.saf2536_pcode_v = column;
                }
                //P
                else if (k == 15)
                {
                    saf25.saf2540_ship_qty = IntTryParse(column, saf25FileInfo, j, k, false);
                }
                //Q
                else if (k == 16)
                {
                    saf25.saf2505_ord_remark = column;
                }
                //R
                else if (k == 17)
                {
                    //saf25.saf2510_ord_name = DoubleTryParse(column, saf25FileInfo, j, k, false);
                }
                //S
                else if (k == 18)
                {
                    //saf25.saf2514_rec_name = column;
                }
                //T
                else if (k == 19)
                {
                    //saf25.saf2518_rec_zip = column;
                }
                //U
                else if (k == 20)
                {
                    //saf25.saf2519_rec_address = column;
                }
                //V
                else if (k == 21)
                {
                    saf25.saf2528_fre_no = column;
                }
                //W
                else if (k == 22)
                {
                    saf25.saf2520_dis_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                }
                //X
                else if (k == 23)
                {
                    saf25.saf2524_ship_remark = column;
                }

            }
            saf25FileInfo.saf25List.Add(saf25);
        }
    }

    public void KS_csvtosaf25(List<List<string>> rowList, saf25FileInfo saf25FileInfo, string OrderTime)
    {
        for (var j = 0; j < rowList.Count; j++)
        {
            var saf25 = new saf25();
            if (j == 0) continue;//跳過標題
            var row = rowList[j];

            if (string.IsNullOrEmpty(row[5].ToString())) continue;

            for (var k = 0; k < row.Count; k++)
            {
                var column = row[k];
                //A
                if (k == 0)
                {
                    saf25.saf2526_ship_status = column;
                }
                //B
                else if (k == 1)
                {
                    saf25.saf2523_ship_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                }
                //C
                else if (k == 2)
                {
                    saf25.saf2529_logis_no = column;
                }
                //D
                else if (k == 3)
                {
                    saf25.saf2528_fre_no = column;
                }
                //E
                else if (k == 4)
                {
                    saf25.saf2502_seq = column;
                }
                //F
                else if (k == 5)
                {
                    saf25.saf2504_ord_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                }
                //G
                else if (k == 6)
                {
                    saf25.saf2503_ord_no = column;
                }
                //H
                else if (k == 7)
                {
                    saf25.saf2506_ord_status = column;
                }
                //I
                else if (k == 8)
                {
                    saf25.saf2531_psname = column;
                }
                //J
                else if (k == 9)
                {
                    saf25.saf2537_pcode = column;
                }
                //K
                else if (k == 10)
                {
                    saf25.saf2536_pcode_v = column;
                }
                //L  
                else if (k == 11)
                {
                    saf25.saf2541_ord_qty =  IntTryParse(column, saf25FileInfo, j, k, false);
                }
                //M
                else if (k == 12)
                {
                    saf25.saf2548_price_sub = DoubleTryParse(column, saf25FileInfo, j, k, false);
                }
                //N
                else if (k == 13)
                {
                    saf25.saf2545_cost_sub = DoubleTryParse(column, saf25FileInfo, j, k, false);
                }
                //O
                else if (k == 14)
                {
                    saf25.saf2514_rec_name = column;
                }
                //P
                else if (k == 15)
                {
                    saf25.saf2518_rec_zip = column;
                }
                //Q
                else if (k == 16)
                {
                    saf25.saf2563_county = column;
                }
                //R
                else if (k == 17)
                {
                    saf25.saf2519_rec_address = column;
                }
                //S
                else if (k == 18)
                {
                    saf25.saf2516_rec_tel01 = column;
                }
                //T
                else if (k == 19)
                {
                    saf25.saf2517_rec_tel02 = column;
                }
                //U
                else if (k == 20)
                {
                    saf25.saf2515_rec_cell = column;
                }
                //V
                else if (k == 21)
                {
                    saf25.saf2505_ord_remark = column;
                }

            }
            saf25FileInfo.saf25List.Add(saf25);
        }
    }

    public void UniPresident_csvtosaf25(List<List<string>> rowList, saf25FileInfo saf25FileInfo, string OrderTime)
    {
        for (var j = 0; j < rowList.Count; j++)
        {
            var saf25 = new saf25();
            if (j == 0) continue;//跳過標題

            var row = rowList[j];
            if (string.IsNullOrEmpty(row[1].ToString())) continue;
            if (row[17].ToString().Contains("運費")) continue;

            for (var k = 0; k < row.Count; k++)
            {
                var column = row[k];
                //A
                if (k == 0)
                {
                    saf25.saf2502_seq = column;
                }
                //B
                else if (k == 1)
                {
                    saf25.saf2568_vendor_no = column;
                }
                //C
                else if (k == 2)
                {
                    saf25.saf2569_vendor_name = column;
                }
                //D
                else if (k == 3)
                {
                    saf25.saf2504_ord_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                }
                //E
                else if (k == 4)
                {
                    saf25.saf2503_ord_no = column;
                }
                //F
                else if (k == 5)
                {
                    saf25.saf2527_ship_no = column;
                }
                //G
                else if (k == 6)
                {
                    saf25.saf2510_ord_name = column;
                }
                //H
                else if (k == 7)
                {
                    saf25.saf2514_rec_name = column;
                }
                //I
                else if (k == 8)
                {
                    saf25.saf2515_rec_cell = column;
                }
                //J
                else if (k == 9)
                {
                    saf25.saf2519_rec_address = column;
                }
                //K
                else if (k == 10)
                {
                    saf25.saf2564_post_box = column;
                }
                //L  
                else if (k == 11)
                {
                    saf25.saf2518_rec_zip = column;
                }
                //M
                else if (k == 12)
                {
                    saf25.saf2565_chg_notes = column;
                }
                //N
                else if (k == 13)
                {
                    saf25.saf2506_ord_status = column;
                }
                //O
                else if (k == 14)
                {
                    saf25.saf2566_warm = column;
                }
                //P
                else if (k == 15)
                {
                    saf25.saf2537_pcode = column;
                }
                //Q
                else if (k == 16)
                {
                    saf25.saf2536_pcode_v = column;
                }
                //R
                else if (k == 17)
                {
                    saf25.saf2531_psname = column;
                }
                //S
                else if (k == 18)
                {
                    saf25.saf2532_pname = column;
                }
                //T
                else if (k == 19)
                {
                    saf25.saf2541_ord_qty = IntTryParse(column, saf25FileInfo, j, k, false);;
                }
                //U
                else if (k == 20)
                {
                    saf25.saf2544_cost = DoubleTryParse(column, saf25FileInfo, j, k, false);;
                }
                //V
                else if (k == 21)
                {
                    saf25.saf2529_logis_no = column;
                }
                //W
                else if (k == 22)
                {
                    saf25.saf2530_logis_comp = column;
                }
                //X
                else if (k == 23)
                {
                    saf25.saf2528_fre_no = column;
                }
                //Y
                else if (k == 24)
                {
                    saf25.saf2567_carton_spec = column;
                }
                //Z
                else if (k == 25)
                {
                    //saf25.saf2570_activity = column;
                }
                //AA
                else if (k == 26)
                {
                    saf25.saf2526_ship_status = column;
                }
                //AB
                else if (k == 27)
                {
                    saf25.saf2505_ord_remark = column;
                }

            }
            saf25FileInfo.saf25List.Add(saf25);
        }
    }

    public void DingDing_csvtosaf25(List<List<string>> rowList, saf25FileInfo saf25FileInfo, string OrderTime)
    {
        for (var j = 0; j < rowList.Count; j++)
        {
            var saf25 = new saf25();
            if (j == 0) continue;//跳過標題

            var row = rowList[j];
            if (string.IsNullOrEmpty(row[1].ToString())) continue;

            for (var k = 0; k < row.Count; k++)
            {
                var column = row[k];
                //A
                if (k == 0)
                {
                    saf25.saf2568_vendor_no = column;
                }
                //B
                else if (k == 1)
                {
                    saf25.saf2569_vendor_name = column;
                }
                //C
                else if (k == 2)
                {
                    saf25.saf2523_ship_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                }
                //D
                else if (k == 3)
                {
                    saf25.saf2527_ship_no = column;
                }
                //E
                else if (k == 4)
                {
                    saf25.saf2549_paymt_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                }
                //F
                else if (k == 5)
                {
                    saf25.saf2526_ship_status = column;
                }
                //G
                else if (k == 6)
                {
                    saf25.saf2503_ord_no = column;
                }
                //H
                else if (k == 7)
                {
                    saf25.saf2506_ord_status = column;
                }
                //I
                else if (k == 8)
                {
                    saf25.saf2504_ord_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                }
                //J
                else if (k == 9)
                {
                    saf25.saf2531_psname = column;
                }
                //K
                else if (k == 10)
                {
                    saf25.saf2535_ptpye = column;
                }
                //L  
                else if (k == 11)
                {
                    saf25.saf2537_pcode = column;
                }
                //M
                else if (k == 12)
                {
                    saf25.saf2532_pname = column;
                }
                //N
                else if (k == 13)
                {
                    saf25.saf2544_cost = DoubleTryParse(column, saf25FileInfo, j, k, false);
                }
                //O
                else if (k == 14)
                {
                    saf25.saf2547_price = DoubleTryParse(column, saf25FileInfo, j, k, false);
                }
                //P
                else if (k == 15)
                {
                    saf25.saf2541_ord_qty = IntTryParse(column, saf25FileInfo, j, k, false);
                }
                //Q
                else if (k == 16)
                {
                    saf25.saf2548_price_sub = DoubleTryParse(column, saf25FileInfo, j, k, false);
                }
                //R
                else if (k == 17)
                {
                    saf25.saf2510_ord_name = column;
                }
                //S
                else if (k == 18)
                {
                    saf25.saf2514_rec_name = column;
                }
                //T
                else if (k == 19)
                {
                    saf25.saf2518_rec_zip = column;
                }
                //U
                else if (k == 20)
                {
                    saf25.saf2519_rec_address = column;
                }
                //V
                else if (k == 21)
                {
                    saf25.saf2516_rec_tel01 = column;
                }
                //W
                else if (k == 22)
                {
                    saf25.saf2515_rec_cell = column;
                }
                //X
                else if (k == 23)
                {
                    saf25.saf2505_ord_remark = column;
                }
                //Y
                else if (k == 24)
                {
                    saf25.saf2509_ord_shop = column;
                }
                //Z
                else if (k == 25)
                {
                    saf25.saf2570_activity = column;
                }
                //AA
                else if (k == 26)
                {
                    saf25.saf2507_ord_class = column;
                }
                //AB
                else if (k == 27)
                {
                    saf25.saf2520_dis_date =  DateTimeTryParse(column, saf25FileInfo, j, k, true);
                }
                //AC
                else if (k == 28)
                {
                    saf25.saf2533_pspec = column;
                }

            }
            saf25FileInfo.saf25List.Add(saf25);
        }
    }

    public void Crazy_csvtosaf25(List<List<string>> rowList, saf25FileInfo saf25FileInfo, string OrderTime)
    {
        for (var j = 0; j < rowList.Count; j++)
        {
            var saf25 = new saf25();
            if (j == 0) continue;//跳過標題

            var row = rowList[j];
            if (string.IsNullOrEmpty(row[3].ToString())) continue;

            for (var k = 0; k < row.Count; k++)
            {
                var column = row[k];
                //A
                if (k == 0)
                {
                    saf25.saf2503_ord_no = column.Replace("'","");
                }
                //B
                else if (k == 1)
                {
                    saf25.saf2523_ship_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                }
                //C
                else if (k == 2)
                {
                    saf25.saf2527_ship_no = column;
                }
                //D
                else if (k == 3)
                {
                    saf25.saf2531_psname = column;
                }
                //E
                else if (k == 4)
                {
                    saf25.saf2541_ord_qty = IntTryParse(column, saf25FileInfo, j, k, false);
                }
                //F
                else if (k == 5)
                {
                    saf25.saf2532_pname = column;
                }
                //G
                else if (k == 6)
                {
                    saf25.saf2544_cost = DoubleTryParse(column, saf25FileInfo, j, k, false);
                }
                //H
                else if (k == 7)
                {
                    saf25.saf2546_mana_fee = DoubleTryParse(column, saf25FileInfo, j, k, false);
                }
                //I
                else if (k == 8)
                {
                    saf25.saf2514_rec_name = column;
                }
                //J
                else if (k == 9)
                {

                    saf25.saf2528_fre_no = column;
                }
                //K
                else if (k == 10)
                {
                    saf25.saf2519_rec_address = column;
                }
                //L  
                else if (k == 11)
                {
                    saf25.saf2515_rec_cell = column.Replace("'", ""); ;
                }
                //M
                else if (k == 12)
                {
                    saf25.saf2553_gifts = column;
                }

            }
            saf25FileInfo.saf25List.Add(saf25);
        }
    }

    public void ShinQi_csvtosaf25(List<List<string>> rowList, saf25FileInfo saf25FileInfo, string OrderTime)
    {
        for (var j = 0; j < rowList.Count; j++)
        {
            var saf25 = new saf25();
            if (j == 0) continue;//跳過標題

            var row = rowList[j];

            if (j == 1 && row[0].ToString().Equals("序號")) continue;//跳過標題

            if (row.Count!=13) continue;

            if (string.IsNullOrEmpty(row[3].ToString())) continue;

            for (var k = 0; k < row.Count; k++)
            {
                var column = row[k];
                //A
                if (k == 0)
                {
                    saf25.saf2502_seq = column;
                }
                //B
                else if (k == 1)
                {
                    saf25.saf2503_ord_no = column;
                }
                //C
                else if (k == 2)
                {
                    saf25.saf2514_rec_name = column;
                }
                //D
                else if (k == 3)
                {
                    saf25.saf2515_rec_cell = column;
                }
                //E
                else if (k == 4)
                {
                    saf25.saf2518_rec_zip = column;
                }
                //F
                else if (k == 5)
                {
                    saf25.saf2519_rec_address = column;
                }
                //G
                else if (k == 6)
                {
                    saf25.saf2516_rec_tel01 = column;
                }
                //H
                else if (k == 7)
                {
                    saf25.saf2531_psname = column;
                }
                //I
                else if (k == 8)
                {
                    saf25.saf2529_logis_no = column;
                }
                //J
                else if (k == 9)
                {
                    saf25.saf2528_fre_no = column;
                }
                //K
                else if (k == 10)
                {
                    saf25.saf2541_ord_qty = IntTryParse(column, saf25FileInfo, j, k, false);
                }
                //L  
                else if (k == 11)
                {
                    saf25.saf2544_cost = DoubleTryParse(column, saf25FileInfo, j, k, false);
                }
                //M
                else if (k == 12)
                {
                    saf25.saf2523_ship_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                }

            }
            saf25FileInfo.saf25List.Add(saf25);
        }
    }

    public void LienHo_csvtosaf25(List<List<string>> rowList, saf25FileInfo saf25FileInfo, string OrderTime)
    {
        for (var j = 0; j < rowList.Count; j++)
        {
            var saf25 = new saf25();
            if (j == 0 || j == 1) continue;//跳過標題

            var row = rowList[j];
            if (string.IsNullOrEmpty(row[2].ToString())) continue;

            for (var k = 0; k < row.Count; k++)
            {
                var column = row[k];
                //A
                if (k == 0)
                {
                    //saf25.saf2504_ord_date = column;
                }
                //B
                else if (k == 1)
                {
                    saf25.saf2523_ship_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                }
                //C
                else if (k == 2)
                {
                    saf25.saf2503_ord_no = column;
                }
                //D
                else if (k == 3)
                {
                    //saf25.saf2527_ship_no = column;
                }
                //E
                else if (k == 4)
                {
                    saf25.saf2504_ord_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                }
                //F
                else if (k == 5)
                {
                    saf25.saf2510_ord_name = column;
                }
                //G
                else if (k == 6)
                {
                    saf25.saf2514_rec_name = column;
                }
                //H
                else if (k == 7)
                {
                    saf25.saf2516_rec_tel01 = column;
                }
                //I
                else if (k == 8)
                {
                    saf25.saf2515_rec_cell = column;
                }
                //J
                else if (k == 9)
                {

                    saf25.saf2518_rec_zip = column;
                }
                //K
                else if (k == 10)
                {
                    saf25.saf2519_rec_address = column;
                }
                //L  
                else if (k == 11)
                {
                    saf25.saf2522_dis_demand = column;
                }
                //M
                else if (k == 12)
                {
                    saf25.saf2505_ord_remark = column;
                }
                //N
                else if (k == 13)
                {
                    saf25.saf2537_pcode = column;
                }
                //O
                else if (k == 14)
                {
                    saf25.saf2536_pcode_v = column;
                }
                //P
                else if (k == 15)
                {
                    saf25.saf2532_pname = column;
                }
                //Q
                else if (k == 16)
                {
                    saf25.saf2533_pspec = column;
                }
                //R
                else if (k == 17)
                {
                    saf25.saf2531_psname = column;
                }
                //S
                else if (k == 18)
                {
                    saf25.saf2570_activity = column;
                }
                //T
                else if (k == 19)
                {
                    saf25.saf2541_ord_qty = IntTryParse(column, saf25FileInfo, j, k, false);
                }
                //U
                else if (k == 20)
                {
                    //saf25.saf2556_leave_msg = column;
                }
                //V
                else if (k == 21)
                {
                    //saf25.saf2587_gift_pnt = IntTryParse(column, saf25FileInfo, j, k, false);
                }
                //W
                else if (k == 22)
                {
                    saf25.saf2547_price = DoubleTryParse(column, saf25FileInfo, j, k, false);
                }
                //X
                else if (k == 23)
                {
                    saf25.saf2548_price_sub = DoubleTryParse(column, saf25FileInfo, j, k, false);
                }
                //Y
                else if (k == 24)
                {
                    saf25.saf2544_cost = DoubleTryParse(column, saf25FileInfo, j, k, false);
                }
                //Z
                else if (k == 25)
                {
                    saf25.saf2545_cost_sub = DoubleTryParse(column, saf25FileInfo, j, k, false);
                }
                //AA
                else if (k == 26)
                {
                    saf25.saf2520_dis_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                }
                //AB
                else if (k == 27)
                {
                    saf25.saf2529_logis_no = column;
                }
                //AC
                else if (k == 28)
                {
                    saf25.saf2528_fre_no = column;
                }
                //AD
                else if (k == 29)
                {
                    saf25.saf2530_logis_comp = column;
                }
            }
            saf25FileInfo.saf25List.Add(saf25);
        }
    }

    public void LuTien_csvtosaf25(List<List<string>> rowList, saf25FileInfo saf25FileInfo, string OrderTime)
    {
        for (var j = 0; j < rowList.Count; j++)
        {
            var saf25 = new saf25();
            if (j == 0) continue;//跳過標題

            var row = rowList[j];
            if (string.IsNullOrEmpty(row[2].ToString())) continue;

            for (var k = 0; k < row.Count; k++)
            {
                var column = row[k];
                //A
                if (k == 0)
                {
                    saf25.saf2504_ord_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                }
                //B
                else if (k == 1)
                {
                    saf25.saf2536_pcode_v = column;
                }
                //C
                else if (k == 2)
                {
                    saf25.saf2531_psname = column;
                }
                //D
                else if (k == 3)
                {
                    saf25.saf2532_pname = column;
                }
                //E
                else if (k == 4)
                {
                    //saf25.saf2523_ship_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                }
                //F
                else if (k == 5)
                {
                    saf25.saf2537_pcode = column;
                }
                //G
                else if (k == 6)
                {
                    saf25.saf2547_price = DoubleTryParse(column, saf25FileInfo, j, k, false);
                }
                //H
                else if (k == 7)
                {
                    saf25.saf2541_ord_qty = IntTryParse(column, saf25FileInfo, j, k, false);
                }
                //I
                else if (k == 8)
                {
                    saf25.saf2548_price_sub = DoubleTryParse(column, saf25FileInfo, j, k, false);
                }
                //J
                else if (k == 9)
                {
                    saf25.saf2578_get_acc = column;
                }
                //K
                else if (k == 10)
                {
                    //有HTML Tag
                    saf25.saf2506_ord_status = Regex.Replace(column.Replace("<br>", "，"), @"<[^>]*>", String.Empty);
                    //saf25.saf2506_ord_status = column;
                }
                //L  
                else if (k == 11)
                {
                    saf25.saf2514_rec_name = column;
                }
                //M
                else if (k == 12)
                {
                    saf25.saf2516_rec_tel01 = column;
                }
                //N
                else if (k == 13)
                {
                    saf25.saf2515_rec_cell = column;
                }
                //O
                else if (k == 14)
                {
                    saf25.saf2519_rec_address = column;
                }
            }
            saf25FileInfo.saf25List.Add(saf25);
        }

    }

    public void Yahoo_csvtosaf25(List<List<string>> rowList, saf25FileInfo saf25FileInfo, string OrderTime)
    {
        for (var j = 0; j < rowList.Count; j++)
        {
            var saf25 = new saf25();
            if (j == 0) continue;//跳過標題

            var row = rowList[j];
            if (string.IsNullOrEmpty(row[2].ToString())) continue;

            for (var k = 0; k < row.Count; k++)
            {
                var column = row[k];
                //A
                if (k == 0)
                {
                    saf25.saf2504_ord_date =  DateTimeTryParse(column, saf25FileInfo, j, k, true);
                }
                //B
                else if (k == 1)
                {
                    //saf25.saf2502_seq = column;
                }
                //C
                else if (k == 2)
                {
                    saf25.saf2503_ord_no = column;
                }
                //D
                else if (k == 3)
                {
                    saf25.saf2527_ship_no = column;
                }
                //E
                else if (k == 4)
                {
                    saf25.saf2536_pcode_v = column;
                }
                //F
                else if (k == 5)
                {
                    saf25.saf2531_psname = column;
                }
                //G
                else if (k == 6)
                {
                    saf25.saf2537_pcode = column;
                }
                //H
                else if (k == 7)
                {
                    //saf25.saf2514_rec_name = column;
                }
                //I
                else if (k == 8)
                {
                    //saf25.saf2522_dis_demand = column;
                }
                //J
                else if (k == 9)
                {

                    saf25.saf2532_pname = column;
                }
                //K
                else if (k == 10)
                {
                    //saf25.saf2515_rec_cell = column;
                }
                //L  
                else if (k == 11)
                {
                    saf25.saf2571_auction = column;
                }
                //M
                else if (k == 12)
                {
                    //saf25.saf2541_ord_qty = IntTryParse(column, saf25FileInfo, j, k, false);
                }
                //N
                else if (k == 13)
                {
                    saf25.saf2547_price = DoubleTryParse(column, saf25FileInfo, j, k, false);
                }
                //O
                else if (k == 14)
                {
                    saf25.saf2541_ord_qty = IntTryParse(column, saf25FileInfo, j, k, false);
                }
                //P
                else if (k == 15)
                {
                    saf25.saf2548_price_sub = DoubleTryParse(column, saf25FileInfo, j, k, false);
                }
                //Q
                else if (k == 16)
                {
                    //saf25.saf2545_cost_sub = DoubleTryParse(column, saf25FileInfo, j, k, false);
                }
                //R
                else if (k == 17)
                {
                    saf25.saf2546_mana_fee = DoubleTryParse(column, saf25FileInfo, j, k, false);
                }
                //S
                else if (k == 18)
                {
                    //saf25.saf2536_pcode_v = column;
                }
                //T
                else if (k == 19)
                {
                    saf25.saf2589_order_amt = DoubleTryParse(column, saf25FileInfo, j, k, false);
                }
                //U
                else if (k == 20)
                {
                    //saf25.saf2556_leave_msg = column;
                }
                //V
                else if (k == 21)
                {
                    saf25.saf2587_gift_pnt = IntTryParse(column, saf25FileInfo, j, k, false);
                }
                //W
                else if (k == 22)
                {
                    //saf25.saf2556_leave_msg = column;
                }
                //X
                else if (k == 23)
                {
                    saf25.saf2514_rec_name = column;
                }
                //Y
                else if (k == 24)
                {
                    saf25.saf2516_rec_tel01 = column;
                }
                //Z
                else if (k == 25)
                {
                    saf25.saf2515_rec_cell = column;
                }
                //AA
                else if (k == 26)
                {
                    saf25.saf2518_rec_zip = column;
                }
                //AB
                else if (k == 27)
                {
                    saf25.saf2519_rec_address = column;
                }
                //AC
                else if (k == 28)
                {
                    //saf25.saf2556_leave_msg = column;
                }
                //AD
                else if (k == 29)
                {
                    //saf25.saf2556_leave_msg = column;
                }
                //AE
                else if (k == 30)
                {
                    //saf25.saf2556_leave_msg = column;
                }
                //AF
                else if (k == 31)
                {
                    saf25.saf2550_paymt_way = column;
                }
                //AG
                else if (k == 32)
                {
                    saf25.saf2530_logis_comp = column;
                }
                //AH
                else if (k == 33)
                {
                    saf25.saf2523_ship_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                }
                //AI
                else if (k == 34)
                {
                    //saf25.saf2556_leave_msg = column;
                }
                //AJ
                else if (k == 35)
                {
                    //saf25.saf2556_leave_msg = column;
                }
                //AK
                else if (k == 36)
                {
                    //saf25.saf2556_leave_msg = column;
                }
                //AL
                else if (k == 37)
                {
                    saf25.saf2506_ord_status = column;
                }
                //AM
                else if (k == 38)
                {
                    saf25.saf2551_paymt_status = column;
                }
                //AN
                else if (k == 39)
                {
                    //saf25.saf2556_leave_msg = column;
                }
                //AO
                else if (k == 40)
                {
                    saf25.saf2526_ship_status = column;
                }

            }
            saf25FileInfo.saf25List.Add(saf25);
        }
    }

    public void Pchome_csvtosaf25(List<List<string>> rowList, saf25FileInfo saf25FileInfo, string OrderTime)
    {
        for (var j = 0; j < rowList.Count; j++)
        {
            var saf25 = new saf25();
            if (j == 0) continue;//跳過標題

            var row = rowList[j];
            if (string.IsNullOrEmpty(row[0].ToString())) continue;

            for (var k = 0; k < row.Count; k++)
            {
                var column = row[k];
                //A
                if (k == 0)
                {
                    saf25.saf2503_ord_no = column;
                }
                //B
                else if (k == 1)
                {
                    saf25.saf2502_seq = column;
                }
                //C
                else if (k == 2)
                {
                    saf25.saf2527_ship_no = column;
                }
                //D
                else if (k == 3)
                {
                    saf25.saf2506_ord_status = column;
                }
                //E
                else if (k == 4)
                {
                    saf25.saf2523_ship_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                }
                //F
                else if (k == 5)
                {
                    saf25.saf2504_ord_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                }
                //G
                else if (k == 6)
                {
                    saf25.saf2520_dis_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                }
                //H
                else if (k == 7)
                {
                    saf25.saf2514_rec_name = column;
                }
                //I
                else if (k == 8)
                {
                    saf25.saf2518_rec_zip = column;
                }
                //J
                else if (k == 9)
                {

                    saf25.saf2519_rec_address = column;
                }
                //K
                else if (k == 10)
                {
                    saf25.saf2515_rec_cell = column;
                }
                //L  
                else if (k == 11)
                {
                    saf25.saf2531_psname = column;
                }
                //M
                else if (k == 12)
                {
                    saf25.saf2541_ord_qty = IntTryParse(column, saf25FileInfo, j, k, false);
                }
                //N
                else if (k == 13)
                {
                    saf25.saf2543_cancel_qty = IntTryParse(column, saf25FileInfo, j, k, false); ;
                }
                //O
                else if (k == 14)
                {
                    saf25.saf2540_ship_qty = IntTryParse(column, saf25FileInfo, j, k, false);
                }
                //P
                else if (k == 15)
                {
                    saf25.saf2544_cost = DoubleTryParse(column, saf25FileInfo, j, k, false);
                }
                //Q
                else if (k == 16)
                {
                    saf25.saf2545_cost_sub = DoubleTryParse(column, saf25FileInfo, j, k, false);
                }
                //R
                else if (k == 17)
                {
                    saf25.saf2532_pname = column;
                }
                //S
                else if (k == 18)
                {
                    saf25.saf2536_pcode_v = column;
                }
                //T
                else if (k == 19)
                {
                    saf25.saf2505_ord_remark = column;
                }
                //U
                else if (k == 20)
                {
                    saf25.saf2556_leave_msg = column;
                }


            }
            saf25FileInfo.saf25List.Add(saf25);
        }

    }

    public void MOMO_csvtosaf25(List<List<string>> rowList, saf25FileInfo saf25FileInfo, string OrderTime)
    {
        for (var j = 0; j < rowList.Count; j++)
        {
            var saf25 = new saf25();
            if (j == 0) continue;//跳過標題

            var row = rowList[j];
            if (string.IsNullOrEmpty(row[1].ToString())) continue;

            for (var k = 0; k < row.Count; k++)
            {
                var column = row[k];
                //A
                if (k == 0)
                {
                    saf25.saf2502_seq = column;
                }
                //B
                else if (k == 1)
                {
                    saf25.saf2503_ord_no = column;
                }
                //C
                else if (k == 2)
                {
                    saf25.saf2506_ord_status = column;
                }
                //D
                else if (k == 3)
                {
                    saf25.saf2505_ord_remark = column;
                }
                //E
                else if (k == 4)
                {
                    //時間判斷 DateTimeTryParse(欄位資料，saf25FileInfo，列，欄，是否允許NULL(DB))
                    saf25.saf2520_dis_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                }
                //F
                else if (k == 5)
                {
                    saf25.saf2529_logis_no = column;
                }
                //G
                else if (k == 6)
                {
                    saf25.saf2528_fre_no = column;
                }
                //H
                else if (k == 7)
                {
                    saf25.saf2507_ord_class = column;
                }
                //I
                else if (k == 8)
                {
                    saf25.saf2522_dis_demand = column;
                }
                //J
                else if (k == 9)
                {
                    //訂單日確認
                    saf25.saf2504_ord_date = DateTimeTryParse(column, saf25FileInfo, j, k, true); ;
                }
                //K
                else if (k == 10)
                {
                    saf25.saf2523_ship_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                }
                //L  
                else if (k == 11)
                {
                    saf25.saf2514_rec_name = column;
                }
                //M
                else if (k == 12)
                {
                    saf25.saf2516_rec_tel01 = column;
                }
                //N
                else if (k == 13)
                {
                    saf25.saf2515_rec_cell = column;
                }
                //O
                else if (k == 14)
                {
                    saf25.saf2519_rec_address = column;
                }
                //P
                else if (k == 15)
                {
                    saf25.saf2536_pcode_v = column;
                }
                //Q
                else if (k == 16)
                {
                    saf25.saf2533_pspec = column;
                }
                //R
                else if (k == 17)
                {
                    saf25.saf2531_psname = column;
                }
                //S
                else if (k == 18)
                {
                    saf25.saf2537_pcode = column;
                }
                //T
                else if (k == 19)
                {
                    saf25.saf2532_pname = column;
                }
                //U
                else if (k == 20)
                {
                    saf25.saf2541_ord_qty = IntTryParse(column, saf25FileInfo, j, k, false);
                }
                //V
                else if (k == 21)
                {
                    saf25.saf2544_cost = DoubleTryParse(column, saf25FileInfo, j, k, false);
                }
                //W
                else if (k == 22)
                {
                    saf25.saf2553_gifts = column;
                }
                //X
                else if (k == 23)
                {
                    saf25.saf2510_ord_name = column;
                }//Y
                else if (k == 24)
                {
                    saf25.saf2538_inv_no = column;
                }//Z
                else if (k == 25)
                {
                    saf25.saf2539_inv_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                }//AA
                else if (k == 26)
                {
                    saf25.saf2554_identifier = IntTryParse(column, saf25FileInfo, j, k, false);
                }
                //AB
                else if (k == 27)
                {
                    saf25.saf2555_chg_price = column;
                }

            }
            saf25FileInfo.saf25List.Add(saf25);
        }
    }
    public string DateTimeTryParse(string Time, saf25FileInfo saf25FileInfo, int row, int column, bool allowEmpty)
    {
        DateTime Value;
        if (DateTime.TryParse(Time, out Value))
        {
            return Time;
        }
        else
        {
            if (!allowEmpty)
            {
                saf25FileInfo.ErrorMsg.Add(CreatErrorMsg(row, column, "非日期格式:" + Time));
            }


            return null;
        }
    }

    public string IntTryParse(string Num, saf25FileInfo saf25FileInfo, int row, int column, bool allowEmpty)
    {
        int Value;
        if (Int32.TryParse(Num, out Value))
        {
            return Num;
        }
        else
        {
            if (!allowEmpty)
            {
                saf25FileInfo.ErrorMsg.Add(CreatErrorMsg(row, column, "非整數格式:" + Num));
            }
            return null;
        }

    }

    public string DoubleTryParse(string Num, saf25FileInfo saf25FileInfo, int row, int column, bool allowEmpty)
    {
        Double Value;
        if (Double.TryParse(Num, out Value))
        {
            return Num;
        }
        else
        {
            if (!allowEmpty)
            {
                saf25FileInfo.ErrorMsg.Add(CreatErrorMsg(row, column, "非實數格式" + Num));
            }
            return "";
        }
    }

    public List<List<string>> CSVtoObject(string Path)
    {
        var Lines = File.ReadAllLines(Path, Encoding.UTF8);
        var rowList = new List<List<string>>();
        foreach (var Line in Lines)
        {

            var row = new List<string>();
            foreach (var column in Line.Split(','))
            {
                row.Add(column.Replace("\x08", ","));
            }

            rowList.Add(row);
        }
        return rowList;
    }

    public ErrorInfo CreatErrorMsg(int Row, int column, string Msg)
    {
        var strReturn = "";
        var iQuotient = (column + 1) / 26;//商數
        var iRemainder = (column + 1) % 26;//餘數
        if (iRemainder == 0)
            iQuotient--;  // 剛好整除的時候，商數要減一
        if (iQuotient > 0)
            strReturn = Convert.ToChar(64 + iQuotient).ToString();//A 65 利用ASCII做轉換

        if (iRemainder == 0)
            strReturn += "Z";
        else
            strReturn += Convert.ToChar(64 + iRemainder).ToString();    //A 65 利用ASCII做轉換
        return new ErrorInfo()
        {
            column = (Row + 1).ToString() + strReturn,
            messenge = Msg
        };

    }
    public void CSVTool(string Path)
    {
        StringBuilder sb = new StringBuilder();
        var Lines = File.ReadAllText(Path, Encoding.Default);
        using (StreamReader sr = new StreamReader(Path, Encoding.Default, true))
        {
            bool quotMarkMode = false;
            string newLineReplacement = "\x07";
            string commaReplacement = "\x08";
            while (sr.Peek() >= 0)
            {
                var ch = (char)sr.Read();
                if (quotMarkMode)
                {
                    //雙引號包含區段內遇到雙引號有兩種情境
                    if (ch == '"')
                    {
                        //連續兩個雙引號，為欄位內雙引號字元
                        if (sr.Peek() == '"')
                        {
                            sb.Append(ch);
                            //sb.Append((char)sr.Read());
                            sr.Read();
                        }
                        //遇到結尾雙引號，雙引號包夾模式結束
                        else
                        {
                            quotMarkMode = false;
                        }
                    }
                    //雙引號內遇到換行符號\r\n
                    else if (ch == '\r' && sr.Peek() == '\n')
                    {
                        sr.Read();
                        sb.Append(" ");
                    }
                    //雙引號內遇到換行符號\n
                    else if (ch == '\n')
                    {
                        sb.Append(" ");
                    }
                    //雙引號內遇到逗號，先置換成特殊字元，稍後換回
                    else if (ch == ',')
                        sb.Append(commaReplacement);
                    //否則，正常插入字元
                    else
                        sb.Append(ch);
                }
                else
                {
                    if (ch == '"')
                    {
                        quotMarkMode = true;
                        sb.Append("");
                    }
                    else if (ch=='\t')
                    {
                        sb.Append(',');
                    }
                    else
                    {
                        sb.Append(ch);
                    }

                }
            }

        }
        File.WriteAllText(Path, sb.ToString(), Encoding.UTF8);
    }

    public void Uploadfile(HttpContext context)
    {
        var DateTime = context.Request.QueryString["DateTime"];
        HttpFileCollection files = context.Request.Files;
        //建立uploads資料夾
        var uploadsRoot = context.Server.MapPath("~/Dsap92501/uploads/");
        var uploadsDirectory = uploadsRoot + DateTime.Replace("/", string.Empty);
        while (!Directory.Exists(uploadsDirectory))
        {
            Directory.CreateDirectory(uploadsDirectory);
        }
        for (int i = 0; i < files.Count; i++)
        {
            HttpPostedFile file = files[i];
            var uploadsPath = uploadsDirectory + "\\" + file.FileName;
            file.SaveAs(uploadsPath);
        }
    }

    public class saf25FileInfo
    {
        public string FileName { get; set; }
        public string CompanyName { get; set; }
        public List<saf25> saf25List = new List<saf25>();
        public List<ErrorInfo> ErrorMsg = new List<ErrorInfo>();
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

        public string saf2571_auction { get; set; }//拍賣代號
        public string saf2572_merge { get; set; }//合併訂單
        public string saf2573_discount { get; set; }//折扣
        public string saf2574_chang_d { get; set; }//變更日
        public string saf2575_check_d { get; set; }//檢核日期
        public string saf2576_cancel_d { get; set; }//取消日期
        public string saf2577_canwatch { get; set; }//買家可觀看
        public string saf2578_get_acc { get; set; }//得標帳號
        public string saf2579_auction_y { get; set; }//Y拍代號
        public string saf2580_email { get; set; }//訂購人email
        public string saf2581_cancel_ｒ { get; set; }//取消原因
        public string saf2582_serial { get; set; }//交易序號
        public string saf2583_store_remark { get; set; }//店家備註
        public string saf2584_deli_date { get; set; }//實際出貨日
        public string saf2585_conf_date { get; set; }//買家確認日
        public string saf2586_tax_class { get; set; }//商品稅別
        public string saf2587_gift_pnt { get; set; }//超贈點點數
        public string saf2588_gift_amt { get; set; }//超贈點折抵$
        public string saf2589_order_amt { get; set; }//訂單總金額

    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}