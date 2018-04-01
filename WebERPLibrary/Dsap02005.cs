using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ErpBaseLibrary.DB;
using System.Data.SqlClient;
namespace WebERPLibrary
{
    public class Dsap02005
    {

        public static List<OrderData> GetData(Filters Filter)
        {

            var datalist = new List<OrderData>();
            using (var conn = new SqlConnection(MyConnStringList.AzureGoodeasy))
            {
                conn.Open();
                var cmd = conn.CreateCommand();
                cmd.CommandText = @"
              SELECT * FROM [dbo].[saf20a] A
              inner join  [dbo].[saf20] B on A.saf20a02_serial=B.saf2002_serial
              inner join [dbo].[cnf10] C on B.saf2001_cuscode=C.cnf1002_fileorder and  cnf1001_filetype = 'D001'
              where (1=1)
                ";
                //cuscode
                if (!String.IsNullOrEmpty(Filter.cuscode_start.Trim())) {
                    cmd.CommandText += " and @cuscode_start<=saf2001_cuscode ";
                    cmd.Parameters.AddWithValue("@cuscode_start", Filter.cuscode_start);
                
                }
                if (!String.IsNullOrEmpty(Filter.cuscode_end.Trim()))
                {
                    cmd.CommandText += " and  @cuscode_end>=saf2001_cuscode ";
                    cmd.Parameters.AddWithValue("@cuscode_end", Filter.cuscode_end);

                }
                //deli_date
                if (!String.IsNullOrEmpty(Filter.deli_date_start.Trim()))
                {
                    cmd.CommandText += " and  @deli_date_start<=saf2084_deli_date ";
                    cmd.Parameters.AddWithValue("@deli_date_start", Filter.deli_date_start);

                }
                
                if (!String.IsNullOrEmpty(Filter.deli_date_end.Trim()))
                {
                    var DateEnd = Convert.ToDateTime(Filter.deli_date_end.Trim());

                    cmd.CommandText += " and saf2084_deli_date<@deli_date_end";
                    cmd.Parameters.AddWithValue("@deli_date_end", DateEnd.AddDays(1).ToString("yyyy/MM/dd"));

                }
                //serial
                if (!String.IsNullOrEmpty(Filter.serial_start.Trim()))
                {


                    cmd.CommandText += " and @serial_start<=saf2002_serial";
                    cmd.Parameters.AddWithValue("@serial_start", Filter.serial_start);

                }

                if (!String.IsNullOrEmpty(Filter.serial_end.Trim()))
                {
                    cmd.CommandText += " and saf2002_serial<=@serial_end";
                    cmd.Parameters.AddWithValue("@serial_end", Filter.serial_end);
                }

                //inv_date
                if (!String.IsNullOrEmpty(Filter.inv_date_start.Trim()))
                {
                    cmd.CommandText += " and  @inv_date_start<=saf20a39_inv_date ";
                    cmd.Parameters.AddWithValue("@inv_date_start", Filter.inv_date_start);

                }

                if (!String.IsNullOrEmpty(Filter.inv_date_end.Trim()))
                {
                    var DateEnd = Convert.ToDateTime(Filter.inv_date_end.Trim());

                    cmd.CommandText += " and saf20a39_inv_date<@inv_date_end";
                    cmd.Parameters.AddWithValue("@inv_date_end", DateEnd.AddDays(1).ToString("yyyy/MM/dd"));

                }

                //inv_no
                if (!String.IsNullOrEmpty(Filter.inv_no_start.Trim()))
                {


                    cmd.CommandText += " and @inv_no_start<=saf20a38_inv_no";
                    cmd.Parameters.AddWithValue("@inv_no_start", Filter.inv_no_start);

                }

                if (!String.IsNullOrEmpty(Filter.inv_no_end.Trim()))
                {
                    cmd.CommandText += " and saf20a38_inv_no<=@inv_no_end";
                    cmd.Parameters.AddWithValue("@inv_no_end", Filter.inv_no_end);
                }


                if (!String.IsNullOrEmpty(Filter.inv_no_y.Trim()))
                {


                    cmd.CommandText += " and saf2038_inv_no<>''";

                }
                if (!String.IsNullOrEmpty(Filter.inv_no_n.Trim()))
                {


                    cmd.CommandText += " and saf2038_inv_no=''";
                    

                }



                using (var rd = cmd.ExecuteReader())
                {

                    while (rd.Read())
                    {

                        var data = new OrderData();
                        data.cnf1003_char01 = rd["cnf1003_char01"].ToString();
                        data.saf2001_cuscode = rd["saf2001_cuscode"].ToString();
                        data.saf2046_mana_fee = rd["saf2046_mana_fee"].ToString();
                        data.saf20107_tax_id = rd["saf20107_tax_id"].ToString();
                        data.saf2002_serial = rd["saf2002_serial"].ToString();
                        data.saf2014_rec_name = rd["saf2014_rec_name"].ToString();
                        data.saf2015_rec_cell = rd["saf2015_rec_cell"].ToString();
                        data.saf20a38_inv_no = rd["saf20a38_inv_no"].ToString();
                        data.saf20a39_inv_date = rd["saf20a39_inv_date"].ToString();
                        data.saf20a37_pcode = rd["saf20a37_pcode"].ToString();
                        data.saf20a31_psname = rd["saf20a31_psname"].ToString();
                        data.saf20a32_pname = rd["saf20a32_pname"].ToString();
                        data.saf20a34_ship_pname = rd["saf20a34_ship_pname"].ToString();
                        data.saf20a03_ord_no = rd["saf20a03_ord_no"].ToString();
                        data.saf20103_sales_amt = rd["saf20103_sales_amt"].ToString();
                        data.saf20105_tax = rd["saf20105_tax"].ToString();
                        data.saf20105_tax = rd["saf20106_total_amt"].ToString();
                        data.saf20105_tax = rd["saf20110_printmark"].ToString();
                        datalist.Add(data);
                    }

                }

               
            }
            return datalist;
        }

        public class OrderData
        {
            public string cnf1003_char01 { get; set; }
            public string saf2001_cuscode { get; set; }
            public string saf2046_mana_fee { get; set; }
            public string saf20107_tax_id { get; set; }
            public string saf2002_serial { get; set; }
            public string saf2014_rec_name { get; set; }
            public string saf2015_rec_cell { get; set; }

            public string saf20103_sales_amt { get; set; }
            public string saf20105_tax { get; set; }
            public string saf20106_total_amt { get; set; }
            public string saf20110_printmark { get; set; }
            

            public string saf20a38_inv_no { get; set; }
            public string saf20a39_inv_date { get; set; }
            public string saf20a37_pcode { get; set; }
            public string saf20a31_psname { get; set; }
            public string saf20a32_pname { get; set; }
            public string saf20a34_ship_pname { get; set; }
            public string saf20a03_ord_no { get; set; }
        }
        public class Filters
        {
            public string cuscode_start { get; set; }
            public string cuscode_end { get; set; }

            public string deli_date_start{ get; set; }
            public string deli_date_end { get; set; }

            public string serial_start { get; set; }
            public string serial_end { get; set; }

            public string inv_date_start { get; set; }
            public string inv_date_end { get; set; }

            public string inv_no_start { get; set; }
            public string inv_no_end { get; set; }

            public string inv_no_y { get; set; }
            public string inv_no_n { get; set; }

        }




    }

}
