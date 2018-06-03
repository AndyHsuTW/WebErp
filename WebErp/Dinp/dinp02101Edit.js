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
            "d_pcode": "D_pcode/D_pcode",
            "d_pcode-css": "D_pcode/D_pcodeCss",
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
        "vue-jQuerydatetimepicker",
        "LoadingHelper",
        "jquery.mousewheel",
        "vue-multiselect",
        "print-js",
        "d_pcode",
        "jquery.floatThead"
    ];

    function onLoaded(bootstrap, 
        functionButton, 
        vueDatetimepicker, 
        loadingHelper, 
        jqueryMousewheel,
         vueMultiselect, 
         printJs,
        dPcode,
        jqFloatThead) {
        if (vueMultiselect == null) {
            console.error("vueMultiselect fallback");
            vueMultiselect = window.VueMultiselect;
        }
        window.dinp02101Edit = new Vue({
            el: "#Dinp02101Edit",
            data: {
                Display: false,
                IsAppBodyDisplay:true,
                IsDpCodeDisplay:false,
                Inf29Item: {
                    id:null,//儲存成功後從伺服器返回
                    BCodeInfo: null, //公司代號相關資料
                    inf2902_docno_type: "SI", //單據分類編號. 組成異動單號
                    inf2902_docno_date: null, //異動單號_日期. 組成異動單號
                    inf2904_pro_date: null, //異動日期
                    inf2902_docno_seq:null,//異動單號_流水號, 儲存成功後從伺服器返回
                    SelectedWherehouse: null, //選中的倉庫代號
                    inf2909_vcode: null, //專案代號
                    inf0303_fname:null, //廠商全名
                    ProjectFullname: null, //專案全名
                    EmpCname: null, //員工Name
                    inf2903_customer_code: "", //客戶代碼
                    Inf2903CustomerCodeName: null, //異動單位
                    inf2906_ref_no_type: null, //單據來源
                    inf2906_ref_no_date: null, //單據來源
                    inf2906_ref_no_seq: null, //單據來源
                    inf2910_in_reason: null, //異動代號
                    SelectedInReason: null, //異動代號
                    inf2916_apr_empid: null, //員工ID
                    inf2921_pmonth: null, //所屬帳款月份
                    SelectedCurrencyInfo: null, //幣別
                    inf2929_exchange_rate: 1, //匯率
                    inf2002_docno_type: null,//單據分類編號
                    inf2002_docno_date: null,//異動單號_日期
                    inf2002_docno_seq: null,//異動單號_流水號
                    inf2951_allowances: 0,//折讓金額
                    inf2952_project_no:"",
                    remark: "",
                    adddate: null,
                    adduser: null,
                    moddate: null,
                    moduser: null,
                }, // New edit item of Inf29
                Inf29aItem: {
                    inf29a02_seq:null,//序號
                    inf29a04_sizeno:null,//尺碼
                    inf29a05_pcode: null, //產品編號
                    inf29a05_shoes_code: null, //貨號
                    inf29a06_qty: 0,//小單位數量
                    inf29a09_retail_one:0,//換算後幣值售價
                    inf29a09_oretail_one:0, //售價
                    inf29a10_ocost_one: 0, //含稅單價
                    inf29a10_cost_one0: 0, //未稅單價
                    inf29a10_cost_one: 0, //換算後幣值進價
                    inf29a13_sold_qty:0,//大單位數量
                    inf29a16_gift_qty:0,//贈品數量
                    inf29a17_runit: "", //單位
                    inf29a22_tax_flag: "",//稅別
                    inf29a24_retrn_qty: 0,//退貨數
                    inf29a26_box_qty: 0,//箱入量
//                    SelectedCurrencyInfo: null, //幣別
//                    inf29a32_exchange_rate: 1, //匯率
                    inf29a33_product_name: null, //商品名稱
                    inf29a36_odds_amt: 0, //尾差
                    inf29a39_price: 0, //售價
                    inf29a40_tax:0,//營業稅率
                    inf29a41_pcat: "",//商品分類編號
                    inf29a49_tax: 0,//營業稅
                    inf0164_dividend :0,
                    adddate: null,
                    adduser: null,
                    moddate: null,
                    moduser: null,
                    Confirmed: "N", //確認
                    remark:"",

                }, // New edit item of Inf29a
                BcodeList: [], //公司代號下拉選單資料
                WherehouseList: [], //倉庫代號下拉選單資料
                InReasonList: [], //異動代號下拉選單資料
                CurrencyList: [], //幣別下拉選單來源
                Inf29aList: [], //
                UiDateFormat: "Y/m/d",
                ConfirmList: ["N", "Y"],
                SelectedInf29aItem: null, //table被選中的row
                Inf29Copy:null, //儲存複製的備份
                SortColumn:null,
                SortOrder:null,
            },
            watch: {
                Display: function (val) {
                    if (val == true) {
                        var vueObj = this;
                        Vue.nextTick(function () {
                            // DOM updated
                            vueObj.$refs.ProDate.setValue(vueObj.Inf29Item.inf2904_pro_date);
                        });
                    }
                }
            },
            components: {
                Multiselect: vueMultiselect.default
            },
            computed: {
                Inf29Item_Inf2902DocNo: function() {
                    var seq = "";
                    if (this.Inf29Item.inf2902_docno_seq == null ||
                        this.Inf29Item.inf2902_docno_seq === "") {
                    } else {
                        seq = (this.Inf29Item.inf2902_docno_seq + "").padStart("4", "0");
                    }
                    return this.Inf29Item.inf2902_docno_type + this.Inf29Item.inf2902_docno_date + seq;
                },
                Inf29aItem_Inf29a13SoldQty: function() {

                    if (this.Inf29aItem.inf29a13_sold_qty == 0) {
                        return this.Inf29aItem.inf29a26_box_qty * this.Inf29aItem.inf0164_dividend + this.Inf29aItem.inf29a06_qty;
                    }
                    return this.Inf29aItem.inf29a13_sold_qty;
                },
                TotalAmount: function () {
                    var total = 0.0;
                    for (var i in this.Inf29aList) {
                        var inf29a = this.Inf29aList[i];
                        total += parseFloat(inf29a.inf29a13_sold_qty);
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
                },
                Inf29aItem_Inf29a38OneAmt: function () { //小計金額
                    var amt = this.Inf29aItem.inf29a39_price * (this.Inf29aItem_Inf29a13SoldQty - this.Inf29aItem.inf29a24_retrn_qty) + this.Inf29aItem.inf29a36_odds_amt * 1;
                    if (isNaN(amt)) {
                        return 0;
                    } else {
                        return amt;
                    }
                },
                Inf29aItem_Inf29a12SubAmt: function () { //換算後幣值小計
                    var amt = this.inf2929_exchange_rate * this.Inf29aItem.inf29a09_retail_one * (this.Inf29aItem_Inf29a13SoldQty - this.Inf29aItem.inf29a24_retrn_qty);
                    if (isNaN(amt)) {
                        return 0;
                    } else {
                        return amt;
                    }
                }
            },
            methods: {
                OnSearch: function () {

                },
                OnAdd: function () {
                    if (this.IsDpCodeDisplay) {
                        return;
                    }
                    console.log("OnAdd");
                    this.Reset();
                },
                OnAddInf29aItem: function (defaultSeq) {//輸入明細
                    var vueObj = this;
                    if ((this.Inf29aItem.inf29a05_pcode || "") == "") {
                        return;
                    }
                    // update
                    if(this.Inf29aItem.inf29a02_seq != null){
                        var inf29a = this.Inf29aList.filter(function(item, index, array){
                            return item.inf29a02_seq == vueObj.Inf29aItem.inf29a02_seq;
                        }).shift();
                        this.SelectedInf29aItem = {
                            inf29a02_seq: this.Inf29aItem.inf29a02_seq,
                            inf29a04_sizeno:this.Inf29aItem.inf29a04_sizeno,//尺碼
                            inf29a05_pcode: this.Inf29aItem.inf29a05_pcode,
                            inf29a05_shoes_code: this.Inf29aItem.inf29a05_shoes_code, //貨號
                            inf29a06_qty: this.Inf29aItem.inf29a06_qty,//小單位數量
                            inf29a09_retail_one: this.Inf29aItem.inf29a09_retail_one,//換算後幣值售價
                            inf29a09_oretail_one:this.Inf29aItem.inf29a09_oretail_one, //售價
                            inf29a10_ocost_one: this.Inf29aItem.inf29a10_ocost_one, //原進價
                            inf29a10_cost_one0:this.Inf29aItem.inf29a10_cost_one0,//未稅單價
                            inf29a10_cost_one: this.Inf29aItem.inf29a10_cost_one, //換算後幣值進價
                            inf29a11_dis_rate: 100, //折扣
                            inf29a14_trn_type: "1", //1表示自行輸入的資料
                            //inf29a31_currency: this.Inf29aItem.SelectedCurrencyInfo == null ? "" : this.Inf29aItem.SelectedCurrencyInfo.cnf1003_char01, //幣別
//                            inf29a32_exchange_rate: this.Inf29aItem.inf29a32_exchange_rate, //匯率
                            inf29a12_sub_amt: this.Inf29aItem_Inf29a12SubAmt, //換算後幣值小計
                            inf29a13_sold_qty: this.Inf29aItem_Inf29a13SoldQty, //數量
                            inf29a16_gift_qty: this.Inf29aItem.inf29a16_gift_qty,//贈品數量
                            inf29a17_runit: this.Inf29aItem.inf29a17_runit, //單位
                            inf29a22_tax_flag: this.Inf29aItem.inf29a22_tax_flag,//稅別
                            inf29a24_retrn_qty:this.Inf29aItem.inf29a24_retrn_qty, //退貨數
                            inf29a26_box_qty: this.Inf29aItem.inf29a26_box_qty, //箱入量
                            inf29a33_product_name: this.Inf29aItem.inf29a33_product_name, //商品名稱
                            inf29a36_odds_amt: this.Inf29aItem.inf29a36_odds_amt, //尾差
                            inf29a38_one_amt: this.Inf29aItem_Inf29a38OneAmt, //小計金額
                            inf29a39_price: this.Inf29aItem.inf29a39_price, //售價
                            inf29a40_tax: this.Inf29aItem.inf29a40_tax, //營業稅率
                            inf29a41_pcat: this.Inf29aItem.inf29a41_pcat, //商品分類編號
                            inf29a49_tax: this.Inf29aItem.inf29a49_tax,//營業稅
                            inf0164_dividend: this.Inf29aItem.inf0164_dividend,//換算值
                            adduser:this.Inf29aItem.adduser,
                            adddate: this.Inf29aItem.adddate,
                            remark: this.Inf29aItem.remark,
                            
                        };
                        var inf29aIndex = this.Inf29aList.indexOf(inf29a);
                        this.Inf29aList.splice(inf29aIndex,1,this.SelectedInf29aItem);
                        // deselect
                        this.OnRowClick(this.SelectedInf29aItem);
                        return;
                    }
                    var inf29a02_seq = defaultSeq || this.Inf29aList.length;
                    for (var i in this.Inf29aList) {
                        if (this.Inf29aList[i].inf29a02_seq == inf29a02_seq) {
                            return this.OnAddInf29aItem(inf29a02_seq + 1);
                        }
                    }
                    this.Inf29aList.push({
                        inf29a02_seq: inf29a02_seq,
                        inf29a04_sizeno: this.Inf29aItem.inf29a04_sizeno,//尺碼
                        inf29a05_pcode: this.Inf29aItem.inf29a05_pcode,
                        inf29a05_shoes_code: this.Inf29aItem.inf29a05_shoes_code, //貨號
                        inf29a06_qty: this.Inf29aItem.inf29a06_qty,//小單位數量
                        inf29a09_retail_one: this.Inf29aItem.inf29a09_retail_one,//換算後幣值售價
                        inf29a09_oretail_one: this.Inf29aItem.inf29a09_oretail_one, //售價
                        inf29a10_ocost_one: this.Inf29aItem.inf29a10_ocost_one, //原進價
                        inf29a10_cost_one: this.Inf29aItem.inf29a10_cost_one, //換算後幣值進價
                        inf29a10_cost_one0: this.Inf29aItem.inf29a10_cost_one0,//未稅單價
                        inf29a11_dis_rate: 100, //折扣
                        inf29a14_trn_type: this.Inf29aItem.inf29a14_trn_type || "1", //1表示自行輸入的資料
                        //inf29a31_currency: this.Inf29aItem.SelectedCurrencyInfo == null ? "" : this.Inf29aItem.SelectedCurrencyInfo.cnf1003_char01, //幣別
                        //inf29a32_exchange_rate: this.Inf29aItem.inf29a32_exchange_rate, //匯率
                        inf29a12_sub_amt: this.Inf29aItem_Inf29a12SubAmt, //換算後幣值小計
                        inf29a13_sold_qty: this.Inf29aItem_Inf29a13SoldQty, //數量
                        inf29a16_gift_qty: this.Inf29aItem.inf29a16_gift_qty,//贈品數量
                        inf29a17_runit: this.Inf29aItem.inf29a17_runit, //單位
                        inf29a22_tax_flag: this.Inf29aItem.inf29a22_tax_flag,//稅別
                        inf29a24_retrn_qty: this.Inf29aItem.inf29a24_retrn_qty,//退貨數
                        inf29a26_box_qty: this.Inf29aItem.inf29a26_box_qty, //箱入量
                        inf29a33_product_name: this.Inf29aItem.inf29a33_product_name, //商品名稱
                        inf29a36_odds_amt: this.Inf29aItem.inf29a36_odds_amt, //尾差
                        inf29a38_one_amt: this.Inf29aItem_Inf29a38OneAmt, //小計金額
                        inf29a39_price: this.Inf29aItem.inf29a39_price, //售價
                        inf29a40_tax: this.Inf29aItem.inf29a40_tax, //營業稅率
                        inf29a41_pcat: this.Inf29aItem.inf29a41_pcat, //商品分類編號
                        inf29a49_tax: this.Inf29aItem.inf29a49_tax,
                        inf0164_dividend: this.Inf29aItem.inf0164_dividend,//換算值
                        adduser: this.Inf29aItem.adduser,
                        adddate: this.Inf29aItem.adddate,
                        remark: this.Inf29aItem.remark,
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
                OnRowClick: function (inf29aItem) {
                    if(this.SelectedInf29aItem == inf29aItem){
                        this.ResetInf29a();
                    } else {
                        this.SelectedInf29aItem = inf29aItem;
                        //var currencyInfo = this.CurrencyList.filter(function(item, index, array){
                        //    return item.cnf1003_char01==inf29aItem.inf29a31_currency;
                        //}).shift();
                        this.Inf29aItem = {
                            inf29a02_seq:inf29aItem.inf29a02_seq,//序號
                            inf29a04_sizeno:inf29aItem.inf29a04_sizeno,//尺碼
                            inf29a05_pcode: inf29aItem.inf29a05_pcode, //產品編號
                            inf29a05_shoes_code: inf29aItem.inf29a05_shoes_code, //貨號
                            inf29a09_retail_one: inf29aItem.inf29a09_retail_one,//換算後幣值售價
                            inf29a09_oretail_one: inf29aItem.inf29a09_oretail_one, //售價
                            inf29a17_runit: inf29aItem.inf29a17_runit, //單位
                            inf29a10_ocost_one: inf29aItem.inf29a10_ocost_one, //原進價
                            inf29a10_cost_one: inf29aItem.inf29a10_cost_one, //換算後幣值進價
                            inf29a10_cost_one0: inf29aItem.inf29a10_cost_one0,//未稅單價
                            inf29a22_tax_flag: inf29aItem.inf29a22_tax_flag,//稅別
                            inf29a24_retrn_qty: inf29aItem.inf29a24_retrn_qty,//退貨數
                            inf29a26_box_qty:inf29aItem.inf29a26_box_qty,//箱入量
                            //SelectedCurrencyInfo: currencyInfo, //幣別
//                            inf29a32_exchange_rate: inf29aItem.inf29a32_exchange_rate, //匯率
                            inf29a33_product_name: inf29aItem.inf29a33_product_name, //商品名稱
                            inf29a39_price: inf29aItem.inf29a39_price, //售價
                            inf29a40_tax:inf29aItem.inf29a40_tax,//營業稅率
                            inf29a41_pcat:inf29aItem.inf29a41_pcat,//商品分類編號
                            inf29a13_sold_qty: inf29aItem.inf29a13_sold_qty, //數量
                            inf29a36_odds_amt: inf29aItem.inf29a36_odds_amt, //尾差
                            adddate: inf29aItem.adddate,
                            adduser: inf29aItem.adduser,
                            moddate: inf29aItem.moddate,
                            moduser: inf29aItem.moduser,
                            Confirmed: inf29aItem.Confirmed, //確認
                        };
                    }
                },
                OnCopy: function () {

                },
                OnSave: function () {

                    if(this.Inf29Copy== JSON.stringify(this.Inf29Item) + JSON.stringify(this.Inf29aList)){
                        alert("您未修改任何欄位，所以不與存檔");
                        return;
                    }
                    if(this.Inf29Item.BCodeInfo==null){
                        alert("公司代號不允許空白，請重新輸入");
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
                    for (var i in this.Inf29aList) {
                        var inf29a = this.Inf29aList[i];
                        if(inf29a.Confirmed =="N"){
                            alert("請先確認所有項目");
                            return;
                        }
                    }
                    var inf29Item = {
                        inf2901_bcode: this.Inf29Item.BCodeInfo.cnf0701_bcode, //公司代號相關資料
                        inf2902_docno_type: this.Inf29Item.inf2902_docno_type, //單據分類編號. 組成異動單號
                        inf2902_docno_date: inf2902_docno_date, //異動單號_日期. 組成異動單號
                        inf2903_customer_code: this.Inf29Item.inf2903_customer_code, //客戶代碼
                        inf2904_pro_date: this.Inf29Item.inf2904_pro_date, //異動日期
                        inf2906_wherehouse: this.Inf29Item.SelectedWherehouse.cnf1002_fileorder, //倉庫代號
                        inf2906_ref_no_type: this.Inf29Item.inf2906_ref_no_type || "", //單據來源
                        inf2906_ref_no_date: inf2906_ref_no_date, //單據來源
                        inf2906_ref_no_seq: this.Inf29Item.inf2906_ref_no_seq || 0, //單據來源
                        inf2910_in_reason: this.Inf29Item.SelectedInReason.cnf1002_fileorder, //異動代號
                        inf2911_sub_amt: this.TotalPrice,//總金額
                        inf2935_total:this.TotalAmount,//總數量
                        inf2914_inv_eff: this.Inf29Item.SelectedInReason.cnf1008_dec01, //庫存影響方向
                        inf2916_apr_empid: this.Inf29Item.inf2916_apr_empid || "", //員工ID
                        inf2909_vcode: this.Inf29Item.inf2909_vcode || "", //代送商
                        inf2928_currency: this.Inf29Item.SelectedCurrencyInfo == null ? "" : this.Inf29Item.SelectedCurrencyInfo.cnf1003_char01, //幣別
                        inf2929_exchange_rate: this.Inf29Item.inf2929_exchange_rate || 0,
                        inf2921_pmonth: this.Inf29Item.inf2921_pmonth,
                        inf2951_allowances: this.Inf29Item.inf2951_allowances,
                        inf2952_project_no: this.Inf29Item.inf2952_project_no,
                        remark: this.Inf29Item.remark || "",
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
                                alert("存檔失敗");
                            } else {
                                vueObj.Inf29Item.id = inf29Item.id;
                                vueObj.Inf29Item.inf2902_docno_seq = inf29Item.inf2902_docno_seq;
                            }
                            LoadingHelper.hideLoading();
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
                OnPrint: function () {
                    var vueObj = this;
                    var bcodeInfo = this.Inf29Item.BCodeInfo;
                    var inf29idList = [];
                    if(this.Inf29Item.id){
                        inf29idList.push(this.Inf29Item.id)
                    }
                    if(inf29idList.length==0){
                        alert("列印前請先存檔");
                        return;
                    }
                    LoadingHelper.showLoading();
                    return $.ajax({
                        type: 'POST',
                        url: rootUrl + "Dinp/Ajax/Inf29Handler.ashx",
                        cache: false,
                        data: {
                            act: "print",
                            data:JSON.stringify(inf29idList),
                            printBcode:JSON.stringify(bcodeInfo),
                        },
                        dataType: 'text',
                        success: function (result) {
                            if (result == "ok") {
                                printJS({printable: rootUrl + "Dinp/Ajax/Inf29Print.ashx",
                                    type: 'pdf',
                                    onLoadingStart:null,
                                    onLoadingEnd:LoadingHelper.hideLoading});
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
                    vueObj.Inf29aItem.inf29a10_ocost_one = parseFloat(productInfo.cost).toFixed(2);
                    vueObj.Inf29aItem.inf29a10_cost_one0 = parseFloat(productInfo.cost_notax).toFixed(2);
                    vueObj.Inf29aItem.inf29a39_price = parseFloat(productInfo.retail).toFixed(2);
                    vueObj.Inf29aItem.inf29a09_oretail_one = vueObj.Inf29aItem.inf29a39_price;
                    vueObj.Inf29aItem.inf29a17_runit = productInfo.runit;
                    vueObj.Inf29aItem.inf29a26_box_qty = productInfo.pqty_o;
                    vueObj.Inf29aItem.inf29a33_product_name = productInfo.psname;
                    vueObj.Inf29aItem.inf29a40_tax = productInfo.tax;
                    vueObj.Inf29aItem.inf29a22_tax_flag = productInfo.tax_flag;
                    vueObj.Inf29aItem.inf29a41_pcat = productInfo.pcat;
                    vueObj.Inf29aItem.inf29a04_sizeno = productInfo.size;
                    vueObj.inf29a38_one_amt = vueObj.Inf29aItem_Inf29a38OneAmt;
                    vueObj.Inf29aItem.inf0164_dividend = productInfo.dividend;
                    if (parseFloat(productInfo.cost) == 0) {
                        if (confirm("您確定進價 = 0，回是(Y)繼續作業，回否(N)請修正進價")) {
                        }
                    }
                    if (vueObj.Inf29aItem.inf29a22_tax_flag == "1") {
                        vueObj.Inf29aItem.inf29a49_tax =
                            (vueObj.Inf29aItem.inf29a38_one_amt / (1 + vueObj.Inf29aItem.inf29a40_tax)) * vueObj.Inf29aItem.inf29a40_tax;
                        if (isNaN(vueObj.Inf29aItem.inf29a49_tax)) {
                            vueObj.Inf29aItem.inf29a49_tax = 0;
                        }
                    } else {
                        vueObj.Inf29aItem.inf29a49_tax = 0;
                    }
                    //TODO also on currency change
                    if (vueObj.Inf29Item.SelectedCurrencyInfo == null) {
                        vueObj.Inf29aItem.inf29a10_cost_one = vueObj.Inf29aItem.inf29a10_ocost_one;
                        vueObj.Inf29aItem.inf29a09_oretail_one = vueObj.Inf29aItem.inf29a39_price;
                    } else {
                        vueObj.Inf29aItem.inf29a10_cost_one =
                            (vueObj.Inf29aItem.inf29a10_ocost_one * vueObj.Inf29Item.inf2929_exchange_rate).toFixed(2);
                        vueObj.Inf29aItem.inf29a09_retail_one =
                            (vueObj.Inf29aItem.inf29a09_oretail_one * vueObj.Inf29Item.inf2929_exchange_rate).toFixed(2);
                    }
                },
                OnExit: function () {
                    if (this.IsDpCodeDisplay
                        || $(this.$refs.HelpDialog).hasClass('in')) {
                        return;
                    }
                    this.Display = false;
                    window.dinp02101Search.Display = true;
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
                    this.Inf29aList.sort(this.SortList);
                },
                SortList: function (a, b) {
                    var paramA = a[this.SortColumn] || "";
                    var paramB = b[this.SortColumn] || "";
                    if (paramA < paramB) {
                        return this.SortOrder == 'asc' ? -1 : 1;
                    }
                    if (paramA > paramB) {
                        return this.SortOrder == 'asc' ? 1 : -1;
                    }
                    if (a["id"] < b["id"]) {
                        return this.SortOrder == 'asc' ? -1 : 1;

                    }
                    if (a["id"] > b["id"]) {
                        return this.SortOrder == 'asc' ? 1 : -1;
                    }
                    return 0;
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
                                vueObj.Inf29aItem.inf29a10_cost_one0 = parseFloat(productInfo.cost_notax).toFixed(2);
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
                                        (vueObj.Inf29aItem.inf29a10_ocost_one * vueObj.Inf29Item.inf2929_exchange_rate).toFixed(2);
                                    vueObj.Inf29aItem.inf29a09_retail_one =
                                        (vueObj.Inf29aItem.inf29a09_oretail_one * vueObj.Inf29Item.inf2929_exchange_rate).toFixed(2);

                                }
                            }
                        });
                },
                OnCustomCodeChange: function () {
                    if(this.Inf29Item.SelectedInReason==null){
                        alert("請選擇異動代碼");
                        this.Inf29Item.inf2903_customer_code=null;
                        this.Inf29Item.Inf2903CustomerCodeName=null;
                        return;
                    }
                    //異動單位變更, 根據異動帶碼讀資料
                    var vueObj = this;
                    return $.ajax({
                        type: 'POST',
                        url: rootUrl + "Dinp/Ajax/GetCustomCodeInfo.ashx",
                        cache: false,
                        data: {
                            inReason: this.Inf29Item.SelectedInReason.cnf1002_fileorder,
                            customCode: this.Inf29Item.inf2903_customer_code
                        },
                        dataType: 'text',
                        success: function (customCodeName) {
                            if (customCodeName == null||customCodeName=="") {
                                vueObj.Inf29Item.inf2903_customer_code=null;
                                vueObj.Inf29Item.Inf2903CustomerCodeName=null;
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
                                    default:
                                        alert("異動單位不存在，請詳查");
                                        break;
                                }
                            } else {
                                switch (vueObj.Inf29Item.SelectedInReason.cnf1004_char02) {
                                    case "cmf01":
                                        vueObj.Inf29Item.Inf2903CustomerCodeName = customCodeName;
                                        break;
                                    case "cnf07":
                                        vueObj.Inf29Item.Inf2903CustomerCodeName = customCodeName;
                                        break;
                                    case "inf03":
                                        vueObj.Inf29Item.Inf2903CustomerCodeName = customCodeName;
                                        break;
                                    case "taf10":
                                        vueObj.Inf29Item.Inf2903CustomerCodeName = customCodeName;
                                        break;
                                    case "cnf10":
                                        vueObj.Inf29Item.Inf2903CustomerCodeName = customCodeName;
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
                GetTotalQty: function (inf29Item) {
                    return 123;
                },
                GetInReasonName: function (inReason) {
                    return "inReason";
                },
                GetCustomerName: function (customerCode) {
                    return "customerCode";
                },
                GetVenderInfo:function(vCode) {
                    if (vCode == null || vCode == "") {
                        return;
                    }
                    var vueObj = this;
                    return $.ajax({
                        type: 'GET',
                        url: rootUrl + "Dinp/Ajax/GetVendorInfo.ashx",
                        cache: false,
                        data: {
                            vCode: vCode,
                        },
                        dataType: 'text',
                        success: function (venderInfoJson) {
                            if (venderInfoJson == null || venderInfoJson == "") {
                                vueObj.Inf29Item.inf0303_fname = null;
                                alert("廠商代號不存在於廠商基本資料檔中，請重新輸入");
                            } else {
                                var venderInfo = JSON.parse(venderInfoJson);
                                vueObj.Inf29Item.inf0303_fname = venderInfo.inf0303_fname;
                            }
                        },
                        error: function (jqXhr, textStatus, errorThrown) {
                            if (jqXhr.status == 0) {
                                return;
                            }
                            LoadingHelper.hideLoading();
                            console.error(errorThrown);
                            alert("查詢廠商代號失敗");
                        }
                    });
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
                                vueObj.Inf29Item.inf2952_project_no=null;
                                vueObj.Inf29Item.ProjectFullname=null;
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
                                vueObj.Inf29Item.inf2916_apr_empid = null;
                                vueObj.Inf29Item.EmpCname = null;
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
                            
                        },
                        error: function (jqXhr, textStatus, errorThrown) {
                            if (jqXhr.status == 0) {
                                return;
                            }
                            LoadingHelper.hideLoading();
                            console.error(errorThrown);
                        }
                    });
                },
                SetCopy:function(inf29){
                    var vueObj = this;
                    var now = new Date();
                    var asyncTasks = [];
                    LoadingHelper.showLoading();
                    if(inf29.inf2906_ref_no_date==null){
                        inf29.inf2906_ref_no_date="";
                    }
                    var currencyInfo = this.CurrencyList.filter(function(item, index, array){
                        return item.cnf1003_char01 == inf29.inf2928_currency;
                    }).shift();
                    this.Inf29Item = {
                        BCodeInfo: null, //公司代號相關資料
                        inf2902_docno_type: "SI", //單據分類編號. 組成異動單號
                        inf2902_docno_date: now.dateFormat("Ymd"), //異動單號_日期. 組成異動單號
                        inf2904_pro_date: now.dateFormat(this.UiDateFormat), //異動日期
                        inf2902_docno_seq:null,//異動單號_流水號, 儲存成功後從伺服器返回
                        SelectedWherehouse: null, //選中的倉庫代號
                        inf2909_vcode: inf29.inf2909_vcode, //代送商
                        ProjectFullname: null, //專案全名
                        inf2916_apr_empid: inf29.inf2916_apr_empid, //員工ID
                        EmpCname: null, //員工Name
                        inf2903_customer_code: inf29.inf2903_customer_code, //客戶代碼
                        Inf2903CustomerCodeName: inf29.Inf2903CustomerCodeName, //異動單位
                        inf2906_ref_no_type: inf29.inf2906_ref_no_type, //單據來源
                        inf2906_ref_no_date: inf29.inf2906_ref_no_date.startsWith("1900")?"":inf29.inf2906_ref_no_date, //單據來源
                        inf2906_ref_no_seq: inf29.inf2906_ref_no_seq, //單據來源
                        inf2910_in_reason: inf29.inf2910_in_reason, //異動代號
                        inf2921_pmonth: inf29.inf2921_pmonth,//所屬帳款月份
                        inf2928_currency: inf29.inf2928_currency, //幣別
                        inf2929_exchange_rate: inf29.inf2929_exchange_rate, //匯率
                        inf2951_allowances: inf29.inf2951_allowances, //匯率
                        SelectedInReason: null, //異動代號
                        SelectedCurrencyInfo: currencyInfo, //幣別
                        remark: inf29.remark,
                        adddate: now.dateFormat(this.UiDateFormat),
                        adduser: loginUserName,
                    };
                    this.Inf29Item.BCodeInfo = this.BcodeList.filter(function(item, index, array){
                        return item.cnf0701_bcode == inf29.inf2901_bcode;
                    }).shift();
                    this.Inf29Item.SelectedWherehouse = this.WherehouseList.filter(function(item, index, array){
                        return item.cnf1002_fileorder == inf29.inf2906_wherehouse;
                    }).shift();
                    this.Inf29Item.SelectedInReason = this.InReasonList.filter(function(item, index, array){
                        return item.cnf1002_fileorder == inf29.inf2910_in_reason;
                    }).shift();
                    
                    if(inf29.inf2916_apr_empid!= null && inf29.inf2916_apr_empid!=''){
                        this.GetEmpCname(inf29.inf2916_apr_empid);
                    }

                    asyncTasks.push(this.GetInf29aList(inf29.inf2901_docno).done(function(inf29aListJson){
                        var now = new Date();
                        var inf29aList = JSON.parse(inf29aListJson);
                        for (var i in inf29aList) {
                            var inf29a = inf29aList[i];
                            vueObj.Inf29aList.push({
                                inf29a02_seq: i,
                                inf29a04_sizeno:inf29a.inf29a04_sizeno,//尺碼
                                inf29a05_pcode: inf29a.inf29a05_pcode,
                                inf29a05_shoes_code: inf29a.inf29a05_shoes_code, //貨號
                                inf29a09_retail_one: inf29a.inf29a09_retail_one,//換算後幣值售價
                                inf29a09_oretail_one: inf29a.inf29a09_oretail_one, //售價
                                inf29a10_ocost_one: inf29a.inf29a10_ocost_one, //原進價
                                inf29a10_cost_one: inf29a.inf29a10_cost_one, //換算後幣值進價
                                inf29a11_dis_rate: inf29a.inf29a11_dis_rate || 100, //折扣
                                inf29a14_trn_type: inf29a.inf29a14_trn_type || "1", //1表示自行輸入的資料
                                ////inf29a31_currency: inf29a.inf29a31_currency, //幣別
//                                inf29a32_exchange_rate: inf29a.inf29a32_exchange_rate, //匯率
                                inf29a39_price: inf29a.inf29a39_price, //售價
                                inf29a38_one_amt: inf29a.inf29a38_one_amt, //小計金額
                                inf29a12_sub_amt: inf29a.inf29a12_sub_amt, //換算後幣值小計
                                inf29a13_sold_qty: inf29a.inf29a13_sold_qty, //數量
                                inf29a16_gift_qty: inf29a.inf29a16_gift_qty,//贈品數量
                                inf29a17_runit: inf29a.inf29a17_runit, //單位
                                inf29a22_tax_flag: inf29a.inf29a22_tax_flag,//稅別
                                inf29a24_retrn_qty: inf29a.inf29a24_retrn_qty,//退貨數
                                inf29a26_box_qty: inf29a.inf29a26_box_qty, //箱入量
                                inf29a33_product_name: inf29a.inf29a33_product_name, //商品名稱
                                inf29a36_odds_amt: inf29a.inf29a36_odds_amt, //尾差
                                inf29a40_tax: inf29a.inf29a40_tax, //營業稅率
                                inf29a41_pcat: inf29a.inf29a41_pcat, //商品分類編號
                                adduser:loginUserName,
                                adddate:now.dateFormat(vueObj.UiDateFormat)
                            });
                        }
                    }));
                    // 所有資料取完後用JSON備份, 用來檢查是否後續有被使用者修改
                    $.when.apply($, asyncTasks).then(function(){
                        LoadingHelper.hideLoading();
                        vueObj.Inf29Copy = JSON.stringify(vueObj.Inf29Item) + JSON.stringify(vueObj.Inf29aList);
                    });
                },
                Reset: function () {
                    var asyncTasks = [];
                    var defaultBCodeInfo = this.BcodeList.filter(function(item, index, array){
                        return item.cnf0751_tax_headoffice=="0";
                    }).shift();
                    var defaultCurrency = this.CurrencyList.filter(function (item, index, array) {
                        return item.cnf1003_char01 == "NTD";
                    }).shift();
                    this.Inf29Item = {
                        id:null,//儲存成功後從伺服器返回
                        BCodeInfo: defaultBCodeInfo, //公司代號相關資料
                        inf2902_docno_type: "SI", //單據分類編號. 組成異動單號
                        inf2902_docno_date: null, //異動單號_日期. 組成異動單號
                        inf2904_pro_date: null, //異動日期
                        inf2902_docno_seq:null,//異動單號_流水號, 儲存成功後從伺服器返回
                        SelectedWherehouse: null, //選中的倉庫代號
                        inf2909_vcode: null, //代送商
                        inf0303_fname: null, //廠商全名
                        ProjectFullname: null, //專案全名
                        inf2916_apr_empid: null, //員工ID
                        EmpCname: null, //員工Name
                        inf2903_customer_code: "", //客戶代碼
                        Inf2903CustomerCodeName: null, //異動單位
                        inf2906_ref_no_type: null, //單據來源
                        inf2906_ref_no_date: null, //單據來源
                        inf2906_ref_no_seq: null, //單據來源
                        SelectedInReason: null, //異動代號
                        inf2910_in_reason: null, //異動代號
                        inf2921_pmonth: null,//所屬帳款月份
                        SelectedCurrencyInfo: defaultCurrency, //幣別
                        inf2929_exchange_rate: 1, //匯率
                        inf2002_docno_type: null,//單據分類編號
                        inf2002_docno_date: null,//異動單號_日期
                        inf2002_docno_seq: null,//異動單號_流水號
                        inf2951_allowances: 0,//折讓金額
                        inf2952_project_no: "",
                        remark: "",
                        adddate: null,
                        adduser: null,
                        moddate: null,
                        moduser: null,
                    };
                    if (defaultCurrency) {
                        asyncTasks.push(this.GetExchangeInfo(defaultCurrency));
                    }
                    this.Inf29Item.adduser = loginUserName;
                    this.Inf29Item.inf2916_apr_empid = loginUserName;
                    this.Inf29Copy = null;

                    var now = new Date();
                    this.Inf29Item.inf2902_docno_date = now.dateFormat("Ymd");
                    this.Inf29Item.inf2904_pro_date = now.dateFormat(this.UiDateFormat);
                    this.Inf29Item.adddate = now.dateFormat(this.UiDateFormat);
                    this.Inf29aList = [];
                    this.ResetInf29a();
                    return $.when.apply($, asyncTasks);
                },
                ResetInf29a:function(){
//                    var defaultCurrency = this.CurrencyList.filter(function(item, index, array){
//                        return item.cnf1003_char01=="NTD";
//                    }).shift();
                    this.Inf29aItem = {
                        inf29a02_seq: null,//序號
                        inf29a04_sizeno: null,//尺碼
                        inf29a05_pcode: null, //產品編號
                        inf29a05_shoes_code: null, //貨號
                        inf29a06_qty: 0,//小單位數量
                        inf29a09_retail_one: 0,//換算後幣值售價
                        inf29a09_oretail_one: 0, //售價
                        inf29a10_ocost_one: 0, //含稅單價
                        inf29a10_cost_one0: 0, //未稅單價
                        inf29a10_cost_one: 0, //換算後幣值進價
                        inf29a13_sold_qty: 0,//大單位數量
                        inf29a16_gift_qty: 0,//贈品數量
                        inf29a17_runit: "", //單位
                        inf29a22_tax_flag: "",//稅別
                        inf29a24_retrn_qty: 0,//退貨數
                        inf29a26_box_qty: 0,//箱入量
                        //                    SelectedCurrencyInfo: null, //幣別
                        //                    inf29a32_exchange_rate: 1, //匯率
                        inf29a33_product_name: null, //商品名稱
                        inf29a36_odds_amt: 0, //尾差
                        inf29a39_price: 0, //售價
                        inf29a40_tax: 0,//營業稅率
                        inf29a41_pcat: null,//商品分類編號
                        inf29a49_tax: 0,//營業稅
                        inf0164_dividend: 0,
                        adddate: null,
                        adduser: null,
                        moddate: null,
                        moduser: null,
                        Confirmed: "N", //確認
                        remark: "",
                    };
                    
//                    if(defaultCurrency){
//                        this.GetExchangeInfo(defaultCurrency);
//                    }
                    this.SelectedInf29aItem = null;
                    this.Inf29aItem.adduser = loginUserName;
                    var now = new Date();
                    this.Inf29aItem.adddate = now.dateFormat(this.UiDateFormat);
                },
                OnInputPo: function () {
                    var vueObj = this;
                    if ((this.Inf29Item.inf2906_ref_no_type || "") == "" ||
                        (this.Inf29Item.inf2906_ref_no_date || "") == "" ||
                        (this.Inf29Item.inf2906_ref_no_seq || "") == "") {
                        alert("採購單轉入失敗");
                        return;
                    }
                    LoadingHelper.showLoading();
                    return $.ajax({
                        type: 'GET',
                        url: rootUrl + "Dinp/Ajax/GetPoInfo.ashx",
                        cache: false,
                        data: {
                            docnoType: this.Inf29Item.inf2906_ref_no_type,
                            docnoDate: this.Inf29Item.inf2906_ref_no_date,
                            docnoSeq: this.Inf29Item.inf2906_ref_no_seq
                        },
                        dataType: 'text',
                        success: function (poInfoJson) {
                            LoadingHelper.hideLoading();
                            if (poInfoJson == "") {
                                alert("查無單號");
                                return;
                            }
                            var poInfo = JSON.parse(poInfoJson);
                            vueObj.Inf29Item.inf2903_customer_code = poInfo.inf2006_mcode;
                            vueObj.Inf29Item.inf2901_bcode = poInfo.inf2001_bcode;
                            vueObj.Inf29Item.BCodeInfo = vueObj.BcodeList.filter(function (item, index, array) {
                                return item.cnf0701_bcode == poInfo.inf2001_bcode;
                            }).shift();
                            vueObj.Inf29Item.inf2909_vcode = poInfo.inf2006_mcode;
                            vueObj.Inf29Item.inf2911_sub_amt = poInfo.inf2039_one_amt;
                            vueObj.Inf29Item.inf2913_pay_term = poInfo.inf2053_account_type;
                            vueObj.Inf29Item.inf2921_pmonth = poInfo.inf2034_pay_yymm;
                            try {
                                vueObj.$refs.PMonth.setValue(new Date(vueObj.Inf29Item.inf2921_pmonth).dateFormat(this.UiDateFormat));
                            } catch(e) {
                                console.error(e);
                            } 
                            vueObj.Inf29Item.inf2924_apply_date = poInfo.inf2904_pro_date;
                            vueObj.Inf29Item.inf2927_mcode = vueObj.Inf29Item.inf2909_vcode;
                            vueObj.Inf29Item.inf2928_currency = poInfo.inf2024_currency;
                            var currencyInfo = vueObj.CurrencyList.filter(function (item, index, array) {
                                return item.cnf1003_char01 == poInfo.inf2024_currency;
                            }).shift();
                            vueObj.Inf29Item.SelectedCurrencyInfo = currencyInfo;
                            vueObj.Inf29Item.inf2929_exchange_rate = poInfo.inf2025_exchnge_rate;
                            vueObj.Inf29Item.inf2933_rec_customer_code = poInfo.inf2040_payto;
                            vueObj.Inf29Item.inf2934_delivery_place = poInfo.inf2033_delivery_place;
                            vueObj.Inf29Item.inf2937_tax = poInfo.inf2047_tax;
                            vueObj.Inf29Item.inf2945_recid = poInfo.inf2037_recid;
                            vueObj.Inf29Item.inf2952_project_no = poInfo.inf2042_project_no;

                            for (var i in poInfo.Inf20aList) {
                                var inf20a = poInfo.Inf20aList[i];
                                vueObj.Inf29aItem.inf29a05_pcode = inf20a.inf20a04_pcode;
                                vueObj.Inf29aItem.inf29a05_shoes_code = inf20a.inf20a57_pclass;
                                vueObj.Inf29aItem.inf29a08_mcode = inf20a.inf20a05_mcode;
                                vueObj.Inf29aItem.inf29a09_oretail_one = inf20a.inf20a08_oretail;
                                vueObj.Inf29aItem.inf29a09_retail_one = inf20a.inf20a08_retail;
                                vueObj.Inf29aItem.inf29a10_ocost_one = inf20a.inf20a07_ocost;
                                vueObj.Inf29aItem.inf29a11_dis_rate = inf20a.inf20a10_dis_rate;
                                vueObj.Inf29aItem.inf29a13_sold_qty = inf20a.inf20a06_qty;
                                vueObj.Inf29aItem.inf29a14_trn_type = "100";
                                vueObj.Inf29aItem.inf29a16_gift_qty = inf20a.inf20a12_dis_qty;
                                vueObj.Inf29aItem.inf29a17_runit = inf20a.inf20a16_punit;
                                vueObj.Inf29aItem.inf29a19_vcode = inf20a.inf20a50_vcode;
                                vueObj.Inf29aItem.inf29a22_tax_flag = inf20a.inf20a24_tax;
                                vueObj.Inf29aItem.inf29a31_currency = inf20a.inf20a36_currency;
                                vueObj.Inf29aItem.inf29a32_exchange_rate = inf20a.inf20a37_exchnge_rate;
                                vueObj.Inf29aItem.inf29a36_odds_amt = inf20a.inf20a39_odds_amt;
                                vueObj.Inf29aItem.inf29a37_magazine_no = inf20a.inf20a29_magazine_no;
                                vueObj.Inf29aItem.inf29a38_one_amt = inf20a.inf20a40_one_amt;
                                vueObj.Inf29aItem.inf29a39_price = inf20a.inf20a07_ocost;
                                vueObj.Inf29aItem.inf29a40_tax = inf20a.inf20a41_tax;

                                vueObj.OnAddInf29aItem();
                            }

                        },
                        error: function (jqXhr, textStatus, errorThrown) {
                            if (jqXhr.status == 0) {
                                return;
                            }
                            LoadingHelper.hideLoading();
                            console.error(errorThrown);
                            alert("採購單轉入失敗");
                        }
                    });
                },
                OnSearchPo:function() {
                    alert("not implement");
                }
            },
            directives: {
                "modal-show-focus":{
                    bind:function(el,binding){
                        $(el).on("shown.bs.modal",function(){
                            $(this).find("iframe").focus();
                        });
                    },
                    unbind:function(el){
                        $(el).off("shown.bs.modal");
                    }
                },
                "float-thead": {
                    inserted: function (el, binding) {
                        $(el).floatThead({
                            scrollContainer: function ($table) {
                                return $table.closest('.wrapper');
                            },
                            zIndex: 0
                        });
                    },
                    unbind: function (el) {
                        $(el).floatThead('destroy');
                    }
                }
            },
            mounted: function () {
                this.Reset();
            }
        });
    }

    function onError(error) {
        console.error(error);
    }

    define(requiredFiles, onLoaded, onError);

})();