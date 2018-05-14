using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ErpBaseLibrary.DB;

namespace Dinp02101
{
    public class Inf20
    {

        #region properties from database

        public string inf2001_docno { get; set; }

        public string inf2001_bcode { get; set; }

        public string inf2002_docno_type { get; set; }

        public DateTime inf2002_docno_date { get; set; }

        public int inf2002_docno_seq { get; set; }

        public string inf2006_mcode { get; set; }

        public string inf2024_currency { get; set; }

        public double inf2025_exchnge_rate { get; set; }

        public string inf2033_delivery_place { get; set; }

        public DateTime inf2034_pay_yymm { get; set; }

        public int inf2037_recid { get; set; }

        public double inf2039_one_amt { get; set; }

        public string inf2040_payto { get; set; }

        public string inf2042_project_no { get; set; }

        public double inf2047_tax { get; set; }

        public string inf2053_account_type { get; set; }

        #endregion

        public List<Inf20a> Inf20aList { get; set; } 


        public static Inf20 GetInf20(string docnoType, DateTime docnoDate, int docnoSeq)
        {
            Inf20 inf20 = null;

            using (var conn = new SqlConnection { ConnectionString = MyConnStringList.AzureGoodeasy })
            using (var sqlCmd = conn.CreateCommand())
            {
                conn.Open();

                sqlCmd.CommandText = String.Format(@"
        SELECT TOP 1 [inf2001_docno]
          ,[inf2001_bcode]
          ,[inf2002_docno_type]
          ,[inf2002_docno_date]
          ,[inf2002_docno_seq]
          ,[inf2006_mcode]
          ,[inf2007_code_status]
          ,[inf2024_currency]
          ,[inf2025_exchnge_rate]
          ,[inf2033_delivery_place]
          ,[inf2034_pay_yymm]
          ,[inf2037_recid]
          ,[inf2039_one_amt]
          ,[inf2040_payto]
          ,[inf2042_project_no]
          ,[inf2047_tax]
          ,[inf2049_docno_seq]
          ,[inf2053_account_type]
      FROM [dbo].[inf20]
        WHERE inf2002_docno_type = @docnoType 
        AND inf2002_docno_date = @docnoDate
        AND inf2002_docno_seq = @docnoSeq ");

                sqlCmd.Parameters.AddWithValue("@docnoType", docnoType);
                sqlCmd.Parameters.AddWithValue("@docnoDate", docnoDate);
                sqlCmd.Parameters.AddWithValue("@docnoSeq", docnoSeq);

                using (var sqlReader = sqlCmd.ExecuteReader())
                {
                    if (sqlReader.HasRows)
                    {
                        if (sqlReader.Read())
                        {
                            inf20 = new Inf20();
                            inf20.inf2001_docno = Convert.ToString(sqlReader["inf2001_docno"]);
                            inf20.inf2001_bcode = Convert.ToString(sqlReader["inf2001_bcode"]);
                            inf20.inf2002_docno_date = Convert.ToDateTime(sqlReader["inf2002_docno_date"]);
                            inf20.inf2002_docno_seq = Convert.ToInt32(sqlReader["inf2002_docno_seq"]);
                            inf20.inf2002_docno_type = Convert.ToString(sqlReader["inf2002_docno_type"]);
                            inf20.inf2006_mcode = Convert.ToString(sqlReader["inf2006_mcode"]);
                            inf20.inf2024_currency = Convert.ToString(sqlReader["inf2024_currency"]);
                            inf20.inf2025_exchnge_rate = Convert.ToDouble(sqlReader["inf2025_exchnge_rate"]);
                            inf20.inf2033_delivery_place = Convert.ToString(sqlReader["inf2033_delivery_place"]);
                            inf20.inf2034_pay_yymm = Convert.ToDateTime(sqlReader["inf2034_pay_yymm"]);
                            inf20.inf2037_recid = Convert.ToInt32(sqlReader["inf2037_recid"]);
                            inf20.inf2039_one_amt = Convert.ToDouble(sqlReader["inf2039_one_amt"]);
                            inf20.inf2040_payto = Convert.ToString(sqlReader["inf2040_payto"]);
                            inf20.inf2042_project_no = Convert.ToString(sqlReader["inf2042_project_no"]);
                            inf20.inf2047_tax = Convert.ToDouble(sqlReader["inf2047_tax"]);
                            inf20.inf2053_account_type = Convert.ToString(sqlReader["inf2053_account_type"]);
                        }
                    }
                }
            }

            return inf20;
        }


    }
}
