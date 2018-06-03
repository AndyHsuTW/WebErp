using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ErpBaseLibrary.DB;
using System.Data.SqlClient;
using OfficeOpenXml;
using OfficeOpenXml.Style;
namespace WebERPLibrary
{

    public class D_pcode
    {
        public static void GetFilterStr(string name, string filter, SqlCommand cmd)
        {
            var haslike = false;
            var result = "";
            var length = filter.Length;
            var count = 0;
            foreach (var i in filter)
            {
                count++;
                var text = i;
                if ((count == 1 && text == '*') || (count == length && text == '*'))
                {
                    result += "%";
                    haslike = true;
                }
                else
                {
                    result += text;
                }

            }
            cmd.Parameters.AddWithValue("@" + name, result);
            if (haslike)
            {
                cmd.CommandText += " and " + name + " like @" + name;

            }
            else
            {
                cmd.CommandText += " and " + name + " = @" + name;

            }

        }


        public static void GetKeyWordStr(string Keyword, SqlCommand cmd)
        {
            cmd.Parameters.AddWithValue("@Keyword", "%" + Keyword + "%");
            cmd.CommandText += @"
                  and (inf01.[ID] like @Keyword
                  OR inf01.[status] like @Keyword
                  OR [inf0102_pcode] like @Keyword
                  OR [inf0103_type] like @Keyword
                  OR [inf0104_mcode] like @Keyword
                  OR [inf0105_mcode] like @Keyword
                  OR [inf0106_relative_no] like @Keyword
                  OR [inf0107_pclass] like @Keyword
                  OR [inf0108_pseq] like @Keyword
                  OR [inf0109_brand] like @Keyword
                  OR [inf0110_pname] like @Keyword
                  OR [inf0111_color] like @Keyword
                  OR [inf0112_pspec] like @Keyword
                  OR [inf0113_psname] like @Keyword
                  OR [inf0114_psupply] like @Keyword
                  OR [inf0115_runit] like @Keyword
                  OR [inf0116_pqty_o] like @Keyword
                  OR [inf0117_pqty_i] like @Keyword
                  OR [inf0118_punit] like @Keyword
                  OR [inf0119_ounit] like @Keyword
                  OR [inf0120_eantype] like @Keyword
                  OR [inf0121_eantype1] like @Keyword
                  OR [inf0122_dis_id] like @Keyword
                  OR [inf0123_pdept]  like @Keyword
                  OR [inf0124_pcat] like @Keyword
                  OR [inf0125_vxcode] like @Keyword
                  OR [inf0126_f_flag] like @Keyword
                  OR [inf0127_tax_flag] like @Keyword
                  OR [inf0128_comb_flag] like @Keyword
                  OR [inf0129_comb_retail] like @Keyword
                  OR [inf0130_ean_flag] like @Keyword
                  OR [inf0131_jan_flag] like @Keyword
                  OR [inf0132_feb_flag] like @Keyword
                  OR [inf0133_mar_flag] like @Keyword
                  OR [inf0134_apr_flag] like @Keyword
                  OR [inf0135_may_flag] like @Keyword
                  OR [inf0136_jun_flag] like @Keyword
                  OR [inf0137_jul_flag] like @Keyword
                  OR [inf0138_aug_flag] like @Keyword
                  OR [inf0139_sep_flag] like @Keyword
                  OR [inf0140_oct_flag] like @Keyword
                  OR [inf0141_nov_flag] like @Keyword
                  OR [inf0142_dec_flag] like @Keyword
                  OR [inf0143_bdem_L] like @Keyword
                  OR [inf0144_bdem_W] like @Keyword
                  OR [inf0145_bdem_H] like @Keyword
                  OR [inf0146_bdem_U] like @Keyword
                  OR [inf0147_pdem_L] like @Keyword
                  OR [inf0148_pdem_W] like @Keyword
                  OR [inf0149_pdem_H] like @Keyword
                  OR [inf0150_pdem_U] like @Keyword
                  OR [inf0151_pn_wt] like @Keyword
                  OR [inf0152_pg_wt] like @Keyword
                  OR [inf0153_pyear] like @Keyword
                  OR [inf0154_ploc] like @Keyword
                  OR [inf0155_picture] like @Keyword
                  OR [inf0156_ipo_date] like @Keyword
                  OR [inf0157_barcode] like @Keyword
                  OR [inf0158_popname1] like @Keyword
                  OR [inf0159_popname2] like @Keyword
                  OR [inf0160_sugt] like @Keyword
                  OR [inf0161_app_code] like @Keyword
                  OR [inf0162_appertain] like @Keyword
                  OR [inf0163_time] like @Keyword
                  OR [inf0164_dividend] like @Keyword
                  OR [inf0165_scalage] like @Keyword
                  OR [inf0166_currency] like @Keyword
                  OR [inf0167_multiplicand] like @Keyword
                  OR [inf0168_by] like @Keyword
                  OR [inf0169_size_print] like @Keyword
                  OR [inf0170_leadtime] like @Keyword
                  OR [inf0171_size] like @Keyword
                  OR [inf0172_order] like @Keyword
                  OR [inf0173_package] like @Keyword
                  OR [inf0174_class] like @Keyword
                  OR [inf0175_graphy] like @Keyword
                  OR [inf0176_retail1] like @Keyword
                  OR [inf0177_retail2] like @Keyword
                  OR [inf0178_retail3] like @Keyword
                  OR [inf0179_retail4] like  @Keyword
                  OR [inf0180_retail5] like  @Keyword
                  OR [inf0181_retail6] like  @Keyword
                  OR [inf0182_retail7] like  @Keyword
                  OR [inf0183_retail8] like  @Keyword
                  OR [inf0184_retail9] like  @Keyword
                  OR [inf0185_dev_date] like  @Keyword
                  OR [inf0186_pur_month] like  @Keyword
                  OR [inf0187_buy_type] like  @Keyword
                  OR [inf0188_least_qty] like  @Keyword
                  OR [inf0189_overflow_rate] like  @Keyword
                  OR [inf0190_now_price] like  @Keyword
                  OR [inf0191_last_price] like  @Keyword
                  OR [inf0192_stuff_store] like  @Keyword
                  OR [inf0193_ys_kind] like  @Keyword
                  OR [inf0194_ys_stuff] like  @Keyword
                  OR [inf0195_size_ys] like  @Keyword
                  OR [inf0196_dev_area] like  @Keyword
                  OR [inf0197_brand_no] like  @Keyword
                  OR [inf0198_tax_rate] like  @Keyword
                  OR [inf0199_shoes_n11] like  @Keyword
                  OR [inf01100_shoes_n12] like  @Keyword
                  OR [inf01101_shoes_n13] like  @Keyword
                  OR [inf01102_shoes_n14] like  @Keyword
                  OR [inf01103_shoes_n15] like  @Keyword
                  OR [inf01104_shoes_n16] like  @Keyword
                  OR [inf01105_shoes_n17] like  @Keyword
                  OR [inf01106_settle_type] like  @Keyword
                  OR [inf01107_stock_no] like  @Keyword
                  OR [inf01108_cost_class] like  @Keyword
                  OR [inf01109_retall_code] like  @Keyword
                  OR [inf01110_stock_key] like  @Keyword
                  OR [inf01111_auteur] like  @Keyword
                  OR [inf01112_publishinghouse] like  @Keyword
                  OR [inf01113_isbn] like  @Keyword
                  OR [inf01114_eantype] like  @Keyword
                  OR [inf01115_eantype1] like  @Keyword
                  OR [inf01116_dis_id] like  @Keyword
                  OR [inf01117_a_cost] like  @Keyword
                  OR [inf01118_a_retail] like  @Keyword
                  OR [inf01119_rfid] like  @Keyword
                  OR [inf01120_not_stocks] like  @Keyword
                  OR [inf01121_test_code] like  @Keyword
                  OR [inf01122_test_code1] like  @Keyword
                  OR [inf01123_numer] like  @Keyword
                  OR [inf01124_use_age] like  @Keyword
                  OR [inf01125_tax] like  @Keyword
                  OR [inf01126_psname_english] like  @Keyword
                  OR [inf01127_psname_simplif] like  @Keyword
                  OR [inf01128_class] like  @Keyword
                  --OR [remark] like  @Keyword
                  --OR [adduser] like  @Keyword
                 -- OR [adddate] like  @Keyword
                 -- OR [moduser] like  @Keyword
                 -- OR [moddate] like  @Keyword
                  OR [inf01129_end_day] like  @Keyword
                  OR [inf01130_supply_code] like  @Keyword
                  OR [inf01131_ctype] like  @Keyword
                  OR [inf01132_sunit] like  @Keyword
                  OR [inf01133_psname_japan] like  @Keyword
                  OR [inf01134_japanno] like  @Keyword
                  OR [inf01135_usemono] like  @Keyword
	              )";
        }
        public static List<D_pcodeData> GetDpcode(D_pcodefilterOption FilterOption, string StartRow)
        {
            var List = new List<D_pcodeData>();
            using (var conn = new SqlConnection(MyConnStringList.AzureGoodeasy))
            {


                conn.Open();

                var cmd = conn.CreateCommand();
                var runitcode =
                cmd.CommandText = @"

                DECLARE @pdeptcode nvarchar(60) = (select top 1 cnf1003_char01 from dbo.cnf10 where cnf1001_filetype='012')
                DECLARE @pcatcode nvarchar(60) = (select top 1 cnf1003_char01 from dbo.cnf10 where cnf1001_filetype='014')

                select * from(
                SELECT ROW_NUMBER() OVER(ORDER BY inf01.ID) AS RowId
                ,inf01.status
                ,inf0102_pcode
                ,inf0107_pclass
                ,inf0113_psname
                ,inf0110_pname
                ,inf0111_color
                ,inf0115_runit
                ,inf0116_pqty_o
                ,inf01125_tax
                ,ISNULL(inf0123_pdept,'')+'-'+ISNULL(@pdeptcode,'') as  inf0123_pdept
                ,ISNULL(inf0124_pcat,'')+'-'+ISNULL(@pcatcode,'') as inf0124_pcat
                ,inf0127_tax_flag
                ,inf01a03_size
                ,inf01a07_retail
                ,inf01a13_cost
                ,inf01a67_cost_notax
                ,inf01b24_inv_qty
                ,ISNULL(inf0104_mcode,'')+'-'+ISNULL(inf0302_bname,'') as bname
                ,inf0175_graphy
                ,inf0164_dividend
                  FROM [dbo].[inf01] inf01
                 Inner join  [dbo].[inf01a]  inf01a on inf01.inf0102_pcode=inf01a.inf01a02_pcode
                 Inner join  [dbo].[inf01b]  inf01b on inf01.inf0102_pcode=inf01b.inf01b02_pcode
                 Inner join  [dbo].[inf03]  inf03 on inf01.inf0104_mcode=inf03.inf0302_mcode
                 where  inf01.status<>'D'
                ";

                if (!String.IsNullOrEmpty(FilterOption.Retail_start))
                {

                    cmd.Parameters.AddWithValue("@Retail_start", FilterOption.Retail_start);
                    cmd.CommandText += " and @Retail_start <= inf01a07_retail";
                }
                if (!String.IsNullOrEmpty(FilterOption.Retail_end))
                {
                    cmd.Parameters.AddWithValue("@Retail_end", FilterOption.Retail_end);
                    cmd.CommandText += " and inf01a07_retail<=@Retail_end";
                }

                if (!String.IsNullOrEmpty(FilterOption.RelativeNo_start))
                {
                    cmd.Parameters.AddWithValue("@RelativeNo_start", FilterOption.RelativeNo_start);
                    cmd.CommandText += " and @RelativeNo_start <= inf0106_relative_no";

                }
                if (!String.IsNullOrEmpty(FilterOption.RelativeNo_end))
                {
                    cmd.Parameters.AddWithValue("@RelativeNo_end", FilterOption.RelativeNo_end);
                    cmd.CommandText += " and inf0106_relative_no<=@RelativeNo_end";
                }
                if (!String.IsNullOrEmpty(FilterOption.Mcode))
                {

                    GetFilterStr("inf0104_mcode", FilterOption.Mcode, cmd);

                }
                if (!String.IsNullOrEmpty(FilterOption.Pcode))
                {

                    GetFilterStr("inf0102_pcode", FilterOption.Pcode, cmd);

                }
                if (!String.IsNullOrEmpty(FilterOption.Psname))
                {
                    GetFilterStr("inf0113_psname", FilterOption.Psname, cmd);
                }
                if (!String.IsNullOrEmpty(FilterOption.Keyword))
                {
                    GetKeyWordStr(FilterOption.Keyword, cmd);

                }
                cmd.CommandText += " ) Main";
                //cmd.Parameters.AddWithValue("@StartRow", StartRow);
                using (var rd = cmd.ExecuteReader())
                {

                    while (rd.Read())
                    {
                        List.Add(new D_pcodeData()
                        {
                            dividend = Convert.ToDouble(rd["inf0164_dividend"]),
                            pcode = rd["inf0102_pcode"].ToString(),
                            pclass = rd["inf0107_pclass"].ToString(),
                            psname = rd["inf0113_psname"].ToString(),
                            pname = rd["inf0110_pname"].ToString(),
                            color = rd["inf0111_color"].ToString(),
                            cost = rd["inf01a13_cost"].ToString(),
                            cost_notax = rd["inf01a67_cost_notax"].ToString(),
                            runit = rd["inf0115_runit"].ToString(),
                            pdept = rd["inf0123_pdept"].ToString(),
                            pcat = rd["inf0124_pcat"].ToString(),
                            pqty_o = Convert.ToDouble(rd["inf0116_pqty_o"]),
                            retail = rd["inf01a07_retail"].ToString(),
                            size = rd["inf01a03_size"].ToString(),
                            tax = Convert.ToDouble(rd["inf01125_tax"]),
                            tax_flag = rd["inf0127_tax_flag"].ToString(),
                            inv_qty = rd["inf01b24_inv_qty"].ToString(),
                            bname = rd["bname"].ToString(),
                            graphy = rd["inf0175_graphy"].ToString(),
                        });

                    }
                }


            }
            return List;

        }



    }

