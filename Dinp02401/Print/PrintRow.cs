using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using ErpBaseLibrary.DB;

namespace Dinp02401.Print
{
    public class PrintRow
    {

        public string inf29a05_pcode { get; set; }

        public string inf29a33_product_name { get; set; }

        public string inf29a17_runit { get; set; }

        public string Inf2903CustomerCodeName { get; set; }

        public string Inf2910InReasonName { get; set; }

        public DateTime inf2904_pro_date { get; set; }

        public string inf29a39_price { get; set; }

        public double inf29a10_ocost_one { get; set; }

        public double inf29a09_oretail_one { get; set; }

        public double inf29a13_sold_qty { get; set; }

        public double TotalPrice { get; set; }

        /// <summary>
        /// Get rows by id.
        /// </summary>
        /// <param name="idList"></param>
        /// <returns></returns>
        public static List<PrintRow> GetPrintRows(List<int> idList)
        {
            List<int> inf29IdList = idList;
            List<PrintRow> printRows = new List<PrintRow>();

            using (var conn = new SqlConnection { ConnectionString = MyConnStringList.AzureGoodeasy })
            using (var sqlCmd = conn.CreateCommand())
            {
                conn.Open();

                sqlCmd.CommandText = String.Format(@"
        SELECT [inf29a05_pcode]
               ,[inf29a33_product_name]
               ,[inf29a17_runit]
               ,[inf2904_pro_date]
               ,[inf29a39_price]
               ,[inf29a10_ocost_one]
               ,[inf29a09_oretail_one]
               ,[inf29a13_sold_qty]
               ,(
			--客戶資料
            CASE WHEN cnf10.cnf1004_char02='cmf01' THEN
                (
                    SELECT TOP 1 cmf0103_bname
                    FROM cmf01
                    WHERE cmf0102_cuscode = inf29.inf2903_customer_code
                )
				--公司資料
				WHEN cnf10.cnf1004_char02='cnf07' THEN
                (
                    SELECT TOP 1 cnf0702_bname
                    FROM cnf07
                    WHERE cnf0701_bcode = inf29.inf2903_customer_code
                )
				--廠商資料
				WHEN cnf10.cnf1004_char02='inf03' THEN
                (
                    SELECT TOP 1 inf0302_bname
                    FROM inf03
                    WHERE inf0302_mcode = inf29.inf2903_customer_code
                )
				--客戶資料
				WHEN cnf10.cnf1004_char02='taf10' THEN
                (
                    SELECT TOP 1 taf1004_cname
                    FROM taf10
                    WHERE taf1001_empid = inf29.inf2903_customer_code
                )
				--異動單位
				WHEN cnf10.cnf1004_char02='cnf10' THEN
                (
                    SELECT TOP 1 cnf1003_char01
                    FROM cnf10
                    WHERE cnf1002_fileorder = inf29.inf2903_customer_code
					AND cnf1001_filetype = 'S35'
                )
            ELSE
                ''
			END
            ) AS Inf2903CustomerCodeName
               ,cnf10.[cnf1003_char01] as Inf2910InReasonName
        FROM inf29a 
        LEFT JOIN inf29
            ON inf29.inf2901_docno = inf29a.inf29a01_docno
        LEFT JOIN [cnf10]
            ON cnf10.cnf1002_fileorder = inf29.inf2910_in_reason AND cnf10.cnf1001_filetype='S15'

        WHERE inf29a01_docno IN(
            SELECT inf2901_docno
            FROM inf29
            WHERE id IN({0})
        ) ", String.Join(",", inf29IdList));

                using (var sqlReader = sqlCmd.ExecuteReader())
                {
                    if (sqlReader.HasRows)
                    {
                        while (sqlReader.Read())
                        {
                            PrintRow printRow = new PrintRow();
                            printRow.inf29a05_pcode = Convert.ToString(sqlReader["inf29a05_pcode"]);
                            printRow.inf29a33_product_name = Convert.ToString(sqlReader["inf29a33_product_name"]);
                            printRow.inf29a17_runit = Convert.ToString(sqlReader["inf29a17_runit"]);
                            printRow.inf2904_pro_date = Convert.ToDateTime(sqlReader["inf2904_pro_date"]);
                            printRow.inf29a10_ocost_one = Convert.ToDouble(sqlReader["inf29a10_ocost_one"]);
                            printRow.inf29a09_oretail_one = Convert.ToDouble(sqlReader["inf29a09_oretail_one"]);
                            printRow.inf29a13_sold_qty = Convert.ToDouble(sqlReader["inf29a13_sold_qty"]);
                            printRow.Inf2903CustomerCodeName = Convert.ToString(sqlReader["Inf2903CustomerCodeName"]);
                            printRow.Inf2910InReasonName = Convert.ToString(sqlReader["Inf2910InReasonName"]);
                            printRow.TotalPrice = printRow.inf29a09_oretail_one*printRow.inf29a13_sold_qty;

                            printRows.Add(printRow);
                        }
                    }
                }
            }

            return printRows;
        } 

    }
}
