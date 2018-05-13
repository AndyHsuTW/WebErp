using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using ErpBaseLibrary.DB;

namespace Dinp02401
{
    using System;

    public partial class saf20
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

        public DateTime? saf20115_docno_date { get; set; }

        
        public decimal saf20115_docno_seq { get; set; }

        
        
        public string saf20116_src_docno { get; set; }
        #endregion

        /// <summary>
        /// 顯示"數量"欄位
        /// </summary>
        public double Qty { get; set; }

        public class FilterOption
        {

            /// <summary>
            /// 銷貨單號
            /// </summary>
            public string saf20114_docno_start { get; set; }
            public string saf20114_docno_end { get; set; }

            /// <summary>
            /// 銷貨日期
            /// </summary>
            public DateTime? saf2023_ship_date_start { get; set; }
            public DateTime? saf2023_ship_date_end { get; set; }

            /// <summary>
            /// 商品編號
            /// </summary>
            public string inf29a05_pcode_start { get; set; }
            public string inf29a05_pcode_end { get; set; }

            /// <summary>
            /// 產品貨號
            /// </summary>
            public string inf29a05_shoes_code_start { get; set; }
            public string inf29a05_shoes_code_end { get; set; }

            /// <summary>
            /// 專案代號
            /// </summary>
            public string inf2952_project_no_start { get; set; }
            public string inf2952_project_no_end { get; set; }

            /// <summary>
            /// 倉庫代號
            /// </summary>
            public string inf2906_wherehouse_start { get; set; }
            public string inf2906_wherehouse_end { get; set; }

            /// <summary>
            /// 異動代碼
            /// </summary>
            public string inf2910_in_reason_start { get; set; }
            public string inf2910_in_reason_end { get; set; }

            /// <summary>
            /// 異動單位
            /// </summary>
            public string inf2903_customer_code_start { get; set; }
            public string inf2903_customer_code_end { get; set; }

            /// <summary>
            /// 公司代號
            /// </summary>
            public string inf2901_bcode_start { get; set; }
            public string inf2901_bcode_end { get; set; }

            /// <summary>
            /// 來源單據
            /// </summary>
            public string inf2906_ref_no_type_start { get; set; }
            public string inf2906_ref_no_type_end { get; set; }

            /// <summary>
            /// 來源單據
            /// </summary>
            public DateTime? inf2906_ref_no_date_start { get; set; }
            public DateTime? inf2906_ref_no_date_end { get; set; }

            /// <summary>
            /// 來源單據
            /// </summary>
            public int inf2906_ref_no_seq_start { get; set; }
            public int inf2906_ref_no_seq_end { get; set; }

            /// <summary>
            /// 新增日期
            /// </summary>
            public DateTime? adddate_start { get; set; }
            public DateTime? adddate_end { get; set; }

            /// <summary>
            /// 異動日期
            /// </summary>
            public DateTime? inf2904_pro_date_start { get; set; }
            public DateTime? inf2904_pro_date_end { get; set; }

            public int id { get; set; }

            public List<int> idList { get; set; }

            public string keyword { get; set; }
        }
    }
}
