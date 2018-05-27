using System;
using System.Collections.Generic;

using DINP015;

public partial class Dinp_Dinp01501 : System.Web.UI.Page
{
    public string AppVersion = "v18.04.22";

    /// <summary>
    /// 公司代號下拉選單來源
    /// </summary>
    public List<Cnf07> BcodeList = null;
    /// <summary>
    /// 系統代碼下拉選單來源
    /// </summary>
    public List<Cnf10> AppCodeList = null;
    /// <summary>
    /// 客戶代號下拉選單來源
    /// </summary>
    public List<Cmf01> CcodeList = null;

    protected void Page_Load(object sender, EventArgs e)
    {
        Title = "各系統結帳關帳設定資料維護 " + this.AppVersion;

        BcodeList = Cnf07.GetList();
        CcodeList = Cmf01.GetList();
        AppCodeList = Cnf10.GetList("000");
        Inf15.CreateKeywordSP();
    }
}