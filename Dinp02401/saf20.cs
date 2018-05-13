using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using ErpBaseLibrary.DB;

namespace Dinp02401
{
    using System;

    public partial class Saf20
    {
        #region properties from database

        public int id { get; set; }
        
        public string saf2000_status { get; set; }

        public string saf2001_cuscode { get; set; }

        public int saf2002_serial { get; set; }
        
        public string saf2010_ord_name { get; set; }

        
        public string saf2011_ord_cell { get; set; }

        
        
        public string saf2012_ord_tel01 { get; set; }

        
        
        public string saf2014_rec_name { get; set; }

        
        
        public string saf2015_rec_cell { get; set; }

        
        
        public string saf2016_rec_tel01 { get; set; }

        
        
        public string saf2017_rec_tel02 { get; set; }

        
        
        public string saf2018_rec_zip { get; set; }

        
        
        public string saf2019_rec_address { get; set; }

        
        
        public string saf2022_dis_demand { get; set; }

        public DateTime? saf2023_ship_date { get; set; }

        
        
        public string saf2024_ship_remark { get; set; }

        
        
        public string saf2025_ship_condi { get; set; }

        
        
        public string saf2026_ship_status { get; set; }

        
        
        public string saf2027_ship_no { get; set; }

        
        
        public string saf2028_fre_no { get; set; }

        
        
        public string saf2029_logis_no { get; set; }

        
        
        public string saf2030_logis_comp { get; set; }

        
        
        public string saf2038_inv_no { get; set; }

        public DateTime? saf2039_inv_date { get; set; }

        
        public decimal saf2040_ship_qty { get; set; }

        
        public decimal saf2041_ord_qty { get; set; }

        
        public decimal saf2043_cancel_qty { get; set; }

        
        public decimal saf2045_cost_sub { get; set; }

        
        public decimal saf2046_mana_fee { get; set; }

        
        public decimal saf2048_price_sub { get; set; }

        public DateTime? saf2049_paymt_date { get; set; }

        
        
        public string saf2050_paymt_way { get; set; }

        
        
        public string saf2051_paymt_status { get; set; }

        
        
        public string saf2068_vendor_no { get; set; }

        
        
        public string saf2069_vendor_name { get; set; }

        public DateTime? saf2075_check_d { get; set; }

        public DateTime? saf2076_cancel_d { get; set; }

        public DateTime? saf2084_deli_date { get; set; }

        
        public decimal saf2090_col_money { get; set; }

        
        
        public string remark { get; set; }

        
        
        public string adduser { get; set; }

        public DateTime? adddate { get; set; }

        
        
        public string moduser { get; set; }

        public DateTime? moddate { get; set; }

        
        public decimal saf20101_total_amt { get; set; }

        
        
        public string saf20102_incl_fee { get; set; }

        
        public decimal saf20103_sales_amt { get; set; }

        
        public decimal saf20104_freetax_amt { get; set; }

        
        public decimal saf20105_tax { get; set; }

        
        public decimal saf20106_total_amt { get; set; }

        
        
        public string saf20107_tax_id { get; set; }

        
        
        public string saf20108_inv_no_end { get; set; }

        
        
        public string saf20109_tax_class { get; set; }

        
        
        public string saf20110_printmark { get; set; }

        
        
        public string saf20111_cuscode { get; set; }

        
        public decimal saf20112_dis_rate { get; set; }

        
        
        public string saf20113_trn_type { get; set; }

        
        
        public string saf20114_docno { get; set; }

        
        
        public string saf20115_bcode { get; set; }

        
        
        public string saf20115_docno_type { get; set; }

        public DateTime saf20115_docno_date { get; set; }

        
        public decimal saf20115_docno_seq { get; set; }
        
        public string saf20116_src_docno { get; set; }

        public List<Saf20a> Saf20aList { get; set; }

        #endregion

        /// <summary>
        /// 顯示"數量"欄位
        /// </summary>
        public double Qty { get; set; }

