using System;
using System.Collections.Generic;
using Dinp02301;

public partial class Dinp02101New_Dinp02101 : System.Web.UI.Page
{
    public string AppVersion = "v18.04.22";

    /// <summary>
    /// 公司代號下拉選單來源
    /// </summary>
    public List<Cnf07> BcodeList = null;

    /// <summary>
    /// 倉庫代號下拉選單來源
    /// </summary>
    public List<Cnf10> WherehouseList = null;

    /// <summary>
    /// 異動代號下拉選單來源
    /// </summary>
    public List<Cnf10> InReasonList = null;

    /// <summary>
    /// 幣別下拉選單來源
    /// </summary>
    public List<Cnf10> CurrencyList = null;

    /// <summary>
    /// 客戶代號下拉選單來源
    /// </summary>
    public List<DINP015.Cmf01> CcodeList = null;


    protected void Page_Load(object sender, EventArgs e)
    {
        BcodeList = Cnf07.GetList();
        WherehouseList = Cnf10.GetList("004");
        InReasonList = Cnf10.GetList("S15");
        CurrencyList = Cnf10.GetList("073");
        CcodeList = DINP015.Cmf01.GetList();
        Inf29.CreateKeywordSP();
    }

}