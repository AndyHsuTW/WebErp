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
using System.Data;
using ExcelDataReader;
using ErpBaseLibrary.DB;
using System.Data.SqlClient;
namespace WebERPLibrary
{
    public class Dsap92501
    {
        public static List<string> Import_saf25(List<saf25FileInfo> List, string user)
        {
            var msg = new List<string>();
            using (var conn = new SqlConnection(MyConnStringList.AzureGoodeasy))
            {
                conn.Open();
                var cmd = conn.CreateCommand();

                foreach (var data in List)
                {
                    var haserror = false;
                    if (data.cnf1004_char02 != "" && data.ErrorMsg.Count == 0)
                    {
                        foreach (var saf25 in data.saf25List)
                        {
                            try
                            {
                                //30170806481078-003
                                Insertsaf25(cmd, saf25, data.cnf1004_char02, user);
                            }
                            catch (Exception ex)
                            {
                                if (!haserror)
                                {

                                    msg.Add(data.FileName);
                                }


                                haserror = true;
                            }

                        }
                    }
                }
            }
            return msg;

        }
        public static void Insertsaf25(SqlCommand cmd, saf25 saf25, string cnf1004_char02, string LoginUser)
        {
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@LoginUser", LoginUser);
            cmd.Parameters.AddWithValue("@saf2501_cuscode", cnf1004_char02);
            cmd.Parameters.AddWithValue("@saf2502_seq", saf25.saf2502_seq ?? "");
            cmd.Parameters.AddWithValue("@saf2503_ord_no", saf25.saf2503_ord_no??"");
            cmd.Parameters.AddWithValue("@saf2504_ord_date", saf25.saf2504_ord_date);
            cmd.Parameters.AddWithValue("@saf2505_ord_remark", saf25.saf2505_ord_remark ?? "");
            cmd.Parameters.AddWithValue("@saf2506_ord_status", saf25.saf2506_ord_status ?? "");
            cmd.Parameters.AddWithValue("@saf2507_ord_class", saf25.saf2507_ord_class ?? "");
            cmd.Parameters.AddWithValue("@saf2508_ord_plan", saf25.saf2508_ord_plan ?? "");
            cmd.Parameters.AddWithValue("@saf2509_ord_shop", saf25.saf2509_ord_shop ?? "");
            cmd.Parameters.AddWithValue("@saf2510_ord_name", saf25.saf2510_ord_name ?? "");
            cmd.Parameters.AddWithValue("@saf2511_ord_cell", saf25.saf2511_ord_cell ?? "");
            cmd.Parameters.AddWithValue("@saf2512_ord_tel01", saf25.saf2512_ord_tel01 ?? "");
            cmd.Parameters.AddWithValue("@saf2513_ord_tel02", saf25.saf2513_ord_tel02 ?? "");
            cmd.Parameters.AddWithValue("@saf2514_rec_name", saf25.saf2514_rec_name ?? "");
            cmd.Parameters.AddWithValue("@saf2515_rec_cell", saf25.saf2515_rec_cell ?? "");
            cmd.Parameters.AddWithValue("@saf2516_rec_tel01", saf25.saf2516_rec_tel01 ?? "");
            cmd.Parameters.AddWithValue("@saf2517_rec_tel02", saf25.saf2517_rec_tel02 ?? "");
            cmd.Parameters.AddWithValue("@saf2518_rec_zip", saf25.saf2518_rec_zip ?? "");
            cmd.Parameters.AddWithValue("@saf2519_rec_address", saf25.saf2519_rec_address ?? "");

            if (!String.IsNullOrEmpty(saf25.saf2520_dis_date))
            {

                cmd.Parameters.AddWithValue("@saf2520_dis_date", saf25.saf2520_dis_date);
            }
            else
            {
                cmd.Parameters.AddWithValue("@saf2520_dis_date", DBNull.Value);

            }

            cmd.Parameters.AddWithValue("@saf2521_dis_time", saf25.saf2521_dis_time ?? "");
            cmd.Parameters.AddWithValue("@saf2522_dis_demand", saf25.saf2522_dis_demand ?? "");
            if (!String.IsNullOrEmpty(saf25.saf2523_ship_date))
            {

                cmd.Parameters.AddWithValue("@saf2523_ship_date", saf25.saf2523_ship_date);
            }
            else
            {
                cmd.Parameters.AddWithValue("@saf2523_ship_date", DBNull.Value);

            }


            cmd.Parameters.AddWithValue("@saf2524_ship_remark", saf25.saf2524_ship_remark ?? "");
            cmd.Parameters.AddWithValue("@saf2525_ship_condi", saf25.saf2525_ship_condi ?? "");
            cmd.Parameters.AddWithValue("@saf2526_ship_status", saf25.saf2526_ship_status ?? "");
            cmd.Parameters.AddWithValue("@saf2527_ship_no", saf25.saf2527_ship_no ?? "");
            cmd.Parameters.AddWithValue("@saf2528_fre_no", saf25.saf2528_fre_no ?? "");
            cmd.Parameters.AddWithValue("@saf2529_logis_no", saf25.saf2529_logis_no ?? "");
            cmd.Parameters.AddWithValue("@saf2530_logis_comp", saf25.saf2530_logis_comp ?? "");
            cmd.Parameters.AddWithValue("@saf2531_psname", saf25.saf2531_psname ?? "");
            cmd.Parameters.AddWithValue("@saf2532_pname", saf25.saf2532_pname ?? "");
            cmd.Parameters.AddWithValue("@saf2533_pspec", saf25.saf2533_pspec ?? "");
            cmd.Parameters.AddWithValue("@saf2534_ship_pname", saf25.saf2534_ship_pname ?? "");
            cmd.Parameters.AddWithValue("@saf2535_ptpye", saf25.saf2535_ptpye ?? "");
            cmd.Parameters.AddWithValue("@saf2536_pcode_v", saf25.saf2536_pcode_v ?? "");
            cmd.Parameters.AddWithValue("@saf2537_pcode", saf25.saf2537_pcode ?? "");
            cmd.Parameters.AddWithValue("@saf2538_inv_no", saf25.saf2538_inv_no ?? "");

            if (!String.IsNullOrEmpty(saf25.saf2539_inv_date))
            {

                cmd.Parameters.AddWithValue("@saf2539_inv_date", saf25.saf2539_inv_date);
            }
            else
            {
                cmd.Parameters.AddWithValue("@saf2539_inv_date", DBNull.Value);

            }
            cmd.Parameters.AddWithValue("@saf2540_ship_qty", String.IsNullOrEmpty(saf25.saf2540_ship_qty) ? "0" : saf25.saf2540_ship_qty);
            cmd.Parameters.AddWithValue("@saf2541_ord_qty", String.IsNullOrEmpty(saf25.saf2541_ord_qty) ? "0" : saf25.saf2541_ord_qty);
            cmd.Parameters.AddWithValue("@saf2542_groups", String.IsNullOrEmpty(saf25.saf2542_groups) ? "0" : saf25.saf2542_groups);
            cmd.Parameters.AddWithValue("@saf2543_cancel_qty", String.IsNullOrEmpty(saf25.saf2543_cancel_qty) ? "0" : saf25.saf2543_cancel_qty);
            cmd.Parameters.AddWithValue("@saf2544_cost", String.IsNullOrEmpty(saf25.saf2544_cost) ? "0" : saf25.saf2544_cost);
            cmd.Parameters.AddWithValue("@saf2545_cost_sub", String.IsNullOrEmpty(saf25.saf2545_cost_sub) ? "0" : saf25.saf2545_cost_sub);
            cmd.Parameters.AddWithValue("@saf2546_mana_fee", String.IsNullOrEmpty(saf25.saf2540_ship_qty) ? "0" : saf25.saf2540_ship_qty);
            cmd.Parameters.AddWithValue("@saf2547_price", String.IsNullOrEmpty(saf25.saf2547_price) ? "0" : saf25.saf2547_price);
            cmd.Parameters.AddWithValue("@saf2548_price_sub", String.IsNullOrEmpty(saf25.saf2548_price_sub) ? "0" : saf25.saf2548_price_sub);
            if (!String.IsNullOrEmpty(saf25.saf2549_paymt_date))
            {

                cmd.Parameters.AddWithValue("@saf2549_paymt_date", saf25.saf2549_paymt_date);
            }
            else
            {
                cmd.Parameters.AddWithValue("@saf2549_paymt_date", DBNull.Value);

            }




            cmd.Parameters.AddWithValue("@saf2550_paymt_way", saf25.saf2550_paymt_way ?? "");
            cmd.Parameters.AddWithValue("@saf2551_paymt_status", saf25.saf2551_paymt_status ?? "");
            cmd.Parameters.AddWithValue("@saf2552_return", saf25.saf2552_return ?? "");
            cmd.Parameters.AddWithValue("@saf2553_gifts", saf25.saf2553_gifts ?? "");
            cmd.Parameters.AddWithValue("@saf2554_identifier", saf25.saf2554_identifier ?? "0");
            cmd.Parameters.AddWithValue("@saf2555_chg_price", saf25.saf2555_chg_price ?? "");
            cmd.Parameters.AddWithValue("@saf2556_leave_msg", saf25.saf2556_leave_msg ?? "");
            cmd.Parameters.AddWithValue("@saf2557_open_no", saf25.saf2557_open_no ?? "");
            cmd.Parameters.AddWithValue("@saf2558_trans_yn", saf25.saf2558_trans_yn ?? "");
            cmd.Parameters.AddWithValue("@saf2559_option_case", saf25.saf2559_option_case ?? "");
            cmd.Parameters.AddWithValue("@saf2560_unit", saf25.saf2560_unit ?? "");
            cmd.Parameters.AddWithValue("@saf2561_option", saf25.saf2561_option ?? "");
            if (!String.IsNullOrEmpty(saf25.saf2562_warehs_date))
            {

                cmd.Parameters.AddWithValue("@saf2562_warehs_date", saf25.saf2562_warehs_date);
            }
            else
            {
                cmd.Parameters.AddWithValue("@saf2562_warehs_date", DBNull.Value);

            }

           

            cmd.Parameters.AddWithValue("@saf2563_county", saf25.saf2563_county ?? "");
            cmd.Parameters.AddWithValue("@saf2564_post_box", saf25.saf2564_post_box ?? "");
            cmd.Parameters.AddWithValue("@saf2565_chg_notes", saf25.saf2565_chg_notes ?? "");
            cmd.Parameters.AddWithValue("@saf2566_warm", saf25.saf2566_warm ?? "");
            cmd.Parameters.AddWithValue("@saf2567_carton_spec", saf25.saf2567_carton_spec ?? "");
            cmd.Parameters.AddWithValue("@saf2568_vendor_no", saf25.saf2568_vendor_no ?? "");
            cmd.Parameters.AddWithValue("@saf2569_vendor_name", saf25.saf2569_vendor_name ?? "");
            cmd.Parameters.AddWithValue("@saf2570_activity", saf25.saf2570_activity ?? "");
            cmd.Parameters.AddWithValue("@saf2571_auction", saf25.saf2571_auction ?? "");
            cmd.Parameters.AddWithValue("@saf2572_merge", saf25.saf2572_merge ?? "");
            cmd.Parameters.AddWithValue("@saf2573_discount", String.IsNullOrEmpty(saf25.saf2573_discount) ? "0" : saf25.saf2573_discount);

            if (!String.IsNullOrEmpty(saf25.saf2574_chang_d))
            {cmd.Parameters.AddWithValue("@saf2574_chang_d", saf25.saf2574_chang_d);}
            else
            { cmd.Parameters.AddWithValue("@saf2574_chang_d", DBNull.Value);}

            if (!String.IsNullOrEmpty(saf25.saf2575_check_d))
            {  cmd.Parameters.AddWithValue("@saf2575_check_d", saf25.saf2575_check_d);}
            else
            {   cmd.Parameters.AddWithValue("@saf2575_check_d", DBNull.Value);}

            if (!String.IsNullOrEmpty(saf25.saf2576_cancel_d))
            { cmd.Parameters.AddWithValue("@saf2576_cancel_d", saf25.saf2576_cancel_d);}
            else
            {  cmd.Parameters.AddWithValue("@saf2576_cancel_d", DBNull.Value); }


            cmd.Parameters.AddWithValue("@saf2577_canwatch", saf25.saf2577_canwatch ?? "");
            cmd.Parameters.AddWithValue("@saf2578_get_acc", saf25.saf2578_get_acc ?? "");
            cmd.Parameters.AddWithValue("@saf2579_auction_y", saf25.saf2579_auction_y ?? "");
            cmd.Parameters.AddWithValue("@saf2580_email", saf25.saf2580_email ?? "");
            cmd.Parameters.AddWithValue("@saf2581_cancel_ｒ", saf25.saf2581_cancel_ｒ ?? "");
            cmd.Parameters.AddWithValue("@saf2582_serial", String.IsNullOrEmpty(saf25.saf2582_serial) ? "0" : saf25.saf2582_serial);
            cmd.Parameters.AddWithValue("@saf2583_store_remark", saf25.saf2583_store_remark ?? "");


            if (!String.IsNullOrEmpty(saf25.saf2584_deli_date))
            { cmd.Parameters.AddWithValue("@saf2584_deli_date", saf25.saf2584_deli_date); }
            else
            { cmd.Parameters.AddWithValue("@saf2584_deli_date", DBNull.Value);}

            if (!String.IsNullOrEmpty(saf25.saf2585_conf_date))
            { cmd.Parameters.AddWithValue("@saf2585_conf_date", saf25.saf2585_conf_date); }
            else{cmd.Parameters.AddWithValue("@saf2585_conf_date", DBNull.Value);}

            cmd.Parameters.AddWithValue("@saf2586_tax_class", saf25.saf2586_tax_class ?? "");
            cmd.Parameters.AddWithValue("@saf2587_gift_pnt", String.IsNullOrEmpty(saf25.saf2587_gift_pnt) ? "0" : saf25.saf2587_gift_pnt);
            cmd.Parameters.AddWithValue("@saf2588_gift_amt", String.IsNullOrEmpty(saf25.saf2588_gift_amt) ? "0" : saf25.saf2588_gift_amt);
            cmd.Parameters.AddWithValue("@saf2589_order_amt", String.IsNullOrEmpty(saf25.saf2589_order_amt) ? "0" : saf25.saf2589_order_amt);

            var filter = "saf2503_ord_no=@saf2503_ord_no and saf2501_cuscode=@saf2501_cuscode";

            if (cnf1004_char02 == "140")
            {
                filter = "saf2504_ord_date=@saf2504_ord_date and saf2536_pcode_v=@saf2536_pcode_v and saf2578_get_acc=@saf2578_get_acc";
            }
           
            


            cmd.CommandText = String.Format(@"
DECLARE @Exist int

SELECT @Exist=1
  FROM [dbo].[saf25] where {0}

if(@Exist=1)
begin
update [dbo].[saf25]
 set
       saf2502_seq=@saf2502_seq
      ,saf2504_ord_date=@saf2504_ord_date
      ,saf2505_ord_remark=@saf2505_ord_remark
      ,saf2506_ord_status=@saf2506_ord_status
      ,saf2507_ord_class=@saf2507_ord_class
      ,saf2508_ord_plan=@saf2508_ord_plan
      ,saf2509_ord_shop=@saf2509_ord_shop
      ,saf2510_ord_name=@saf2510_ord_name
      ,saf2511_ord_cell=@saf2511_ord_cell
      ,saf2512_ord_tel01=@saf2512_ord_tel01
      ,saf2513_ord_tel02=@saf2513_ord_tel02
      ,saf2514_rec_name=@saf2514_rec_name
      ,saf2515_rec_cell=@saf2515_rec_cell
      ,saf2516_rec_tel01=@saf2516_rec_tel01
      ,saf2517_rec_tel02=@saf2517_rec_tel02
      ,saf2518_rec_zip=@saf2518_rec_zip
      ,saf2519_rec_address=@saf2519_rec_address
      ,saf2520_dis_date=@saf2520_dis_date
      ,saf2521_dis_time=@saf2521_dis_time
      ,saf2522_dis_demand=@saf2522_dis_demand
      ,saf2523_ship_date=@saf2523_ship_date
      ,saf2524_ship_remark=@saf2524_ship_remark
      ,saf2525_ship_condi=@saf2525_ship_condi
      ,saf2526_ship_status=@saf2526_ship_status
      ,saf2527_ship_no=@saf2527_ship_no
      ,saf2528_fre_no=@saf2528_fre_no
      ,saf2529_logis_no=@saf2529_logis_no
      ,saf2530_logis_comp=@saf2530_logis_comp
      ,saf2531_psname=@saf2531_psname
      ,saf2532_pname=@saf2532_pname
      ,saf2533_pspec=@saf2533_pspec
      ,saf2534_ship_pname=@saf2534_ship_pname
      ,saf2535_ptpye=@saf2535_ptpye
      ,saf2536_pcode_v=@saf2536_pcode_v
      ,saf2537_pcode=@saf2537_pcode
      ,saf2538_inv_no=@saf2538_inv_no
      ,saf2539_inv_date=@saf2539_inv_date
      ,saf2540_ship_qty=@saf2540_ship_qty
      ,saf2541_ord_qty=@saf2541_ord_qty
      ,saf2542_groups=@saf2542_groups
      ,saf2543_cancel_qty=@saf2543_cancel_qty
      ,saf2544_cost=@saf2544_cost
      ,saf2545_cost_sub=@saf2545_cost_sub
      ,saf2546_mana_fee=@saf2546_mana_fee
      ,saf2547_price=@saf2547_price
      ,saf2548_price_sub=@saf2548_price_sub
      ,saf2549_paymt_date=@saf2549_paymt_date
      ,saf2550_paymt_way=@saf2550_paymt_way
      ,saf2551_paymt_status=@saf2551_paymt_status
      ,saf2552_return=@saf2552_return
      ,saf2553_gifts=@saf2553_gifts
      ,saf2554_identifier=@saf2554_identifier
      ,saf2555_chg_price=@saf2555_chg_price
      ,saf2556_leave_msg=@saf2556_leave_msg
      ,saf2557_open_no=@saf2557_open_no
      ,saf2558_trans_yn=@saf2558_trans_yn
      ,saf2559_option_case=@saf2559_option_case
      ,saf2560_unit=@saf2560_unit
      ,saf2561_option=@saf2561_option
      ,saf2562_warehs_date=@saf2562_warehs_date
      ,saf2563_county=@saf2563_county
      ,saf2564_post_box=@saf2564_post_box
      ,saf2565_chg_notes=@saf2565_chg_notes
      ,saf2566_warm=@saf2566_warm
      ,saf2567_carton_spec=@saf2567_carton_spec
      ,saf2568_vendor_no=@saf2568_vendor_no
      ,saf2569_vendor_name=@saf2569_vendor_name
      ,saf2570_activity=@saf2570_activity
      ,saf2571_auction=@saf2571_auction
      ,saf2572_merge=@saf2572_merge
      ,saf2573_discount=@saf2573_discount
      ,saf2574_chang_d=@saf2574_chang_d
      ,saf2575_check_d=@saf2575_check_d
      ,saf2576_cancel_d=@saf2576_cancel_d
      ,saf2577_canwatch=@saf2577_canwatch
      ,saf2578_get_acc=@saf2578_get_acc
      ,saf2579_auction_y=@saf2579_auction_y
      ,saf2580_email=@saf2580_email
      ,saf2581_cancel_ｒ=@saf2581_cancel_ｒ
      ,saf2582_serial=@saf2582_serial
      ,saf2583_store_remark=@saf2583_store_remark
      ,saf2584_deli_date=@saf2584_deli_date
      ,saf2585_conf_date=@saf2585_conf_date
      ,saf2586_tax_class=@saf2586_tax_class
      ,saf2587_gift_pnt=@saf2587_gift_pnt
      ,saf2588_gift_amt=@saf2588_gift_amt
      ,saf2589_order_amt=@saf2589_order_amt
      ,moduser=@LoginUser
      ,moddate=GETDATE()
	  where {0}
end
else
begin
INSERT INTO [dbo].[saf25]
           (
            [saf2501_cuscode]
           ,[saf2502_seq]
           ,[saf2503_ord_no]
           ,[saf2504_ord_date]
           ,[saf2505_ord_remark]
           ,[saf2506_ord_status]
           ,[saf2507_ord_class]
           ,[saf2508_ord_plan]
           ,[saf2509_ord_shop]
           ,[saf2510_ord_name]
           ,[saf2511_ord_cell]
           ,[saf2512_ord_tel01]
           ,[saf2513_ord_tel02]
           ,[saf2514_rec_name]
           ,[saf2515_rec_cell]
           ,[saf2516_rec_tel01]
           ,[saf2517_rec_tel02]
           ,[saf2518_rec_zip]
           ,[saf2519_rec_address]
           ,[saf2520_dis_date]
           ,[saf2521_dis_time]
           ,[saf2522_dis_demand]
           ,[saf2523_ship_date]
           ,[saf2524_ship_remark]
           ,[saf2525_ship_condi]
           ,[saf2526_ship_status]
           ,[saf2527_ship_no]
           ,[saf2528_fre_no]
           ,[saf2529_logis_no]
           ,[saf2530_logis_comp]
           ,[saf2531_psname]
           ,[saf2532_pname]
           ,[saf2533_pspec]
           ,[saf2534_ship_pname]
           ,[saf2535_ptpye]
           ,[saf2536_pcode_v]
           ,[saf2537_pcode]
           ,[saf2538_inv_no]
           ,[saf2539_inv_date]
           ,[saf2540_ship_qty]
           ,[saf2541_ord_qty]
           ,[saf2542_groups]
           ,[saf2543_cancel_qty]
           ,[saf2544_cost]
           ,[saf2545_cost_sub]
           ,[saf2546_mana_fee]
           ,[saf2547_price]
           ,[saf2548_price_sub]
           ,[saf2549_paymt_date]
           ,[saf2550_paymt_way]
           ,[saf2551_paymt_status]
           ,[saf2552_return]
           ,[saf2553_gifts]
           ,[saf2554_identifier]
           ,[saf2555_chg_price]
           ,[saf2556_leave_msg]
           ,[saf2557_open_no]
           ,[saf2558_trans_yn]
           ,[saf2559_option_case]
           ,[saf2560_unit]
           ,[saf2561_option]
           ,[saf2562_warehs_date]
           ,[saf2563_county]
           ,[saf2564_post_box]
           ,[saf2565_chg_notes]
           ,[saf2566_warm]
           ,[saf2567_carton_spec]
           ,[saf2568_vendor_no]
           ,[saf2569_vendor_name]
           ,[saf2570_activity]
           ,[saf2571_auction]
           ,[saf2572_merge]
           ,[saf2573_discount]
           ,[saf2574_chang_d]
           ,[saf2575_check_d]
           ,[saf2576_cancel_d]
           ,[saf2577_canwatch]
           ,[saf2578_get_acc]
           ,[saf2579_auction_y]
           ,[saf2580_email]
           ,[saf2581_cancel_ｒ]
           ,[saf2582_serial]
           ,[saf2583_store_remark]
           ,[saf2584_deli_date]
           ,[saf2585_conf_date]
           ,[saf2586_tax_class]
           ,[saf2587_gift_pnt]
           ,[saf2588_gift_amt]
           ,[saf2589_order_amt]
           ,[adduser]
           ,[adddate]
           ,[moduser]
           ,[moddate])
     VALUES
           (
         
            @saf2501_cuscode
           ,@saf2502_seq
           ,@saf2503_ord_no
           ,@saf2504_ord_date
           ,@saf2505_ord_remark
           ,@saf2506_ord_status
           ,@saf2507_ord_class
           ,@saf2508_ord_plan
           ,@saf2509_ord_shop
           ,@saf2510_ord_name
           ,@saf2511_ord_cell
           ,@saf2512_ord_tel01
           ,@saf2513_ord_tel02
           ,@saf2514_rec_name
           ,@saf2515_rec_cell
           ,@saf2516_rec_tel01
           ,@saf2517_rec_tel02
           ,@saf2518_rec_zip
           ,@saf2519_rec_address
           ,@saf2520_dis_date
           ,@saf2521_dis_time
           ,@saf2522_dis_demand
           ,@saf2523_ship_date
           ,@saf2524_ship_remark
           ,@saf2525_ship_condi
           ,@saf2526_ship_status
           ,@saf2527_ship_no
           ,@saf2528_fre_no
           ,@saf2529_logis_no
           ,@saf2530_logis_comp
           ,@saf2531_psname
           ,@saf2532_pname
           ,@saf2533_pspec
           ,@saf2534_ship_pname
           ,@saf2535_ptpye
           ,@saf2536_pcode_v
           ,@saf2537_pcode
           ,@saf2538_inv_no
           ,@saf2539_inv_date
           ,@saf2540_ship_qty
           ,@saf2541_ord_qty
           ,@saf2542_groups
           ,@saf2543_cancel_qty
           ,@saf2544_cost
           ,@saf2545_cost_sub
           ,@saf2546_mana_fee
           ,@saf2547_price
           ,@saf2548_price_sub
           ,@saf2549_paymt_date
           ,@saf2550_paymt_way
           ,@saf2551_paymt_status
           ,@saf2552_return
           ,@saf2553_gifts
           ,@saf2554_identifier
           ,@saf2555_chg_price
           ,@saf2556_leave_msg
           ,@saf2557_open_no
           ,@saf2558_trans_yn
           ,@saf2559_option_case
           ,@saf2560_unit
           ,@saf2561_option
           ,@saf2562_warehs_date
           ,@saf2563_county
           ,@saf2564_post_box
           ,@saf2565_chg_notes
           ,@saf2566_warm
           ,@saf2567_carton_spec
           ,@saf2568_vendor_no
           ,@saf2569_vendor_name
           ,@saf2570_activity
           ,@saf2571_auction
           ,@saf2572_merge
           ,@saf2573_discount
           ,@saf2574_chang_d
           ,@saf2575_check_d
           ,@saf2576_cancel_d
           ,@saf2577_canwatch
           ,@saf2578_get_acc
           ,@saf2579_auction_y
           ,@saf2580_email
           ,@saf2581_cancel_ｒ
           ,@saf2582_serial
           ,@saf2583_store_remark
           ,@saf2584_deli_date
           ,@saf2585_conf_date
           ,@saf2586_tax_class
           ,@saf2587_gift_pnt
           ,@saf2588_gift_amt
           ,@saf2589_order_amt
           ,@LoginUser
           ,GETDATE()
           ,@LoginUser
           ,GETDATE())
end
", filter);
            cmd.ExecuteNonQuery();

        }
        public static saf25FileInfo ImportExcels(string uploadsPath, string FileName, string OrderTime)
        {
            var saf25FileInfo = new saf25FileInfo();


            try
            {
                var filenumber = FileName.Substring(0, 2);

                
                if (filenumber=="01" && FileName.ToUpper().Contains(".CSV"))
                {
                    var rowList = setPreWork(uploadsPath, FileName, "100", ref saf25FileInfo);
                    SeventeenP_csvtosaf25(rowList, saf25FileInfo, OrderTime);
                }
                else if (filenumber == "02" && FileName.ToUpper().Contains(".CSV"))
                {
                    var rowList = setPreWork(uploadsPath, FileName, "102", ref saf25FileInfo);
                    MOMO_csvtosaf25(rowList, saf25FileInfo, OrderTime);
                }
                else if (filenumber == "03" && FileName.ToUpper().Contains(".CSV"))
                {
                    var rowList = setPreWork(uploadsPath, FileName, "104", ref saf25FileInfo);
                    Pchome_csvtosaf25(rowList, saf25FileInfo, OrderTime);
                }
                else if (filenumber == "23" && FileName.ToUpper().Contains(".CSV"))
                {
                    var rowList = setPreWork(uploadsPath, FileName, "142", ref saf25FileInfo);
                    Yahoo_csvtosaf25(rowList, saf25FileInfo, OrderTime);
                }
                else if (filenumber == "22" && FileName.ToUpper().Contains(".CSV"))
                {
                    var rowList = setPreWork(uploadsPath, FileName, "140", ref saf25FileInfo);
                    LuTien_csvtosaf25(rowList, saf25FileInfo, OrderTime);
                }
                else if (filenumber == "16" && FileName.ToUpper().Contains(".CSV"))
                {
                    var rowList = setPreWork(uploadsPath, FileName, "130", ref saf25FileInfo);
                    LienHo_csvtosaf25(rowList, saf25FileInfo, OrderTime);
                }

                else if (filenumber == "15" && FileName.ToUpper().Contains(".CSV"))
                {
                    var rowList = setPreWork(uploadsPath, FileName, "128", ref saf25FileInfo);
                    ShinQi_csvtosaf25(rowList, saf25FileInfo, OrderTime);
                }

                else if (filenumber == "14" && FileName.ToUpper().Contains(".CSV"))
                {
                    var rowList = setPreWork(uploadsPath, FileName, "126", ref saf25FileInfo);
                    Crazy_csvtosaf25(rowList, saf25FileInfo, OrderTime);
                }

                else if (filenumber == "13" && FileName.ToUpper().Contains(".CSV"))
                {
                    var rowList = setPreWork(uploadsPath, FileName, "124", ref saf25FileInfo);
                    DingDing_csvtosaf25(rowList, saf25FileInfo, OrderTime);
                }
                else if (filenumber == "12" && FileName.ToUpper().Contains(".CSV"))
                {
                    var rowList = setPreWork(uploadsPath, FileName, "122", ref saf25FileInfo);
                    UniPresident_csvtosaf25(rowList, saf25FileInfo, OrderTime);
                }
                else if (filenumber == "11" && FileName.ToUpper().Contains(".CSV"))
                {
                    var rowList = setPreWork(uploadsPath, FileName, "120", ref saf25FileInfo);
                    KS_csvtosaf25(rowList, saf25FileInfo, OrderTime);
                }
                else if (filenumber == "10" && FileName.ToUpper().Contains(".CSV"))
                {
                    var rowList = setPreWork(uploadsPath, FileName, "118", ref saf25FileInfo);
                    Gomaji_csvtosaf25(rowList, saf25FileInfo, OrderTime);
                }
                else if (filenumber == "09" && FileName.ToUpper().Contains(".CSV"))
                {
                    var rowList = setPreWork(uploadsPath, FileName, "116", ref saf25FileInfo);
                    ShenFang_csvtosaf25(rowList, saf25FileInfo, OrderTime);
                }
                else if (filenumber == "08" && FileName.ToUpper().Contains(".CSV"))
                {
                    var rowList = setPreWork(uploadsPath, FileName, "114", ref saf25FileInfo);
                    SonGuo_csvtosaf25(rowList, saf25FileInfo, OrderTime);
                }
                else if (filenumber == "07" && FileName.ToUpper().Contains(".CSV"))
                {
                    var rowList = setPreWork(uploadsPath, FileName, "112", ref saf25FileInfo);
                    ET_csvtosaf25(rowList, saf25FileInfo, OrderTime);
                }
                else if (filenumber == "06" && FileName.ToUpper().Contains(".CSV"))
                {
                    var rowList = setPreWork(uploadsPath, FileName, "110", ref saf25FileInfo);
                    LifeMarket_csvtosaf25(rowList, saf25FileInfo, OrderTime);
                }
                else if (filenumber == "05" && FileName.ToUpper().Contains(".CSV"))
                {
                    var rowList = setPreWork(uploadsPath, FileName, "108", ref saf25FileInfo);
                    TaiwanMobile_csvtosaf25(rowList, saf25FileInfo, OrderTime);
                }
                else if (filenumber == "04" && FileName.ToUpper().Contains(".CSV"))
                {
                    var rowList = setPreWork(uploadsPath, FileName, "106", ref saf25FileInfo);
                    FormosaPlastics_csvtosaf25(rowList, saf25FileInfo, OrderTime);
                }
                else if (filenumber == "18" && FileName.ToUpper().Contains(".CSV"))
                {
                    var rowList = setPreWork(uploadsPath, FileName, "132", ref saf25FileInfo);
                    YahooSmart_tosaf25(rowList, saf25FileInfo, OrderTime);
                }
                else if (filenumber == "19" && FileName.ToUpper().Contains(".CSV"))
                {
                    var rowList = setPreWork(uploadsPath, FileName, "134", ref saf25FileInfo);
                    Motian_tosaf25(rowList, saf25FileInfo, OrderTime);
                }
                else if (filenumber == "20" && FileName.ToUpper().Contains(".CSV"))
                {
                    var rowList = setPreWork(uploadsPath, FileName, "136", ref saf25FileInfo);
                    Letian_tosaf25(rowList, saf25FileInfo, OrderTime);
                }
                else if (filenumber == "21" && FileName.ToUpper().Contains(".CSV"))
                {
                    var rowList = setPreWork(uploadsPath, FileName, "139", ref saf25FileInfo);
                    PC_tosaf25(rowList, saf25FileInfo, OrderTime);
                }
                else if (filenumber == "17" && FileName.ToUpper().Contains(".CSV"))
                {
                    var rowList = setPreWork(uploadsPath, FileName, "103", ref saf25FileInfo);
                    MOMO2_csvtosaf25(rowList, saf25FileInfo, OrderTime);
                }
                else if (filenumber == "24" && FileName.ToUpper().Contains(".CSV"))
                {
                    var rowList = setPreWork(uploadsPath, FileName, "115", ref saf25FileInfo);
                    SonGuo2_csvtosaf25(rowList, saf25FileInfo, OrderTime);
                }
                else if (filenumber == "26" && FileName.ToUpper().Contains(".CSV"))
                {
                    var rowList = setPreWork(uploadsPath, FileName, "138", ref saf25FileInfo);
                    PC2_tosaf25(rowList, saf25FileInfo, OrderTime);
                }
                else if (filenumber == "27" && FileName.ToUpper().Contains(".CSV"))
                {
                    var rowList = setPreWork(uploadsPath, FileName, "156", ref saf25FileInfo);
                    ShoPee_csvtosaf25(rowList, saf25FileInfo, OrderTime);
                }
                else if (filenumber == "28" && FileName.ToUpper().Contains(".CSV"))
                {
                    var rowList = setPreWork(uploadsPath, FileName, "143", ref saf25FileInfo);
                    Yahoo_csvtosaf25(rowList, saf25FileInfo, OrderTime);
                }
            }
            catch (Exception ex)
            {
                saf25FileInfo.ErrorMsg = new List<ErrorInfo>();

                saf25FileInfo.ErrorMsg.Add(new ErrorInfo()
                {
                    column = "",
                    messenge = "解析過程出錯，請聯繫資訊人員"
                });

            }
            if (saf25FileInfo.ErrorMsg.Count > 0)
            {
                saf25FileInfo.saf25List = new List<saf25>();

            }
            return saf25FileInfo;
        }

        private static List<List<string>> ExcelTool(string path)
        {
            var rowList = new List<List<string>>();
            var file = new FileInfo(path);
            using (var stream = File.Open(path, FileMode.Open, FileAccess.Read))
            {
                IExcelDataReader reader;

                if (file.Extension.Equals(".xls"))
                {
                    reader = ExcelDataReader.ExcelReaderFactory.CreateBinaryReader(stream);
                }
                else if (file.Extension.Equals(".xlsx"))
                {
                    reader = ExcelDataReader.ExcelReaderFactory.CreateOpenXmlReader(stream);
                }
                else
                {
                    throw new Exception("Invalid FileName");
                }
                //// reader.IsFirstRowAsColumnNames
                var conf = new ExcelDataSetConfiguration
                {
                    ConfigureDataTable = _ => new ExcelDataTableConfiguration
                    {
                        UseHeaderRow = false
                    }
                };
                var dataSet = reader.AsDataSet(conf);
                var dataTable = dataSet.Tables[0];
                for (var i = 0; i < dataTable.Rows.Count; i++)
                {

                    var row = new List<string>();
                    for (var j = 0; j < dataTable.Columns.Count; j++)
                    {

                        row.Add(dataTable.Rows[i][j].ToString().Replace("\n", " "));

                    }
                    rowList.Add(row);
                }
            }
            return rowList;
        }

        private static List<List<string>> setExcelPreWork(string p_uploadsPath, string p_FileName, string cnf1002_fileorder, ref saf25FileInfo p_saf25FileInfo)
        {

            var rowList = ExcelTool(p_uploadsPath);
            CompanyExists_cnf1004_char02(cnf1002_fileorder, ref  p_saf25FileInfo);
            p_saf25FileInfo.FileName = p_FileName;
            return rowList;
        }

        private static void PC_tosaf25(List<List<string>> rowList, saf25FileInfo saf25FileInfo, string OrderTime)
        {
            for (var j = 0; j < rowList.Count; j++)
            {
                var saf25 = new saf25();
                if (j <= 5) continue;//跳過標題

                var row = rowList[j];
                if (row.Count != 11) continue;
                if (string.IsNullOrEmpty(row[0]) || string.IsNullOrEmpty(row[3])) continue;


                for (var k = 0; k < row.Count; k++)
                {
                    var column = row[k];
                    //A
                    if (k == 0)
                    {
                        if (column.Trim() == "")
                        {
                            saf25FileInfo.ErrorMsg.Add(CreatErrorMsg(j, k, "沒有訂單編號"));
                        }
                        saf25.saf2503_ord_no = column;
                    }
                    //B
                    else if (k == 1)
                    {
                        if (column.Trim() == "")
                        {
                            saf25.saf2504_ord_date = OrderTime;

                        }
                        else
                        {
                            saf25.saf2504_ord_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                        }
                    }
                    //C
                    else if (k == 2)
                    {
                        saf25.saf2510_ord_name = column;
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
                        saf25.saf2531_psname = column;
                    }
                    //G
                    else if (k == 6)
                    {
                        saf25.saf2541_ord_qty = IntTryParse(column, saf25FileInfo, j, k, false); ;
                    }
                    //H
                    else if (k == 7)
                    {
                        saf25.saf2548_price_sub = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                    }
                    //I
                    else if (k == 8)
                    {
                        saf25.saf2532_pname = column;
                    }
                    //J
                    else if (k == 9)
                    {

                        saf25.saf2505_ord_remark = column;
                    }
                    //K
                    else if (k == 10)
                    {
                        saf25.saf2538_inv_no = column;
                    }

                }
                saf25FileInfo.saf25List.Add(saf25);
            }


        }

        private static void PC2_tosaf25(List<List<string>> rowList, saf25FileInfo saf25FileInfo, string OrderTime)
        {
            for (var j = 0; j < rowList.Count; j++)
            {
                var saf25 = new saf25();
                if (j <= 5) continue;//跳過標題

                var row = rowList[j];
                if (row.Count != 11) continue;
                if (string.IsNullOrEmpty(row[0]) || string.IsNullOrEmpty(row[3])) continue;


                for (var k = 0; k < row.Count; k++)
                {
                    var column = row[k];
                    //A
                    if (k == 0)
                    {
                        if (column.Trim() == "")
                        {
                            saf25FileInfo.ErrorMsg.Add(CreatErrorMsg(j, k, "沒有訂單編號"));
                        }
                        saf25.saf2503_ord_no = column;
                    }
                    //B
                    else if (k == 1)
                    {
                        if (column.Trim() == "")
                        {
                            saf25.saf2504_ord_date = OrderTime;

                        }
                        else
                        {
                            saf25.saf2504_ord_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                        }
                    }
                    //C
                    else if (k == 2)
                    {
                        saf25.saf2510_ord_name = column;
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
                        saf25.saf2531_psname = column;
                    }
                    //G
                    else if (k == 6)
                    {
                        saf25.saf2541_ord_qty = IntTryParse(column, saf25FileInfo, j, k, false); ;
                    }
                    //H
                    else if (k == 7)
                    {
                        saf25.saf2548_price_sub = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                    }
                    //I
                    else if (k == 8)
                    {
                        saf25.saf2532_pname = column;
                    }
                    //J
                    else if (k == 9)
                    {

                        saf25.saf2505_ord_remark = column;
                    }
                    //K
                    else if (k == 10)
                    {
                        saf25.saf2538_inv_no = column;
                    }

                }
                saf25FileInfo.saf25List.Add(saf25);
            }


        }

        private static void Letian_tosaf25(List<List<string>> rowList, saf25FileInfo saf25FileInfo, string OrderTime)
        {
            for (var j = 0; j < rowList.Count; j++)
            {
                var saf25 = new saf25();
                if (j == 0) continue;//跳過標題

                var row = rowList[j];
                for (var k = 0; k < row.Count; k++)
                {
                    var column = row[k];
                    //A
                    if (k == 0)
                    {
                        if (column.Trim() == "")
                        {
                            saf25.saf2504_ord_date = OrderTime;

                        }
                        else
                        {
                            saf25.saf2504_ord_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                        }
                    }
                    //B
                    else if (k == 1)
                    {
                        if (column.Trim() == "")
                        {
                            saf25FileInfo.ErrorMsg.Add(CreatErrorMsg(j, k, "沒有訂單編號"));
                        }
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
                        //saf25.saf2505_ord_remark = column;
                    }
                    //E
                    else if (k == 4)
                    {
                        //saf25.saf2530_logis_comp = column;
                    }
                    //F
                    else if (k == 5)
                    {
                        saf25.saf2537_pcode = column;
                    }
                    //G
                    else if (k == 6)
                    {
                        saf25.saf2536_pcode_v = column;
                    }
                    //H
                    else if (k == 7)
                    {
                        //saf25.saf2549_paymt_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                    }
                    //I
                    else if (k == 8)
                    {
                        saf25.saf2535_ptpye = column;
                    }
                    //J
                    else if (k == 9)
                    {

                        saf25.saf2531_psname = column;
                    }
                    //K
                    else if (k == 10)
                    {
                        saf25.saf2541_ord_qty = IntTryParse(column, saf25FileInfo, j, k, false); ;
                    }
                    //L  
                    else if (k == 11)
                    {
                        saf25.saf2547_price = DoubleTryParse(column, saf25FileInfo, j, k, false);
                    }
                    //M
                    else if (k == 12)
                    {
                        //saf25.saf2519_rec_address = column;
                    }
                    //N
                    else if (k == 13)
                    {
                        //saf25.saf2537_pcode = column;
                    }
                    //O
                    else if (k == 14)
                    {
                        //saf25.saf2536_pcode_v = column;
                    }
                    //P
                    else if (k == 15)
                    {
                        saf25.saf2548_price_sub = column;
                    }
                    //Q
                    else if (k == 16)
                    {
                        saf25.saf2587_gift_pnt = column;
                    }
                    //R
                    else if (k == 17)
                    {
                        saf25.saf2588_gift_amt = column;
                    }
                    //S
                    else if (k == 18)
                    {
                        saf25.saf2573_discount = column;
                    }
                    //T
                    else if (k == 19)
                    {
                        //saf25.saf2550_paymt_way = column;
                    }
                    //U
                    else if (k == 20)
                    {
                        //saf25.saf2551_paymt_status = column;
                    }
                    //V
                    else if (k == 21)
                    {
                        saf25.saf2532_pname = column;
                    }
                    //W
                    else if (k == 22)
                    {
                        //saf25.saf2510_ord_name = column;
                    }
                    //X
                    else if (k == 23)
                    {
                        //saf25.saf2512_ord_tel01 = column;
                    }
                    //Y
                    else if (k == 24)
                    {
                        //saf25.saf2511_ord_cell = column;
                    } //Z
                    else if (k == 25)
                    {
                        //saf25.saf2511_ord_cell = column;
                    } //AA
                    else if (k == 26)
                    {
                        //saf25.saf2511_ord_cell = column;
                    } //AB
                    else if (k == 27)
                    {
                        //saf25.saf2511_ord_cell = column;
                    } //AC
                    else if (k == 28)
                    {
                        //saf25.saf2511_ord_cell = column;
                    }//AD
                    else if (k == 29)
                    {
                        saf25.saf2551_paymt_status = column;
                    }//AE
                    else if (k == 30)
                    {
                        //saf25.saf2511_ord_cell = column;
                    }//AF
                    else if (k == 31)
                    {
                        saf25.saf2550_paymt_way = column;
                    }//AG
                    else if (k == 32)
                    {
                        //saf25.saf2511_ord_cell = column;
                    }//AH
                    else if (k == 33)
                    {
                        //saf25.saf2511_ord_cell = column;
                    }//AI
                    else if (k == 34)
                    {
                        //saf25.saf2511_ord_cell = column;
                    }//AJ
                    else if (k == 35)
                    {
                        //saf25.saf2511_ord_cell = column;
                    }//AK
                    else if (k == 36)
                    {
                        //saf25.saf2511_ord_cell = column;
                    }//AL
                    else if (k == 37)
                    {
                        saf25.saf2549_paymt_date = column;
                    }//AM
                    else if (k == 38)
                    {
                        //saf25.saf2511_ord_cell = column;
                    }//AN
                    else if (k == 39)
                    {
                        //saf25.saf2511_ord_cell = column;
                    }//AO
                    else if (k == 40)
                    {
                        saf25.saf2576_cancel_d = column;
                    }//AP
                    else if (k == 41)
                    {
                        //saf25.saf2511_ord_cell = column;
                    }//AQ
                    else if (k == 42)
                    {
                        //saf25.saf2511_ord_cell = column;
                    }//AR
                    else if (k == 43)
                    {
                        saf25.saf2526_ship_status = column;
                    }//AS
                    else if (k == 44)
                    {
                        //saf25.saf2511_ord_cell = column;
                    }//AT
                    else if (k == 45)
                    {
                        saf25.saf2523_ship_date = column;
                    }//AU
                    else if (k == 46)
                    {
                        saf25.saf2546_mana_fee = column;
                    }//AV
                    else if (k == 47)
                    {
                        //saf25.saf2511_ord_cell = column;
                    }//AW
                    else if (k == 48)
                    {
                        //saf25.saf2511_ord_cell = column;
                    }//AX
                    else if (k == 49)
                    {
                        saf25.saf2522_dis_demand = column;
                    }//AY
                    else if (k == 50)
                    {
                        //saf25.saf2511_ord_cell = column;
                    }//AZ
                    else if (k == 51)
                    {
                        //saf25.saf2511_ord_cell = column;
                    }//BA
                    else if (k == 52)
                    {
                        //saf25.saf2511_ord_cell = column;
                    }//BB
                    else if (k == 53)
                    {
                        //saf25.saf2511_ord_cell = column;
                    }//BC
                    else if (k == 54)
                    {
                        saf25.saf2510_ord_name = column;
                    }//BD
                    else if (k == 55)
                    {
                        //saf25.saf2511_ord_cell = column;
                    }//BE
                    else if (k == 56)
                    {
                        saf25.saf2511_ord_cell = column;
                    }//BF
                    else if (k == 57)
                    {
                        saf25.saf2538_inv_no = column;
                    }//BG
                    else if (k == 58)
                    {
                        //saf25.saf2511_ord_cell = column;
                    }//BH
                    else if (k == 59)
                    {
                        //saf25.saf2511_ord_cell = column;
                    }//BI
                    else if (k == 60)
                    {
                        saf25.saf2539_inv_date = column;
                    }//BJ
                    else if (k == 61)
                    {
                        //saf25.saf2511_ord_cell = column;
                    }//BK
                    else if (k == 62)
                    {
                        //saf25.saf2511_ord_cell = column;
                    }//BL
                    else if (k == 63)
                    {
                        //saf25.saf2511_ord_cell = column;
                    }//BM
                    else if (k == 64)
                    {
                        //saf25.saf2511_ord_cell = column;
                    }//BN
                    else if (k == 65)
                    {
                        //saf25.saf2511_ord_cell = column;
                    }//BO
                    else if (k == 66)
                    {
                        saf25.saf2514_rec_name = column;
                    }//BP
                    else if (k == 67)
                    {
                        saf25.saf2515_rec_cell = column;
                    }//BQ
                    else if (k == 68)
                    {
                        saf25.saf2518_rec_zip = column;
                    }//BR
                    else if (k == 69)
                    {
                        saf25.saf2519_rec_address = column;
                    }//BS
                    else if (k == 70)
                    {
                        //saf25.saf2511_ord_cell = column;
                    }//BT
                    else if (k == 71)
                    {
                        //saf25.saf2511_ord_cell = column;
                    }//BU
                    else if (k == 72)
                    {
                        //saf25.saf2511_ord_cell = column;
                    }//BV
                    else if (k == 73)
                    {
                        //saf25.saf2511_ord_cell = column;
                    }//BW
                    else if (k == 74)
                    {
                        //saf25.saf2511_ord_cell = column;
                    }//BX
                    else if (k == 75)
                    {
                        //saf25.saf2511_ord_cell = column;
                    }//BY
                    else if (k == 76)
                    {
                        //saf25.saf2511_ord_cell = column;
                    }//BZ
                    else if (k == 77)
                    {
                        //saf25.saf2511_ord_cell = column;
                    }//CA
                    else if (k == 78)
                    {
                        //saf25.saf2511_ord_cell = column;
                    }//CB
                    else if (k == 79)
                    {
                        //saf25.saf2511_ord_cell = column;
                    }//CC
                    else if (k == 80)
                    {
                        //saf25.saf2511_ord_cell = column;
                    }//CD
                    else if (k == 81)
                    {
                        //saf25.saf2511_ord_cell = column;
                    }//CE
                    else if (k == 82)
                    {
                        //saf25.saf2511_ord_cell = column;
                    }//CF
                    else if (k == 83)
                    {
                        //saf25.saf2511_ord_cell = column;
                    }//CG
                    else if (k == 84)
                    {
                        //saf25.saf2511_ord_cell = column;
                    }//CH
                    else if (k == 85)
                    {
                        //saf25.saf2511_ord_cell = column;
                    }//CI
                    else if (k == 86)
                    {
                        //saf25.saf2511_ord_cell = column;
                    }//CJ
                    else if (k == 87)
                    {
                        // saf25.saf2511_ord_cell = column;
                    }
                    //Ck
                    else if (k == 88)
                    {
                        //saf25.saf2511_ord_cell = column;
                    }

                }
                saf25FileInfo.saf25List.Add(saf25);
            }


        }

        private static void Motian_tosaf25(List<List<string>> rowList, saf25FileInfo saf25FileInfo, string OrderTime)
        {
            for (var j = 0; j < rowList.Count; j++)
            {
                var saf25 = new saf25();
                if (j == 0) continue;//跳過標題

                var row = rowList[j];
                saf25.saf2504_ord_date = OrderTime;
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
                        if (column.Trim() == "")
                        {
                            saf25FileInfo.ErrorMsg.Add(CreatErrorMsg(j, k, "沒有訂單編號"));
                        }
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
                        saf25.saf2530_logis_comp = column;
                    }
                    //F
                    else if (k == 5)
                    {
                        saf25.saf2528_fre_no = column;
                    }
                    //G
                    else if (k == 6)
                    {
                        saf25.saf2522_dis_demand = column;
                    }
                    //H
                    else if (k == 7)
                    {
                        saf25.saf2549_paymt_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                    }
                    //I
                    else if (k == 8)
                    {
                        saf25.saf2523_ship_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                    }
                    //J
                    else if (k == 9)
                    {

                        saf25.saf2514_rec_name = column;
                    }
                    //K
                    else if (k == 10)
                    {
                        saf25.saf2516_rec_tel01 = column;
                    }
                    //L  
                    else if (k == 11)
                    {
                        saf25.saf2515_rec_cell = column;
                    }
                    //M
                    else if (k == 12)
                    {
                        saf25.saf2519_rec_address = column;
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
                        saf25.saf2531_psname = column;
                    }
                    //Q
                    else if (k == 16)
                    {
                        saf25.saf2532_pname = column;
                    }
                    //R
                    else if (k == 17)
                    {
                        saf25.saf2541_ord_qty = IntTryParse(column, saf25FileInfo, j, k, false); ;
                    }
                    //S
                    else if (k == 18)
                    {
                        saf25.saf2548_price_sub = column;
                    }
                    //T
                    else if (k == 19)
                    {
                        saf25.saf2550_paymt_way = column;
                    }
                    //U
                    else if (k == 20)
                    {
                        saf25.saf2551_paymt_status = column;
                    }
                    //V
                    else if (k == 21)
                    {
                        saf25.saf2535_ptpye = column;
                    }
                    //W
                    else if (k == 22)
                    {
                        saf25.saf2510_ord_name = column;
                    }
                    //X
                    else if (k == 23)
                    {
                        saf25.saf2512_ord_tel01 = column;
                    }
                    //Y
                    else if (k == 24)
                    {
                        saf25.saf2511_ord_cell = column;
                    }

                }
                saf25FileInfo.saf25List.Add(saf25);
            }

        }