        public class FilterOption
        {
            /// <summary>
            /// 銷貨日期
            /// </summary>
            public DateTime? saf2023_ship_date_start { get; set; }
            public DateTime? saf2023_ship_date_end { get; set; }

            /// <summary>
            /// 商品編號
            /// </summary>
            public string saf20a37_pcode_start { get; set; }
            public string saf20a37_pcode_end { get; set; }

            /// <summary>
            /// 產品貨號
            /// </summary>
            public string saf20a36_pcode_v_start { get; set; }
            public string saf20a36_pcode_v_end { get; set; }

            /// <summary>
            /// 倉庫代號
            /// </summary>
            public string saf20a107_wherehouse_start { get; set; }
            public string saf20a107_wherehouse_end { get; set; }

            /// <summary>
            /// 客戶代號
            /// </summary>
            public string saf20111_cuscode_start { get; set; }
            public string saf20111_cuscode_end { get; set; }

            /// <summary>
            /// 新增日期
            /// </summary>
            public DateTime? adddate_start { get; set; }
            public DateTime? adddate_end { get; set; }

            /// <summary>
            /// 公司代號
            /// </summary>
            public string saf20115_bcode_start { get; set; }
            public string saf20115_bcode_end { get; set; }

            /// <summary>
            /// 訂單單號
            /// </summary>
            public string saf20116_src_docno_start { get; set; }
            public string saf20116_src_docno_end { get; set; }

            /// <summary>
            /// 關鍵字
            /// </summary>
            public string keyword { get; set; }

            /// <summary>
            /// 大於n才顯示
            /// </summary>
            public int saf20a41_ord_qty { get; set; }

            public int id { get; set; }

            public List<int> idList { get; set; }
        }

        public static int GetLastDocnoSeq(string docnoType, DateTime docnoDate)
        {
            var seq = -1;

            using (var conn = new SqlConnection { ConnectionString = MyConnStringList.AzureGoodeasy })
            using (var sqlCmd = conn.CreateCommand())
            {
                conn.Open();
                sqlCmd.CommandText = @"SELECT TOP 1 saf20115_docno_seq
                                            FROM [saf20]
                                        WHERE saf20115_docno_type = @docnoType
                                        AND saf20115_docno_date = @docnoDate
                                        ORDER BY saf20115_docno_type DESC
                                        ";
                sqlCmd.Parameters.AddWithValue("@docnoType", docnoType);
                sqlCmd.Parameters.AddWithValue("@docnoDate", docnoDate);

                using (var sqlReader = sqlCmd.ExecuteReader())
                {
                    if (sqlReader.HasRows)
                    {
                        if (sqlReader.Read())
                        {
                            seq = Convert.ToInt32(sqlReader["saf20115_docno_seq"]);
                        }
                    }
                }
            }
            return seq;
        }

