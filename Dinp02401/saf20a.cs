namespace Dinp02401
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;

    public partial class saf20a
    {
        public int Id { get; set; }

        public int saf20a02_serial { get; set; }

        [Required]
        [StringLength(30)]
        public string saf20a03_ord_no { get; set; }

        public DateTime? saf20a04_ord_date { get; set; }

        [Required]
        [StringLength(60)]
        public string saf20a31_psname { get; set; }

        [Required]
        [StringLength(60)]
        public string saf20a32_pname { get; set; }

        [Required]
        [StringLength(60)]
        public string saf20a33_pspec { get; set; }

        [Required]
        [StringLength(60)]
        public string saf20a34_ship_pname { get; set; }

        [Required]
        [StringLength(20)]
        public string saf20a35_ptpye { get; set; }

        [Required]
        [StringLength(20)]
        public string saf20a36_pcode_v { get; set; }

        [Required]
        [StringLength(20)]
        public string saf20a37_pcode { get; set; }

        [Required]
        [StringLength(20)]
        public string saf20a38_inv_no { get; set; }

        public DateTime? saf20a39_inv_date { get; set; }

        [Column(TypeName = "numeric")]
        public decimal saf20a40_ship_qty { get; set; }

        [Column(TypeName = "numeric")]
        public decimal saf20a41_ord_qty { get; set; }

        [Column(TypeName = "numeric")]
        public decimal saf20a42_groups { get; set; }

        [Column(TypeName = "numeric")]
        public decimal saf20a43_cancel_qty { get; set; }

        [Column(TypeName = "numeric")]
        public decimal saf20a44_cost { get; set; }

        [Column(TypeName = "numeric")]
        public decimal saf20a45_cost_sub { get; set; }

        [Column(TypeName = "numeric")]
        public decimal saf20a46_mana_fee { get; set; }

        [Column(TypeName = "numeric")]
        public decimal saf20a47_price { get; set; }

        [Column(TypeName = "numeric")]
        public decimal saf20a48_price_sub { get; set; }

        [Required]
        [StringLength(10)]
        public string saf20a86_tax_class { get; set; }

        [Column(TypeName = "numeric")]
        public decimal saf20a87_gift_pnt { get; set; }

        [Column(TypeName = "numeric")]
        public decimal saf20a88_gift_amt { get; set; }

        [Column(TypeName = "text")]
        [Required]
        public string remark { get; set; }

        [Required]
        [StringLength(20)]
        public string adduser { get; set; }

        public DateTime? adddate { get; set; }

        [Required]
        [StringLength(20)]
        public string moduser { get; set; }

        public DateTime? moddate { get; set; }

        [Column(TypeName = "numeric")]
        public decimal saf20a103_sales_amt { get; set; }

        [Column(TypeName = "numeric")]
        public decimal saf20a104_freetax_amt { get; set; }

        [Column(TypeName = "numeric")]
        public decimal saf20a105_tax { get; set; }

        [Column(TypeName = "numeric")]
        public decimal saf20a106_price_ntax { get; set; }

        [Required]
        [StringLength(10)]
        public string saf20a107_wherehouse { get; set; }

        [Column(TypeName = "numeric")]
        public decimal saf20a108_dis_rate { get; set; }

        [Required]
        [StringLength(20)]
        public string saf20a109_docno { get; set; }

        [Column(TypeName = "numeric")]
        public decimal saf20a109_seq { get; set; }

        [Column(TypeName = "numeric")]
        public decimal saf20a110_dis_amt { get; set; }
    }
}
