namespace Dinp02401
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;

    public partial class saf37
    {
        public int id { get; set; }

        [Required]
        [StringLength(20)]
        public string saf3701_docno { get; set; }

        [Required]
        [StringLength(10)]
        public string status { get; set; }

        [Required]
        [StringLength(20)]
        public string saf3701_bcode { get; set; }

        [Required]
        [StringLength(20)]
        public string saf3702_pro_no { get; set; }

        public DateTime? saf3703_docno_date { get; set; }

        [Required]
        [StringLength(10)]
        public string saf3704_pclass { get; set; }

        [Required]
        [StringLength(60)]
        public string saf3705_pro_name { get; set; }

        public DateTime? saf3706_beg_date { get; set; }

        public DateTime? saf3706_end_date { get; set; }

        public DateTime? saf3707_beg_time { get; set; }

        public DateTime? saf3707_end_time { get; set; }

        [Column(TypeName = "numeric")]
        public decimal saf3708_pro_qty1 { get; set; }

        [Column(TypeName = "numeric")]
        public decimal saf3708_pro_qty2 { get; set; }

        [Column(TypeName = "numeric")]
        public decimal saf3708_pro_qty3 { get; set; }

        [Column(TypeName = "numeric")]
        public decimal saf3709_retail_new1 { get; set; }

        [Column(TypeName = "numeric")]
        public decimal saf3709_retail_new2 { get; set; }

        [Column(TypeName = "numeric")]
        public decimal saf3709_retail_new3 { get; set; }

        [Column(TypeName = "numeric")]
        public decimal saf3710_discount1 { get; set; }

        [Column(TypeName = "numeric")]
        public decimal saf3710_discount2 { get; set; }

        [Column(TypeName = "numeric")]
        public decimal saf3710_discount3 { get; set; }

        [Required]
        [StringLength(10)]
        public string saf3711_relative { get; set; }

        [Required]
        [StringLength(10)]
        public string saf3712_card_class { get; set; }

        [Required]
        [StringLength(20)]
        public string saf3713_dis_no { get; set; }

        [Required]
        [StringLength(60)]
        public string remark { get; set; }

        [Required]
        [StringLength(20)]
        public string adduser { get; set; }

        public DateTime? adddate { get; set; }

        [Required]
        [StringLength(20)]
        public string moduser { get; set; }

        public DateTime? moddate { get; set; }

        [Required]
        [StringLength(20)]
        public string verifyuser { get; set; }

        public DateTime? verifydate { get; set; }
    }
}
