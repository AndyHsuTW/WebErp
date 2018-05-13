namespace Dinp02401
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;

    public partial class saf37a
    {
        public int id { get; set; }

        public int saf37a00_saf37id { get; set; }

        [Required]
        [StringLength(20)]
        public string saf37a00_docno { get; set; }

        [Required]
        [StringLength(10)]
        public string status { get; set; }

        [Required]
        [StringLength(20)]
        public string saf37a01_docno { get; set; }

        [Column(TypeName = "numeric")]
        public decimal saf37a02_seq { get; set; }

        [Required]
        [StringLength(20)]
        public string saf37a03_pcode { get; set; }

        [Column(TypeName = "numeric")]
        public decimal saf37a04_retail_old { get; set; }

        [Column(TypeName = "numeric")]
        public decimal saf37a05_member_new { get; set; }

        [Column(TypeName = "numeric")]
        public decimal saf37a06_retail_new { get; set; }

        [Column(TypeName = "numeric")]
        public decimal saf37a07_limit_qty { get; set; }

        [Column(TypeName = "numeric")]
        public decimal saf37a08_points { get; set; }

        [Column(TypeName = "numeric")]
        public decimal saf37a09_deduct { get; set; }

        [Column(TypeName = "numeric")]
        public decimal saf37a10_pdept { get; set; }

        [Column(TypeName = "numeric")]
        public decimal saf37a11_pcat { get; set; }

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
    }
}
