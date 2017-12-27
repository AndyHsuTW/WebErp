<%@ WebHandler Language="C#" Class="CompanyHandler" %>
using System;
using System.Web;
using Newtonsoft.Json;
using ErpBaseLibrary.DB;
using System.Data.SqlClient;
using System.Collections.Generic;
public class CompanyHandler : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";


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

        context.Response.Write(JsonConvert.SerializeObject(List));
        

    }




    public class FilterOption
    {
        public DateTime? StartDate { get; set; }
        public DateTime? EndDate { get; set; }
    }
    public class Company
    {
        public string Name { get; set; }
        public string Code { get; set; }
    }
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}