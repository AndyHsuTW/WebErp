﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Dsap_Dsap92001 : System.Web.UI.Page
{
    public string AppVersion = "v18.01.06";
    protected void Page_Load(object sender, EventArgs e)
    {
        Title = "出貨資料匯出各物流公司 " + this.AppVersion;

    }
}