        public static Saf20 AddItem(Saf20 saf20)
        {
            if (saf20 == null)
            {
                throw new ArgumentNullException("saf20");
            }

            var lastDocSeq = GetLastDocnoSeq(saf20.saf20115_docno_type, saf20.saf20115_docno_date);
            saf20.saf20115_docno_seq = ++lastDocSeq;

            saf20.saf20114_docno =  saf20.saf20115_docno_type +
                                  saf20.saf20115_docno_date.ToString("yyyyMMdd") +
                                  saf20.saf20115_docno_seq;

            using (var conn = new SqlConnection { ConnectionString = MyConnStringList.AzureGoodeasy })
            using (var sqlCmd = conn.CreateCommand())
            {
                conn.Open();
                sqlCmd.CommandText = @"INSERT INTO [dbo].[saf20]
                                   ([saf2000_status]
                                   ,[saf2001_cuscode]
                                   ,[saf2002_serial]
                                   ,[saf2010_ord_name]
                                   ,[saf2011_ord_cell]
                                   ,[saf2012_ord_tel01]
                                   ,[saf2014_rec_name]
                                   ,[saf2015_rec_cell]
                                   ,[saf2016_rec_tel01]
                                   ,[saf2017_rec_tel02]
                                   ,[saf2018_rec_zip]
                                   ,[saf2019_rec_address]
                                   ,[saf2022_dis_demand]
                                   ,[saf2023_ship_date]
                                   ,[saf2024_ship_remark]
                                   ,[saf2025_ship_condi]
                                   ,[saf2026_ship_status]
                                   ,[saf2027_ship_no]
                                   ,[saf2028_fre_no]
                                   ,[saf2029_logis_no]
                                   ,[saf2030_logis_comp]
                                   ,[saf2038_inv_no]
                                   ,[saf2039_inv_date]
                                   ,[saf2040_ship_qty]
                                   ,[saf2041_ord_qty]
                                   ,[saf2043_cancel_qty]
                                   ,[saf2045_cost_sub]
                                   ,[saf2046_mana_fee]
                                   ,[saf2048_price_sub]
                                   ,[saf2049_paymt_date]
                                   ,[saf2050_paymt_way]
                                   ,[saf2051_paymt_status]
                                   ,[saf2068_vendor_no]
                                   ,[saf2069_vendor_name]
                                   ,[saf2075_check_d]
                                   ,[saf2076_cancel_d]
                                   ,[saf2084_deli_date]
                                   ,[saf2090_col_money]
                                   ,[remark]
                                   ,[adduser]
                                   ,[adddate]
                                   ,[moduser]
                                   ,[moddate]
                                   ,[saf20101_total_amt]
                                   ,[saf20102_incl_fee]
                                   ,[saf20103_sales_amt]
                                   ,[saf20104_freetax_amt]
                                   ,[saf20105_tax]
                                   ,[saf20106_total_amt]
                                   ,[saf20107_tax_id]
                                   ,[saf20108_inv_no_end]
                                   ,[saf20109_tax_class]
                                   ,[saf20110_printmark]
                                   ,[saf20111_cuscode]
                                   ,[saf20112_dis_rate]
                                   ,[saf20113_trn_type]
                                   ,[saf20114_docno]
                                   ,[saf20115_bcode]
                                   ,[saf20115_docno_type]
                                   ,[saf20115_docno_date]
                                   ,[saf20115_docno_seq]
                                   ,[saf20116_src_docno])
                             VALUES
                                   (@saf2000_status
                                   ,@saf2001_cuscode
                                   ,@saf2002_serial
                                   ,@saf2010_ord_name
                                   ,@saf2011_ord_cell
                                   ,@saf2012_ord_tel01
                                   ,@saf2014_rec_name
                                   ,@saf2015_rec_cell
                                   ,@saf2016_rec_tel01
                                   ,@saf2017_rec_tel02
                                   ,@saf2018_rec_zip
                                   ,@saf2019_rec_address
                                   ,@saf2022_dis_demand
                                   ,@saf2023_ship_date
                                   ,@saf2024_ship_remark
                                   ,@saf2025_ship_condi
                                   ,@saf2026_ship_status
                                   ,@saf2027_ship_no
                                   ,@saf2028_fre_no
                                   ,@saf2029_logis_no
                                   ,@saf2030_logis_comp
                                   ,@saf2038_inv_no
                                   ,@saf2039_inv_date
                                   ,@saf2040_ship_qty
                                   ,@saf2041_ord_qty
                                   ,@saf2043_cancel_qty
                                   ,@saf2045_cost_sub
                                   ,@saf2046_mana_fee
                                   ,@saf2048_price_sub
                                   ,@saf2049_paymt_date
                                   ,@saf2050_paymt_way
                                   ,@saf2051_paymt_status
                                   ,@saf2068_vendor_no
                                   ,@saf2069_vendor_name
                                   ,@saf2075_check_d
                                   ,@saf2076_cancel_d
                                   ,@saf2084_deli_date
                                   ,@saf2090_col_money
                                   ,@remark
                                   ,@adduser
                                   ,@adddate
                                   ,@moduser
                                   ,@moddate
                                   ,@saf20101_total_amt
                                   ,@saf20102_incl_fee
                                   ,@saf20103_sales_amt
                                   ,@saf20104_freetax_amt
                                   ,@saf20105_tax
                                   ,@saf20106_total_amt
                                   ,@saf20107_tax_id
                                   ,@saf20108_inv_no_end
                                   ,@saf20109_tax_class
                                   ,@saf20110_printmark
                                   ,@saf20111_cuscode
                                   ,@saf20112_dis_rate
                                   ,@saf20113_trn_type
                                   ,@saf20114_docno
                                   ,@saf20115_bcode
                                   ,@saf20115_docno_type
                                   ,@saf20115_docno_date
                                   ,@saf20115_docno_seq
                                   ,@saf20116_src_docno)";

                sqlCmd.Parameters.AddWithValue("@saf2000_status", saf20.saf2000_status);
                sqlCmd.Parameters.AddWithValue("@saf2001_cuscode", saf20.saf2001_cuscode);
                sqlCmd.Parameters.AddWithValue("@saf2002_serial", saf20.saf2002_serial);
                sqlCmd.Parameters.AddWithValue("@saf2010_ord_name", saf20.saf2010_ord_name);
                sqlCmd.Parameters.AddWithValue("@saf2011_ord_cell", saf20.saf2011_ord_cell);
                sqlCmd.Parameters.AddWithValue("@saf2012_ord_tel01", saf20.saf2012_ord_tel01);
                sqlCmd.Parameters.AddWithValue("@saf2014_rec_name", saf20.saf2014_rec_name);
                sqlCmd.Parameters.AddWithValue("@saf2015_rec_cell", saf20.saf2015_rec_cell);
                sqlCmd.Parameters.AddWithValue("@saf2016_rec_tel01", saf20.saf2016_rec_tel01);
                sqlCmd.Parameters.AddWithValue("@saf2017_rec_tel02", saf20.saf2017_rec_tel02);
                sqlCmd.Parameters.AddWithValue("@saf2018_rec_zip", saf20.saf2018_rec_zip);
                sqlCmd.Parameters.AddWithValue("@saf2019_rec_address", saf20.saf2019_rec_address);
                sqlCmd.Parameters.AddWithValue("@saf2022_dis_demand", saf20.saf2022_dis_demand);
                sqlCmd.Parameters.AddWithValue("@saf2023_ship_date", saf20.saf2023_ship_date);
                sqlCmd.Parameters.AddWithValue("@saf2024_ship_remark", saf20.saf2024_ship_remark);
                sqlCmd.Parameters.AddWithValue("@saf2025_ship_condi", saf20.saf2025_ship_condi);
                sqlCmd.Parameters.AddWithValue("@saf2026_ship_status", saf20.saf2026_ship_status);
                sqlCmd.Parameters.AddWithValue("@saf2027_ship_no", saf20.saf2027_ship_no);
                sqlCmd.Parameters.AddWithValue("@saf2028_fre_no", saf20.saf2028_fre_no);
                sqlCmd.Parameters.AddWithValue("@saf2029_logis_no", saf20.saf2029_logis_no);
                sqlCmd.Parameters.AddWithValue("@saf2030_logis_comp", saf20.saf2030_logis_comp);
                sqlCmd.Parameters.AddWithValue("@saf2038_inv_no", saf20.saf2038_inv_no);
                sqlCmd.Parameters.AddWithValue("@saf2039_inv_date", saf20.saf2039_inv_date);
                sqlCmd.Parameters.AddWithValue("@saf2040_ship_qty", saf20.saf2040_ship_qty);
                sqlCmd.Parameters.AddWithValue("@saf2041_ord_qty", saf20.saf2041_ord_qty);
                sqlCmd.Parameters.AddWithValue("@saf2043_cancel_qty", saf20.saf2043_cancel_qty);
                sqlCmd.Parameters.AddWithValue("@saf2045_cost_sub", saf20.saf2045_cost_sub);
                sqlCmd.Parameters.AddWithValue("@saf2046_mana_fee", saf20.saf2046_mana_fee);
                sqlCmd.Parameters.AddWithValue("@saf2048_price_sub", saf20.saf2048_price_sub);
                sqlCmd.Parameters.AddWithValue("@saf2049_paymt_date", saf20.saf2049_paymt_date);
                sqlCmd.Parameters.AddWithValue("@saf2050_paymt_way", saf20.saf2050_paymt_way);
                sqlCmd.Parameters.AddWithValue("@saf2051_paymt_status", saf20.saf2051_paymt_status);
                sqlCmd.Parameters.AddWithValue("@saf2068_vendor_no", saf20.saf2068_vendor_no);
                sqlCmd.Parameters.AddWithValue("@saf2069_vendor_name", saf20.saf2069_vendor_name);
                sqlCmd.Parameters.AddWithValue("@saf2075_check_d", saf20.saf2075_check_d);
                sqlCmd.Parameters.AddWithValue("@saf2076_cancel_d", saf20.saf2076_cancel_d);
                sqlCmd.Parameters.AddWithValue("@saf2084_deli_date", saf20.saf2084_deli_date);
                sqlCmd.Parameters.AddWithValue("@saf2090_col_money", saf20.saf2090_col_money);
                sqlCmd.Parameters.AddWithValue("@remark",saf20.remark);
                sqlCmd.Parameters.AddWithValue("@adduser", saf20.adduser);
                sqlCmd.Parameters.AddWithValue("@adddate", saf20.adddate);
                sqlCmd.Parameters.AddWithValue("@moduser", saf20.moduser);
                sqlCmd.Parameters.AddWithValue("@moddate", saf20.moddate);
                sqlCmd.Parameters.AddWithValue("@saf20101_total_amt", saf20.saf20101_total_amt);
                sqlCmd.Parameters.AddWithValue("@saf20102_incl_fee", saf20.saf20102_incl_fee);
                sqlCmd.Parameters.AddWithValue("@saf20103_sales_amt", saf20.saf20103_sales_amt);
                sqlCmd.Parameters.AddWithValue("@saf20104_freetax_amt", saf20.saf20104_freetax_amt);
                sqlCmd.Parameters.AddWithValue("@saf20105_tax", saf20.saf20105_tax);
                sqlCmd.Parameters.AddWithValue("@saf20106_total_amt", saf20.saf20106_total_amt);
                sqlCmd.Parameters.AddWithValue("@saf20107_tax_id", saf20.saf20107_tax_id);
                sqlCmd.Parameters.AddWithValue("@saf20108_inv_no_end", saf20.saf20108_inv_no_end);
                sqlCmd.Parameters.AddWithValue("@saf20109_tax_class", saf20.saf20109_tax_class);
                sqlCmd.Parameters.AddWithValue("@saf20110_printmark", saf20.saf20110_printmark);
                sqlCmd.Parameters.AddWithValue("@saf20111_cuscode", saf20.saf20111_cuscode);
                sqlCmd.Parameters.AddWithValue("@saf20112_dis_rate", saf20.saf20112_dis_rate);
                sqlCmd.Parameters.AddWithValue("@saf20113_trn_type", saf20.saf20113_trn_type);
                sqlCmd.Parameters.AddWithValue("@saf20114_docno", saf20.saf20114_docno);
                sqlCmd.Parameters.AddWithValue("@saf20115_bcode", saf20.saf20115_bcode);
                sqlCmd.Parameters.AddWithValue("@saf20115_docno_type", saf20.saf20115_docno_type);
                sqlCmd.Parameters.AddWithValue("@saf20115_docno_date", saf20.saf20115_docno_date);
                sqlCmd.Parameters.AddWithValue("@saf20115_docno_seq", saf20.saf20115_docno_seq);
                sqlCmd.Parameters.AddWithValue("@saf20116_src_docno", saf20.saf20116_src_docno);
                int id = (int)sqlCmd.ExecuteScalar();
                saf20.id = id;
            }

            return saf20;
        }
    }
}