        private static void YahooSmart_tosaf25(List<List<string>> rowList, saf25FileInfo saf25FileInfo, string OrderTime)
        {
            for (var j = 0; j < rowList.Count; j++)
            {
                var saf25 = new saf25();
                if (j == 0) continue;//跳過標題

                var row = rowList[j];
                for (var k = 0; k < row.Count; k++)
                {
                    var column = row[k];
                    //A
                    if (k == 0)
                    {
                        saf25.saf2582_serial = column;
                    }
                    //B
                    else if (k == 1)
                    {
                        saf25.saf2550_paymt_way = column;
                    }
                    //C
                    else if (k == 2)
                    {
                        saf25.saf2510_ord_name = column;
                    }
                    //D
                    else if (k == 3)
                    {
                        if (column.Trim() == "")
                        {
                            saf25FileInfo.ErrorMsg.Add(CreatErrorMsg(j, k, "沒有訂單編號"));
                        }
                        saf25.saf2503_ord_no = column;
                    }
                    //E
                    else if (k == 4)
                    {
                        saf25.saf2514_rec_name = column;
                    }
                    //F
                    else if (k == 5)
                    {
                        saf25.saf2518_rec_zip = column;
                    }
                    //G
                    else if (k == 6)
                    {
                        saf25.saf2519_rec_address = column;
                    }
                    //H
                    else if (k == 7)
                    {
                        if (column.Trim() == "")
                        {
                            saf25.saf2504_ord_date = OrderTime;

                        }
                        else
                        {
                            saf25.saf2504_ord_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                        }
                    }
                    //I
                    else if (k == 8)
                    {
                        saf25.saf2523_ship_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                    }
                    //J
                    else if (k == 9)
                    {

                        saf25.saf2584_deli_date = DateTimeTryParse(column, saf25FileInfo, j, k, true); ;
                    }
                    //K
                    else if (k == 10)
                    {
                        //saf25.saf2526_ship_status = column;
                    }
                    //L  
                    else if (k == 11)
                    {
                        saf25.saf2535_ptpye = column;
                    }
                    //M
                    else if (k == 12)
                    {
                        saf25.saf2530_logis_comp = column;
                    }
                    //N
                    else if (k == 13)
                    {
                        saf25.saf2536_pcode_v = column;
                    }
                    //O
                    else if (k == 14)
                    {
                        saf25.saf2537_pcode = column;
                    }
                    //P
                    else if (k == 15)
                    {
                        saf25.saf2531_psname = column;
                    }
                    //Q
                    else if (k == 16)
                    {
                        saf25.saf2505_ord_remark = column;
                    }
                    //R
                    else if (k == 17)
                    {
                        saf25.saf2532_pname = column;
                    }
                    //S
                    else if (k == 18)
                    {
                        saf25.saf2548_price_sub = column;
                    }
                    //T
                    else if (k == 19)
                    {
                        saf25.saf2541_ord_qty = IntTryParse(column, saf25FileInfo, j, k, false); ;
                    }
                    //U
                    else if (k == 20)
                    {
                        saf25.saf2506_ord_status = column;
                    }
                    //V
                    else if (k == 21)
                    {
                        //saf25.saf2519_rec_address = column;
                    }
                    //W
                    else if (k == 22)
                    {
                        saf25.saf2516_rec_tel01 = column;
                    }
                    //X
                    else if (k == 23)
                    {
                        saf25.saf2517_rec_tel02 = column;
                    }
                    //Y
                    else if (k == 24)
                    {
                        saf25.saf2515_rec_cell = column;
                    }
                    //Z
                    else if (k == 25)
                    {
                        saf25.saf2564_post_box = column;
                    }
                    //AA
                    else if (k == 26)
                    {
                        saf25.saf2586_tax_class = column;
                    }
                    //AB
                    else if (k == 27)
                    {
                        saf25.saf2587_gift_pnt = column;
                    }
                    //AC
                    else if (k == 28)
                    {
                        saf25.saf2588_gift_amt = column;
                    }
                }
                saf25FileInfo.saf25List.Add(saf25);

            }
        }

