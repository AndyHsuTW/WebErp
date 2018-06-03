using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ErpBaseLibrary.DB;

public partial class Dcnp_Dcnp00501 : System.Web.UI.Page
{
    public string AppVersion = "v18.06.03";

    protected void Page_Load(object sender, EventArgs e)
    {
        Title = "Dcnp00501 各檔案欄位說明維護 " + this.AppVersion;
    }
}