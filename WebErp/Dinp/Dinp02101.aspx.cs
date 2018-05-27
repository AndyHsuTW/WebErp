using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DCNP005;
using Dinp02301;
using iTextSharp.text;
using iTextSharp.text.pdf;

public partial class Dinp_Dinp02101 : System.Web.UI.Page
{
    public string AppVersion = "v18.03.25";

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


    protected void Page_Load(object sender, EventArgs e)
    {
        BcodeList = Cnf07.GetList();
        WherehouseList = Cnf10.GetList("004");
        InReasonList = Cnf10.GetList("S15");
        CurrencyList = Cnf10.GetList("073");

        Inf29.CreateKeywordSP();
    }

}