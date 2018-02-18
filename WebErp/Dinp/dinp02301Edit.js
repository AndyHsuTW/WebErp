'use strict';
(function () {

    requirejs.config({
        paths: {
            "FunctionButton": isIE ? "VueComponent/FunctionButton.babel" : "VueComponent/FunctionButton",
            "vuejs-uib-pagination": "public/scripts/VueComponent/vuejs-uib-pagination",
            "vue-jQuerydatetimepicker": isIE ? "public/scripts/VueComponent/vue-jQuerydatetimepicker.babel" : "public/scripts/VueComponent/vue-jQuerydatetimepicker",
            "jquery.datetimepicker": "public/scripts/jquery.datetimepicker/jquery.datetimepicker.full",
            "jqueryDatetimepicker-css": "public/scripts/jquery.datetimepicker/jquery.datetimepicker",
            "jquery.mousewheel": "public/scripts/jquery.mousewheel.min",
            "d_pcode_component": "D_pcode/D_pcode",
            "d_pcode-css": "D_pcode/D_pcodeCss",
        },
        shim: {
            "jquery.datetimepicker": {
                "deps": ["css!jqueryDatetimepicker-css"]
            },
            "vue-jQuerydatetimepicker": {
                "deps": ['jquery.datetimepicker']
            },
            "d_pcode_component": {
                "deps": ["css!d_pcode-css"]
            },
        },
        map: {
            '*': {
                'jquery-mousewheel': 'jquery.mousewheel',
                "functionButton": "FunctionButton",
                "uibPagination": "vuejs-uib-pagination"
            }
        }
    });

    var requiredFiles = ["bootstrap",
        "FunctionButton",
        "vuejs-uib-pagination",
        "vue-jQuerydatetimepicker",
        "LoadingHelper",
        "jquery.mousewheel",
        "vue-multiselect"
    ];

    function onLoaded(bootstrap, functionButton, uibPagination, vueDatetimepicker, loadingHelper, jqueryMousewheel, vueMultiselect, dPcodeComponent) {
        window.dinp02301Edit = new Vue({
            el: "#Dinp02301Edit",
            data: {
                Display: false,
                Inf29Item: {
                    id:null,//儲存成功後從伺服器返回
                    BCodeInfo: null, //公司代號相關資料
                    inf2902_docno_type: "XC", //單據分類編號. 組成異動單號
                    inf2902_docno_date: null, //異動單號_日期. 組成異動單號
                    inf2904_pro_date: null, //異動日期
                    inf2902_docno_seq:null,//異動單號_流水號, 儲存成功後從伺服器返回
                    SelectedWherehouse: null, //選中的倉庫代號
                    inf2952_project_no: null, //專案代號
                    ProjectFullname: null, //專案全名
                    inf2916_apr_empid: null, //員工ID
                    EmpCname: null, //員工Name
                    inf2903_customer_code: null, //客戶代碼
                    Inf2903CustomerCodeName: null, //cmf0104_fname客戶名稱
                    inf2906_ref_no_type: null, //單據來源
                    inf2906_ref_no_date: null, //單據來源
                    inf2906_ref_no_seq: null, //單據來源
                    SelectedInReason: null, //異動代號
                    inf2910_in_reason: null, //異動代號
                    remark: null,
                    adddate: null,
                    adduser: null,
                    moddate: null,
                    moduser: null,
                }, // New edit item of Inf29
                Inf29aItem: {
                    inf29a05_pcode: null, //產品編號
                    inf29a05_shoes_code: null, //貨號
                    inf29a17_runit: null, //單位
                    inf29a10_ocost_one: 0, //原進價
                    inf29a10_cost_one: 0, //換算後幣值進價
                    SelectedCurrencyInfo: null, //幣別
                    inf29a32_exchange_rate: 0, //匯率
                    inf29a33_product_name: null, //商品名稱
                    inf29a39_price: 0, //售價
                    inf29a13_sold_qty: 0, //數量
                    inf29a36_odds_amt: 0, //尾差
                    adddate: null,
                    adduser: null,
                    moddate: null,
                    moduser: null,
                    Confirmed: null, //確認

                }, // New edit item of Inf29a
                BcodeList: [], //公司代號下拉選單資料
                WherehouseList: [], //倉庫代號下拉選單資料
                InReasonList: [], //異動代號下拉選單資料
                CurrencyList: [], //幣別下拉選單來源
                Inf29aList: [], //
                UiDateFormat: "Y/m/d",
                ConfirmList: ["", "Y", "N"],
                SelectedInf29aItem: null, //table被選中的row
            },
            watch: {
                Display: function (val) {
                    if (val == true) {
                        var vueObj = this;
                        Vue.nextTick(function () {
                            vueObj.$refs.ProDate.setValue(vueObj.Inf29Item.inf2904_pro_date);
                            // DOM updated
                        });
                    }
                }
            },
            components: {
                Multiselect: vueMultiselect.default
            },
            computed: {
                Inf29Item_Inf2902DocNo: function () {
                    var seq="";
                    if(this.Inf29Item.inf2902_docno_seq==null||
                        this.Inf29Item.inf2902_docno_seq===""){
                    } else {
                        seq = (this.Inf29Item.inf2902_docno_seq+"").padStart("4","0");
                    }
                    return this.Inf29Item.inf2902_docno_type + this.Inf29Item.inf2902_docno_date+seq;
                },
                TotalAmount: function () {
                    return 0.0.toFixed(2);
                },
                TotalPrice: function () {
                    return 0.0.toFixed(2);
                },
                Inf29aItem_Inf29a38OneAmt: function () { //小計金額
                    return this.Inf29aItem.inf29a39_price * this.Inf29aItem.inf29a13_sold_qty + this.Inf29aItem.inf29a36_odds_amt * 1;
                },
                Inf29aItem_Inf29a12SubAmt: function () { //換算後幣值小計
                    return this.Inf29aItem.inf29a09_retail_one * this.Inf29aItem.inf29a13_sold_qty;
                }
            },
            methods: {
                OnSearch: function () {

                },
                OnAdd: function () {
                    console.log("OnAdd");
                    //TODO clear data
                },
                OnAddInf29aItem: function (defaultSeq) {
                    var inf29a02_seq = defaultSeq || this.Inf29aList.length;
                    for (var i in this.Inf29aList) {
                        if (this.Inf29aList[i].inf29a02_seq == inf29a02_seq) {
                            return this.OnAddInf29aItem(inf29a02_seq + 1);
                        }
                    }
                    this.Inf29aList.push({
                        inf29a02_seq: inf29a02_seq,
                        inf29a04_sizeno:this.Inf29aItem.inf29a04_sizeno,//尺碼
                        inf29a05_pcode: this.Inf29aItem.inf29a05_pcode,
                        inf29a05_shoes_code: this.Inf29aItem.inf29a05_shoes_code, //貨號
                        inf29a10_ocost_one: this.Inf29aItem.inf29a10_ocost_one, //原進價
                        inf29a10_cost_one: this.Inf29aItem.inf29a10_cost_one, //換算後幣值進價
                        inf29a11_dis_rate: 100, //折扣
                        inf29a14_trn_type: "1", //1表示自行輸入的資料
                        inf29a31_currency: this.Inf29aItem.SelectedCurrencyInfo == null ? "" : this.Inf29aItem.SelectedCurrencyInfo.cnf1003_char01, //幣別
                        inf29a32_exchange_rate: this.Inf29aItem.inf29a32_exchange_rate, //匯率
                        inf29a39_price: this.Inf29aItem.inf29a39_price, //售價
                        inf29a38_one_amt: this.Inf29aItem_Inf29a38OneAmt, //小計金額
                        inf29a12_sub_amt: this.Inf29aItem_Inf29a12SubAmt, //換算後幣值小計
                        inf29a13_sold_qty: this.Inf29aItem.inf29a13_sold_qty, //數量
                        inf29a17_runit: this.Inf29aItem.inf29a17_runit, //單位
                        inf29a26_box_qty: this.Inf29aItem.inf29a26_box_qty, //箱入量
                        inf29a33_product_name: this.Inf29aItem.inf29a33_product_name, //商品名稱
                        inf29a36_odds_amt: this.Inf29aItem.inf29a36_odds_amt, //尾差
                        inf29a40_tax: this.Inf29aItem.inf29a40_tax, //營業稅率
                        inf29a41_pcat: this.Inf29aItem.inf29a41_pcat, //商品分類編號
                        Confirmed: this.Inf29aItem.Confirmed, //確認
                        adduser:this.Inf29aItem.adduser,
                        adddate:this.Inf29aItem.adddate
                    });
                },
                OnDeleteInf29aItem: function () {
                    //TODO
                    if (this.SelectedInf29aItem == null) {
                        return;
                    }
                    if (confirm("是否確認刪除明細?")) {
                        var index = this.Inf29aList.indexOf(this.SelectedInf29aItem);
                        this.Inf29aList.splice(index, 1);
                    }
                },
                OnRowClick: function (inf29aItem) {
                    this.SelectedInf29aItem = inf29aItem;
                },
                OnCopy: function () {

                },
                OnSave: function () {

                    if (this.Inf29Item.inf2903_customer_code == null ||
                        this.Inf29Item.inf2903_customer_code == "") {
                        alert("請輸入異動單位");
                        return;
                    }
                    var inf2902_docno_date = null;
                    if (this.Inf29Item.inf2902_docno_date != null && this.Inf29Item.inf2902_docno_date != "") {
                        inf2902_docno_date = Date.parseDate(this.Inf29Item.inf2902_docno_date, 'Ymd').dateFormat('Y-m-d');
                    }
                    var inf2906_ref_no_date = null;
                    if (this.Inf29Item.inf2906_ref_no_date != null && this.Inf29Item.inf2906_ref_no_date != "") {
                        inf2906_ref_no_date = Date.parseDate(this.Inf29Item.inf2906_ref_no_date, 'Ymd').dateFormat('Y-m-d');
                    }
                    var inf29Item = {
                        inf2901_bcode: this.Inf29Item.BCodeInfo.cnf0701_bcode, //公司代號相關資料
                        inf2902_docno_type: this.Inf29Item.inf2902_docno_type, //單據分類編號. 組成異動單號
                        inf2902_docno_date: inf2902_docno_date, //異動單號_日期. 組成異動單號
                        inf2903_customer_code: this.Inf29Item.inf2903_customer_code, //客戶代碼
                        inf2904_pro_date: this.Inf29Item.inf2904_pro_date, //異動日期
                        inf2906_wherehouse: this.Inf29Item.SelectedWherehouse.cnf1002_fileorder, //倉庫代號
                        inf2906_ref_no_type: this.Inf29Item.inf2906_ref_no_type||"", //單據來源
                        inf2906_ref_no_date: inf2906_ref_no_date, //單據來源
                        inf2906_ref_no_seq: this.Inf29Item.inf2906_ref_no_seq || 0, //單據來源
                        inf2910_in_reason: this.Inf29Item.SelectedInReason.cnf1002_fileorder, //異動代號
                        inf2914_inv_eff: this.Inf29Item.SelectedInReason.cnf1008_dec01, //庫存影響方向
                        inf2916_apr_empid: this.Inf29Item.inf2916_apr_empid||"", //員工ID
                        inf2952_project_no: this.Inf29Item.inf2952_project_no||"", //專案代號
                        remark: this.Inf29Item.remark||"",
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
                        url: rootUrl + "Dinp/Ajax/Inf29Handler.ashx",
                        cache: false,
                        data: {
                            act: "save",
                            data: JSON.stringify(inf29Item)
                        },
                        dataType: 'text',
                        success: function (inf29Json) {
                            var inf29Item = JSON.parse(inf29Json);
                            if(inf29Item==null){
                                alert("儲存失敗");
                            } else {
                                vueObj.Inf29Item.id = inf29Item.id;
                                vueObj.Inf29Item.inf2902_docno_seq = inf29Item.inf2902_docno_seq;
                            }
                            LoadingHelper.hideLoading();
                            debugger;
                        },
                        error: function (jqXhr, textStatus, errorThrown) {
                            if (jqXhr.status == 0) {
                                return;
                            }
                            LoadingHelper.hideLoading();
                            console.error(errorThrown);
                            alert("儲存失敗");
                        }
                    });
                },
                OnPrint: function () {

                },
                OnExport: function () {
                    // reset dialog
                    this.Export = {
                        cnf0501_file: true,
                        cnf0502_field: true,
                        cnf0503_fieldname_tw: true,
                        cnf0506_program: true,
                        adddate: true,
                        adduser: true,
                        moddate: true,
                        moduser: true,
                        cnf0504_fieldname_cn: true,
                        cnf0505_fieldname_en: true
                    };
                },
                OnExit: function () {
                    this.Display = false;
                    window.dinp02301Search.Display = true;
                },
                AutoFillFilter: function (field, value, type) {
                    this.Filter[field] = value;
                    if (type == "datetime") {
                        this.$refs["Filter" + field].setValue(value);
                    }
                },
                OnTableSorting: function (column) {
                    if (this.SortColumn == column) {
                        if (this.SortOrder == "asc") {
                            this.SortOrder = "desc";
                        } else {
                            this.SortOrder = "asc";
                        }
                    } else {
                        this.SortOrder = "asc";
                    }
                    this.SortColumn = column;

                    this.Cnf05List.sort(this.SortCnf05List);
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
                                vueObj.Inf29aItem.inf29a05_shoes_code = productInfo.pclass;
                                vueObj.Inf29aItem.inf29a10_ocost_one = parseFloat(productInfo.cost).toFixed(2);
                                vueObj.Inf29aItem.inf29a39_price = parseFloat(productInfo.retail).toFixed(2);
                                vueObj.Inf29aItem.inf29a09_oretail_one = vueObj.Inf29aItem.inf29a39_price;
                                vueObj.Inf29aItem.inf29a17_runit = productInfo.runit;
                                vueObj.Inf29aItem.inf29a26_box_qty = productInfo.pqty_o;
                                vueObj.Inf29aItem.inf29a33_product_name = productInfo.psname;
                                vueObj.Inf29aItem.inf29a40_tax = productInfo.tax;
                                vueObj.Inf29aItem.inf29a41_pcat = productInfo.pcat;
                                vueObj.Inf29aItem.inf29a04_sizeno= productInfo.size;

                                if (parseFloat(productInfo.cost) == 0) {
                                    if (confirm("您確定進價 = 0，回是(Y)繼續作業，回否(N)請修正進價")) {

                                    }
                                }
                                //TODO also on currency change
                                if (vueObj.Inf29aItem.SelectedCurrencyInfo == null) {
                                    vueObj.Inf29aItem.inf29a10_cost_one = vueObj.Inf29aItem.inf29a10_ocost_one;
                                    vueObj.Inf29aItem.inf29a09_oretail_one = vueObj.Inf29aItem.inf29a39_price;
                                } else {
                                    vueObj.Inf29aItem.inf29a10_cost_one =
                                        vueObj.Inf29aItem.inf29a10_ocost_one * vueObj.Inf29aItem.inf29a32_exchange_rate;
                                    vueObj.Inf29aItem.inf29a09_retail_one =
                                        vueObj.Inf29aItem.inf29a09_oretail_one * vueObj.Inf29aItem.inf29a32_exchange_rate;

                                }
                            }
                        });
                },
                OnCustomCodeChange: function () {
                    //異動單位變更, 根據異動帶碼讀資料
                    var vueObj = this;
                    return $.ajax({
                        type: 'POST',
                        url: rootUrl + "Dinp/Ajax/GetCustomCodeInfo.ashx",
                        cache: false,
                        data: {
                            inReasonCh02: this.Inf29Item.SelectedInReason.cnf1004_char02,
                            customCode: this.Inf29Item.inf2903_customer_code
                        },
                        dataType: 'text',
                        success: function (customCodeInfoJson) {
                            var customCodeInfo = JSON.parse(customCodeInfoJson);
                            if (customCodeInfo == null) {
                                switch (vueObj.Inf29Item.SelectedInReason.cnf1004_char02) {
                                    case "cmf01":
                                        alert("客戶資料不存在，請詳查");
                                        break;
                                    case "cnf07":
                                        alert("公司資料不存在，請詳查");
                                        break;
                                    case "inf03":
                                        alert("廠商資料不存在，請詳查");
                                        break;
                                    case "taf10":
                                        alert("客戶資料不存在，請詳查");
                                        break;
                                    case "cnf10":
                                        alert("異動單位不存在，請詳查");
                                        break;
                                }
                            } else {
                                switch (vueObj.Inf29Item.SelectedInReason.cnf1004_char02) {
                                    case "cmf01":
                                        vueObj.Inf29Item.Inf2903CustomerCodeName = customCodeInfo.cmf0103_bname;
                                        break;
                                    case "cnf07":
                                        vueObj.Inf29Item.Inf2903CustomerCodeName = customCodeInfo.cnf0702_bname;
                                        break;
                                    case "inf03":
                                        vueObj.Inf29Item.Inf2903CustomerCodeName = customCodeInfo.inf0302_bname;
                                        break;
                                    case "taf10":
                                        vueObj.Inf29Item.Inf2903CustomerCodeName = customCodeInfo.taf1004_cname;
                                        break;
                                    case "cnf10":
                                        vueObj.Inf29Item.Inf2903CustomerCodeName = customCodeInfo.cnf1003_char01;
                                        break;
                                }
                            }
                        },
                        error: function (jqXhr, textStatus, errorThrown) {
                            if (jqXhr.status == 0) {
                                return;
                            }
                            LoadingHelper.hideLoading();
                            console.error(errorThrown);
                            alert("查詢異動單位失敗");
                        }
                    });

                },
                GetExchangeInfo: function (currencyInfo) {
                    var vueObj = this;
                    return $.ajax({
                        type: 'POST',
                        url: rootUrl + "Dinp/Ajax/GetExchangeInfo.ashx",
                        cache: true,
                        data: {
                            exchangeCode: currencyInfo.cnf1003_char01
                        },
                        dataType: 'text',
                        success: function (exchangeInfoJson) {
                            var exchangeInfo = JSON.parse(exchangeInfoJson);
                            if (exchangeInfo == null) {
                                vueObj.Inf29aItem.inf29a32_exchange_rate = 1;
                            } else {
                                vueObj.Inf29aItem.inf29a32_exchange_rate = exchangeInfo.cnf1406_exchange_fix;
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
                GetTotalQty: function (inf29Item) {
                    return 123;
                },
                GetInReasonName: function (inReason) {
                    return "inReason";
                },
                GetCustomerName: function (customerCode) {
                    return "customerCode";
                },
                GetProjectFullname: function (projectNo, bcodeInfo) {
                    if (bcodeInfo == null) {
                        alert("請選擇公司代號");
                        return;
                    }
                    var vueObj = this;
                    return $.ajax({
                        type: 'POST',
                        url: rootUrl + "Dinp/Ajax/GetProjectInfo.ashx",
                        cache: false,
                        data: {
                            bcode: bcodeInfo.cnf0701_bcode,
                            projectNo: projectNo
                        },
                        dataType: 'text',
                        success: function (projectInfoJson) {
                            var projectInfo = JSON.parse(projectInfoJson);
                            if (projectInfo == null) {
                                alert("專案代號不存在於專案合約檔中，請重新輸入");
                            } else {
                                vueObj.Inf29Item.ProjectFullname = projectInfo.gaf0404_project_fullname;
                            }
                        },
                        error: function (jqXhr, textStatus, errorThrown) {
                            if (jqXhr.status == 0) {
                                return;
                            }
                            LoadingHelper.hideLoading();
                            console.error(errorThrown);
                            alert("查詢專案名稱失敗");
                        }
                    });
                },
                GetEmpCname: function (empid) {
                    var vueObj = this;
                    return $.ajax({
                        type: 'POST',
                        url: rootUrl + "Dinp/Ajax/GetEmpInfo.ashx",
                        cache: true,
                        data: {
                            empId: empid
                        },
                        dataType: 'text',
                        success: function (empInfoJson) {
                            var empInfo = JSON.parse(empInfoJson);
                            if (empInfo == null) {
                                alert("員工代號不存在於人事基本資料檔中，請重新輸入");
                            } else {
                                vueObj.Inf29Item.EmpCname = empInfo.taf1004_cname;
                            }
                        },
                        error: function (jqXhr, textStatus, errorThrown) {
                            if (jqXhr.status == 0) {
                                return;
                            }
                            LoadingHelper.hideLoading();
                            console.error(errorThrown);
                            alert("查詢員工名稱失敗");
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
            },
            directives: {

            },
            mounted: function () {
                this.Inf29Item.adduser = localStorage["USER_ID"];
                this.Inf29aItem.adduser = localStorage["USER_ID"];

                var now = new Date();
                this.Inf29Item.inf2902_docno_date = now.dateFormat("Ymd");
                this.Inf29Item.inf2904_pro_date = now.dateFormat(this.UiDateFormat);
                this.Inf29Item.adddate = now.dateFormat(this.UiDateFormat);
                this.Inf29aItem.adddate = now.dateFormat(this.UiDateFormat);
            }
        });
    }

    function onError(error) {
        console.error(error);
    }

    define(requiredFiles, onLoaded, onError);

})();