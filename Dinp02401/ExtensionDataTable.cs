using System;
using System.Collections.Generic;
using System.Data;
using System.Reflection;


namespace TLExtensionMethods
{
    public static partial class TLExtension
    {
        public static List<T> ToList<T>(this DataTable dt)
        {
            Type type = typeof(T);
            List<T> list = new List<T>();
            List<string> colNameList = new List<string>();
            foreach (DataColumn dc in dt.Columns)
                colNameList.Add(dc.ColumnName.ToUpper());
            
            PropertyInfo[] pInfos = type.GetProperties();

            foreach (DataRow dr in dt.Rows)
            {
                var item =Activator.CreateInstance(type);
                
                foreach (PropertyInfo pInfo in pInfos)
                {
                    if (colNameList.Contains(pInfo.Name.ToUpper()))
                    {
                        var o = dr[pInfo.Name].ToString() == "" ? "" : dr[pInfo.Name].ToString();
                        pInfo.SetValue(item,
                            Convert.ChangeType(o, pInfo.PropertyType));
                    }
                }
                list.Add((T) item);
            }
            return list;
        }
    }
}