﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Dsap92501_Dsap92501 : System.Web.UI.Page
{
    public string Title { get; set; }
    
    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Title = "Dsap92501 各網站excel資料轉入訂單v18.05.10";
        Title = Page.Title;
    }
}