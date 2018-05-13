using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using ErpBaseLibrary.DB;

namespace Dinp02401
{
    using System;
    public partial class Saf20a
    {
        public int Id { get; set; }

        public int saf20a02_serial { get; set; }

        public string saf20a03_ord_no { get; set; }

        public DateTime? saf20a04_ord_date { get; set; }
        
        public string saf20a31_psname { get; set; }
        
        public string saf20a32_pname { get; set; }
        
        public string saf20a33_pspec { get; set; }

        public string saf20a34_ship_pname { get; set; }

        public string saf20a35_ptpye { get; set; }

        public string saf20a36_pcode_v { get; set; }

        public string saf20a37_pcode { get; set; }

        public string saf20a38_inv_no { get; set; }

        public DateTime? saf20a39_inv_date { get; set; }

        public decimal saf20a40_ship_qty { get; set; }

        public decimal saf20a41_ord_qty { get; set; }

        public decimal saf20a42_groups { get; set; }

        public decimal saf20a43_cancel_qty { get; set; }

        public decimal saf20a44_cost { get; set; }

        public decimal saf20a45_cost_sub { get; set; }

        public decimal saf20a46_mana_fee { get; set; }

        public decimal saf20a47_price { get; set; }

        public decimal saf20a48_price_sub { get; set; }

        public string saf20a86_tax_class { get; set; }

        public decimal saf20a87_gift_pnt { get; set; }

        public decimal saf20a88_gift_amt { get; set; }

        public string remark { get; set; }

        public string adduser { get; set; }

        public DateTime? adddate { get; set; }

        public string moduser { get; set; }

        public DateTime? moddate { get; set; }

        public decimal saf20a103_sales_amt { get; set; }

        public decimal saf20a104_freetax_amt { get; set; }

        public decimal saf20a105_tax { get; set; }

        public decimal saf20a106_price_ntax { get; set; }

        public string saf20a107_wherehouse { get; set; }

        public decimal saf20a108_dis_rate { get; set; }

        public string saf20a109_docno { get; set; }

        public decimal saf20a109_seq { get; set; }

        public decimal saf20a110_dis_amt { get; set; }

