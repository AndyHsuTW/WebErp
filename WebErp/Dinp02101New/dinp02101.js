'use strict';
(function () {

    requirejs.config({
        paths: {
            "FunctionButton": isIE ? "VueComponent/FunctionButton.babel" : "VueComponent/FunctionButton",
            "vuejs-uib-pagination": "public/scripts/VueComponent/vuejs-uib-pagination",
            "vue-jQuerydatetimepicker": isIE
                ? "public/scripts/VueComponent/vue-jQuerydatetimepicker.babel"
                : "public/scripts/VueComponent/vue-jQuerydatetimepicker",
            "jquery.datetimepicker": "public/scripts/jquery.datetimepicker/jquery.datetimepicker.full",
            "jqueryDatetimepicker-css": "public/scripts/jquery.datetimepicker/jquery.datetimepicker",
            "jquery.mousewheel": "public/scripts/jquery.mousewheel.min",
            "d_pcode": "D_pcode/D_pcode",
            "d_pcode-css": "D_pcode/D_pcodeCss",
            "tableHeadFixer": "public/scripts/FixedHeader/tableHeadFixer"
        },
        map: {
            '*': {
                'jquery-mousewheel': 'jquery.mousewheel',
                "functionButton": "FunctionButton",
                "uibPagination": "vuejs-uib-pagination"
            }
        },
        shim: {
            "jquery.datetimepicker": {
                "deps": ["css!jqueryDatetimepicker-css"]
            },
            "vue-jQuerydatetimepicker": {
                "deps": ['jquery.datetimepicker']
            },
            "d_pcode": {
                "deps": ["css!d_pcode-css"]
            },
        }
    });

    var requiredFiles = ["bootstrap",
        "FunctionButton",
        "vue-jQuerydatetimepicker",
        "LoadingHelper",
        "jquery.mousewheel",
        "UserLog",
        "print-js",
        "vue-multiselect",
        "d_pcode",
        "tableHeadFixer"
    ];

    function onLoaded(bootstrap,
        functionButton,
        vueDatetimepicker,
        loadingHelper,
        jqMousewheel,
        userLog,
        printJs,
        vueMultiselect,
        dPcode,
        jqTable) {
        if (vueMultiselect == null) {
            console.error("vueMultiselect fallback");
            vueMultiselect = window.VueMultiselect;
        }
        var now = new Date();
        window.dinp02101 = new Vue({
            el: "#Dinp02101",
            data: {
                DisplaySearch: true,
                DisplayUpdate: false,
                IsAppBodyDisplay: true,
                IsDpCodeDisplay: false,
                Inf29Item: {
                    isCopyMode: false,
                    id: null,
                    inf2901_bcode: null, //公司代號
                    inf2901_docno: null,//進貨單號 #UpdateDocno
                    inf2904_pro_date: null, //進貨日期 #UpdateProDate
                    inf2921_pmonth: null, //所屬帳款月份 #UpdateAcctMonth
                    inf2906_wherehouse: null,//倉庫代號
                    inf2903_customer_code: null,
                    inf2964_src_docno: null,
                    inf2928_currency: null,
                    remark: null,
                    inf2910_in_reason: 100,//不顯示
                    inf2929_exchange_rate: null,
                    inf2951_allowances: null,
                    adddate: null,
                    adduser: null,
                    moddate: null,
                    moduser: null

                    //Ccode: null,
                    //inf2964_src_docno: null,
                    //inf2928_currency: null,
                    //inf2929_exchange_rate: null,
                    //inf2910_in_reason: 100,//不顯示
                    //remark: null,
                    //inf2909_vcode: null,//廠商代號
                    //inf2921_pmonth: null,//所屬帳款月份
                    ////inf2902_docno_type: "SI", //單據分類編號. 組成異動單號 SI=進(退)貨單號
                    ////inf2902_docno_date: now.dateFormat("Ymd"), //進(退)貨單號日期. 組成進(退)貨單號
                    ////inf2902_docno_seq: null,//進(退)貨單號流水號, 儲存成功後從伺服器返回                    
                    //adddate: null,
                    //adduser: null,
                    //moddate: null,
                    //moduser: null
                },
                Inf29aItem: {
                    inf29a02_seq: null,//序號
                    inf29a05_pcode: null, //產品編號
                    inf29a05_shoes_code: null, //產品貨號
                    inf29a33_product_name: null,//產品名稱
                    inf29a17_runit: null, //銷售單位
                    inf29a13_sold_qty: 0,//進貨數量
                    inf29a24_retrn_qty: 0,//退貨數量
                    inf29a16_gift_qty: 0,//贈品數量
                    inf29a26_box_qty: null,//大單位數量
                    inf29a10_cost_one: 0,//大單位換算值
                    inf29a06_qty: null,//小單位數量
                    inf29a10_cost_one0: 0,//未稅單價
                    inf29a40_tax: null,//營業稅
                    inf29a10_ocost_one: null,//含稅單價
                    inf29a38_one_amt: null,//金額小計
                    remark: null, //remark
                    adddate: null,
                    adduser: null,
                    moddate: null,
                    moduser: null
                }, // New edit item of Inf29a
                Filter: {
                    ProDateStart: '',
                    ProDateEnd: '',
                    PcodeStart: '',
                    PcodeEnd: '',
                    ShoesCodeStart: '',
                    ShoesCodeEnd: '',
                    WherehouseStart: '',
                    WherehouseEnd: '',
                    InReasonStart: '',
                    InReasonEnd: '',
                    VCodeStart: '',
                    VCodeEnd: '',
                    AddDateStart: '',
                    AddDateEnd: '',
                    BcodeStart: '',
                    BcodeEnd: '',
                    Srcdocno: '',
                    Keyword: ''
                },
                BcodeList: [], //公司代號下拉選單資料
                WherehouseList: [], //倉庫代號下拉選單資料
                InReasonList: [], //異動代號下拉選單資料
                CurrencyList: [], //幣別下拉選單來源
                CcodeList: [],
                Inf29List: [], // source data from server
                Inf29aList: [], // source data from server
                Export: {
                    Inf29List: [],
                    Inf29aList: [],
                    SelectedInf29List: [],
                    SelectedInf29aList: []
                },
                SelectedInf29Item: null,
                SelectedInf29aItem: null,
                Inf29Copy: null,
                UiDateFormat: "Y/m/d",
                Inf29SortColumn: null,
                Inf29SortOrder: null,
                Inf29aSortColumn: null,
                Inf29aSortOrder: null,
                SortColumn: null,
                SortOrder: null,
            },
            components: {
                Multiselect: vueMultiselect.default
            },
            computed: {
                TotalAmount: function () {
                    var total = 0.0;
                    for (var i in this.Inf29aList) {
                        var inf29a = this.Inf29aList[i];
                        total += parseFloat(inf29a.inf29a13_sold_qty) - parseFloat(inf29a.inf29a24_retrn_qty);
                    }
                    return total.toFixed(2);
                },
                TotalPrice: function () {
                    var total = 0.0;
                    for (var i in this.Inf29aList) {
                        var inf29a = this.Inf29aList[i];
                        total += parseFloat(inf29a.inf29a38_one_amt);
                    }
                    return total.toFixed(2);
                }
            },
            methods: {
                OnAddInf29aItem: function (defaultSeq) {//輸入明細
                    var vueObj = this;
                    if (this.Inf29aItem.inf29a05_pcode == null || this.Inf29aItem.inf29a05_pcode == "") {
                        return;
                    }
                    // update
                    if (this.Inf29aItem.inf29a02_seq != null) {
                        var inf29a = this.Inf29aList.filter(function (item, index, array) {
                            return item.inf29a02_seq == vueObj.Inf29aItem.inf29a02_seq;
                        }).shift();
                        this.SelectedInf29aItem = {
                            inf29a02_seq: this.Inf29aItem.inf29a02_seq,
                            inf29a05_pcode: this.Inf29aItem.inf29a05_pcode,//產品編號
                            inf29a33_product_name: this.Inf29aItem.inf29a33_product_name, //商品名稱
                            inf29a05_shoes_code: this.Inf29aItem.inf29a05_shoes_code, //貨號
                            inf29a17_runit: this.Inf29aItem.inf29a17_runit, //單位
                            inf29a10_cost_one0: this.Inf29aItem.inf29a10_cost_one0,//未稅單價
                            inf29a10_ocost_one: this.Inf29aItem.inf29a10_ocost_one,//含稅單價
                            inf29a40_tax: this.Inf29aItem.inf29a40_tax,//營業稅
                            inf29a13_sold_qty: this.Inf29aItem.inf29a13_sold_qty, //進貨數量
                            inf29a16_gift_qty: this.Inf29aItem.inf29a16_gift_qty,//贈品數量
                            inf29a24_retrn_qty: this.Inf29aItem.inf29a24_retrn_qty, //退貨數量
                            inf29a26_box_qty: this.Inf29aItem.inf29a26_box_qty, //大單位數量
                            inf29a10_cost_one: this.Inf29aItem.inf29a10_cost_one,//換算值
                            inf29a06_qty: this.Inf29aItem.inf29a06_qty,//小單位數量
                            inf29a38_one_amt: this.Inf29aItem.inf29a38_one_amt, //小計金額
                            remark: this.Inf29aItem.remark, 
                            adduser: this.Inf29aItem.adduser,
                            adddate: this.Inf29aItem.adddate,
                            moduser: this.Inf29aItem.moduser,
                            moddate: this.Inf29aItem.moddate
                        };
                        var inf29aIndex = this.Inf29aList.indexOf(inf29a);
                        this.Inf29aList.splice(inf29aIndex, 1, this.SelectedInf29aItem);
                        // deselect
                        this.OnRowClick(this.SelectedInf29aItem);
                        return;
                    }
                    var inf29a02_seq = defaultSeq || this.Inf29aList.length;
                    inf29a02_seq = inf29a02_seq + 1;
                    for (var i in this.Inf29aList) {
                        if (this.Inf29aList[i].inf29a02_seq == inf29a02_seq) {
                            return this.OnAddInf29aItem(inf29a02_seq + 1);
                        }
                    }
                    this.Inf29aList.push({
                        inf29a02_seq: inf29a02_seq,
                        inf29a05_pcode: this.Inf29aItem.inf29a05_pcode,//產品編號
                        inf29a33_product_name: this.Inf29aItem.inf29a33_product_name, //商品名稱
                        inf29a05_shoes_code: this.Inf29aItem.inf29a05_shoes_code, //貨號
                        inf29a17_runit: this.Inf29aItem.inf29a17_runit, //單位
                        inf29a10_cost_one0: this.Inf29aItem.inf29a10_cost_one0,//未稅單價
                        inf29a10_ocost_one: this.Inf29aItem.inf29a10_ocost_one,//含稅單價
                        inf29a40_tax: this.Inf29aItem.inf29a40_tax,//營業稅
                        inf29a13_sold_qty: this.Inf29aItem.inf29a13_sold_qty, //進貨數量
                        inf29a16_gift_qty: this.Inf29aItem.inf29a16_gift_qty,//贈品數量
                        inf29a24_retrn_qty: this.Inf29aItem.inf29a24_retrn_qty, //退貨數量
                        inf29a26_box_qty: this.Inf29aItem.inf29a26_box_qty, //大單位數量
                        inf29a10_cost_one: this.Inf29aItem.inf29a10_cost_one,//換算值
                        inf29a06_qty: this.Inf29aItem.inf29a06_qty,//小單位數量
                        inf29a38_one_amt: this.Inf29aItem.inf29a38_one_amt, //小計金額
                        remark: this.Inf29aItem.remark, 
                        remark: this.Inf29aItem.remark,
                        adduser: this.Inf29aItem.adduser,
                        adddate: this.Inf29aItem.adddate,
                        moduser: this.Inf29aItem.moduser,
                        moddate: this.Inf29aItem.moddate
                    });
                },
                OnDeleteInf29aItem: function () {//刪除明細
                    if (this.SelectedInf29aItem == null) {
                        return;
                    }
                    if (confirm("是否確認刪除明細?")) {
                        var index = this.Inf29aList.indexOf(this.SelectedInf29aItem);
                        this.Inf29aList.splice(index, 1);
                    }
                },
                OnSearch: function () {
                    //this.Reset();
                    window.dinp02101.DisplaySearch = true;
                    window.dinp02101.DisplayUpdate = false;
                    this.SelectedInf29Item = null;
                    this.SelectedInf29aItem = null;
                    this.Inf29aList = [];

                    var filterOption = {
                        inf2904_pro_date_start: this.Filter.ProDateStart,
                        inf2904_pro_date_end: this.Filter.ProDateEnd,
                        inf29a05_pcode_start: this.Filter.PcodeStart,
                        inf29a05_pcode_end: this.Filter.PcodeEnd,
                        inf29a05_shoes_code_start: this.Filter.ShoesCodeStart,
                        inf29a05_shoes_code_end: this.Filter.ShoesCodeEnd,
                        inf2906_wherehouse_start: (this.Filter.WherehouseStart || {}).cnf1002_fileorder,
                        inf2906_wherehouse_end: (this.Filter.WherehouseEnd || {}).cnf1002_fileorder,
                        inf2910_in_reason_start: this.Filter.InReasonStart,
                        inf2910_in_reason_end: this.Filter.InReasonEnd,
                        inf2909_vcode_start: this.Filter.VCodeStart,
                        inf2909_vcode_end: this.Filter.VCodeEnd,
                        adddate_start: this.Filter.AddDateStart,
                        adddate_end: this.Filter.AddDateEnd,
                        inf2901_bcode_start: this.Filter.BcodeStart,
                        inf2901_bcode_end: this.Filter.BcodeEnd,
                        inf2964_src_docno: this.Filter.Srcdocno,
                        keyword: this.Filter.Keyword
                    };
                    LoadingHelper.showLoading();
                    var vueObj = this;
                    return $.ajax({
                        type: 'POST',
                        url: rootUrl + "Dinp02101New/Ajax/Inf29Handler.ashx",
                        cache: false,
                        data: {
                            act: "get",
                            data: JSON.stringify(filterOption)
                        },
                        dataType: 'text',
                        success: function (inf29ListJson) {
                            LoadingHelper.hideLoading();
                            var inf29List = JSON.parse(inf29ListJson);
                            vueObj.Inf29List = inf29List;
                            $("#lbCount").html(vueObj.Inf29List.length);
                            if (vueObj.SortColumn != null) {
                                console.warn("todo sort");
                                // inf29List.sort(vueObj.SortCnf05List);
                            }
                            for (var i in inf29List) {
                                inf29List[i].adddate = new Date(inf29List[i].adddate).dateFormat('Y/m/d');
                                if (inf29List[i].moddate) {
                                    inf29List[i].moddate = new Date(inf29List[i].moddate).dateFormat('Y/m/d');
                                }
                                if (inf29List[i].inf2904_pro_date) {
                                    inf29List[i].inf2904_pro_date = new Date(inf29List[i].inf2904_pro_date).dateFormat('Ymd');
                                }

                            }
                            if (inf29List.length == 0) {
                                alert("查無資料");
                            }
                        },
                        error: function (jqXhr, textStatus, errorThrown) {
                            if (jqXhr.status == 0) {
                                return;
                            }
                            LoadingHelper.hideLoading();
                            console.error(errorThrown);
                            alert("查詢失敗");
                        }
                    });

                },
                OnMainRowClick: function (inf29Item) {
                    if (this.SelectedInf29Item == inf29Item) {
                        this.SelectedInf29Item = null;
                        this.SelectedInf29aItem = null;
                        this.Inf29aList = [];
                    } else {
                        this.SelectedInf29Item = inf29Item;
                        this.GetInf29aList(inf29Item.inf2901_docno);
                    }
                },
                OnSubRowClick: function (inf29aItem) {
                    if (this.SelectedInf29aItem == inf29aItem) {
                        this.SelectedInf29aItem = null;
                    } else {
                        this.SelectedInf29aItem = inf29aItem;
                    }
                },
                OnAdd: function () {
                    if (this.IsDpCodeDisplay) {
                        return;
                    }

                    this.ResetInf29();
                    window.dinp02101.DisplaySearch = false;
                    window.dinp02101.DisplayUpdate = true;
                    LoadingHelper.showLoading();
                    var vueObj = this;
                    return $.ajax({
                        type: 'POST',
                        url: rootUrl + "Dinp02101/Ajax/Inf29Handler.ashx",
                        cache: false,
                        data: {
                            act: "last"
                        },
                        dataType: 'text',
                        success: function (result) {
                            LoadingHelper.hideLoading();
                            $("#IUDocno").val(result);
                        },
                        error: function (jqXhr, textStatus, errorThrown) {
                            if (jqXhr.status == 0) {
                                return;
                            }
                            LoadingHelper.hideLoading();
                            alert("取得進貨單號失敗");
                        }
                    });
                },
                OnDelete: function () {
                    if (this.SelectedInf29Item == null) {
                        return;
                    }
                    if (loginUserName != null) {
                        if (this.SelectedInf29Item.adduser.toLowerCase() != loginUserName.toLowerCase()) {
                            alert("只可以刪除自己的資料");
                            return;
                        }
                    }
                    if (!confirm("是否確認刪除?")) {
                        return;
                    }
                    LoadingHelper.showLoading();
                    var vueObj = this;
                    return $.ajax({
                        type: 'POST',
                        url: rootUrl + "Dinp/Ajax/Inf29Handler.ashx",
                        cache: false,
                        data: {
                            act: "del",
                            data: this.SelectedInf29Item.inf2901_docno
                        },
                        dataType: 'text',
                        success: function (result) {
                            LoadingHelper.hideLoading();
                            if (result != "ok") {
                                alert("刪除失敗");
                            } else {
                                vueObj.OnSearch();
                            }
                        },
                        error: function (jqXhr, textStatus, errorThrown) {
                            if (jqXhr.status == 0) {
                                return;
                            }
                            LoadingHelper.hideLoading();
                            console.error(errorThrown);
                            alert("刪除失敗");
                        }
                    });
                },
                OnExportAllFieldClick: function (checkAllInf29, checkAllInf29a) {
                    if (checkAllInf29 == null) {
                        this.Export.SelectedInf29aList = [];
                        if (checkAllInf29a) {
                            for (var i in this.Export.Inf29aList) {
                                var field = this.Export.Inf29aList[i];
                                this.Export.SelectedInf29aList.push(field.cnf0502_field);
                            }
                        }
                    } else {
                        this.Export.SelectedInf29List = [];
                        if (checkAllInf29) {
                            for (var i in this.Export.Inf29List) {
                                var field = this.Export.Inf29List[i];
                                this.Export.SelectedInf29List.push(field.cnf0502_field);
                            }
                        }
                    }
                },
                OnExportSubmit: function () {
                    var vueObj = this;
                    // Get inf29 id list
                    var inf29idList = [];
                    for (var i in this.Inf29List) {
                        var inf29Item = this.Inf29List[i];
                        inf29idList.push(inf29Item.id);
                    }
                    if (inf29idList.length == 0) {
                        $(this.$refs.ExportDialog).modal('hide');
                        return $.when(null);
                    }

                    var inf29fields = this.Export.Inf29List.filter(function (item, index, array) {
                        return vueObj.Export.SelectedInf29List.indexOf(item.cnf0502_field) >= 0;
                    });
                    var inf29afields = this.Export.Inf29aList.filter(function (item, index, array) {
                        return vueObj.Export.SelectedInf29aList.indexOf(item.cnf0502_field) >= 0;
                    });

                    LoadingHelper.showLoading();
                    return $.ajax({
                        type: 'POST',
                        url: rootUrl + "Dinp02101New/Ajax/Inf29Handler.ashx",
                        cache: false,
                        data: {
                            act: "export",
                            inf29fields: JSON.stringify(inf29fields),
                            inf29afields: JSON.stringify(inf29afields),
                            data: JSON.stringify(inf29idList)
                        },
                        dataType: 'text',
                        success: function (result) {
                            LoadingHelper.hideLoading();
                            if (result == "ok") {
                                $(vueObj.$refs.ExportDialog).modal('hide');
                                location.href = rootUrl + "Dinp02101New/Ajax/Inf29Export.ashx";
                            } else {
                                alert("匯出失敗");
                            }
                        },
                        error: function (jqXhr, textStatus, errorThrown) {
                            LoadingHelper.hideLoading();
                            if (jqXhr.status == 0) {
                                return;
                            }
                            console.error(errorThrown);
                            alert("匯出失敗");
                        }
                    });
                },
                OnImportSubmit: function () {
                    var vueObj = this;
                    var formData = new FormData();
                    // 取得UploadFile元件的檔案
                    var files = this.$refs.ImportExcelInput.files;
                    if (files.length == 0) {
                        alert("請先選擇檔案");
                        return;
                    }
                    // 將指定的檔案放在formData內
                    formData.append("file", files[0]);
                    formData.append("act", "import");
                    formData.append("user", loginUserName);
                    LoadingHelper.showLoading();
                    //發送http請求
                    return $.ajax({
                        url: rootUrl + "Dinp/Ajax/Inf29Handler.ashx",
                        type: 'POST',
                        data: formData,
                        cache: false,
                        dataType: 'text',
                        processData: false,
                        contentType: false,
                        success: function (result) {
                            // IE might have issue to upload same file 
                            vueObj.$refs.ImportExcelInput.value = "";
                            LoadingHelper.hideLoading();
                            if (result == "ok") {
                                $(vueObj.$refs.ImportExcelDialog).modal('hide');
                                vueObj.OnSearch();
                                alert("匯入成功");
                            } else {
                                alert("匯入失敗\n" + result);
                            }
                        },
                        error: function (jqXhr, textStatus, errorThrown) {
                            LoadingHelper.hideLoading();
                            if (jqXhr.status == 0) {
                                return;
                            }
                            console.error(errorThrown);
                            alert("匯入失敗");
                        }
                    });

                },
                OnRowClick: function (inf29aItem) {
                    if (this.SelectedInf29aItem == inf29aItem) {
                        this.ResetInf29a();
                    } else {
                        this.SelectedInf29aItem = inf29aItem;
                        var currencyInfo = this.CurrencyList.filter(function (item, index, array) {
                            return item.cnf1003_char01 == inf29aItem.inf29a31_currency;
                        }).shift();
                        this.Inf29aItem = {
                            inf29a02_seq: inf29aItem.inf29a02_seq,
                            inf29a05_pcode: inf29aItem.inf29a05_pcode,//產品編號
                            inf29a33_product_name: inf29aItem.inf29a33_product_name, //商品名稱
                            inf29a05_shoes_code: inf29aItem.inf29a05_shoes_code, //貨號
                            inf29a17_runit: inf29aItem.inf29a17_runit, //單位
                            inf29a10_cost_one0: inf29aItem.inf29a10_cost_one0,//未稅單價
                            inf29a10_ocost_one: inf29aItem.inf29a10_ocost_one,//含稅單價
                            inf29a40_tax: inf29aItem.inf29a40_tax,//營業稅
                            inf29a13_sold_qty: inf29aItem.inf29a13_sold_qty, //進貨數量
                            inf29a24_retrn_qty: inf29aItem.inf29a24_retrn_qty, //退貨數量
                            inf29a26_box_qty: inf29aItem.inf29a26_box_qty, //大單位數量
                            inf29a10_cost_one: inf29aItem.inf29a10_cost_one,//換算值
                            inf29a06_qty: inf29aItem.inf29a06_qty,//小單位數量
                            inf29a38_one_amt: inf29aItem.inf29a38_one_amt, //小計金額
                            remark: inf29aItem.remark,
                            adddate: inf29aItem.adddate,
                            adduser: inf29aItem.adduser,
                            moddate: inf29aItem.moddate,
                            moduser: inf29aItem.moduser
                        };
                    }
                },
                OnPcodeChange: function (pcode) {
                    var vueObj = this;
                    vueObj.Inf29aItem.inf29a33_product_name = "";
                    vueObj.Inf29aItem.inf29a05_shoes_code = "";
                    vueObj.Inf29aItem.inf29a10_ocost_one = 0;

                    this.GetProductInfo(pcode)
                        .done(function (productInfoJson) {
                            var productInfo = JSON.parse(productInfoJson);
                            if (productInfo == null) {
                                alert("商品代號不存在於商品基本資料檔中，請重新輸入");
                            } else {
                                vueObj.Inf29aItem.inf29a05_pcode = productInfo.pcode;
                                vueObj.Inf29aItem.inf29a05_shoes_code = productInfo.pclass;
                                vueObj.Inf29aItem.inf29a10_ocost_one = parseFloat(productInfo.retail).toFixed(2);
                                vueObj.Inf29aItem.inf29a10_cost_one0 = parseFloat(productInfo.cost).toFixed(2);
                                vueObj.Inf29aItem.inf29a10_ocost_one = parseFloat(productInfo.retail).toFixed(2);
                                vueObj.Inf29aItem.inf29a09_oretail_one = vueObj.Inf29aItem.inf29a10_ocost_one;
                                vueObj.Inf29aItem.inf29a17_runit = productInfo.runit;
                                vueObj.Inf29aItem.inf29a26_box_qty = productInfo.pqty_o;
                                vueObj.Inf29aItem.inf29a33_product_name = productInfo.psname;
                                vueObj.Inf29aItem.inf29a40_tax = productInfo.tax;
                                vueObj.Inf29aItem.inf29a41_pcat = productInfo.pcat;
                                vueObj.Inf29aItem.inf29a04_sizeno = productInfo.size;
                                vueObj.Inf29aItem.inf29a38_one_amt = (vueObj.Inf29aItem.inf29a13_sold_qty - vueObj.Inf29aItem.inf29a24_retrn_qty) * vueObj.Inf29aItem.inf29a10_ocost_one;
                                if (parseFloat(productInfo.cost) == 0) {
                                    if (confirm("您確定進價 = 0，回是(Y)繼續作業，回否(N)請修正進價")) {
                                    }
                                }
                                //TODO also on currency change
                                if (vueObj.Inf29aItem.SelectedCurrencyInfo == null) {
                                    vueObj.Inf29aItem.inf29a10_cost_one = vueObj.Inf29aItem.inf29a10_ocost_one;
                                    vueObj.Inf29aItem.inf29a09_oretail_one = vueObj.Inf29aItem.inf29a10_ocost_one;
                                } else {
                                    vueObj.Inf29aItem.inf29a10_cost_one =
                                        (vueObj.Inf29aItem.inf29a10_ocost_one * vueObj.Inf29Item.inf2929_exchange_rate).toFixed(2);
                                    vueObj.Inf29aItem.inf29a09_retail_one =
                                        (vueObj.Inf29aItem.inf29a09_oretail_one * vueObj.Inf29Item.inf2929_exchange_rate).toFixed(2);

                                }
                            }
                        });
                },
                OnSave: function () {
                    var inf29Item = {
                        inf2901_bcode: (this.Inf29Item.inf2901_bcode || {}).cnf0701_bcode,
                        inf2901_docno: $("#IUDocno").val(),
                        inf2904_pro_date: $("#IUProDate").val(),
                        inf2921_pmonth: $("#IUAcctMonth").val(),
                        inf2906_wherehouse: (this.Inf29Item.inf2906_wherehouse || {}).cnf1002_fileorder,
                        inf2903_customer_code: (this.Inf29Item.inf2903_customer_code || {}).cmf0102_cuscode,
                        inf2964_src_docno: $("#IUSrcDocno").val(),
                        inf2928_currency: (this.Inf29Item.inf2928_currency || {}).cnf1003_char01,
                        remark: $("#IURemark").val(),
                        inf2929_exchange_rate: $("#IURate").val(),
                        inf2951_allowances: $("#IUAllowances").val(),
                        adddate: new Date(),
                        adduser: this.Inf29Item.adduser,
                        moddate: this.Inf29Item.moddate,
                        moduser: this.Inf29Item.moduser
                    };
                    inf29Item.Inf29aList = this.Inf29aList;
                    var vueObj = this;
                    LoadingHelper.showLoading();
                    return $.ajax({
                        type: 'POST',
                        url: rootUrl + "Dinp02101New/Ajax/Inf29Handler.ashx",
                        cache: false,
                        data: {
                            act: "save",
                            data: JSON.stringify(inf29Item)
                        },
                        dataType: 'text',
                        success: function (inf29Json) {
                            var inf29Item = JSON.parse(inf29Json);
                            if (inf29Item == null) {
                                alert("存檔失敗");
                            } else {
                                vueObj.Inf29Item.id = inf29Item.id;
                                vueObj.Inf29Item.inf2902_docno_seq = inf29Item.inf2902_docno_seq;
                            }
                            LoadingHelper.hideLoading();
                            $.ajax({
                                type: 'POST',
                                url: rootUrl + "Dinp02101/Ajax/Inf29Handler.ashx",
                                cache: false,
                                data: {
                                    act: "last"
                                },
                                dataType: 'text',
                                success: function (result) {
                                    LoadingHelper.hideLoading();
                                    $("#IUDocno").val(result);
                                },
                                error: function (jqXhr, textStatus, errorThrown) {
                                    if (jqXhr.status == 0) {
                                        return;
                                    }
                                    LoadingHelper.hideLoading();
                                    alert("取得進貨單號失敗");
                                }
                            });
                            alert("存檔成功");
                        },
                        error: function (jqXhr, textStatus, errorThrown) {
                            if (jqXhr.status == 0) {
                                return;
                            }
                            LoadingHelper.hideLoading();
                            console.error(errorThrown);
                            alert("存檔失敗");
                        }
                    });
                },
                OnCopy: function (inf29Item) {
                    if (this.SelectedInf29Item == null) {
                        return;
                    }
                    if (this.IsDpCodeDisplay) {
                        return;
                    }

                    this.ResetInf29();
                    var asyncTasks = [];
                    var defaultBCodeInfo = this.BcodeList.filter(function (item, index, array) {
                        return item.cnf0701_bcode == inf29Item.inf2901_bcode;
                    }).shift();
                    var defaultWherehouseInfo = this.WherehouseList.filter(function (item, index, array) {
                        return item.cnf1002_fileorder == inf29Item.inf2906_wherehouse;
                    }).shift();
                    var defaultCCodeInfo = this.CcodeList.filter(function (item, index, array) {
                        return item.cmf0102_cuscode == inf29Item.inf2903_customer_code;
                    }).shift();
                    var defaultCurrency = this.CurrencyList.filter(function (item, index, array) {
                        return item.cnf1003_char01 == inf29Item.inf2928_currency;
                    }).shift();
                    this.Inf29Item.inf2901_docno = inf29Item.inf2901_docno;
                    this.Inf29Item.inf2901_bcode = defaultBCodeInfo;
                    this.Inf29Item.inf2951_allowances = inf29Item.inf2951_allowances;
                    $("#IUProDate").val(inf29Item.inf2904_pro_date);
                    $("#IUAcctMonth").val(inf29Item.inf2921_pmonth);
                    this.Inf29Item.inf2906_wherehouse = defaultWherehouseInfo;
                    this.Inf29Item.inf2903_customer_code = defaultCCodeInfo;
                    this.Inf29Item.inf2928_currency = defaultCurrency;
                    this.Inf29Item.inf2964_src_docno = inf29Item.inf2964_src_docno;
                    this.Inf29Item.remark = inf29Item.remark;
                    this.Inf29Item.inf2929_exchange_rate = inf29Item.inf2929_exchange_rate;
                    this.Inf29Item.adddate = new Date(inf29Item.adddate).dateFormat(this.UiDateFormat);
                    this.Inf29Item.adduser = inf29Item.adduser;
                    this.Inf29Item.moddate = new Date().dateFormat(this.UiDateFormat);
                    this.Inf29Item.moduser = loginUserName;

                    window.dinp02101.DisplaySearch = false;
                    window.dinp02101.DisplayUpdate = true;
                    LoadingHelper.showLoading();
                    var vueObj = this;
                    $.ajax({
                        type: 'POST',
                        url: rootUrl + "Dinp02101New/Ajax/Inf29Handler.ashx",
                        cache: false,
                        data: {
                            act: "last"
                        },
                        dataType: 'text',
                        success: function (result) {
                            LoadingHelper.hideLoading();
                            $("#IUDocno").val(result);
                            asyncTasks.push(vueObj.GetInf29aList(inf29Item.inf2901_docno).done(function (inf29aListJson) {
                                var now = new Date();
                                var inf29aList = JSON.parse(inf29aListJson);
                                vueObj.Inf29aList = [];
                                for (var i in inf29aList) {
                                    var inf29a = inf29aList[i];
                                    vueObj.Inf29aList.push({
                                        inf29a01_docno: result,
                                        inf29a01_bcode: inf29Item.inf2901_bcode,
                                        inf29a02_seq: inf29a.inf29a02_seq,
                                        inf29a05_pcode: inf29a.inf29a05_pcode,//產品編號
                                        inf29a33_product_name: inf29a.inf29a33_product_name, //商品名稱
                                        inf29a05_shoes_code: inf29a.inf29a05_shoes_code, //貨號
                                        inf29a17_runit: inf29a.inf29a17_runit, //單位
                                        inf29a10_cost_one0: inf29a.inf29a10_cost_one0,//未稅單價
                                        inf29a10_ocost_one: inf29a.inf29a10_ocost_one,//含稅單價
                                        inf29a40_tax: inf29a.inf29a40_tax,//營業稅
                                        inf29a13_sold_qty: inf29a.inf29a13_sold_qty, //進貨數量
                                        inf29a16_gift_qty: inf29a.inf29a16_gift_qty,//贈品數量
                                        inf29a24_retrn_qty: inf29a.inf29a24_retrn_qty, //退貨數量
                                        inf29a26_box_qty: inf29a.inf29a26_box_qty, //大單位數量
                                        inf29a10_cost_one: inf29a.inf29a10_cost_one,//換算值
                                        inf29a06_qty: inf29a.inf29a06_qty,//小單位數量
                                        inf29a38_one_amt: inf29a.inf29a38_one_amt, //小計金額
                                        remark: inf29a.remark,
                                        adduser: inf29a.adduser,
                                        adddate: inf29a.adddate,
                                        //moduser: inf29a.moduser,
                                        //moddate: inf29a.moddate
                                    });
                                }
                            }));
                            $.when.apply($, asyncTasks).then(function () {
                                LoadingHelper.hideLoading();
                                vueObj.Inf29Copy = JSON.stringify(vueObj.Inf29Item) + JSON.stringify(vueObj.Inf29aList);
                            });
                        },
                        error: function (jqXhr, textStatus, errorThrown) {
                            if (jqXhr.status == 0) {
                                return;
                            }
                            LoadingHelper.hideLoading();
                            alert("取得進貨單號失敗");
                        }
                    });
                    //var keycode = $("#IUDocno").val();
                    ////this.GetInf29aList($("#IUDocno").val());
                    //this.GetInf29aList(keycode).done(function (inf29aListJson) {
                    //    var now = new Date();
                    //    var inf29aList = JSON.parse(inf29aListJson);
                    //    console.log(inf29aList);
                    //    for (var i in inf29aList) {
                    //        var inf29a = inf29aList[i];
                    //        vueObj.Inf29aList.push({
                    //            inf29a02_seq: inf29a.inf29a02_seq,
                    //            inf29a05_pcode: inf29a.inf29a05_pcode,//產品編號
                    //            inf29a33_product_name: inf29a.inf29a33_product_name, //商品名稱
                    //            inf29a05_shoes_code: inf29a.inf29a05_shoes_code, //貨號
                    //            inf29a17_runit: inf29a.inf29a17_runit, //單位
                    //            inf29a10_cost_one0: inf29a.inf29a10_cost_one0,//未稅單價
                    //            inf29a10_ocost_one: inf29a.inf29a10_ocost_one,//含稅單價
                    //            inf29a40_tax: inf29a.inf29a40_tax,//營業稅
                    //            inf29a13_sold_qty: inf29a.inf29a13_sold_qty, //進貨數量
                    //            inf29a16_gift_qty: inf29a.inf29a16_gift_qty,//贈品數量
                    //            inf29a24_retrn_qty: inf29a.inf29a24_retrn_qty, //退貨數量
                    //            inf29a26_box_qty: inf29a.inf29a26_box_qty, //大單位數量
                    //            inf29a10_cost_one: inf29a.inf29a10_cost_one,//換算值
                    //            inf29a06_qty: inf29a.inf29a06_qty,//小單位數量
                    //            inf29a38_one_amt: inf29a.inf29a38_one_amt, //小計金額
                    //            remark: inf29a.remark,
                    //            adduser: inf29a.adduser,
                    //            adddate: inf29a.adddate,
                    //            moduser: inf29a.moduser,
                    //            moddate: inf29a.moddate
                    //        });
                    //    }
                    //});
                    //// 所有資料取完後用JSON備份, 用來檢查是否後續有被使用者修改
                    //$.when.apply($, asyncTasks).then(function () {
                    //    LoadingHelper.hideLoading();
                    //    vueObj.Inf29Copy = JSON.stringify(vueObj.Inf29Item) + JSON.stringify(vueObj.Inf29aList);
                    //});
                    //this.Inf29Item.inf2901_bcode = inf29Item.inf2901_bcode;
                    //$("#IUProDate").val(inf29Item.inf2904_pro_date);
                    //$("#IUAcctMonth").val(inf29Item.inf2921_pmonth);
                    //this.Inf29Item.inf2906_wherehouse = inf29Item.inf2906_wherehouse;
                    //var inf29Item = {
                    //    id: null,//儲存成功後從伺服器返回
                    //    inf2901_bcode: (this.Inf29Item.inf2901_bcode || {}).cnf0701_bcode,
                    //    inf2901_docno: $("#IUDocno").val(),
                    //    inf2904_pro_date: $("#IUProDate").val(),
                    //    inf2921_pmonth: $("#IUAcctMonth").val(),
                    //    inf2906_wherehouse: (this.Inf29Item.SelectedWherehouse || {}).cnf1002_fileorder,
                    //    inf2903_customer_code: (this.Inf29Item.Ccode || {}).cmf0102_cuscode,
                    //    inf2964_src_docno: $("#IUSrcDocno").val(),
                    //    inf2928_currency: (this.Inf29Item.inf2928_currency || {}).cnf1003_char01,
                    //    remark: $("#IURemark").val(),
                    //    inf2929_exchange_rate: $("#IURate").val(),
                    //    inf2951_allowances: $("#IUAllowances").val(),
                    //    remark: null,
                    //    adddate: null,
                    //    adduser: null,
                    //    moddate: null,
                    //    moduser: null,
                    //};
                },
                SetCopy: function (inf29) {
                    var vueObj = this;
                    var now = new Date();
                    LoadingHelper.showLoading();
                    if (inf29.inf2906_ref_no_date == null) {
                        inf29.inf2906_ref_no_date = "";
                    }
                    var currencyInfo = this.CurrencyList.filter(function (item, index, array) {
                        return item.cnf1003_char01 == inf29.inf2928_currency;
                    }).shift();
                    this.Inf29Item = {
                        BCodeInfo: null, //公司代號相關資料
                        inf2902_docno_type: "XC", //單據分類編號. 組成異動單號
                        inf2902_docno_date: now.dateFormat("Ymd"), //異動單號_日期. 組成異動單號
                        inf2904_pro_date: now.dateFormat(this.UiDateFormat), //異動日期
                        inf2902_docno_seq: null,//異動單號_流水號, 儲存成功後從伺服器返回
                        SelectedWherehouse: null, //選中的倉庫代號
                        inf2952_project_no: inf29.inf2952_project_no, //專案代號
                        ProjectFullname: null, //專案全名
                        inf2916_apr_empid: inf29.inf2916_apr_empid, //員工ID
                        EmpCname: null, //員工Name
                        inf2903_customer_code: inf29.inf2903_customer_code, //客戶代碼
                        Inf2903CustomerCodeName: inf29.Inf2903CustomerCodeName, //異動單位
                        inf2906_ref_no_type: inf29.inf2906_ref_no_type, //單據來源
                        inf2906_ref_no_date: inf29.inf2906_ref_no_date.startsWith("1900") ? "" : inf29.inf2906_ref_no_date, //單據來源
                        inf2906_ref_no_seq: inf29.inf2906_ref_no_seq, //單據來源
                        inf2910_in_reason: inf29.inf2910_in_reason, //異動代號
                        inf2928_currency: inf29.inf2928_currency, //幣別
                        inf2929_exchange_rate: inf29.inf2929_exchange_rate, //匯率
                        SelectedInReason: null, //異動代號
                        SelectedCurrencyInfo: currencyInfo, //幣別
                        remark: inf29.remark,
                        adddate: now.dateFormat(this.UiDateFormat),
                        adduser: loginUserName,
                    };
                    this.Inf29Item.BCodeInfo = this.BcodeList.filter(function (item, index, array) {
                        return item.cnf0701_bcode == inf29.inf2901_bcode;
                    }).shift();
                    this.Inf29Item.SelectedWherehouse = this.WherehouseList.filter(function (item, index, array) {
                        return item.cnf1002_fileorder == inf29.inf2906_wherehouse;
                    }).shift();
                    this.Inf29Item.SelectedInReason = this.InReasonList.filter(function (item, index, array) {
                        return item.cnf1002_fileorder == inf29.inf2910_in_reason;
                    }).shift();
                    if (inf29.inf2952_project_no != null && inf29.inf2952_project_no != '') {
                        this.GetProjectFullname(inf29.inf2952_project_no, this.Inf29Item.BCodeInfo);
                    }
                    if (inf29.inf2916_apr_empid != null && inf29.inf2916_apr_empid != '') {
                        this.GetEmpCname(inf29.inf2916_apr_empid);
                    }

                    asyncTasks.push(this.GetInf29aList(inf29.inf2901_docno).done(function (inf29aListJson) {
                        var now = new Date();
                        var inf29aList = JSON.parse(inf29aListJson);
                        for (var i in inf29aList) {
                            var inf29a = inf29aList[i];
                            vueObj.Inf29aList.push({
                                inf29a02_seq: i,
                                inf29a04_sizeno: inf29a.inf29a04_sizeno,//尺碼
                                inf29a05_pcode: inf29a.inf29a05_pcode,
                                inf29a05_shoes_code: inf29a.inf29a05_shoes_code, //貨號
                                inf29a09_retail_one: inf29a.inf29a09_retail_one,//換算後幣值售價
                                inf29a09_oretail_one: inf29a.inf29a09_oretail_one, //售價
                                inf29a10_ocost_one: inf29a.inf29a10_ocost_one, //原進價
                                inf29a10_cost_one: inf29a.inf29a10_cost_one, //換算後幣值進價
                                inf29a11_dis_rate: 100, //折扣
                                inf29a14_trn_type: "1", //1表示自行輸入的資料
                                ////inf29a31_currency: inf29a.inf29a31_currency, //幣別
                                //                                inf29a32_exchange_rate: inf29a.inf29a32_exchange_rate, //匯率
                                inf29a39_price: inf29a.inf29a39_price, //售價
                                inf29a38_one_amt: inf29a.inf29a38_one_amt, //小計金額
                                inf29a12_sub_amt: inf29a.inf29a12_sub_amt, //換算後幣值小計
                                inf29a13_sold_qty: inf29a.inf29a13_sold_qty, //數量
                                inf29a17_runit: inf29a.inf29a17_runit, //單位
                                inf29a26_box_qty: inf29a.inf29a26_box_qty, //箱入量
                                inf29a33_product_name: inf29a.inf29a33_product_name, //商品名稱
                                inf29a36_odds_amt: inf29a.inf29a36_odds_amt, //尾差
                                inf29a40_tax: inf29a.inf29a40_tax, //營業稅率
                                inf29a41_pcat: inf29a.inf29a41_pcat, //商品分類編號
                                Confirmed: "N", //確認
                                adduser: loginUserName,
                                adddate: now.dateFormat(vueObj.UiDateFormat)
                            });
                        }
                    }));
                    // 所有資料取完後用JSON備份, 用來檢查是否後續有被使用者修改
                    $.when.apply($, asyncTasks).then(function () {
                        LoadingHelper.hideLoading();
                        vueObj.Inf29Copy = JSON.stringify(vueObj.Inf29Item) + JSON.stringify(vueObj.Inf29aList);
                    });
                },
                OnPrint: function () {
                    var vueObj = this;
                    var bcodeInfo = null;
                    if (this.Filter.BcodeStart == this.Filter.BcodeEnd) {
                        bcodeInfo = this.Filter.BcodeStart;
                    }
                    var inf29idList = [];
                    for (var i in this.Inf29List) {
                        var inf29Item = this.Inf29List[i];
                        inf29idList.push(inf29Item.id);
                    }
                    if (inf29idList.length == 0) {
                        alert("無查詢資料");
                        return;
                    }
                    LoadingHelper.showLoading();
                    return $.ajax({
                        type: 'POST',
                        url: rootUrl + "Dinp/Ajax/Inf29Handler.ashx",
                        cache: false,
                        data: {
                            act: "print",
                            data: JSON.stringify(inf29idList),
                            printBcode: JSON.stringify(bcodeInfo),
                        },
                        dataType: 'text',
                        success: function (result) {
                            if (result != "") {
                                printJS({
                                    printable: rootUrl + "Dinp/Ajax/Inf29Print.ashx?session=" + result,
                                    type: 'pdf',
                                    onLoadingStart: null,
                                    onLoadingEnd: LoadingHelper.hideLoading
                                });
                            } else {
                                alert("匯出失敗");
                            }
                        },
                        error: function (jqXhr, textStatus, errorThrown) {
                            LoadingHelper.hideLoading();
                            if (jqXhr.status == 0) {
                                return;
                            }
                            console.error(errorThrown);
                            alert("匯出失敗");
                        }
                    });
                },
                ShowDpCodeWindow: function () {
                    this.IsAppBodyDisplay = false;
                    this.IsDpCodeDisplay = true;
                },
                OnDetailTotalAmt: function () {
                    this.Inf29aItem.inf29a38_one_amt = (this.Inf29aItem.inf29a13_sold_qty - this.Inf29aItem.inf29a24_retrn_qty) * this.Inf29aItem.inf29a10_ocost_one;
                },
                OnDPCodeResult: function (productInfo) {
                    this.IsAppBodyDisplay = true;
                    this.IsDpCodeDisplay = false;
                    if (productInfo == null) {
                        return;
                    }
                    var vueObj = this;
                    vueObj.Inf29aItem.inf29a05_pcode = productInfo.pcode;
                    vueObj.Inf29aItem.inf29a05_shoes_code = productInfo.pclass;
                    vueObj.Inf29aItem.inf29a10_ocost_one = parseFloat(productInfo.retail).toFixed(2);
                    vueObj.Inf29aItem.inf29a10_cost_one0 = parseFloat(productInfo.cost).toFixed(2);
                    vueObj.Inf29aItem.inf29a10_ocost_one = parseFloat(productInfo.retail).toFixed(2);
                    vueObj.Inf29aItem.inf29a09_oretail_one = vueObj.Inf29aItem.inf29a10_ocost_one;
                    vueObj.Inf29aItem.inf29a17_runit = productInfo.runit;
                    vueObj.Inf29aItem.inf29a26_box_qty = productInfo.pqty_o;
                    vueObj.Inf29aItem.inf29a33_product_name = productInfo.psname;
                    vueObj.Inf29aItem.inf29a40_tax = productInfo.tax;
                    vueObj.Inf29aItem.inf29a41_pcat = productInfo.pcat;
                    vueObj.Inf29aItem.inf29a04_sizeno = productInfo.size;
                    vueObj.Inf29aItem.inf29a38_one_amt = (vueObj.Inf29aItem.inf29a13_sold_qty - vueObj.Inf29aItem.inf29a24_retrn_qty) * vueObj.Inf29aItem.inf29a10_ocost_one;
                    if (parseFloat(productInfo.cost) == 0) {
                        if (confirm("您確定進價 = 0，回是(Y)繼續作業，回否(N)請修正進價")) {
                        }
                    }
                    //TODO also on currency change
                    if (vueObj.Inf29Item.SelectedCurrencyInfo == null) {
                        vueObj.Inf29aItem.inf29a10_cost_one = vueObj.Inf29aItem.inf29a10_ocost_one;
                        vueObj.Inf29aItem.inf29a09_oretail_one = vueObj.Inf29aItem.inf29a10_ocost_one;
                    } else {
                        vueObj.Inf29aItem.inf29a10_cost_one =
                            (vueObj.Inf29aItem.inf29a10_ocost_one * vueObj.Inf29Item.inf2929_exchange_rate).toFixed(2);
                        vueObj.Inf29aItem.inf29a09_retail_one =
                            (vueObj.Inf29aItem.inf29a09_oretail_one * vueObj.Inf29Item.inf2929_exchange_rate).toFixed(2);
                    }
                },
                OnExport: function () {
                    // reset dialog
                },
                OnImport: function () {
                    // reset dialog
                    this.$refs.ImportExcelInput.value = null
                },
                ShowDpCodeWindow: function () {
                    this.IsAppBodyDisplay = false;
                    this.IsDpCodeDisplay = true;
                },
                OnDPCodeResult: function (productInfo) {
                    this.IsAppBodyDisplay = true;
                    this.IsDpCodeDisplay = false;
                    if (productInfo == null) {
                        return;
                    }
                    var vueObj = this;
                    vueObj.Inf29aItem.inf29a05_pcode = productInfo.pcode;
                    vueObj.Inf29aItem.inf29a05_shoes_code = productInfo.pclass;
                    vueObj.Inf29aItem.inf29a10_ocost_one = parseFloat(productInfo.retail).toFixed(2);
                    vueObj.Inf29aItem.inf29a10_cost_one0 = parseFloat(productInfo.cost).toFixed(2);
                    vueObj.Inf29aItem.inf29a10_ocost_one = parseFloat(productInfo.retail).toFixed(2);
                    vueObj.Inf29aItem.inf29a09_oretail_one = vueObj.Inf29aItem.inf29a10_ocost_one;
                    vueObj.Inf29aItem.inf29a17_runit = productInfo.runit;
                    vueObj.Inf29aItem.inf29a26_box_qty = productInfo.pqty_o;
                    vueObj.Inf29aItem.inf29a33_product_name = productInfo.psname;
                    vueObj.Inf29aItem.inf29a40_tax = productInfo.tax;
                    vueObj.Inf29aItem.inf29a41_pcat = productInfo.pcat;
                    vueObj.Inf29aItem.inf29a04_sizeno = productInfo.size;
                    vueObj.Inf29aItem.inf29a38_one_amt = (vueObj.Inf29aItem.inf29a13_sold_qty - vueObj.Inf29aItem.inf29a24_retrn_qty) * vueObj.Inf29aItem.inf29a10_ocost_one;
                    if (parseFloat(productInfo.cost) == 0) {
                        if (confirm("您確定進價 = 0，回是(Y)繼續作業，回否(N)請修正進價")) {
                        }
                    }
                    //TODO also on currency change
                    if (vueObj.Inf29Item.SelectedCurrencyInfo == null) {
                        vueObj.Inf29aItem.inf29a10_cost_one = vueObj.Inf29aItem.inf29a10_ocost_one;
                        vueObj.Inf29aItem.inf29a09_oretail_one = vueObj.Inf29aItem.inf29a10_ocost_one;
                    } else {
                        vueObj.Inf29aItem.inf29a10_cost_one =
                            (vueObj.Inf29aItem.inf29a10_ocost_one * vueObj.Inf29Item.inf2929_exchange_rate).toFixed(2);
                        vueObj.Inf29aItem.inf29a09_retail_one =
                            (vueObj.Inf29aItem.inf29a09_oretail_one * vueObj.Inf29Item.inf2929_exchange_rate).toFixed(2);

                    }
                },
                OnExit: function () {
                    //igonre if other exit event triggered
                    if ($(this.$refs.ExportDialog).hasClass('in')
                        || $(this.$refs.ImportExcelDialog).hasClass('in')
                        || $(this.$refs.HelpDialog).hasClass('in')) {
                        return;
                    }
                    window.close();
                    setTimeout(function () {
                        window.location.href = "about:blank";
                    }, 500);
                },
                OnIUExit: function () {
                    if (this.IsDpCodeDisplay
                        || $(this.$refs.HelpDialog).hasClass('in')) {
                        return;
                    }
                    this.ResetInf29();
                    window.dinp02101.DisplaySearch = true;
                    window.dinp02101.DisplayUpdate = false;
                },
                AutoFillFilter: function (field, value, type) {
                    this.Filter[field] = value;
                    if (type == "datetime") {
                        this.$refs["Filter" + field].setValue(value);
                    }
                },
                OnInf29TableSorting: function (column) {
                    if (this.Inf29SortColumn == column) {
                        if (this.Inf29SortOrder == "asc") {
                            this.Inf29SortOrder = "desc";
                        } else {
                            this.Inf29SortOrder = "asc";
                        }
                    } else {
                        this.Inf29SortOrder = "asc";
                    }
                    this.Inf29SortColumn = column;

                    this.Inf29List.sort(this.SortInf29List);
                },
                OnInf29aTableSorting: function (column) {
                    if (this.Inf29aSortColumn == column) {
                        if (this.Inf29aSortOrder == "asc") {
                            this.Inf29aSortOrder = "desc";
                        } else {
                            this.Inf29aSortOrder = "asc";
                        }
                    } else {
                        this.Inf29aSortOrder = "asc";
                    }
                    this.Inf29aSortColumn = column;

                    this.Inf29aList.sort(this.SortInf29aList);
                },
                SortInf29List: function (a, b) {
                    var paramA = a[this.Inf29SortColumn] || "";
                    var paramB = b[this.Inf29SortColumn] || "";
                    if (paramA < paramB) {
                        return this.Inf29SortOrder == 'asc' ? -1 : 1;
                    }
                    if (paramA > paramB) {
                        return this.Inf29SortOrder == 'asc' ? 1 : -1;
                    }
                    if (a["id"] < b["id"]) {
                        return this.Inf29SortOrder == 'asc' ? -1 : 1;

                    }
                    if (a["id"] > b["id"]) {
                        return this.Inf29SortOrder == 'asc' ? 1 : -1;
                    }
                    return 0;
                },
                SortInf29aList: function (a, b) {
                    var paramA = a[this.Inf29aSortColumn] || "";
                    var paramB = b[this.Inf29aSortColumn] || "";
                    if (paramA < paramB) {
                        return this.Inf29aSortOrder == 'asc' ? -1 : 1;
                    }
                    if (paramA > paramB) {
                        return this.Inf29aSortOrder == 'asc' ? 1 : -1;
                    }
                    if (a["id"] < b["id"]) {
                        return this.Inf29aSortOrder == 'asc' ? -1 : 1;

                    }
                    if (a["id"] > b["id"]) {
                        return this.Inf29aSortOrder == 'asc' ? 1 : -1;
                    }
                    return 0;
                },
                GetWherehouseName: function (wherehouse) {
                    var wherehouseInfo = this.WherehouseList.filter(function (item, index, array) {
                        return item.cnf1002_fileorder == wherehouse;
                    }).shift();
                    return (wherehouseInfo || {}).cnf1003_char01;
                },
                GetInReasonName: function (inReason) {
                    return "inReason";
                },
                GetCustomerName: function (customerCode) {
                    return "customerCode";
                },
                GetInf29aList: function (docno) {
                    LoadingHelper.showLoading();
                    var vueObj = this;
                    return $.ajax({
                        type: 'POST',
                        url: rootUrl + "Dinp/Ajax/Inf29Handler.ashx",
                        cache: false,
                        data: {
                            act: "getdetail",
                            data: docno
                        },
                        dataType: 'text',
                        success: function (inf29aListJson) {
                            LoadingHelper.hideLoading();
                            var inf29aList = JSON.parse(inf29aListJson);
                            vueObj.Inf29aList = inf29aList;
                            if (vueObj.SortColumn != null) {
                                console.warn("todo sort");
                                // inf29List.sort(vueObj.SortCnf05List);
                            }
                        },
                        error: function (jqXhr, textStatus, errorThrown) {
                            if (jqXhr.status == 0) {
                                return;
                            }
                            LoadingHelper.hideLoading();
                            console.error(errorThrown);
                            alert("查詢失敗");
                        }
                    });
                },
                GetExportFields: function () {
                    var vueObj = this;
                    return $.ajax({
                        type: 'GET',
                        url: rootUrl + "Dinp/Ajax/GetExportFields.ashx",
                        cache: true,
                        dataType: 'text',
                        success: function (exportFieldsJson) {
                            var exportFields = JSON.parse(exportFieldsJson);
                            vueObj.Export.Inf29List = exportFields[0];
                            vueObj.Export.Inf29aList = exportFields[1];
                        },
                        error: function (jqXhr, textStatus, errorThrown) {
                            if (jqXhr.status == 0) {
                                return;
                            }
                            console.error(errorThrown);
                        }
                    });
                },
                GetProductInfo: function (pcode) {

                    var vueObj = this;

                    return $.ajax({
                        type: 'POST',
                        url: rootUrl + "Dinp/Ajax/GetProductInfo.ashx",
                        cache: false,
                        data: {
                            pcode: pcode
                        },
                        dataType: 'text',
                        success: function (productInfoJson) {

                        },
                        error: function (jqXhr, textStatus, errorThrown) {
                            if (jqXhr.status == 0) {
                                return;
                            }
                            LoadingHelper.hideLoading();
                            console.error(errorThrown);
                            alert("查詢商品基本資料失敗");
                        }
                    });
                },
                BcodeSelectLabel: function (bcode) {
                    return bcode.cnf0701_bcode + "-" + bcode.cnf0703_bfname;
                },
                WherehouseSelectLabel: function (wherehouse) {
                    return wherehouse.cnf1002_fileorder + "-" + wherehouse.cnf1003_char01;
                },
                InReasonSelectLabel: function (inReason) {
                    return inReason.cnf1002_fileorder + "-" + inReason.cnf1003_char01;
                },
                CcodeSelectLabel: function (ccode) {
                    return ccode.cmf0102_cuscode + "-" + ccode.cmf0103_bname;
                },
                GetExchangeInfo: function (currencyInfo) {
                    var vueObj = this;
                    return $.ajax({
                        type: 'POST',
                        url: rootUrl + "Dinp02101New/Ajax/GetExchangeInfo.ashx",
                        cache: true,
                        data: {
                            exchangeCode: currencyInfo.cnf1003_char01
                        },
                        dataType: 'text',
                        success: function (exchangeInfoJson) {
                            var exchangeInfo = JSON.parse(exchangeInfoJson);
                            if (exchangeInfo == null) {
                                vueObj.Inf29Item.inf2929_exchange_rate = 1;
                            } else {
                                vueObj.Inf29Item.inf2929_exchange_rate = exchangeInfo.cnf1406_exchange_fix;
                            }
                        },
                        error: function (jqXhr, textStatus, errorThrown) {
                            if (jqXhr.status == 0) {
                                return;
                            }
                            LoadingHelper.hideLoading();
                            console.error(errorThrown);
                            alert("查詢匯率失敗");
                        }
                    });
                },
                ResetInf29: function () {
                    //var asyncTasks = [];
                    var defaultBCodeInfo = this.BcodeList.filter(function (item, index, array) {
                        return item.cnf0751_tax_headoffice == "0";
                    }).shift();
                    var defaultCurrency = this.CurrencyList.filter(function (item, index, array) {
                        return item.cnf1003_char01 == "NTD";
                    }).shift();

                    this.Inf29Item = {
                        DisplaySearch: false,
                        DisplayUpdate: false,
                        isCopyMode: false,
                        id: null,
                        inf2901_bcode: defaultBCodeInfo,
                        inf2901_docno: null,//進貨單號 inf2902_docno_type+inf2902_docno_date+inf2902_docno_seq
                        inf2904_pro_date: null, //進貨日期
                        inf2921_pmonth: null,//所屬帳款月份
                        inf2906_wherehouse: null,//倉庫代號
                        inf2910_in_reason: 100,//不顯示
                        inf2903_customer_code: null,
                        inf2964_src_docno: null,
                        inf2928_currency: defaultCurrency,
                        inf2929_exchange_rate: null,
                        inf2951_allowances: null,
                        remark: null,                  
                        adddate: null,
                        adduser: null,
                        moddate: null,
                        moduser: null
                    };
                    //this.Inf29Item.inf2901_bcode = defaultBCodeInfo;
                    this.Inf29Item.adduser = loginUserName;
                    this.Inf29Copy = null;
                    var now = new Date();
                    this.Inf29Item.inf2902_docno_date = now.dateFormat("Ymd");
                    this.Inf29Item.inf2904_pro_date = now.dateFormat(this.UiDateFormat);
                    this.Inf29Item.adddate = now.dateFormat(this.UiDateFormat);
                    this.Inf29aList = [];
                    this.GetExchangeInfo(defaultCurrency);

                    this.ResetInf29a();
                    //return $.when.apply($, asyncTasks);
                },
                ResetInf29a: function () {
                    this.Inf29aItem = {
                        inf29a02_seq: null,
                        inf29a05_pcode: null,//產品編號
                        inf29a33_product_name: null, //商品名稱
                        inf29a05_shoes_code: null, //貨號
                        inf29a17_runit: null, //單位
                        inf29a10_cost_one0: null,//未稅單價
                        inf29a10_ocost_one: null,//含稅單價
                        inf29a40_tax: null,//營業稅
                        inf29a13_sold_qty: 0, //進貨數量
                        inf29a24_retrn_qty: 0, //退貨數量
                        inf29a16_gift_qty: 0,//贈品數量
                        inf29a26_box_qty: null, //大單位數量
                        inf29a10_cost_one: null,//換算值
                        inf29a06_qty: null,//小單位數量
                        inf29a38_one_amt: null, //小計金額
                        remark: null,
                        adddate: null,
                        adduser: null,
                        moddate: null,
                        moduser: null
                    };
                    this.SelectedInf29aItem = null;
                    this.Inf29aItem.adduser = loginUserName;
                    var now = new Date();
                    this.Inf29aItem.adddate = now.dateFormat(this.UiDateFormat);
                }
            },
            directives: {
                "modal-show-focus": {
                    bind: function (el, binding) {
                        $(el).on("shown.bs.modal", function () {
                            $(this).find("iframe").focus();
                        });
                    },
                    unbind: function (el) {
                        $(el).off("shown.bs.modal");
                    }
                }
            },
            mounted: function () {
                SaveEnterPageLog(rootUrl, localStorage.getItem("USER_ID"), "Dinp02101");
                this.GetExportFields();
            }
        });
    }

    function onError(error) {
        console.error(error);
    }

    define(requiredFiles, onLoaded, onError);

})();