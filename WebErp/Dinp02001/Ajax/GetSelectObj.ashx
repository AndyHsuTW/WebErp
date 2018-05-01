<%@ WebHandler Language="C#" Class="GetSelectObj" %>

using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web;
using Dinp02301;
using ErpBaseLibrary.DB;
using Newtonsoft.Json;

public class GetSelectObj : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        //context.Response.Write("Hello World");
        var SelectObj = new SelectObj();
        SelectObj.BcodeList = Cnf07.GetList();
        SelectObj.WherehouseList = Cnf10.GetList("004");
        SelectObj.InReasonList = Cnf10.GetList("S15");
        SelectObj.CurrencyList = Cnf10.GetList("073");
        SelectObj.PayList = Cnf10.GetList("S05");
        SelectObj.EmpList = GetTaf10List();
        SelectObj.ManufacturerList = GetInf03List();
        SelectObj.ManufacturerEmpList = GetInf03aList();
        context.Response.Write(JsonConvert.SerializeObject(SelectObj));
    }

    public class SelectObj
    {
        public List<Cnf07> BcodeList { get; set; }
        public List<Cnf10> WherehouseList { get; set; }
        public List<Cnf10> InReasonList { get; set; }
        public List<Cnf10> CurrencyList { get; set; }
        public List<Taf10> EmpList { get; set; }
        public List<Cnf10> PayList { get; set; }
        public List<Inf03> ManufacturerList { get; set; }
        public List<Inf03a> ManufacturerEmpList { get; set; }
    }

    public List<Taf10> GetTaf10List()
    {
        var taf10List = new List<Taf10>();
        using (var conn = new SqlConnection(MyConnStringList.AzureGoodeasy))
        {
            conn.Open();
            using (var cmd = conn.CreateCommand())
            {
                cmd.CommandText = " select taf1001_empid,taf1004_cname from taf10";
                using (var rd = cmd.ExecuteReader())
                {
                    while (rd.Read())
                    {
                        var taf10 = new Taf10();
                        taf10.taf1001_empid = rd["taf1001_empid"].ToString();
                        taf10.taf1004_cname = rd["taf1004_cname"].ToString();
                        taf10List.Add(taf10);
                    }
                }
            }
        }

        return taf10List;
    }

    public List<Inf03> GetInf03List()
    {
        var inf03List = new List<Inf03>();
        using (var conn = new SqlConnection(MyConnStringList.AzureGoodeasy))
        {
            conn.Open();
            using (var cmd = conn.CreateCommand())
            {
                cmd.CommandText = " select * from Inf03";
                using (var rd = cmd.ExecuteReader())
                {
                    while (rd.Read())
                    {
                        var inf03 = new Inf03();
                        inf03.inf0302_mcode = rd["inf0302_mcode"].ToString();
                        inf03.inf0302_bname = rd["inf0302_bname"].ToString();
                        inf03List.Add(inf03);
                    }
                }
            }
        }

        return inf03List;

    }
    public List<Inf03a> GetInf03aList()
    {
        var inf03List = new List<Inf03a>();
        using (var conn = new SqlConnection(MyConnStringList.AzureGoodeasy))
        {
            conn.Open();
            using (var cmd = conn.CreateCommand())
            {
                cmd.CommandText = " select inf03a03_rec_id,inf03a01_bcode,inf03a06_fname,inf03a18_tel01,inf03a24_cellphone from Inf03a";
                using (var rd = cmd.ExecuteReader())
                {
                    while (rd.Read())
                    {
                        var inf03a = new Inf03a();
                        inf03a.inf03a03_rec_id = Convert.ToInt16(rd["inf03a03_rec_id"]).ToString("000");
                        inf03a.inf03a01_bcode = rd["inf03a01_bcode"].ToString();
                        inf03a.inf03a06_fname = rd["inf03a06_fname"].ToString();
                        inf03a.inf03a18_tel01 = rd["inf03a18_tel01"].ToString();
                        inf03a.inf03a24_cellphone = rd["inf03a24_cellphone"].ToString();
                        inf03List.Add(inf03a);
                    }
                }
            }
        }

        return inf03List;

    }
    public class Taf10
    {
        /// <summary>
        /// 員工編號
        /// </summary>
        public string taf1001_empid { get; set; }

        /// <summary>
        /// 員工姓名
        /// </summary>
        public string taf1004_cname { get; set; }
    }
    public class Inf03
    {

        public string inf0302_mcode { get; set; }
        public string inf0302_bname { get; set; }
    }
    public class Inf03a
    {

        /// <summary>
        /// 廠商聯絡人序號
        /// </summary>
        public string inf03a03_rec_id { get; set; }
        /// <summary>
        /// 廠商代碼
        /// </summary>
        public string inf03a01_bcode { get; set; }
        /// <summary>
        /// 廠商聯絡人姓名
        /// </summary>
        public string inf03a06_fname { get; set; }
        /// <summary>
        /// 聯絡電話
        /// </summary>
        public string inf03a18_tel01 { get; set; }
        /// <summary>
        /// 手機 
        /// </summary>
        public string inf03a24_cellphone { get; set; }
    }


    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}