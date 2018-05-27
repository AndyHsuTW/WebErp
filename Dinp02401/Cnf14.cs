namespace Dinp02401
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;

    public partial class cnf14
    {
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int id { get; set; }

        [Required]
        [StringLength(10)]
        public string status { get; set; }

        [Required]
        [StringLength(10)]
        public string cnf1401_exchange_code { get; set; }

        public DateTime? cnf1402_exchange_date { get; set; }

        [Required]
        [StringLength(20)]
        public string cnf1403_exchange_bname { get; set; }

        [Required]
        [StringLength(20)]
        public string cnf1404_exchange_fname { get; set; }

        [Required]
        [StringLength(60)]
        public string cnf1405_exchange_ename { get; set; }

        [Column(TypeName = "numeric")]
        public decimal cnf1406_exchange_fix { get; set; }

        [Column(TypeName = "numeric")]
        public decimal cnf1407_exchange_buy { get; set; }

        [Column(TypeName = "numeric")]
        public decimal cnf1408_exchange_sell { get; set; }

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
