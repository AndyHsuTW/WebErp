using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ErpBaseLibrary.DB;
using System.Data.SqlClient;
using ICSharpCode.SharpZipLib.Zip;
using ICSharpCode.SharpZipLib.Core;
using System.IO;
namespace WebERPLibrary
{
    public class Dsap02005
    {
        public static Byte[] InvoicePrint(List<OrderData> OrderDatalist, string loginUserName)
        {

            MemoryStream outputMemStream = new MemoryStream();
            ZipOutputStream zipStream = new ZipOutputStream(outputMemStream);
            zipStream.SetLevel(3); //0-9, 9 being the highest level of compression

            var title = "";

            using (var conn = new SqlConnection(MyConnStringList.AzureGoodeasy))
            {
                conn.Open();
                var cmd = conn.CreateCommand();
                cmd.CommandText = @"SELECT cnf0703_bfname,cnf0706_address,cnf0707_tel FROM [dbo].[cnf07] where cnf0751_tax_headoffice=0";
                using (var rd = cmd.ExecuteReader())
                {
                    if (rd.Read())
                    {

                        title = rd["cnf0703_bfname"].ToString() + "  " + rd["cnf0706_address"].ToString() + "  " + rd["cnf0707_tel"].ToString();


                    }

                }

            }



            var Invoice = "";

            foreach (var OrderData in OrderDatalist)
            {
                var sb = new StringBuilder();
                var wordline = "";
                var linecount = 1;
                var No = 1;
                foreach (var Orderbody in OrderData.OrderbodyDataList)
                {
                    if (Invoice != Orderbody.saf20a38_inv_no)
                    {
                        if (sb.Length > 0)
                        {
                            pressZip(sb.ToString(), Invoice, zipStream);
                        }
                        Invoice = Orderbody.saf20a38_inv_no;


                        sb = new StringBuilder();
                        No = 1;
                        for (var i = 0; i < title.Length; i++)
                        {
                            var title_word = title.Substring(i, 1);
                            sb.Append(title_word);
                            if (i % 15 == 0)
                            {
                                sb.AppendLine();
                                linecount++;
                            }
                        }

                        for (var a = linecount; a <= 3; linecount++)
                        {
                            sb.AppendLine();
                        }
                        sb.AppendLine("        " + Convert.ToDateTime(Orderbody.saf20a39_inv_date).ToString("yyyy/MM/dd"));
                        linecount++;
                        sb.AppendLine("        " + OrderData.saf20107_tax_id);
                        linecount++;
                    }

                    sb.AppendLine(No.ToString().PadLeft(2, '0') + " " + Orderbody.saf20a37_pcode + " " + Orderbody.saf20a32_pname + Orderbody.saf20a34_ship_pname);
                    linecount++;
                    var l = 0;
                    for (var i = 0; i < Orderbody.saf20a31_psname.Length; i++)
                    {
                        var title_word = title.Substring(i, 1);

                        l = l + System.Text.Encoding.Default.GetBytes(title_word).Length;
                        if (l <= 30)
                        {
                            sb.Append(title_word);
                            if (i % 15 == 0)
                            {

                                sb.AppendLine();
                                linecount++;
                            }
                            
                        }
                        

                    }
                    sb.AppendLine();
                    linecount++;
                    sb.AppendLine(Orderbody.saf20a41_ord_qty + "*" + Orderbody.saf20a47_price + "=" + Orderbody.saf20a48_price_sub);
                    linecount++;

                }

                if (sb.Length > 0)
                {
                 pressZip(sb.ToString(), Invoice, zipStream);
                
                }





               
            }
            using (var conn = new SqlConnection(MyConnStringList.AzureGoodeasy))
            {
                conn.Open();
                var cmd = conn.CreateCommand();
                foreach (var OrderData in OrderDatalist)
                {
                    cmd.Parameters.Clear();
                    cmd.Parameters.AddWithValue("@id", OrderData.Id);
                    cmd.CommandText = @"update saf20 set saf20110_printmark='Y' where Id=@id";
                    cmd.ExecuteNonQuery();


                }
            }

            zipStream.IsStreamOwner = false;
            zipStream.Close();

            outputMemStream.Position = 0;

            byte[] byteArray = outputMemStream.ToArray();


            return byteArray;
        }


