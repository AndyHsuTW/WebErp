<%@ WebHandler Language="C#" Class="D_pcodeHandler" %>

using System;
using System.Web;
using Newtonsoft.Json;
using ErpBaseLibrary.DB;
using System.Data.SqlClient;
using System.Collections.Generic;
public class D_pcodeHandler : IHttpHandler
{

    public void ProcessRequest(HttpContext context) {
        context.Response.ContentType = "text/plain";
        var List = new List<D_pcodeData>();
        using (var conn = new SqlConnection(MyConnStringList.AzureGoodeasy))
        {
            conn.Open();
            var cmd = conn.CreateCommand();
            cmd.CommandText = @"
                SELECT 
                 inf01.status
                ,inf0102_pcode
                ,inf0113_psname
                ,inf0110_pname
                ,inf0111_color
                ,inf0115_runit
                ,inf0123_pdept
                ,inf0124_pcat
                ,inf01a07_retail
                ,inf01b24_inv_qty
                ,inf0104_mcode
                ,inf0302_bname
                ,inf0175_graphy
                  FROM [dbo].[inf01] inf01
                 left join  [dbo].[inf01a]  inf01a on inf01.inf0102_pcode=inf01a.inf01a02_pcode
                 left join  [dbo].[inf01b]  inf01b on inf01.inf0102_pcode=inf01b.inf01b02_pcode
                 left join  [dbo].[inf03]  inf03 on inf01.inf0104_mcode=inf03.inf0302_mcode
                 where  inf01.status<>'D'
                ";
            using (var rd = cmd.ExecuteReader()) {

                while (rd.Read()) {
                    List.Add(new D_pcodeData()
                    {
                        pcode = rd["inf0102_pcode"].ToString(),
                        psname = rd["inf0113_psname"].ToString(),
                        color = rd["inf0111_color"].ToString(),
                        runit = rd["inf0115_runit"].ToString(),

                        pdept = rd["inf0123_pdept"].ToString(),
                        pcat = rd["inf0124_pcat"].ToString(),
                        retail = rd["inf01a07_retail"].ToString(),
                        inv_qty = rd["inf01b24_inv_qty"].ToString(),
                        bname = rd["inf0302_bname"].ToString(),
                        graphy = rd["inf0175_graphy"].ToString(),
                    });
                
                }
            }
        
        
        }


        context.Response.Write(JsonConvert.SerializeObject(List));
       
    }

    public class D_pcodeData
    {
        public string pcode { get; set; }
        public string psname { get; set; }
        public string pname { get; set; }
        public string color { get; set; }
        public string runit { get; set; }
        public string pdept { get; set; }
        public string pcat { get; set; }
        public string retail { get; set; }
        public string inv_qty { get; set; }
        public string bname { get; set; }
        public string graphy { get; set; }

    }


    public class filterOption
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
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}