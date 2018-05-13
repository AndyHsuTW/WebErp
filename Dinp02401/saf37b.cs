namespace Dinp02401
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;

    public partial class saf37b
    {
        public int id { get; set; }

        public int saf37b00_saf37aid { get; set; }

        [Required]
        [StringLength(10)]
        public string status { get; set; }

        [Required]
        [StringLength(20)]
        public string saf37b01_docno { get; set; }

        [Column(TypeName = "numeric")]
        public decimal saf37b02_seq { get; set; }

        [Required]
        [StringLength(20)]
        public string saf37b02_pcode_pro { get; set; }

        [Column(TypeName = "numeric")]
        public decimal saf37b03_retail_new { get; set; }

        [Column(TypeName = "numeric")]
        public decimal saf37b03_retail_old { get; set; }

        [Column(TypeName = "numeric")]
        public decimal saf37b04_limit_qty { get; set; }

        [Column(TypeName = "numeric")]
        public decimal saf37b05_discount { get; set; }

        [Required]
        [StringLength(20)]
        public string remark { get; set; }
    }
}