        public static List<Saf20a> AddItem(Saf20 saf20, List<Saf20a> saf20aList)
        {
            if (saf20aList == null|| saf20aList.Count==0)
            {
                throw new ArgumentNullException("saf20aList");
            }

            using (var conn = new SqlConnection { ConnectionString = MyConnStringList.AzureGoodeasy })
            using (var sqlCmd = conn.CreateCommand())
            {
                conn.Open();
                sqlCmd.CommandText = @"INSERT INTO [dbo].[saf20a]
                                           ([saf20a02_serial]
                                           ,[saf20a03_ord_no]
                                           ,[saf20a04_ord_date]
                                           ,[saf20a31_psname]
                                           ,[saf20a32_pname]
                                           ,[saf20a33_pspec]
                                           ,[saf20a34_ship_pname]
                                           ,[saf20a35_ptpye]
                                           ,[saf20a36_pcode_v]
                                           ,[saf20a37_pcode]
                                           ,[saf20a38_inv_no]
                                           ,[saf20a39_inv_date]
                                           ,[saf20a40_ship_qty]
                                           ,[saf20a41_ord_qty]
                                           ,[saf20a42_groups]
                                           ,[saf20a43_cancel_qty]
                                           ,[saf20a44_cost]
                                           ,[saf20a45_cost_sub]
                                           ,[saf20a46_mana_fee]
                                           ,[saf20a47_price]
                                           ,[saf20a48_price_sub]
                                           ,[saf20a86_tax_class]
                                           ,[saf20a87_gift_pnt]
                                           ,[saf20a88_gift_amt]
                                           ,[remark]
                                           ,[adduser]
                                           ,[adddate]
                                           ,[moduser]
                                           ,[moddate]
                                           ,[saf20a103_sales_amt]
                                           ,[saf20a104_freetax_amt]
                                           ,[saf20a105_tax]
                                           ,[saf20a106_price_ntax]
                                           ,[saf20a107_wherehouse]
                                           ,[saf20a108_dis_rate]
                                           ,[saf20a109_docno]
                                           ,[saf20a109_seq]
                                           ,[saf20a110_dis_amt])
                                     VALUES
                                           (@saf20a02_serial
                                           ,@saf20a03_ord_no
                                           ,@saf20a04_ord_date
                                           ,@saf20a31_psname
                                           ,@saf20a32_pname
                                           ,@saf20a33_pspec
                                           ,@saf20a34_ship_pname
                                           ,@saf20a35_ptpye
                                           ,@saf20a36_pcode_v
                                           ,@saf20a37_pcode
                                           ,@saf20a38_inv_no
                                           ,@saf20a39_inv_date
                                           ,@saf20a40_ship_qty
                                           ,@saf20a41_ord_qty
                                           ,@saf20a42_groups
                                           ,@saf20a43_cancel_qty
                                           ,@saf20a44_cost
                                           ,@saf20a45_cost_sub
                                           ,@saf20a46_mana_fee
                                           ,@saf20a47_price
                                           ,@saf20a48_price_sub
                                           ,@saf20a86_tax_class
                                           ,@saf20a87_gift_pnt
                                           ,@saf20a88_gift_amt
                                           ,@remark
                                           ,@adduser
                                           ,@adddate
                                           ,@moduser
                                           ,@moddate
                                           ,@saf20a103_sales_amt
                                           ,@saf20a104_freetax_amt
                                           ,@saf20a105_tax
                                           ,@saf20a106_price_ntax
                                           ,@saf20a107_wherehouse
                                           ,@saf20a108_dis_rate
                                           ,@saf20a109_docno
                                           ,@saf20a109_seq
                                           ,@saf20a110_dis_amt)";
                foreach (var saf20a in saf20aList)
                {
                    sqlCmd.Parameters.Clear();
                    sqlCmd.Parameters.AddWithValue("@saf20a02_serial", saf20.saf2002_serial);
                    sqlCmd.Parameters.AddWithValue("@saf20a03_ord_no", saf20a.saf20a03_ord_no);
                    sqlCmd.Parameters.AddWithValue("@saf20a04_ord_date", saf20a.saf20a04_ord_date);
                    sqlCmd.Parameters.AddWithValue("@saf20a31_psname", saf20a.saf20a31_psname);
                    sqlCmd.Parameters.AddWithValue("@saf20a32_pname", saf20a.saf20a32_pname);
                    sqlCmd.Parameters.AddWithValue("@saf20a33_pspec", saf20a.saf20a33_pspec);
                    sqlCmd.Parameters.AddWithValue("@saf20a34_ship_pname", saf20a.saf20a34_ship_pname);
                    sqlCmd.Parameters.AddWithValue("@saf20a35_ptpye", saf20a.saf20a35_ptpye);
                    sqlCmd.Parameters.AddWithValue("@saf20a36_pcode_v", saf20a.saf20a36_pcode_v);
                    sqlCmd.Parameters.AddWithValue("@saf20a37_pcode", saf20a.saf20a37_pcode);
                    sqlCmd.Parameters.AddWithValue("@saf20a38_inv_no", saf20a.saf20a38_inv_no);
                    sqlCmd.Parameters.AddWithValue("@saf20a39_inv_date", saf20a.saf20a39_inv_date);
                    sqlCmd.Parameters.AddWithValue("@saf20a40_ship_qty", saf20a.saf20a40_ship_qty);
                    sqlCmd.Parameters.AddWithValue("@saf20a41_ord_qty", saf20a.saf20a41_ord_qty);
                    sqlCmd.Parameters.AddWithValue("@saf20a42_groups", saf20a.saf20a42_groups);
                    sqlCmd.Parameters.AddWithValue("@saf20a43_cancel_qty", saf20a.saf20a43_cancel_qty);
                    sqlCmd.Parameters.AddWithValue("@saf20a44_cost", saf20a.saf20a44_cost);
                    sqlCmd.Parameters.AddWithValue("@saf20a45_cost_sub", saf20a.saf20a45_cost_sub);
                    sqlCmd.Parameters.AddWithValue("@saf20a46_mana_fee", saf20a.saf20a46_mana_fee);
                    sqlCmd.Parameters.AddWithValue("@saf20a47_price", saf20a.saf20a47_price);
                    sqlCmd.Parameters.AddWithValue("@saf20a48_price_sub", saf20a.saf20a48_price_sub);
                    sqlCmd.Parameters.AddWithValue("@saf20a86_tax_class", saf20a.saf20a86_tax_class);
                    sqlCmd.Parameters.AddWithValue("@saf20a87_gift_pnt", saf20a.saf20a87_gift_pnt);
                    sqlCmd.Parameters.AddWithValue("@saf20a88_gift_amt", saf20a.saf20a88_gift_amt);
                    sqlCmd.Parameters.AddWithValue("@remark", saf20a.remark);
                    sqlCmd.Parameters.AddWithValue("@adduser", saf20a.adduser);
                    sqlCmd.Parameters.AddWithValue("@adddate", saf20a.adddate);
                    sqlCmd.Parameters.AddWithValue("@moduser", saf20a.moduser);
                    sqlCmd.Parameters.AddWithValue("@moddate", saf20a.moddate);
                    sqlCmd.Parameters.AddWithValue("@saf20a103_sales_amt", saf20a.saf20a103_sales_amt);
                    sqlCmd.Parameters.AddWithValue("@saf20a104_freetax_amt", saf20a.saf20a104_freetax_amt);
                    sqlCmd.Parameters.AddWithValue("@saf20a105_tax", saf20a.saf20a105_tax);
                    sqlCmd.Parameters.AddWithValue("@saf20a106_price_ntax", saf20a.saf20a106_price_ntax);
                    sqlCmd.Parameters.AddWithValue("@saf20a107_wherehouse", saf20a.saf20a107_wherehouse);
                    sqlCmd.Parameters.AddWithValue("@saf20a108_dis_rate", saf20a.saf20a108_dis_rate);
                    sqlCmd.Parameters.AddWithValue("@saf20a109_docno", saf20a.saf20a109_docno);
                    sqlCmd.Parameters.AddWithValue("@saf20a109_seq", saf20a.saf20a109_seq);
                    sqlCmd.Parameters.AddWithValue("@saf20a110_dis_amt", saf20a.saf20a110_dis_amt);
                    int id = (int) sqlCmd.ExecuteScalar();
                    saf20a.Id = id;
                }
            }

            return saf20aList;
        }
    }
}