        public static void pressZip(string content, string Invoice, ZipOutputStream zipStream)
        {

            var byteData = Encoding.GetEncoding(950).GetBytes(content);
            var msFormXml = new MemoryStream(byteData);
            ZipEntry xmlEntry = new ZipEntry(String.Format("{0}.txt", Invoice));
            zipStream.PutNextEntry(xmlEntry);
            StreamUtils.Copy(msFormXml, zipStream, new byte[4096]);
            zipStream.CloseEntry();
        
        }

        public static string InvoiceOpening(List<OrderData> OrderDatalist, string loginUserName)
        {
            var result = "";
            using (var conn = new SqlConnection(MyConnStringList.AzureGoodeasy))
            {
                conn.Open();
                var cmd = conn.CreateCommand();
                var cnf0701_bcode = "";
                cmd.CommandText = @"
                  SELECT cnf0701_bcode
                  FROM [dbo].[cnf07] where cnf0751_tax_headoffice='0'";
                using (var rd = cmd.ExecuteReader())
                {
                    if (rd.Read())
                    {
                        cnf0701_bcode = rd["cnf0701_bcode"].ToString();
                    }

                }

                if (string.IsNullOrEmpty(cnf0701_bcode))
                {
                    return "資料庫沒有總公司資訊";

                }

                cmd.CommandText = @"
                  SELECT 1
                  FROM [dbo].[cnf07] where cnf0701_bcode=@cnf0701_bcode and cnf07115_zipcode2=''";
                cmd.Parameters.AddWithValue("@cnf0701_bcode", cnf0701_bcode);
                var hascnf07115_zipcode2 = false;
                using (var rd = cmd.ExecuteReader())
                {
                    hascnf07115_zipcode2 = rd.HasRows;

                }
                if (!hascnf07115_zipcode2)
                {
                    return "營業稅憑證代號 = 空白,沒有發票可取";

                }

            }
            var thisPeriods = DateTime.Now.ToString("yyyy") + (Convert.ToInt32(DateTime.Now.ToString("M")) % 2 == 0 ? Convert.ToInt32(DateTime.Now.ToString("M")) : Convert.ToInt32(DateTime.Now.ToString("M")) + 1).ToString().PadLeft(2, '0');



            foreach (var OrderData in OrderDatalist)
            {


                using (var conn = new SqlConnection(MyConnStringList.AzureGoodeasy))
                {
                    conn.Open();
                    var cmd = conn.CreateCommand();
                    cmd.CommandText = @"select saf20107_tax_id from saf20 where saf2002_serial=@serial";
                    cmd.Parameters.Clear();
                    cmd.Parameters.AddWithValue("@serial", OrderData.saf2002_serial);

                    using (var rd = cmd.ExecuteReader())
                    {
                        if (rd.Read())
                        {


                            var tax_id = rd["saf20107_tax_id"].ToString();
                            if (!string.IsNullOrEmpty(tax_id))
                            {
                                if (!checksaf20107_tax_id(tax_id))
                                {
                                    return "訂單編號: " + OrderData.saf2002_serial + "，統一編號經檢查公式判斷有錯誤，請重新輸入";
                                }


                            }
                        }

                    }
                    cmd.CommandText = @"select 1 from saf20 where saf2002_serial=@serial and saf2038_inv_no<>''";
                    cmd.Parameters.Clear();
                    cmd.Parameters.AddWithValue("@serial", OrderData.saf2002_serial);

                    using (var rd = cmd.ExecuteReader())
                    {
                        if (rd.HasRows)
                        {


                            return "訂單編號: " + OrderData.saf2002_serial + "，您選出的資料已經有開立發票，不可以再開立發票了，請重新選擇或修正後重選，謝謝您";
                        }

                    }



                    var Invoicedata = new InvoiceInfo();

                    var fisrtInvoice = "";
                    var itemNO = 1;
                    for (var i = 0; i <= OrderData.OrderbodyDataList.Count(); i++)
                    {

                        var OrderbodyData = OrderData.OrderbodyDataList[i];

                        if (i == 0)
                        {
                            Invoicedata = getInvoice(cmd, thisPeriods);
                            fisrtInvoice = Invoicedata.Invoice;
                            itemNO = 1;

                        }
                        else if (i % 3 == 0)
                        {
                            Invoicedata = getInvoice(cmd, thisPeriods);
                            itemNO = 1;
                        }


                        if (OrderData.saf20102_incl_fee.Trim() == "1" && OrderbodyData.saf20a86_tax_class.Trim() == "1")
                        {
                            cmd.Parameters.Clear();
                            cmd.Parameters.AddWithValue("@Id", OrderbodyData.Id);
                            cmd.CommandText = @"
                            Update [dbo].[saf20a] set saf20a103_sales_amt=saf20a48_price_sub+saf20a46_mana_fee
                            where Id=@Id
                             where Id=@Id";
                            cmd.ExecuteNonQuery();

                        }
                        else if (OrderData.saf20102_incl_fee.Trim() == "1" && OrderbodyData.saf20a86_tax_class.Trim() == "3")
                        {

                            cmd.Parameters.Clear();
                            cmd.Parameters.AddWithValue("@Id", OrderbodyData.Id);
                            cmd.CommandText = @"
                            Update [dbo].[saf20a] set saf20a104_freetax_amt=saf20a48_price_sub+saf20a46_mana_fee
                            where Id=@Id
                             where Id=@Id";
                            cmd.ExecuteNonQuery();


                        }
                        else if (OrderData.saf20102_incl_fee.Trim() == "" && OrderbodyData.saf20a86_tax_class.Trim() == "1")
                        {

                            cmd.Parameters.Clear();
                            cmd.Parameters.AddWithValue("@Id", OrderbodyData.Id);
                            cmd.CommandText = @"
                            Update [dbo].[saf20a] set saf20a103_sales_amt=saf20a48_price_sub
                            where Id=@Id
                             where Id=@Id";
                            cmd.ExecuteNonQuery();


                        }
                        else if (OrderData.saf20102_incl_fee.Trim() == "" && OrderbodyData.saf20a86_tax_class.Trim() == "3")
                        {

                            cmd.Parameters.Clear();
                            cmd.Parameters.AddWithValue("@Id", OrderbodyData.Id);
                            cmd.CommandText = @"
                            Update [dbo].[saf20a] set saf20a104_freetax_amt=saf20a48_price_sub
                            where Id=@Id";
                            cmd.ExecuteNonQuery();


                        }


                        if (OrderbodyData.saf20a86_tax_class.Trim() == "0" || OrderbodyData.saf20a86_tax_class.Trim() == "3")
                        {
                            cmd.Parameters.Clear();
                            cmd.Parameters.AddWithValue("@Id", OrderbodyData.Id);
                            cmd.CommandText = @"
                            Update [dbo].[saf20a] set saf20a105_tax=0
                            where Id=@Id";
                            cmd.ExecuteNonQuery();

                        }
                        else if (OrderbodyData.saf20a86_tax_class.Trim() == "1")
                        {
                            cmd.Parameters.Clear();
                            cmd.Parameters.AddWithValue("@Id", OrderbodyData.Id);
                            cmd.CommandText = @"
                            Update [dbo].[saf20a] set saf20a105_tax=  
                            (saf20a103_sales_amt/(1+(select inf01125_tax from  [dbo].[inf01] where [inf0102_pcode] = saf20a37_pcode )))*(select inf01125_tax from  [dbo].[inf01] where [inf0102_pcode] = saf20a37_pcode )
                            where Id=@Id";
                            cmd.ExecuteNonQuery();

                        }
                        else if (OrderbodyData.saf20a86_tax_class.Trim() == "2")
                        {

                            cmd.Parameters.Clear();
                            cmd.Parameters.AddWithValue("@Id", OrderbodyData.Id);
                            cmd.CommandText = @"

                            Update [dbo].[saf20a] set saf20a105_tax=saf20a103_sales_amt*(select inf01125_tax from  [dbo].[inf01] where [inf0102_pcode] = saf20a37_pcode )
                            where Id=@Id";
                            cmd.ExecuteNonQuery();

                        }

                        cmd.Parameters.Clear();
                        cmd.Parameters.AddWithValue("@Id", OrderbodyData.Id);
                        cmd.Parameters.AddWithValue("@Invoice", Invoicedata.Invoice);

                        cmd.Parameters.AddWithValue("@saf20a31_psname", OrderbodyData.saf20a31_psname);
                        cmd.Parameters.AddWithValue("@saf20a48_price_sub", OrderbodyData.saf20a48_price_sub);

                        cmd.CommandText = String.Format(@"
                           Update pgf22 set pgf22 pgf2216_item{0} = @saf20a31_psname, pgf2222_amount{0} = @saf20a48_price_sub
                           where pgf2206_s_no=@Invoice
                            Update [dbo].[saf20a] set saf2038a_inv_no=@Invoice,saf20a39_inv_date=getdate()
                            where Id=@Id", itemNO);
                        cmd.ExecuteNonQuery();

                        if (i == 0 || i % 3 == 0)
                        {
                            updateInvoice(cmd, Invoicedata);
                        }
                        itemNO++;
                    }

                    cmd.Parameters.Clear();
                    cmd.Parameters.AddWithValue("@serial", OrderData.saf2002_serial);
                    cmd.Parameters.AddWithValue("@Invoice", Invoicedata.Invoice);
                    cmd.Parameters.AddWithValue("@User", loginUserName);
                    cmd.Parameters.AddWithValue("@fisrtInvoice", fisrtInvoice);
                    cmd.CommandText = @"

                    Update saf20 set 
                    saf20103_sales_amt = ISNULL((select SUM(saf20a103_sales_amt) from saf20a where saf20a02_serial =@serial),0)
                    where saf2002_serial=@serial


                    Update saf20 set 
                    saf20104_freetax_amt = ISNULL((select SUM(saf20a104_freetax_amt) from saf20a where saf20a02_serial =@serial),0)
                    where saf2002_serial=@serial

                    Update saf20 set 
                    saf20105_tax = ISNULL((select SUM(saf20a105_tax) from saf20a where saf20a02_serial =@serial),0)
                    where saf2002_serial=@serial

                    Update saf20 set 
                    saf20106_total_amt = ISNULL(saf20103_sales_amt,0)+ISNULL(saf20103_sales_amt,0)+ISNULL(saf20105_tax,0)
                    where saf2002_serial=@serial
                    
                    Update saf20 set 
                    saf2038_inv_no=@fisrtInvoice,saf20108_inv_no_end = @Invoice,saf2039_inv_date=getdate()
                    where saf2002_serial=@serial

                    Update arf25 set 
                    arf2505_buy_next_guino = @Invoice,arf2506_buy_last_date=getdate()
                    where saf2002_serial=@serial


                    UPDATE
                        Table_A
                    SET
	                    Table_A.pgf2208_flag = Table_B.saf20109_tax_class,
	                    Table_A.pgf2209_amount = Table_B.saf20103_sales_amt + Table_B.saf20104_freetax_amt,
	                    Table_A.pgf2210_tax = Table_B.saf20105_tax,
	                    Table_A.pgf2211_total = Table_B.saf20105_tax,
	                    Table_A.pgf2213_cname = Table_B.saf2014_rec_name,
	                    Table_A.pgf2214_caddress = Table_B.saf2019_rec_address,
	                    Table_A.pgf2215_cid = Table_B.saf20107_tax_id,
                        Table_A.pgf2251_amount01 = Table_B.saf20103_sales_amt,
                        Table_A.pgf2252_amount02 = Table_B.saf20104_freetax_amt,
                        Table_A.moduser =@User,
                        Table_A.moddate =GETDATE()
	
                    FROM
                        pgf22 AS Table_A
                        INNER JOIN saf20 AS Table_B
                            ON Table_A.pgf2206_s_no = Table_B.saf2038_inv_no 
                    WHERE
                        Table_A.pgf2206_s_no = @fisrtInvoice


                    DECLARE @saf20103_sales_amy numeric(9, 2) = (select saf20103_sales_amt from saf20 where saf2002_serial=@serial)
                    DECLARE @saf20104_freetax_amt numeric(9, 2) = (select saf20104_freetax_amt from saf20 where saf2002_serial=@serial)


                    IF @saf20103_sales_amy>0 and @saf20104_freetax_amt>0
                    Update saf20 set saf20109_tax_class =9 where saf2002_serial=@serial
                    ELSE IF @saf20103_sales_amy>0 and @saf20104_freetax_amt=0
                    Update saf20 set saf20109_tax_class =1 where saf2002_serial=@serial
                    ELSE IF @saf20103_sales_amy=0 and @saf20104_freetax_amt>0
                    Update saf20 set saf20109_tax_class =3 where saf2002_serial=@serial
                    go";
                    cmd.ExecuteNonQuery();
                }
            }




            return "Success";



        }
        private static void updateInvoice(SqlCommand cmd, InvoiceInfo Invoicedata)
        {
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@Id", Invoicedata.id);
            cmd.CommandText = @"
           update arf25 set arf2505_buy_next_guino=(arf2505_buy_next_guino+1),arf2506_buy_last_date=getdate() where id=@Id";
            cmd.ExecuteNonQuery();

        }



        private static InvoiceInfo getInvoice(SqlCommand cmd, string thisPeriods)
        {
            var hasInvoice = false;
            var Invoice = "";
            var id = "";
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@thisPeriods", thisPeriods);
            cmd.CommandText = @"
                        select top 1 * from arf25
                        where 
                        arf2501_inv_ym=@thisPeriods
                        and arf2503_buy_pieces >arf2504_buy_beused
                        order by arf2522_seq";

            using (var rd = cmd.ExecuteReader())
            {

                if (rd.Read())
                {
                    id = rd["id"].ToString();
                    if (rd["arf2504_buy_beused"].ToString() == "0")
                    {
                        Invoice = rd["arf2501_word"].ToString() + rd["arf2501_buy_startno"].ToString();

                    }
                    else
                    {
                        var num = rd["arf2505_buy_next_guino"].ToString();
                        var length = num.Length;
                        var nextnum = (Convert.ToInt64(num) + 1).ToString().PadLeft(length, '0');
                        Invoice = rd["arf2501_word"].ToString() + nextnum;
                    }
                }



            }

            var data = new InvoiceInfo();
            data.id = id;
            data.Invoice = Invoice;
            return data;



        }


        private class InvoiceInfo
        {

            public string id = "";
            public string Invoice = "";

        }

        private static Boolean checksaf20107_tax_id(string saf20107_tax_id)
        {
            var result = false;

            var cx = new List<int>() { 1, 2, 1, 2, 1, 2, 4, 1 };
            var NO = saf20107_tax_id;
            var SUM = 0;

            if (NO.Length != 8)
            {
                result = false;
                return result;
            }

            for (var i = 0; i < 8; i++)
            {
                var a = Convert.ToInt16(NO.Substring(i, 1));
                var b = cx[i];

                if (a * b > 9)
                {
                    var s = (a * b).ToString();
                    var n1 = Convert.ToInt16(s.Substring(0, 1));
                    var n2 = Convert.ToInt16(s.Substring(1, 1));
                    SUM += n1 + n2;

                }
                else
                {
                    SUM += a * b;
                }
            }

            if (SUM % 10 == 0)
            {

                result = true;
            }
            else if (NO.Substring(6, 1) == "7" && (SUM + 1) % 10 == 0)
            {
                result = true;

            }
            else
            {
                result = false;
                //error
            }





            return result;

        }


        public static List<OrderData> GetData(Filters Filter)
        {

            var datalist = new List<OrderData>();
            using (var conn = new SqlConnection(MyConnStringList.AzureGoodeasy))
            {
                conn.Open();
                var cmd = conn.CreateCommand();
                cmd.CommandText = @"
              SELECT B.*,C.cnf1003_char01 FROM  [dbo].[saf20] B
              inner join [dbo].[cnf10] C on B.saf2001_cuscode=C.cnf1002_fileorder and  cnf1001_filetype = 'D001'
              where (1=1) and EXISTS (select 1 from [dbo].[saf20a] A where A.saf20a02_serial=B.saf2002_serial)


             
                ";
                //cuscode
                if (!String.IsNullOrEmpty(Filter.cuscode_start.Trim()))
                {
                    cmd.CommandText += " and @cuscode_start<=saf2001_cuscode ";
                    cmd.Parameters.AddWithValue("@cuscode_start", Filter.cuscode_start);

                }
                if (!String.IsNullOrEmpty(Filter.cuscode_end.Trim()))
                {
                    cmd.CommandText += " and  @cuscode_end>=saf2001_cuscode ";
                    cmd.Parameters.AddWithValue("@cuscode_end", Filter.cuscode_end);

                }
                //deli_date
                if (!String.IsNullOrEmpty(Filter.deli_date_start.Trim()))
                {
                    cmd.CommandText += " and  @deli_date_start<=saf2084_deli_date ";
                    cmd.Parameters.AddWithValue("@deli_date_start", Filter.deli_date_start);

                }

                if (!String.IsNullOrEmpty(Filter.deli_date_end.Trim()))
                {
                    var DateEnd = Convert.ToDateTime(Filter.deli_date_end.Trim());

                    cmd.CommandText += " and saf2084_deli_date<@deli_date_end";
                    cmd.Parameters.AddWithValue("@deli_date_end", DateEnd.AddDays(1).ToString("yyyy/MM/dd"));

                }
                //serial
                if (!String.IsNullOrEmpty(Filter.serial_start.Trim()))
                {


                    cmd.CommandText += " and @serial_start<=saf2002_serial";
                    cmd.Parameters.AddWithValue("@serial_start", Filter.serial_start);

                }

                if (!String.IsNullOrEmpty(Filter.serial_end.Trim()))
                {
                    cmd.CommandText += " and saf2002_serial<=@serial_end";
                    cmd.Parameters.AddWithValue("@serial_end", Filter.serial_end);
                }

                //inv_date
                if (!String.IsNullOrEmpty(Filter.inv_date_start.Trim()))
                {
                    cmd.CommandText += " and EXISTS (select 1 from [dbo].[saf20a] A where A.saf20a02_serial=B.saf2002_serial and  @inv_date_start<=saf20a39_inv_date ) ";
                    cmd.Parameters.AddWithValue("@inv_date_start", Filter.inv_date_start);

                }

                if (!String.IsNullOrEmpty(Filter.inv_date_end.Trim()))
                {
                    var DateEnd = Convert.ToDateTime(Filter.inv_date_end.Trim());
                    cmd.CommandText += " and EXISTS (select 1 from [dbo].[saf20a] A where A.saf20a02_serial=B.saf2002_serial and  saf20a39_inv_date<@inv_date_end ) ";
                    cmd.Parameters.AddWithValue("@inv_date_end", DateEnd.AddDays(1).ToString("yyyy/MM/dd"));

                }

                //inv_no
                if (!String.IsNullOrEmpty(Filter.inv_no_start.Trim()))
                {


                    cmd.CommandText += " and EXISTS (select 1 from [dbo].[saf20a] A where A.saf20a02_serial=B.saf2002_serial and @inv_no_start<=saf20a38_inv_no";
                    cmd.Parameters.AddWithValue("@inv_no_start", Filter.inv_no_start);

                }

                if (!String.IsNullOrEmpty(Filter.inv_no_end.Trim()))
                {
                    cmd.CommandText += "  and EXISTS (select 1 from [dbo].[saf20a] A where A.saf20a02_serial=B.saf2002_serialand saf20a38_inv_no<=@inv_no_end";
                    cmd.Parameters.AddWithValue("@inv_no_end", Filter.inv_no_end);
                }


                if (!String.IsNullOrEmpty(Filter.inv_no_y.Trim()))
                {


                    cmd.CommandText += " and saf2038_inv_no<>''";

                }
                if (!String.IsNullOrEmpty(Filter.inv_no_n.Trim()))
                {


                    cmd.CommandText += " and saf2038_inv_no=''";


                }



                using (var rd = cmd.ExecuteReader())
                {

                    while (rd.Read())
                    {

                        var data = new OrderData();
                        data.Id = rd["Id"].ToString();
                        data.cnf1003_char01 = rd["cnf1003_char01"].ToString();
                        data.saf2001_cuscode = rd["saf2001_cuscode"].ToString();
                        data.saf2046_mana_fee = rd["saf2046_mana_fee"].ToString();
                        data.saf20107_tax_id = rd["saf20107_tax_id"].ToString();
                        data.saf2002_serial = rd["saf2002_serial"].ToString();
                        data.saf2014_rec_name = rd["saf2014_rec_name"].ToString();
                        data.saf2015_rec_cell = rd["saf2015_rec_cell"].ToString();
                        data.saf20103_sales_amt = rd["saf20103_sales_amt"].ToString();
                        data.saf20105_tax = rd["saf20105_tax"].ToString();
                        data.saf20106_total_amt = rd["saf20106_total_amt"].ToString();
                        data.saf20110_printmark = rd["saf20110_printmark"].ToString();
                        data.saf20102_incl_fee = rd["saf20110_printmark"].ToString();
                        datalist.Add(data);
                    }

                }

                foreach (var data in datalist)
                {
                    cmd.Parameters.Clear();
                    cmd.Parameters.AddWithValue("@serial", data.saf2002_serial);
                    cmd.CommandText = " SELECT * FROM [dbo].[saf20a] where saf20a02_serial =@serial";
                    using (var rd = cmd.ExecuteReader())
                    {
                        while (rd.Read())
                        {


                            var OrderbodyData = new OrderbodyData();

                            OrderbodyData.Id = rd["Id"].ToString();
                            OrderbodyData.saf20a38_inv_no = rd["saf20a38_inv_no"].ToString();
                            OrderbodyData.saf20a39_inv_date = rd["saf20a39_inv_date"].ToString();
                            OrderbodyData.saf20a37_pcode = rd["saf20a37_pcode"].ToString();
                            OrderbodyData.saf20a31_psname = rd["saf20a31_psname"].ToString();
                            OrderbodyData.saf20a32_pname = rd["saf20a32_pname"].ToString();
                            OrderbodyData.saf20a34_ship_pname = rd["saf20a34_ship_pname"].ToString();
                            OrderbodyData.saf20a03_ord_no = rd["saf20a03_ord_no"].ToString();
                            OrderbodyData.saf20a86_tax_class = rd["saf20a86_tax_class"].ToString();

                            OrderbodyData.saf20a48_price_sub = rd["saf20a48_price_sub"].ToString();
                            OrderbodyData.saf20a46_mana_fee = rd["saf20a46_mana_fee"].ToString();
                            OrderbodyData.saf20a41_ord_qty = rd["saf20a41_ord_qty"].ToString();
                            OrderbodyData.saf20a47_price = rd["saf20a47_price"].ToString();
                            

                            data.OrderbodyDataList.Add(OrderbodyData);


                        }
                    }


                }



            }










            return datalist;
        }

        public class OrderData
        {
            public string Id { get; set; }
            public string cnf1003_char01 { get; set; }
            public string saf2001_cuscode { get; set; }
            public string saf2046_mana_fee { get; set; }
            public string saf20107_tax_id { get; set; }
            public string saf2002_serial { get; set; }
            public string saf2014_rec_name { get; set; }
            public string saf2015_rec_cell { get; set; }
            public string saf20103_sales_amt { get; set; }
            public string saf20105_tax { get; set; }
            public string saf20106_total_amt { get; set; }
            public string saf20110_printmark { get; set; }
            public string saf20102_incl_fee { get; set; }




            public List<OrderbodyData> OrderbodyDataList = new List<OrderbodyData>();




        }

        public class OrderbodyData
        {
            public string Id { get; set; }
            public string saf20a02_serial { get; set; }
            public string saf20a38_inv_no { get; set; }
            public string saf20a39_inv_date { get; set; }
            public string saf20a37_pcode { get; set; }
            public string saf20a31_psname { get; set; }
            public string saf20a32_pname { get; set; }
            public string saf20a34_ship_pname { get; set; }
            public string saf20a03_ord_no { get; set; }
            public string saf20a86_tax_class { get; set; }
            public string saf20a48_price_sub { get; set; }
            public string saf20a46_mana_fee { get; set; }
            public string saf20a103_sales_amt { get; set; }
            public string saf20a104_freetax_amt { get; set; }
            public string saf20a41_ord_qty { get; set; }
             public string saf20a47_price { get; set; }
            
        }

        public class Filters
        {
            public string cuscode_start { get; set; }
            public string cuscode_end { get; set; }

            public string deli_date_start { get; set; }
            public string deli_date_end { get; set; }

            public string serial_start { get; set; }
            public string serial_end { get; set; }

            public string inv_date_start { get; set; }
            public string inv_date_end { get; set; }

            public string inv_no_start { get; set; }
            public string inv_no_end { get; set; }

            public string inv_no_y { get; set; }
            public string inv_no_n { get; set; }

        }




    }

}
