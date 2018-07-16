using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ErpBaseLibrary.DB;

namespace Dinp02101
{
    public class Inf20a
    {

        #region properties from database

        public string inf20a04_pcode { get; set; }

        public string inf20a05_mcode { get; set; }

        public double inf20a06_qty { get; set; }

        public double inf20a07_cost { get; set; }

        public double inf20a07_ocost { get; set; }

        public double inf20a08_oretail { get; set; }

        public double inf20a08_retail { get; set; }

        public double inf20a10_dis_rate { get; set; }

        public double inf20a12_dis_qty { get; set; }

        public string inf20a16_punit { get; set; }

        public string inf20a24_tax { get; set; }

        public string inf20a29_magazine_no { get; set; }

        public string inf20a36_currency { get; set; }

        public double inf20a37_exchnge_rate { get; set; }

        public double inf20a39_odds_amt { get; set; }

        public double inf20a40_one_amt { get; set; }

        public double inf20a41_tax { get; set; }

        public string inf20a50_vcode { get; set; }

        public string inf20a57_pclass { get; set; }

        #endregion


        public static List<Inf20a> GetInf20aList(string docNo)
        {
            List<Inf20a> inf20aList = new List<Inf20a>();

            using (var conn = new SqlConnection { ConnectionString = MyConnStringList.AzureGoodeasy })
            using (var sqlCmd = conn.CreateCommand())
            {
                conn.Open();

                sqlCmd.CommandText = String.Format(@"
    SELECT [inf20a04_pcode]
          ,[inf20a04_shoes_code]
          ,[inf20a05_mcode]
          ,[inf20a06_qty]
          ,[inf20a07_ocost]
          ,[inf20a07_cost]
          ,[inf20a08_oretail]
          ,[inf20a08_retail]
          ,[inf20a09_sub_amt]
          ,[inf20a10_dis_flag]
          ,[inf20a10_dis_rate]
          ,[inf20a12_dis_qty]
          ,[inf20a16_punit]
          ,[inf20a24_tax]
          ,[inf20a29_magazine_no]
          ,[inf20a36_currency]
          ,[inf20a37_exchnge_rate]
          ,[inf20a38_product_name]
          ,[inf20a39_odds_amt]
          ,[inf20a40_one_amt]
          ,[inf20a41_tax]
          ,[inf20a50_vcode]
          ,[inf20a57_pclass]
      FROM [dbo].[inf20a]
        WHERE inf20a01_docno = @docNo  ");

                sqlCmd.Parameters.AddWithValue("@docNo", docNo);

                using (var sqlReader = sqlCmd.ExecuteReader())
                {
                    if (sqlReader.HasRows)
                    {
                        while (sqlReader.Read())
                        {
                            Inf20a inf20a = new Inf20a();
                            inf20a.inf20a04_pcode = Convert.ToString(sqlReader["inf20a04_pcode"]);
                            inf20a.inf20a05_mcode = Convert.ToString(sqlReader["inf20a05_mcode"]);
                            inf20a.inf20a06_qty = Convert.ToDouble(sqlReader["inf20a06_qty"]);
                            inf20a.inf20a07_cost = Convert.ToDouble(sqlReader["inf20a07_cost"]);
                            inf20a.inf20a07_ocost = Convert.ToDouble(sqlReader["inf20a07_ocost"]);
                            inf20a.inf20a08_oretail = Convert.ToDouble(sqlReader["inf20a08_oretail"]);
                            inf20a.inf20a08_retail = Convert.ToDouble(sqlReader["inf20a08_retail"]);
                            inf20a.inf20a10_dis_rate = Convert.ToDouble(sqlReader["inf20a10_dis_rate"]);
                            inf20a.inf20a12_dis_qty = Convert.ToDouble(sqlReader["inf20a12_dis_qty"]);
                            inf20a.inf20a16_punit = Convert.ToString(sqlReader["inf20a16_punit"]);
                            inf20a.inf20a24_tax = Convert.ToString(sqlReader["inf20a24_tax"]);
                            inf20a.inf20a29_magazine_no = Convert.ToString(sqlReader["inf20a29_magazine_no"]);
                            inf20a.inf20a36_currency = Convert.ToString(sqlReader["inf20a36_currency"]);
                            inf20a.inf20a37_exchnge_rate = Convert.ToDouble(sqlReader["inf20a37_exchnge_rate"]);
                            inf20a.inf20a39_odds_amt = Convert.ToDouble(sqlReader["inf20a39_odds_amt"]);
                            inf20a.inf20a40_one_amt = Convert.ToDouble(sqlReader["inf20a40_one_amt"]);
                            inf20a.inf20a41_tax = Convert.ToDouble(sqlReader["inf20a41_tax"]);
                            inf20a.inf20a50_vcode = Convert.ToString(sqlReader["inf20a50_vcode"]);
                            inf20a.inf20a57_pclass = Convert.ToString(sqlReader["inf20a57_pclass"]);

                            inf20aList.Add(inf20a);
                        }
                    }
                }
            }

            return inf20aList;
        }


    }
}