    public class Dsap92001
    {
        public static List<Company> GetCompanyList()
        {

            var List = new List<Company>();
            using (var conn = new SqlConnection(MyConnStringList.AzureGoodeasy))
            {
                conn.Open();
                var cmd = conn.CreateCommand();
                cmd.CommandText = @"
            SELECT 
                cnf1002_fileorder AS code, 
                cnf1003_char01 AS name
            FROM [dbo].[cnf10]
            WHERE 
                cnf1001_filetype ='D002' 
                and  cnf1005_char03 ='1'
            order by cnf1003_char01
            ";
                using (var rd = cmd.ExecuteReader())
                {
                    if (rd.HasRows)
                    {
                        while (rd.Read())
                        {
                            List.Add(new Company()
                            {
                                Name = rd["name"].ToString(),
                                Code = rd["code"].ToString()

                            });

                        }
                    }

                }

            }
            return List;

        }

        public static byte[] GetExcelData(List<saf20Data> Listdata, Company Company)
        {
            var excel = new ExcelPackage();
            var sheet = excel.Workbook.Worksheets.Add(Company.Name);
            var title = 1;
            if (Company.Code == "2004")
            {
                //sheet.Cells[title, 1].Value = "序號";
                //sheet.Cells[title, 2].Value = "客戶";
                //sheet.Cells[title, 3].Value = "";
                //sheet.Cells[title, 4].Value = "";
                //sheet.Cells[title, 5].Value = "手機";
                //sheet.Cells[title, 6].Value = "姓名";
                //sheet.Cells[title, 7].Value = "";
                //sheet.Cells[title, 8].Value = "地址";
                //sheet.Cells[title, 9].Value = "";
                //sheet.Cells[title, 10].Value = "";
                //sheet.Cells[title, 11].Value = "";
                //sheet.Cells[title, 12].Value = "";
                //sheet.Cells[title, 13].Value = "";
                //sheet.Cells[title, 14].Value = "品名";
                //sheet.Cells[title, 15].Value = "";
                //sheet.Cells[title, 16].Value = "";
                sheet.Cells[title, 1].Value = "";
                sheet.Cells[title, 2].Value = "";
                sheet.Cells[title, 3].Value = "";
                sheet.Cells[title, 4].Value = "";
                sheet.Cells[title, 5].Value = "";
                sheet.Cells[title, 6].Value = "";
                sheet.Cells[title, 7].Value = "";
                sheet.Cells[title, 8].Value = "";
                sheet.Cells[title, 9].Value = "";
                sheet.Cells[title, 10].Value = "";
                sheet.Cells[title, 11].Value = "";
                sheet.Cells[title, 12].Value = "";
                sheet.Cells[title, 13].Value = "";
                sheet.Cells[title, 14].Value = "";
                sheet.Cells[title, 15].Value = "";
                sheet.Cells[title, 16].Value = "";
                title = 0;
                for (int i = 0; i < Listdata.Count; i++)
                {
                    var data = Listdata[i];
                    sheet.Cells[title + i + 1, 1].Value = data.RowId;
                    sheet.Cells[title + i + 1, 2].Value = data.Cuscod;
                    sheet.Cells[title + i + 1, 3].Value = "";
                    sheet.Cells[title + i + 1, 4].Value = "";
                    sheet.Cells[title + i + 1, 5].Value = data.Cell;
                    sheet.Cells[title + i + 1, 6].Value = data.Name;
                    sheet.Cells[title + i + 1, 7].Value = "";
                    sheet.Cells[title + i + 1, 8].Value = data.Address;
                    sheet.Cells[title + i + 1, 9].Value = "";
                    sheet.Cells[title + i + 1, 10].Value = "";
                    sheet.Cells[title + i + 1, 11].Value = "";
                    sheet.Cells[title + i + 1, 12].Value = "";
                    sheet.Cells[title + i + 1, 13].Value = "";
                    sheet.Cells[title + i + 1, 14].Value = data.PsName;
                    sheet.Cells[title + i + 1, 15].Value = "";
                    sheet.Cells[title + i + 1, 16].Value = "";
                }

            }
            else
            {

                sheet.Cells[title, 1].Value = "序號";
                sheet.Cells[title, 2].Value = "姓名";
                sheet.Cells[title, 3].Value = "地址";
                sheet.Cells[title, 4].Value = "手機";
                sheet.Cells[title, 5].Value = "電話";
                sheet.Cells[title, 6].Value = "數量";
                sheet.Cells[title, 7].Value = "品名";
                sheet.Cells[title, 8].Value = "代收款";

                for (int i = 0; i < Listdata.Count; i++)
                {
                    var data = Listdata[i];
                    sheet.Cells[title + i + 1, 1].Value = data.RowId;
                    sheet.Cells[title + i + 1, 2].Value = data.Name;
                    sheet.Cells[title + i + 1, 3].Value = data.Address;
                    sheet.Cells[title + i + 1, 4].Value = data.Cell;
                    sheet.Cells[title + i + 1, 5].Value = data.Tel01;
                    sheet.Cells[title + i + 1, 6].Value = data.Ordqty;
                    sheet.Cells[title + i + 1, 7].Value = data.PsName;
                    sheet.Cells[title + i + 1, 8].Value = data.Money;
                }


            }


            return excel.GetAsByteArray();


        }