        private static void SeventeenP_csvtosaf25(List<List<string>> rowList, saf25FileInfo saf25FileInfo, string OrderTime)
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
                        if (column.Trim() == "")
                        {
                            saf25FileInfo.ErrorMsg.Add(CreatErrorMsg(j, k, "沒有訂單編號"));
                        }
                        saf25.saf2503_ord_no = column;
                    }
                    //C
                    else if (k == 2)
                    {
                        if (column.Trim() == "")
                        {
                            saf25.saf2504_ord_date = OrderTime;

                        }
                        else
                        {
                            saf25.saf2504_ord_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                        }
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
                        saf25.saf2534_ship_pname = column;
                    }
                    //I
                    else if (k == 8)
                    {
                        saf25.saf2536_pcode_v = column;
                    }
                    //J
                    else if (k == 9)
                    {

                        saf25.saf2540_ship_qty = IntTryParse(column, saf25FileInfo, j, k, false);
                        saf25.saf2541_ord_qty = IntTryParse(column, saf25FileInfo, j, k, false);
                    }
                    //K
                    else if (k == 10)
                    {
                        saf25.saf2547_price = DoubleTryParse(column, saf25FileInfo, j, k, false);
                    }
                    //L  
                    else if (k == 11)
                    {
                        saf25.saf2544_cost = DoubleTryParse(column, saf25FileInfo, j, k, false);
                    }
                    //M
                    else if (k == 12)
                    {
                        saf25.saf2546_mana_fee = DoubleTryParse(column, saf25FileInfo, j, k, false);
                    }
                    //N
                    else if (k == 13)
                    {
                        saf25.saf2505_ord_remark = column;
                    }
                    //O
                    else if (k == 14)
                    {
                        saf25.saf2506_ord_status = column;
                    }
                    //P
                    else if (k == 15)
                    {
                        saf25.saf2552_return = column;
                    }
                    //Q
                    else if (k == 16)
                    {
                        saf25.saf2523_ship_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                    }
                    //R
                    else if (k == 17)
                    {
                        saf25.saf2529_logis_no = column;
                    }
                    //S
                    else if (k == 18)
                    {
                        saf25.saf2530_logis_comp = column;
                    }
                    //T
                    else if (k == 19)
                    {
                        saf25.saf2528_fre_no = column;
                    }
                    //U
                    else if (k == 20)
                    {
                        saf25.saf2524_ship_remark = column;
                    }
                    //V
                    else if (k == 21)
                    {
                        saf25.saf2525_ship_condi = column;
                    }
                }
                saf25FileInfo.saf25List.Add(saf25);
            }
        }

        private static void FormosaPlastics_csvtosaf25(List<List<string>> rowList, saf25FileInfo saf25FileInfo, string OrderTime)
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
                        if (column.Trim() == "")
                        {
                            saf25FileInfo.ErrorMsg.Add(CreatErrorMsg(j, k, "沒有訂單編號"));
                        }
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
                        if (column.Trim() == "")
                        {
                            saf25.saf2504_ord_date = OrderTime;

                        }
                        else
                        {
                            saf25.saf2504_ord_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                        }
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
                        saf25.saf2542_groups = DoubleTryParse(column, saf25FileInfo, j, k, false); ;
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

        private static void TaiwanMobile_csvtosaf25(List<List<string>> rowList, saf25FileInfo saf25FileInfo, string OrderTime)
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
                        if (column.Trim() == "")
                        {
                            saf25.saf2504_ord_date = OrderTime;

                        }
                        else
                        {
                            saf25.saf2504_ord_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                        }
                    }
                    //B
                    else if (k == 1)
                    {
                        saf25.saf2527_ship_no = column;
                    }
                    //C
                    else if (k == 2)
                    {
                        if (column.Trim() == "")
                        {
                            saf25FileInfo.ErrorMsg.Add(CreatErrorMsg(j, k, "沒有訂單編號"));
                        }
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
                        saf25.saf2541_ord_qty = IntTryParse(column, saf25FileInfo, j, k, false);
                    }
                    //M
                    else if (k == 12)
                    {
                        saf25.saf2544_cost = DoubleTryParse(column, saf25FileInfo, j, k, false);
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
                        saf25.saf2524_ship_remark = column;
                    }

                }
                saf25FileInfo.saf25List.Add(saf25);
            }
        }

        private static void LifeMarket_csvtosaf25(List<List<string>> rowList, saf25FileInfo saf25FileInfo, string OrderTime)
        {
            for (var j = 0; j < rowList.Count; j++)
            {
                var saf25 = new saf25();
                if (j == 0) continue;//跳過標題

                var row = rowList[j];
                if (string.IsNullOrEmpty(row[0].ToString())) continue;
                saf25.saf2504_ord_date = OrderTime;
                for (var k = 0; k < row.Count; k++)
                {
                    var column = row[k];



                    //A
                    if (k == 0)
                    {
                        if (column.Trim() == "")
                        {
                            saf25FileInfo.ErrorMsg.Add(CreatErrorMsg(j, k, "沒有訂單編號"));
                        }
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
                        saf25.saf2549_paymt_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
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

        private static void ET_csvtosaf25(List<List<string>> rowList, saf25FileInfo saf25FileInfo, string OrderTime)
        {
            for (var j = 0; j < rowList.Count; j++)
            {
                var saf25 = new saf25();
                if (j == 0) continue;//跳過標題

                var row = rowList[j];
                if (row.Count != 32) continue;

                if (string.IsNullOrEmpty(row[2].ToString())) continue;
                saf25.saf2504_ord_date = OrderTime;
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
                        if (column.Trim() == "")
                        {
                            saf25FileInfo.ErrorMsg.Add(CreatErrorMsg(j, k, "沒有訂單編號"));
                        }

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
                        saf25.saf2541_ord_qty = IntTryParse(column, saf25FileInfo, j, k, false);
                    }
                    //N
                    else if (k == 13)
                    {
                        saf25.saf2547_price = DoubleTryParse(column, saf25FileInfo, j, k, false);
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

        private static void SonGuo_csvtosaf25(List<List<string>> rowList, saf25FileInfo saf25FileInfo, string OrderTime)
        {
            for (var j = 0; j < rowList.Count; j++)
            {
                var saf25 = new saf25();
                if (j == 0) continue;//跳過標題

                var row = rowList[j];
                if (string.IsNullOrEmpty(row[0].ToString())) continue;
                saf25.saf2504_ord_date = OrderTime;
                for (var k = 0; k < row.Count; k++)
                {
                    var column = row[k];

                    //A
                    if (k == 0)
                    {
                        if (column.Trim() == "")
                        {
                            saf25FileInfo.ErrorMsg.Add(CreatErrorMsg(j, k, "沒有訂單編號"));
                        }
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
                        saf25.saf2511_ord_cell = column;
                    }
                    //E
                    else if (k == 4)
                    {
                        saf25.saf2550_paymt_way = column;
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
                        saf25.saf2542_groups = DoubleTryParse(column, saf25FileInfo, j, k, false); ;
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

        private static void SonGuo2_csvtosaf25(List<List<string>> rowList, saf25FileInfo saf25FileInfo, string OrderTime)
        {
            for (var j = 0; j < rowList.Count; j++)
            {
                var saf25 = new saf25();
                if (j == 0) continue;//跳過標題

                var row = rowList[j];
                if (string.IsNullOrEmpty(row[0].ToString())) continue;
                saf25.saf2504_ord_date = OrderTime;
                for (var k = 0; k < row.Count; k++)
                {
                    var column = row[k];

                    //A
                    if (k == 0)
                    {
                        if (column.Trim() == "")
                        {
                            saf25FileInfo.ErrorMsg.Add(CreatErrorMsg(j, k, "沒有訂單編號"));
                        }
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
                        saf25.saf2542_groups = DoubleTryParse(column, saf25FileInfo, j, k, false); ;
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

        private static void ShenFang_csvtosaf25(List<List<string>> rowList, saf25FileInfo saf25FileInfo, string OrderTime)
        {
            for (var j = 0; j < rowList.Count; j++)
            {
                var saf25 = new saf25();
                if (j == 0) continue;//跳過標題

                var row = rowList[j];
                if (row.Count != 17) continue;
                if (string.IsNullOrEmpty(row[1].ToString()) || string.IsNullOrEmpty(row[6].ToString())) continue;

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
                        if (column.Trim() == "")
                        {
                            saf25FileInfo.ErrorMsg.Add(CreatErrorMsg(j, k, "沒有訂單編號"));
                        }
                        saf25.saf2503_ord_no = column;
                    }
                    //C
                    else if (k == 2)
                    {
                        if (column.Trim() == "")
                        {
                            saf25.saf2504_ord_date = OrderTime;

                        }
                        else
                        {
                            saf25.saf2504_ord_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                        }
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

        private static void Gomaji_csvtosaf25(List<List<string>> rowList, saf25FileInfo saf25FileInfo, string OrderTime)
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
                        if (column.Trim() == "")
                        {
                            saf25FileInfo.ErrorMsg.Add(CreatErrorMsg(j, k, "沒有訂單編號"));
                        }
                        saf25.saf2503_ord_no = column;
                    }
                    //D
                    else if (k == 3)
                    {
                        if (column.Trim() == "")
                        {
                            saf25.saf2504_ord_date = OrderTime;

                        }
                        else
                        {
                            saf25.saf2504_ord_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                        }
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
                        saf25.saf2542_groups = DoubleTryParse(column, saf25FileInfo, j, k, false); ;
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

        private static void KS_csvtosaf25(List<List<string>> rowList, saf25FileInfo saf25FileInfo, string OrderTime)
        {
            for (var j = 0; j < rowList.Count; j++)
            {
                var saf25 = new saf25();
                if (j == 0) continue;//跳過標題
                var row = rowList[j];
                if (row.Count != 22) continue;
                if (string.IsNullOrEmpty(row[6].ToString().Trim())) continue;

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
                        if (column.Trim() == "")
                        {
                            saf25.saf2504_ord_date = OrderTime;

                        }
                        else
                        {
                            saf25.saf2504_ord_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                        }
                    }
                    //G
                    else if (k == 6)
                    {
                        if (column.Trim() == "")
                        {
                            saf25FileInfo.ErrorMsg.Add(CreatErrorMsg(j, k, "沒有訂單編號"));
                        }
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
                        saf25.saf2541_ord_qty = IntTryParse(column, saf25FileInfo, j, k, false);
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

        private static void UniPresident_csvtosaf25(List<List<string>> rowList, saf25FileInfo saf25FileInfo, string OrderTime)
        {
            for (var j = 0; j < rowList.Count; j++)
            {
                var saf25 = new saf25();
                if (j == 0) continue;//跳過標題

                var row = rowList[j];

                if (row.Count != 28) continue;
                if (string.IsNullOrEmpty(row[1].ToString())) continue;
                if (row[17].ToString().Contains("運費")) continue;

                for (var k = 0; k < row.Count; k++)
                {
                    var column = row[k];
                    if (column.Substring(0, 1) == "'")
                    {
                        column = column.Substring(1, column.Length - 1);
                    }
                    if (column.Substring(column.Length - 1, 1) == "'")
                    {
                        column = column.Substring(0, column.Length - 1);
                    }
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
                        if (column.Trim() == "")
                        {
                            saf25.saf2504_ord_date = OrderTime;

                        }
                        else
                        {
                            saf25.saf2504_ord_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                        }
                    }
                    //E
                    else if (k == 4)
                    {
                        if (column.Trim() == "")
                        {
                            saf25FileInfo.ErrorMsg.Add(CreatErrorMsg(j, k, "沒有訂單編號"));
                        }
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
                        saf25.saf2541_ord_qty = IntTryParse(column, saf25FileInfo, j, k, false); ;
                    }
                    //U
                    else if (k == 20)
                    {
                        saf25.saf2544_cost = DoubleTryParse(column, saf25FileInfo, j, k, false); ;
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

        private static void DingDing_csvtosaf25(List<List<string>> rowList, saf25FileInfo saf25FileInfo, string OrderTime)
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
                        if (column.Trim() == "")
                        {
                            saf25FileInfo.ErrorMsg.Add(CreatErrorMsg(j, k, "沒有訂單編號"));
                        }
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
                        if (column.Trim() == "")
                        {
                            saf25.saf2504_ord_date = OrderTime;

                        }
                        else
                        {
                            saf25.saf2504_ord_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                        }
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
                        saf25.saf2520_dis_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
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

        private static void Crazy_csvtosaf25(List<List<string>> rowList, saf25FileInfo saf25FileInfo, string OrderTime)
        {
            for (var j = 0; j < rowList.Count; j++)
            {
                var saf25 = new saf25();
                if (j == 0) continue;//跳過標題

                var row = rowList[j];
                if (string.IsNullOrEmpty(row[3].ToString())) continue;
                saf25.saf2504_ord_date = OrderTime;
                for (var k = 0; k < row.Count; k++)
                {
                    var column = row[k];
                    //A
                    if (k == 0)
                    {

                        if (column.Replace("'", "").Trim() == "")
                        {
                            saf25FileInfo.ErrorMsg.Add(CreatErrorMsg(j, k, "沒有訂單編號"));
                        }
                        saf25.saf2503_ord_no = column.Replace("'", "");
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

        private static void ShinQi_csvtosaf25(List<List<string>> rowList, saf25FileInfo saf25FileInfo, string OrderTime)
        {
            for (var j = 0; j < rowList.Count; j++)
            {
                var saf25 = new saf25();
                if (j == 0) continue;//跳過標題

                var row = rowList[j];

                if (j == 1 && row[0].ToString().Equals("序號")) continue;//跳過標題

                if (row.Count != 13) continue;

                if (string.IsNullOrEmpty(row[3].ToString())) continue;
                saf25.saf2504_ord_date = OrderTime;
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
                        if (column.Trim() == "")
                        {
                            saf25FileInfo.ErrorMsg.Add(CreatErrorMsg(j, k, "沒有訂單編號"));
                        }
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

        private static void LienHo_csvtosaf25(List<List<string>> rowList, saf25FileInfo saf25FileInfo, string OrderTime)
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
                        if (column.Trim() == "")
                        {
                            saf25FileInfo.ErrorMsg.Add(CreatErrorMsg(j, k, "沒有訂單編號"));
                        }
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
                        if (column.Trim() == "")
                        {
                            saf25.saf2504_ord_date = OrderTime;

                        }
                        else
                        {
                            saf25.saf2504_ord_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                        }


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

        private static void LuTien_csvtosaf25(List<List<string>> rowList, saf25FileInfo saf25FileInfo, string OrderTime)
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
                        if (column.Trim() == "")
                        {
                            saf25.saf2504_ord_date = OrderTime;

                        }
                        else
                        {
                            saf25.saf2504_ord_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                        }
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

        private static void Yahoo_csvtosaf25(List<List<string>> rowList, saf25FileInfo saf25FileInfo, string OrderTime)
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
                        if (column.Trim() == "")
                        {
                            saf25.saf2504_ord_date = OrderTime;

                        }
                        else
                        {
                            saf25.saf2504_ord_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                        }
                    }
                    //B
                    else if (k == 1)
                    {
                        //saf25.saf2502_seq = column;
                    }
                    //C
                    else if (k == 2)
                    {
                        if (column.Trim() == "")
                        {
                            saf25FileInfo.ErrorMsg.Add(CreatErrorMsg(j, k, "沒有訂單編號"));
                        }
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
                        saf25.saf2587_gift_pnt = IntTryParse(column, saf25FileInfo, j, k, true);
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

        private static void Pchome_csvtosaf25(List<List<string>> rowList, saf25FileInfo saf25FileInfo, string OrderTime)
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
                        if (column.Trim() == "")
                        {
                            saf25FileInfo.ErrorMsg.Add(CreatErrorMsg(j, k, "沒有訂單編號"));
                        }
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
                        if (column.Trim() == "")
                        {
                            saf25.saf2504_ord_date = OrderTime;

                        }
                        else
                        {
                            saf25.saf2504_ord_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                        }
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

        private static void _17P_csvtosaf25(List<List<string>> rowList, saf25FileInfo saf25FileInfo, string OrderTime) {
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
                        if (column.Trim() == "")
                        {
                            saf25FileInfo.ErrorMsg.Add(CreatErrorMsg(j, k, "沒有訂單編號"));
                        }
                        saf25.saf2503_ord_no = column;
                    }
                    //C
                    else if (k == 2)
                    {
                        saf25.saf2504_ord_date = DateTimeTryParse(column, saf25FileInfo, j, k, true); ;
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
                        if (column.Trim() == "")
                        {
                            saf25.saf2504_ord_date = OrderTime;

                        }
                        else
                        {
                            saf25.saf2504_ord_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                        }
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

        private static void MOMO_csvtosaf25(List<List<string>> rowList, saf25FileInfo saf25FileInfo, string OrderTime)
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
                        if (column.Trim() == "")
                        {
                            saf25FileInfo.ErrorMsg.Add(CreatErrorMsg(j, k, "沒有訂單編號"));
                        }
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
                        if (column.Trim() == "")
                        {
                            saf25.saf2504_ord_date = OrderTime;

                        }
                        else
                        {
                            saf25.saf2504_ord_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                        }
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

        private static void MOMO2_csvtosaf25(List<List<string>> rowList, saf25FileInfo saf25FileInfo, string OrderTime)
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
                        //if (column.Trim() == "")
                        //{
                        //    saf25FileInfo.ErrorMsg.Add(CreatErrorMsg(j, k, "沒有訂單編號"));
                        //}
                        saf25.saf2506_ord_status = column;
                    }
                    //C
                    else if (k == 2)
                    {
                        saf25.saf2505_ord_remark = column;
                    }
                    //D
                    else if (k == 3)
                    {
                        saf25.saf2520_dis_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                    }
                    //E
                    else if (k == 4)
                    {
                        ////時間判斷 DateTimeTryParse(欄位資料，saf25FileInfo，列，欄，是否允許NULL(DB))
                        //saf25.saf2520_dis_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                    }
                    //F
                    else if (k == 5)
                    {
                        saf25.saf2503_ord_no = column;
                    }
                    //G
                    else if (k == 6)
                    {
                        saf25.saf2550_paymt_way = column;
                    }
                    //H
                    else if (k == 7)
                    {
                        saf25.saf2514_rec_name = column;
                    }
                    //I
                    else if (k == 8)
                    {
                        saf25.saf2519_rec_address = column;
                    }
                    //J
                    else if (k == 9)
                    {
                        saf25.saf2564_post_box = column;
                        ////訂單日確認
                        //if (column.Trim() == "")
                        //{
                        //    saf25.saf2504_ord_date = OrderTime;

                        //}
                        //else
                        //{
                        //    saf25.saf2504_ord_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                        //}
                    }
                    //K
                    else if (k == 10)
                    {
                        saf25.saf2565_chg_notes = column;
                        //saf25.saf2523_ship_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                    }
                    //L  
                    else if (k == 11)
                    {
                        saf25.saf2507_ord_class = column;
                    }
                    //M
                    else if (k == 12)
                    {
                        saf25.saf2522_dis_demand = column;
                    }
                    //N
                    else if (k == 13)
                    {
                        saf25.saf2504_ord_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                    }
                    //O
                    else if (k == 14)
                    {
                        saf25.saf2523_ship_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
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

        private static void ShoPee_csvtosaf25(List<List<string>> rowList, saf25FileInfo saf25FileInfo, string OrderTime)
        {
            for (var j = 0; j < rowList.Count; j++)
            {
                var saf25 = new saf25();
                if (j == 0) continue;//跳過標題

                var row = rowList[j];

                for (var k = 0; k < row.Count; k++)
                {
                    var column = row[k];
                    if (column.Substring(0, 1) == "'")
                    {
                        column = column.Substring(1, column.Length - 1);
                    }
                    if (column.Substring(column.Length - 1, 1) == "'")
                    {
                        column = column.Substring(0, column.Length - 1);
                    }
                    //A
                    if (k == 0)
                    {
                        saf25.saf2503_ord_no = column;
                    }
                    //B
                    else if (k == 1)
                    {
                        saf25.saf2506_ord_status = column;
                    }
                    //C
                    else if (k == 2)
                    {
                        saf25.saf2552_return = column;
                    }
                    //D
                    else if (k == 3)
                    {
                        saf25.saf2578_get_acc = column;
                        //if (column.Trim() == "")
                        //{
                        //    saf25.saf2504_ord_date = OrderTime;

                        //}
                        //else
                        //{
                        //    saf25.saf2504_ord_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                        //}
                    }
                    //E
                    else if (k == 4)
                    {
                        //if (column.Trim() == "")
                        //{
                        //    saf25FileInfo.ErrorMsg.Add(CreatErrorMsg(j, k, "沒有訂單編號"));
                        //}
                        saf25.saf2504_ord_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                    }
                    //F
                    else if (k == 5)
                    {
                        saf25.saf2549_paymt_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                    }
                    //G
                    else if (k == 6)
                    {
                        saf25.saf2548_price_sub = DoubleTryParse(column, saf25FileInfo, j, k, false);
                    }
                    //H
                    else if (k == 7)
                    {
                        saf25.saf2546_mana_fee = DoubleTryParse(column, saf25FileInfo, j, k, false);
                    }
                    //I
                    else if (k == 8)
                    {
                        saf25.saf2589_order_amt = DoubleTryParse(column, saf25FileInfo, j, k, false);
                    }
                    //J
                    else if (k == 9)
                    {
                        saf25.saf2531_psname = column;
                    }
                    //K
                    else if (k == 10)
                    {
                        saf25.saf2519_rec_address = column;
                    }
                    //L  
                    else if (k == 11)
                    {
                        saf25.saf2561_option = column;
                    }
                    //M
                    else if (k == 12)
                    {
                        saf25.saf2566_warm = column;
                    }
                    //N
                    else if (k == 13)
                    {
                        saf25.saf2563_county = column;
                    }
                    //O
                    else if (k == 14)
                    {
                        saf25.saf2518_rec_zip = column;
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
                        saf25.saf2522_dis_demand = column;
                    }
                    //S
                    else if (k == 18)
                    {
                        saf25.saf2525_ship_condi = column;
                    }
                    //T
                    else if (k == 19)
                    {
                        saf25.saf2502_seq = column;
                    }
                    //U
                    else if (k == 20)
                    {
                        saf25.saf2507_ord_class = column;
                    }
                    //V
                    else if (k == 21)
                    {
                        saf25.saf2550_paymt_way = column;
                    }
                    //W
                    else if (k == 22)
                    {
                        saf25.saf2523_ship_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                    }
                    //X
                    else if (k == 23)
                    {
                        saf25.saf2579_auction_y = column;
                    }
                    //Y
                    else if (k == 24)
                    {
                        saf25.saf2584_deli_date = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                    }
                    //Z
                    else if (k == 25)
                    {
                        saf25.saf2575_check_d = DateTimeTryParse(column, saf25FileInfo, j, k, true);
                    }
                    //AA
                    else if (k == 26)
                    {
                        saf25.saf2505_ord_remark = column;
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


        private static string DateTimeTryParse(string Time, saf25FileInfo saf25FileInfo, int row, int column, bool allowEmpty)
        {
            DateTime Value;

            int A;
            if (Int32.TryParse(Time, out A) && Time.Length == 8)
            {
                try
                {
                    Time = DateTime.ParseExact(Time, "yyyyMMdd", null).ToString("yyyy/MM/dd");
                    return Time;
                }
                catch
                {
                    if (!allowEmpty)
                    {
                        saf25FileInfo.ErrorMsg.Add(CreatErrorMsg(row, column, "不符合日期格式，欄位值為:" + Time));
                    }


                    return null;
                }

            }



            if (DateTime.TryParse(Time, out Value))
            {
                return Time;
            }
            else
            {
                if (!allowEmpty && Time.Trim() != "")
                {
                    saf25FileInfo.ErrorMsg.Add(CreatErrorMsg(row, column, "不符合日期格式，欄位值為:" + Time));
                }


                return null;
            }
        }

        private static string IntTryParse(string Num, saf25FileInfo saf25FileInfo, int row, int column, bool allowEmpty)
        {
            int Value;
            if (Int32.TryParse(Num, out Value))
            {
                return Num;
            }
            else
            {
                if (!allowEmpty && Num.Trim() != "")
                {
                    saf25FileInfo.ErrorMsg.Add(CreatErrorMsg(row, column, "不符合整數格式，欄位值為:" + Num));
                }
                return null;
            }

        }

        private static string DoubleTryParse(string Num, saf25FileInfo saf25FileInfo, int row, int column, bool allowEmpty)
        {
            Double Value;
            if (Double.TryParse(Num, out Value))
            {
                return Num;
            }
            else
            {
                if (!allowEmpty && Num.Trim() != "")
                {
                    saf25FileInfo.ErrorMsg.Add(CreatErrorMsg(row, column, "不符合實數格式，欄位值為:" + Num));
                }
                return "";
            }
        }

        private static ErrorInfo CreatErrorMsg(int Row, int column, string Msg)
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
        private static List<List<string>> setPreWork(string p_uploadsPath, string p_FileName, string cnf1002_fileorder, ref saf25FileInfo p_saf25FileInfo)
        {
            CompanyExists_cnf1004_char02(cnf1002_fileorder, ref  p_saf25FileInfo);
            CSVTool(p_uploadsPath);
            var rowList = CSVtoObject(p_uploadsPath);
            p_saf25FileInfo.FileName = p_FileName;
            return rowList;
        }

        private static List<List<string>> CSVtoObject(string Path)
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



        private static void CSVTool(string Path)
        {
            StringBuilder sb = new StringBuilder();
            var Lines = File.ReadAllText(Path, Encoding.ASCII);
            var Lines1 = File.ReadAllText(Path, Encoding.Unicode);
            var Lines2 = File.ReadAllText(Path, Encoding.UTF32);
            var Lines3 = File.ReadAllText(Path, Encoding.UTF7);
            var Lines4 = File.ReadAllText(Path, Encoding.GetEncoding(950));
            var Lines5 = File.ReadAllText(Path, Encoding.BigEndianUnicode);
            using (StreamReader sr = new StreamReader(Path, Encoding.GetEncoding(950), true))
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
                        else if (ch == '\t')
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




        private static void CompanyExists_cnf1004_char02(string cnf1002_fileorder, ref saf25FileInfo p_saf25FileInfo)
        {

            using (var conn = new SqlConnection(MyConnStringList.AzureGoodeasy))
            {
                conn.Open();
                var cmd = conn.CreateCommand();
                cmd.CommandText = "select cnf1004_char02,cnf1003_char01 from cnf10 where cnf1001_filetype='D001' and cnf1002_fileorder=@cnf1002_fileorder";
                cmd.Parameters.AddWithValue("@cnf1002_fileorder", cnf1002_fileorder);
                using (var rd = cmd.ExecuteReader())
                {
                    if (rd.Read())
                    {

                        p_saf25FileInfo.cnf1004_char02 = rd["cnf1004_char02"].ToString();
                        p_saf25FileInfo.CompanyName = rd["cnf1003_char01"].ToString();
                    }
                }
            }

        }

    }
    public class saf25FileInfo
    {
        public string FileName { get; set; }
        public string CompanyName { get; set; }
        public string cnf1004_char02 = "";
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
        public string saf2590_col_money { get; set; }//代收貨款
        public string saf2591_rec_email { get; set; }//收件人email
        public string saf2592_serial { get; set; }//編定之交易序號
    }
}
