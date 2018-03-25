using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ErpBaseLibrary.DB;
using System.Data.SqlClient;
namespace WebERPLibrary
{
    class Dsap02005
    {

        public static List<saf20> GetData()
        {

            var datalist = new List<saf20>();
            using (var conn = new SqlConnection(MyConnStringList.AzureGoodeasy))
            {
                conn.Open();
                var cmd = conn.CreateCommand();
                cmd.CommandText = @"
                SELECT *
                  FROM [dbo].[saf20]
                ";

                using (var rd = cmd.ExecuteReader())
                {

                    while (rd.Read())
                    {

                        var data =new saf20();
                        data.saf2001_cuscode = rd["saf2001_cuscode"].ToString();
                        data.saf2046_mana_fee = rd["saf2046_mana_fee"].ToString();
                        data.saf20107_tax_id = rd["saf20107_tax_id"].ToString();
                        data.saf2002_serial = rd["saf2002_serial"].ToString();
                        data.saf2014_rec_name = rd["saf2014_rec_name"].ToString();
                        data.saf2015_rec_cell = rd["saf2015_rec_cell"].ToString();
                    }

                }



            }




            return datalist;



        }

        public class saf20
        {
            public string saf2001_cuscode { get; set; }
            public string saf2046_mana_fee { get; set; }
            public string saf20107_tax_id { get; set; }
            public string saf2002_serial { get; set; }
            public string saf2014_rec_name { get; set; }
            public string saf2015_rec_cell { get; set; }

        }

        public class saf20a
        {


        }



    }

}