        public static List<saf20Data> GetCompanysaf20Data(FilterOption FilterOption, string Code)
        {
            var List = new List<saf20Data>();
            using (var conn = new SqlConnection(MyConnStringList.AzureGoodeasy))
            {
                conn.Open();
                var cmd = conn.CreateCommand();
                cmd.CommandText = @"
           SELECT 
	            ROW_NUMBER() OVER(ORDER BY saf2023_ship_date) AS RowId,
	            saf2001_cuscode as Cuscod,
	            saf2014_rec_name as Name,
	            saf2019_rec_address as Address,
	            saf2015_rec_cell as Cell,
	            saf2016_rec_tel01 as Tel01,
	            saf20a41_ord_qty as Ordqty,
	            saf20a31_psname  as PsName,
	            saf2090_col_money as Money 
            FROM [dbo].[saf20] saf20
            inner join  [dbo].[saf20a] saf20a on saf20.saf2002_serial=saf20a.saf20a02_serial
            where 
                saf2029_logis_no=@code and 
                @startdate<= Convert(varchar(10),saf2023_ship_date,111) and 
                Convert(varchar(10),saf2023_ship_date,111)<= @enddate";
                cmd.Parameters.AddWithValue("@code", Code);
                cmd.Parameters.AddWithValue("@startdate", FilterOption.StartDate);
                cmd.Parameters.AddWithValue("@enddate", FilterOption.EndDate);
                using (var rd = cmd.ExecuteReader())
                {
                    if (rd.HasRows)
                    {
                        while (rd.Read())
                        {
                            List.Add(new saf20Data()
                            {
                                RowId = rd["RowId"].ToString(),
                                Cuscod = rd["Cuscod"].ToString(),
                                Name = rd["Name"].ToString(),
                                Address = rd["Address"].ToString(),
                                Cell = rd["Cell"].ToString(),
                                Tel01 = rd["Tel01"].ToString(),
                                Ordqty = rd["Ordqty"].ToString(),
                                PsName = rd["PsName"].ToString(),
                                Money = rd["Money"].ToString(),
                            });

                        }
                    }
                }
            }


            return List;
        }
    }

    public class saf20Data
    {
        public string RowId { get; set; }
        public string Cuscod { get; set; }
        public string Name { get; set; }
        public string Address { get; set; }
        public string Cell { get; set; }
        public string Tel01 { get; set; }
        public string Ordqty { get; set; }
        public string PsName { get; set; }
        public string Money { get; set; }
    }
    public class FilterOption
    {
        public string StartDate { get; set; }
        public string EndDate { get; set; }
    }
    public class Company
    {
        public string Name { get; set; }
        public string Code { get; set; }
    }

    public class D_pcodeData
    {
        public string pcode { get; set; }
        public string pclass { get; set; }
        public string psname { get; set; }
        public string pname { get; set; }
        public string color { get; set; }
        public string cost { get; set; }
        public string cost_notax { get; set; }
        public double dividend { get; set; }
        public string runit { get; set; }
        public string pdept { get; set; }
        public string pcat { get; set; }
        public double pqty_o { get; set; }
        public string retail { get; set; }
        public string size { get; set; }
        public double tax { get; set; }
        public string tax_flag { get; set; }
        public string inv_qty { get; set; }
        public string bname { get; set; }
        public string graphy { get; set; }

    }


    public class D_pcodefilterOption
    {
        public string Mcode { get; set; }
        public string RelativeNo_start { get; set; }
        public string RelativeNo_end { get; set; }
        public string Pcode { get; set; }
        public string Psname { get; set; }
        public string Keyword { get; set; }
        public string Retail_start { get; set; }
        public string Retail_end { get; set; }

    }
}
