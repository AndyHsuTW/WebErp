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
        "d_pcode"
    ];

    function onLoaded(bootstrap,
        functionButton,
        vueDatetimepicker,
        loadingHelper,
        jqueryMousewheel,
        vueMultiselect,
        printJs,
        dPcode) {
        if (vueMultiselect == null) {
            console.error("vueMultiselect fallback");
            vueMultiselect = window.VueMultiselect;
        }
        window.dsap02101Edit = new Vue({
            el: "#Dinp02301Edit",
            data: {
                Edit: false,
                newSaf21aList:[],
                Display: false,
                IsAppBodyDisplay: true,
                IsDpCodeDisplay: false,
                Saf21Item: {
                    id: null,
                    BCodeInfo: null,
                    saf2101_bcode: null,
                    saf2101_docno: null,
                    status: null,
                    saf2101_docno_type: "OA",
                    saf2101_docno_date: null,
                    saf2101_docno_orderno: null,
                    saf2106_order_date: null,
                    saf2156_take_no: null,
                    saf2108_customer_code: null,
                    saf2128_currency: null,
                    saf2150_one_amt: null,
                    saf2134_p_po_time: null,
                    saf2147_recid: null,
                    cmf01a23_cellphone: null,
                    cmf01a17_telo1: null,
                    saf2114_payment: null,
                    cmf0103_bname: null,
                    cnf1003_char01: null,
                    saf2129_exchange_rate: null,
                    saf2110_del_date: null,
                    saf2123_delivery_place_no: null,
                    cmf0110_oaddress: null,
                    cmf01a05_fname: null,
                    remark: null,
                    adduser: null,
                    adddate: null,
                    moduser: null,
                    moddate: null,
                    verifyuser: null,
                    verifydate: null,

                },
                Saf21aItem: {
                    id:null,
                    saf21a02_pcode: null,
                    saf21a03_relative_no: null,
                    saf21a41_product_name: null,
                    saf21a37_utax_price: null,
                    saf21a43_runit: null,
                    saf21a55_cost: null,
                    saf21a12_tax_type: null,
                    saf21a13_tax: null,
                    saf21a11_unit_price: null,
                    saf21a61_chng_price: null,
                    saf2129_exchange_rate: null,
                    saf21a16_total_qty: null,
                    saf21a49_odds_amt: null,
                    saf21a62_chg_sub: null,
                    saf2140_docno_seq: null,
                    saf21a56_box_qty: null,
                    saf21a51_gift_qty: null,
                    inf0164_dividend: null,
                    saf21a57_qty: null,
                    saf21a02_seq: null,
                    Remark: null,
                    saf21a38_discount: null,
                    saf21a63_chg_tax: null,
                    saf20a64_chg_sum: null,
                    adduer: null,
                    adddate: null,
                    modifiuser: null,
                    modifidate: null,
                    beenMod: false
                },
                Inf29Item: {
                    id: null,//儲存成功後從伺服器返回
                    BCodeInfo: null, //公司代號相關資料
                    inf2902_docno_type: "XC", //單據分類編號. 組成異動單號
                    inf2902_docno_date: null, //異動單號_日期. 組成異動單號
                    inf2904_pro_date: null, //異動日期
                    inf2902_docno_seq: null,//異動單號_流水號, 儲存成功後從伺服器返回
                    SelectedWherehouse: null, //選中的倉庫代號
                    inf2952_project_no: null, //專案代號
                    ProjectFullname: null, //專案全名
                    inf2916_apr_empid: null, //員工ID
                    EmpCname: null, //員工Name
                    inf2903_customer_code: null, //客戶代碼
                    Inf2903CustomerCodeName: null, //異動單位
                    inf2906_ref_no_type: null, //單據來源
                    inf2906_ref_no_date: null, //單據來源
                    inf2906_ref_no_seq: null, //單據來源
                    SelectedInReason: null, //異動代號
                    inf2910_in_reason: null, //異動代號
                    SelectedCurrencyInfo: null, //幣別
                    inf2929_exchange_rate: 1, //匯率
                    remark: null,
                    adddate: null,
                    adduser: null,
                    moddate: null,
                    moduser: null,
                }, // New edit item of Inf29
                Inf29aItem: {
                    inf29a02_seq: null,//序號
                    inf29a04_sizeno: null,//尺碼
                    inf29a05_pcode: null, //產品編號
                    inf29a05_shoes_code: null, //貨號
                    inf29a09_retail_one: null,//換算後幣值售價
                    inf29a09_oretail_one: null, //售價
                    inf29a10_ocost_one: 0, //原進價
                    inf29a10_cost_one: 0, //換算後幣值進價
                    inf29a17_runit: null, //單位
                    inf29a26_box_qty: null,//箱入量
                    //                    SelectedCurrencyInfo: null, //幣別
                    //                    inf29a32_exchange_rate: 1, //匯率
                    inf29a33_product_name: null, //商品名稱
                    inf29a39_price: 0, //售價
                    inf29a40_tax: null,//營業稅率
                    inf29a41_pcat: null,//商品分類編號
                    inf29a13_sold_qty: 0, //數量
                    inf29a36_odds_amt: 0, //尾差
                    adddate: null,
                    adduser: null,
                    moddate: null,
                    moduser: null,
                    Confirmed: "N", //確認

                }, // New edit item of Inf29a
                BcodeList: [], //公司代號下拉選單資料
                WherehouseList: [], //倉庫代號下拉選單資料
                InReasonList: [], //異動代號下拉選單資料
                CurrencyList: [], //幣別下拉選單來源
                Saf21aList: [],
                Inf29aList: [], //
                UiDateFormat: "Y/m/d",
                ConfirmList: ["N", "Y"],
                SelectedSaf21aItem: null,
                SelectedInf29aItem: null, //table被選中的row
                Saf21Copy: null,
                Inf29Copy: null, //儲存複製的備份
                SortColumn: null,
                SortOrder: null,
            },
            watch: {
                Display: function (val) {
                    if (val == true) {
                        var vueObj = this;
                        Vue.nextTick(function () {
                            // DOM updated
                            vueObj.$refs.ProDate.setValue(vueObj.Saf21Item.saf2110_del_date);

                        });
                    }
                }
            },
            components: {
                Multiselect: vueMultiselect.default
            },
            computed: {
                Saf21Item_Saf2101DocNo: function () {
                    var seq = "";
                    if (this.Saf21Item.saf2101_docno) {
                        if (this.Saf21Item.saf2101_docno != "" || this.Saf21Item.saf2101_docno != null) {
                            return this.Saf21Item.saf2101_docno
                        }
                    }
                     else {
                        if (this.Saf21Item.saf2101_docno_orderno == null || this.Saf21Item.saf2101_docno_orderno == "") {

                        } else {
                            seq = (this.Saf21Item.saf2101_docno_orderno + "")
                        }
                        return this.Saf21Item.BCodeInfo.cnf0701_bcode + this.Saf21Item.saf2101_docno_type + this.Saf21Item.saf2101_docno_date + seq;
                    }
                    
                },
                Inf29Item_Inf2902DocNo: function () {
                    var seq = "";
                    if (this.Inf29Item.inf2902_docno_seq == null ||
                        this.Inf29Item.inf2902_docno_seq === "") {
                    } else {
                        seq = (this.Inf29Item.inf2902_docno_seq + "");
                    }
                    return this.Inf29Item.inf2902_docno_type + this.Inf29Item.inf2902_docno_date + seq;
                },
                Saf21aTotalAmount: function () {
                    var total = 0.0;
                    for (var i in this.Saf21aList) {
                        var saf21a = this.Saf21aList[i];
                        total += parseFloat(saf21a.saf21a16_total_qty);
                    }
                    return total.toFixed(2);
                },
                Saf21aItem_Total_Qty: function () {
                    return parseInt((this.Saf21aItem.saf21a56_box_qty * this.Saf21aItem.inf0164_dividend) + this.Saf21aItem.saf21a57_qty);
                },
                TotalAmount: function () {
                    var total = 0.0;
                    for (var i in this.Inf29aList) {
                        var inf29a = this.Inf29aList[i];
                        total += parseFloat(inf29a.inf29a13_sold_qty);
                    }
                    return total.toFixed(2);
                },
                Saf21aTotalPrice: function () {
                    var total = 0.0;
                    for (var i in this.Saf21aList) {
                        var saf21a = this.Saf21aList[i];
                        total += parseFloat(saf21a.saf21a50_one_amt);
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
                Saf21aItem_Saf21a50OneAmt: function () { //小計金額
                    var a = (this.Saf21aItem.saf21a11_unit_price * this.Saf21aItem_Total_Qty) + this.Saf21aItem.saf21a49_odds_amt * 1;
                    return a;
                },
                Saf21aItem_Saf21a62ChgAmt: function () { //換算後幣值小計
                    return this.Inf29aItem.inf29a09_retail_one * this.Inf29aItem.inf29a13_sold_qty;
                },
                Saf21aItem_Saf21a63ChgTax: function () {
                    return this.Saf21aItem.saf21a11_unit_price - this.Saf21aItem.saf21a37_utax_price;
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
                    if (this.IsDpCodeDisplay) {
                        return;
                    }
                    console.log("OnAdd");
                    this.Reset();
                },
                OnAddSaf21aItem: function (defaultSeq) {//輸入明細
                    var vueObj = this;

                    if (this.Saf21aItem.saf21a02_pcode == null || this.Saf21aItem.saf21a02_pcode == "") {
                        return;
                    }
                    // update
                    if (this.Saf21aItem.saf21a02_seq != null) {
                        var saf21a = this.Saf21aList.filter(function (item, index, array) {
                            return item.saf21a02_seq == vueObj.Saf21aItem.saf21a02_seq;
                        }).shift();
                        this.SelectedSaf21aItem = {
                            id: this.Saf21aItem.id,
                            saf21a02_seq: this.Saf21aItem.saf21a02_seq,
                            saf21a02_pcode: this.Saf21aItem.saf21a02_pcode,
                            saf21a37_utax_price: this.Saf21aItem.saf21a37_utax_price, //未稅單價
                            saf21a11_unit_price: this.Saf21aItem.saf21a11_unit_price,
                            saf21a16_total_qty: this.Saf21aItem_Total_Qty,
                            saf21a51_gift_qty: 0, //贈品數量
                            saf21a03_relative_no: this.Saf21aItem.saf21a03_relative_no, //貨號
                            inf0164_dividend: this.Saf21aItem.inf0164_dividend, //換算值
                            saf21a57_qty: this.Saf21aItem.saf21a57_qty, //小單位數量
                            saf21a49_odds_amt: this.Saf21aItem.saf21a49_odds_amt, //差額
                            saf21a50_one_amt: this.Saf21aItem_Saf21a50OneAmt, //金額小計
                            Remark: this.Saf21aItem.Remark,
                            saf21a12_tax_type: this.Saf21aItem.saf21a12_tax_type,
                            saf21a13_tax: this.Saf21aItem.saf21a13_tax, //營業稅率
                            saf21a43_runit: this.Saf21aItem.saf21a43_runit, //單位
                            saf21a56_box_qty: this.Saf21aItem.saf21a56_box_qty, //箱入量
                            saf21a41_product_name: this.Saf21aItem.saf21a41_product_name, //商品名稱
                            saf21a38_discount: 100,
                            saf21a39_total_price: this.Saf21aItem.saf21a37_utax_price * this.Saf21aItem_Total_Qty,
                            saf21a55_cost: parseInt(this.Saf21aItem.saf21a55_cost),
                            saf21a61_chng_price: this.Saf21aItem.saf21a11_unit_price * this.Saf21Item.saf2129_exchange_rate,
                            saf21a64_chg_sum: this.Saf21aItem_Saf21a50OneAmt * this.Saf21Item.saf2129_exchange_rate,
                            saf21a63_chg_tax: this.Saf21aItem.saf21a12_tax_type == 1 ? (((this.Saf21aItem_Saf21a50OneAmt / (1 + this.Saf21aItem.saf21a13_tax)) * this.Saf21aItem.saf21a13_tax)) * this.Saf21Item.saf2129_exchange_rate : 0,
                            moduser: loginUserName,
                            moddate: new Date().dateFormat(this.UiDateFormat),
                            beenMod: true,

                            inf29a09_retail_one: this.Inf29aItem.inf29a09_retail_one,//換算後幣值售價
                            inf29a09_oretail_one: this.Inf29aItem.inf29a09_oretail_one, //售價
                            inf29a10_ocost_one: this.Inf29aItem.inf29a10_ocost_one, //原進價
                            inf29a10_cost_one: this.Inf29aItem.inf29a10_cost_one, //換算後幣值進價
                            inf29a11_dis_rate: 100, //折扣
                            inf29a14_trn_type: "1", //1表示自行輸入的資料
                            //inf29a31_currency: this.Inf29aItem.SelectedCurrencyInfo == null ? "" : this.Inf29aItem.SelectedCurrencyInfo.cnf1003_char01, //幣別
                            //                            inf29a32_exchange_rate: this.Inf29aItem.inf29a32_exchange_rate, //匯率
                            inf29a39_price: this.Inf29aItem.inf29a39_price, //售價
                            inf29a38_one_amt: this.Inf29aItem_Inf29a38OneAmt, //小計金額
                            inf29a12_sub_amt: this.Inf29aItem_Inf29a12SubAmt, //換算後幣值小計
                            inf29a13_sold_qty: this.Inf29aItem.inf29a13_sold_qty, //數量

                            inf29a36_odds_amt: this.Inf29aItem.inf29a36_odds_amt, //尾差
                            inf29a41_pcat: this.Inf29aItem.inf29a41_pcat, //商品分類編號
                            Confirmed: this.Saf21aItem.Confirmed, //確認
                            //adduser: this.Saf21aItem.adduser,
                            //adddate: new Date().dateFormat(this.UiDateFormat),


                        };
                        this.SelectedSaf21aItem.saf21a62_chg_sub = this.SelectedSaf21aItem.saf21a64_chg_sum - this.SelectedSaf21aItem.saf21a63_chg_tax
                        var saf21aIndex = this.Saf21aList.indexOf(saf21a);
                        this.Saf21aList.splice(saf21aIndex, 1, this.SelectedSaf21aItem);
                        // deselect
                        this.OnRowClick(this.SelectedSaf21aItem);
                        return;
                    }
                    var saf21a02_seq = defaultSeq || this.Saf21aList.length + 1;
                    for (var i in this.Saf21aList) {
                        if (this.Saf21aList[i].saf21a02_seq == saf21a02_seq) {
                            return this.OnAddSaf21aItem(saf21a02_seq + 1);
                        }
                    }
                    var tmpSaf21a = {
                        saf21a02_seq: saf21a02_seq,
                        saf21a02_pcode: this.Saf21aItem.saf21a02_pcode,
                        saf21a37_utax_price: this.Saf21aItem.saf21a37_utax_price, //未稅單價
                        saf21a11_unit_price: this.Saf21aItem.saf21a11_unit_price,
                        saf21a16_total_qty: this.Saf21aItem_Total_Qty,
                        saf21a51_gift_qty: 0, //贈品數量
                        saf21a03_relative_no: this.Saf21aItem.saf21a03_relative_no, //貨號
                        inf0164_dividend: this.Saf21aItem.inf0164_dividend, //換算值
                        saf21a57_qty: this.Saf21aItem.saf21a57_qty, //小單位數量
                        saf21a49_odds_amt: this.Saf21aItem.saf21a49_odds_amt, //差額
                        saf21a50_one_amt: this.Saf21aItem_Saf21a50OneAmt, //金額小計
                        Remark: this.Saf21aItem.Remark,
                        saf21a12_tax_type: this.Saf21aItem.saf21a12_tax_type,
                        saf21a13_tax: this.Saf21aItem.saf21a13_tax, //營業稅率
                        saf21a43_runit: this.Saf21aItem.saf21a43_runit, //單位
                        saf21a56_box_qty: this.Saf21aItem.saf21a56_box_qty, //箱入量
                        saf21a41_product_name: this.Saf21aItem.saf21a41_product_name, //商品名稱
                        saf21a38_discount: 100,
                        saf21a39_total_price: this.Saf21aItem.saf21a37_utax_price * this.Saf21aItem_Total_Qty,
                        saf21a55_cost: parseInt(this.Saf21aItem.saf21a55_cost),
                        saf21a61_chng_price: this.Saf21aItem.saf21a11_unit_price * this.Saf21Item.saf2129_exchange_rate,
                        saf21a64_chg_sum: this.Saf21aItem_Saf21a50OneAmt * this.Saf21Item.saf2129_exchange_rate,
                        saf21a63_chg_tax: this.Saf21aItem.saf21a12_tax_type == 1 ? (((this.Saf21aItem_Saf21a50OneAmt / (1 + this.Saf21aItem.saf21a13_tax)) * this.Saf21aItem.saf21a13_tax)) * this.Saf21Item.saf2129_exchange_rate : 0,
                        adduser: loginUserName,
                        adddate: new Date().dateFormat(this.UiDateFormat)
                    };
                    tmpSaf21a.saf21a62_chg_sub =tmpSaf21a.saf21a64_chg_sum -tmpSaf21a.saf21a63_chg_tax
                    this.Saf21aList.push(tmpSaf21a);
                    this.ResetSaf21a();
                    
                },
                OnDelete: function (saf21Item) {
                    window.dsap02101Search.OnDelete(saf21Item);
                    this.OnExit();
                },
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
                            inf29a04_sizeno: this.Inf29aItem.inf29a04_sizeno,//尺碼
                            inf29a05_pcode: this.Inf29aItem.inf29a05_pcode,
                            inf29a05_shoes_code: this.Inf29aItem.inf29a05_shoes_code, //貨號
                            inf29a09_retail_one: this.Inf29aItem.inf29a09_retail_one,//換算後幣值售價
                            inf29a09_oretail_one: this.Inf29aItem.inf29a09_oretail_one, //售價
                            inf29a10_ocost_one: this.Inf29aItem.inf29a10_ocost_one, //原進價
                            inf29a10_cost_one: this.Inf29aItem.inf29a10_cost_one, //換算後幣值進價
                            inf29a11_dis_rate: 100, //折扣
                            inf29a14_trn_type: "1", //1表示自行輸入的資料
                            //inf29a31_currency: this.Inf29aItem.SelectedCurrencyInfo == null ? "" : this.Inf29aItem.SelectedCurrencyInfo.cnf1003_char01, //幣別
                            //                            inf29a32_exchange_rate: this.Inf29aItem.inf29a32_exchange_rate, //匯率
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
                            adduser: this.Inf29aItem.adduser,
                            adddate: this.Inf29aItem.adddate
                        };
                        var inf29aIndex = this.Inf29aList.indexOf(inf29a);
                        this.Inf29aList.splice(inf29aIndex, 1, this.SelectedInf29aItem);
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
                        inf29a09_retail_one: this.Inf29aItem.inf29a09_retail_one,//換算後幣值售價
                        inf29a09_oretail_one: this.Inf29aItem.inf29a09_oretail_one, //售價
                        inf29a10_ocost_one: this.Inf29aItem.inf29a10_ocost_one, //原進價
                        inf29a10_cost_one: this.Inf29aItem.inf29a10_cost_one, //換算後幣值進價
                        inf29a11_dis_rate: 100, //折扣
                        inf29a14_trn_type: "1", //1表示自行輸入的資料
                        //inf29a31_currency: this.Inf29aItem.SelectedCurrencyInfo == null ? "" : this.Inf29aItem.SelectedCurrencyInfo.cnf1003_char01, //幣別
                        //                        inf29a32_exchange_rate: this.Inf29aItem.inf29a32_exchange_rate, //匯率
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
                        adduser: this.Inf29aItem.adduser,
                        adddate: this.Inf29aItem.adddate
                    });
                },
                OnDeleteSaf21aItem: function () {//刪除明細
                    if (this.SelectedSaf21aItem == null) {
                        return;
                    }
                    if (confirm("是否確認刪除明細?")) {
                        var index = this.Saf21aList.indexOf(this.SelectedSaf21aItem);
                        this.Saf21aList.splice(index, 1);
                        this.ResetSaf21a();
                    }
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
                OnRowClick: function (saf21aItem) {
                    if (this.SelectedSaf21aItem == saf21aItem) {
                        this.ResetSaf21a();
                    } else {
                        this.SelectedSaf21aItem = saf21aItem;
                        //var currencyInfo = this.CurrencyList.filter(function(item, index, array){
                        //    return item.cnf1003_char01==inf29aItem.inf29a31_currency;
                        //}).shift();
                        this.Saf21aItem = {
                            id: saf21aItem.id,
                            saf21a02_seq: saf21aItem.saf21a02_seq,
                            saf21a02_pcode: saf21aItem.saf21a02_pcode,
                            saf21a37_utax_price: saf21aItem.saf21a37_utax_price, //未稅單價
                            saf21a11_unit_price: saf21aItem.saf21a11_unit_price,
                            saf21a16_total_qty: saf21aItem.saf21a16_total_qty,
                            saf21a51_gift_qty: saf21aItem.saf21a51_gift_qty, //贈品數量
                            saf21a03_relative_no: saf21aItem.saf21a03_relative_no, //貨號
                            inf0164_dividend: saf21aItem.inf0164_dividend, //換算值
                            saf21a57_qty: saf21aItem.saf21a57_qty, //小單位數量
                            saf21a49_odds_amt: saf21aItem.saf21a49_odds_amt, //差額
                            saf21a50_one_amt: saf21aItem.saf21a50_one_amt, //金額小計
                            Remark: saf21aItem.Remark,
                            saf21a12_tax_type: saf21aItem.saf21a12_tax_type,
                            saf21a13_tax: saf21aItem.saf21a13_tax, //營業稅率
                            saf21a43_runit: saf21aItem.saf21a43_runit, //單位
                            saf21a56_box_qty: saf21aItem.saf21a56_box_qty, //箱入量
                            saf21a41_product_name: saf21aItem.saf21a41_product_name, //商品名稱
                            saf21a38_discount: 100,
                            saf21a55_cost: saf21aItem.saf21a55_cost,
                            adduser: saf21aItem.adduser,
                            adddate: saf21aItem.adddate
                        };
                    }
                },
                /*OnRowClick: function (inf29aItem) {
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
                },*/
                OnCopy: function () {

                },
                OnSave: function () {

                    if (this.Saf21Copy == JSON.stringify(this.Saf21Item) + JSON.stringify(this.Saf21aList)) {
                        alert("您未修改任何欄位，所以不與存檔");
                        return;
                    }
                    if (this.Saf21Item.BCodeInfo == null) {
                        alert("公司代號不允許空白，請重新輸入");
                        return;
                    }
                    if (this.Saf21Item.saf2108_customer_code == null ||
                        this.Saf21Item.saf2108_customer_code == "") {
                        alert("請輸入客戶代號");
                        return;
                    }
                    var saf2101_docno_date = null;
                    if (this.Saf21Item.saf2101_docno_date != null && this.Saf21Item.saf2101_docno_date != "") {
                        saf2101_docno_date = Date.parseDate(this.Saf21Item.saf2101_docno_date, 'Ymd').dateFormat('Y-m-d');
                    }
                    var saf2106_order_date = null;
                    if (this.Saf21Item.saf2106_order_date != null && this.Saf21Item.saf2106_order_date != "") {
                        saf2106_order_date = Date.parseDate(this.Saf21Item.saf2106_order_date, 'Ymd').dateFormat('Y-m-d');
                    }
                    var saf2110_del_date = null;
                    if (this.Saf21Item.saf2110_del_date != null && this.Saf21Item.saf2110_del_date != "") {
                        //saf2110_del_date = Date.parseDate(this.Saf21Item.saf2110_del_date, 'Y/m/d').dateFormat('Y-m-d');
                    }
                    if (this.Saf21Item.saf2134_p_po_time == null) {
                        var now = new Date();
                        this.Saf21Item.saf2134_p_po_time = now.dateFormat(this.UiDateFormat);
                    }
                    /*for (var i in this.Saf21aList) {
                        var saf21a = this.Saf21aList[i];
                        if(saf21a.Confirmed =="N"){
                            alert("請先確認所有項目");
                            return;
                        }
                    }*/
                    var saf21Item = {
                        saf2101_docno: this.Saf21Item.saf2101_docno,
                        saf2101_bcode: this.Saf21Item.BCodeInfo.cnf0701_bcode,
                        saf2101_docno_type: this.Saf21Item.saf2101_docno_type,
                        saf2101_docno_date: saf2101_docno_date,
                        saf2106_order_date: saf2106_order_date,
                        saf2108_customer_code: this.Saf21Item.saf2108_customer_code,
                        saf2110_del_date: this.Saf21Item.saf2110_del_date.substring(0,10),
                        saf2114_payment : this.Saf21Item.saf2114_payment,
                        saf2123_delivery_place_no: this.Saf21Item.saf2123_delivery_place_no,
                        saf2128_currency: this.Saf21Item.SelectedCurrencyInfo == null ? "" : this.Saf21Item.SelectedCurrencyInfo.cnf1002_fileorder,
                        saf2129_exchange_rate: this.Saf21Item.saf2129_exchange_rate,
                        saf2134_p_po_time: this.Saf21Item.saf2134_p_po_time,
                        saf2139_total_price: parseInt(this.Saf21aTotalPrice),
                        saf2147_recid: this.Saf21Item.saf2147_recid,
                        saf2156_take_no : this.Saf21Item.saf2156_take_no,
                        remark : this.Saf21Item.Remark,
                        adduser: loginUserName,
                        adddate: new Date().dateFormat(this.UiDateFormat),
                        moduser: loginUserName,
                        moddate: new Date().dateFormat(this.UiDateFormat)
                        /*inf2901_bcode: this.Inf29Item.BCodeInfo.cnf0701_bcode, //公司代號相關資料
                        inf2902_docno_type: this.Inf29Item.inf2902_docno_type, //單據分類編號. 組成異動單號
                        inf2902_docno_date: inf2902_docno_date, //異動單號_日期. 組成異動單號
                        inf2903_customer_code: this.Inf29Item.inf2903_customer_code, //客戶代碼
                        inf2904_pro_date: this.Inf29Item.inf2904_pro_date, //異動日期
                        inf2906_wherehouse: this.Inf29Item.SelectedWherehouse.cnf1002_fileorder, //倉庫代號
                        inf2906_ref_no_type: this.Inf29Item.inf2906_ref_no_type || "", //單據來源
                        inf2906_ref_no_date: inf2906_ref_no_date, //單據來源
                        inf2906_ref_no_seq: this.Inf29Item.inf2906_ref_no_seq || 0, //單據來源
                        inf2910_in_reason: this.Inf29Item.SelectedInReason.cnf1002_fileorder, //異動代號
                        inf2914_inv_eff: this.Inf29Item.SelectedInReason.cnf1008_dec01, //庫存影響方向
                        inf2916_apr_empid: this.Inf29Item.inf2916_apr_empid || "", //員工ID
                        inf2952_project_no: this.Inf29Item.inf2952_project_no || "", //專案代號
                        inf2928_currency: this.Inf29Item.SelectedCurrencyInfo == null ? "" : this.Inf29Item.SelectedCurrencyInfo.cnf1003_char01, //幣別
                        inf2929_exchange_rate: this.Inf29Item.inf2929_exchange_rate || 0,
                        remark: this.Inf29Item.remark || "",
                        adddate: new Date(),
                        adduser: this.Inf29Item.adduser,
                        moddate: this.Inf29Item.moddate,
                        moduser: this.Inf29Item.moduser*/
                    };
                        saf21Item.Saf21aList = this.Saf21aList;

                        var vueObj = this;
                        LoadingHelper.showLoading();
                        return $.ajax({
                            type: 'POST',
                            url: rootUrl + "Dsap02101/Ajax/Saf21Handler.ashx",
                            cache: false,
                            data: {
                                act: "save",
                                edit:this.Edit,
                                data: JSON.stringify(saf21Item)
                            },
                            dataType: 'text',
                            success: function (saf21Json) {
                                var saf21Item = JSON.parse(saf21Json);
                                if (saf21Item == null) {
                                    alert("存檔失敗");
                                } else {
                                    vueObj.Saf21Item.id = saf21Item.id;
                                    vueObj.Saf21Item.saf2101_docno_orderno = saf21Item.saf2101_docno_orderno;
                                }
                                LoadingHelper.hideLoading();
                                alert("存檔成功");
                            },
                            error: function (jqXhr, textStatus, errorThrown) {
                                if (jqXhr.status == 0) {
                                    return;
                                }
                                LoadingHelper.hideLoading();
                                console.error(jqXhr.responseText);
                                alert("存檔失敗");
                            }
                        });
                    },
                        OnPrint: function () {
                            var vueObj = this;
                            var bcodeInfo = this.Inf29Item.BCodeInfo;
                            var inf29idList = [];
                            if (this.Inf29Item.id) {
                                inf29idList.push(this.Inf29Item.id)
                            }
                            if (inf29idList.length == 0) {
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
                                    data: JSON.stringify(inf29idList),
                                    printBcode: JSON.stringify(bcodeInfo),
                                },
                                dataType: 'text',
                                success: function (result) {
                                    if (result == "ok") {
                                        printJS({
                                            printable: rootUrl + "Dinp/Ajax/Inf29Print.ashx",
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
                            this.IsDpCodeDisplay = false
                            if (productInfo == null) {
                                return;
                            }
                            this.SetSaf21aItem(productInfo)

                        },
                        SetSaf21aItem(productInfo) {
                            var vueObj = this;

                            $.ajax({
                                type: 'POST',
                                url: rootUrl + "Dsap02101/Ajax/Getdividend.ashx",
                                cache: false,
                                data: {
                                    pcode: productInfo.pcode
                                },
                                dataType: 'text',
                                success: function (result) {
                                    var inf01 = JSON.parse(result)
                                    vueObj.Saf21aItem.inf0164_dividend = inf01.inf0164_dividend;
                                    vueObj.Saf21aItem.saf21a12_tax_type = inf01.inf0127_tax_flag;
                                },
                                error: function (jqXhr, textStatus, errorThrown) {
                                    LoadingHelper.hideLoading();
                                    if (jqXhr.status == 0) {
                                        return;
                                    }
                                    console.error(errorThrown);
                                    alert("查詢換算值失敗");
                                }
                            });
                            var now = new Date();

                            vueObj.Saf21aItem.saf21a02_pcode = productInfo.pcode;
                            vueObj.Saf21aItem.saf21a03_relative_no = productInfo.pclass;
                            vueObj.Saf21aItem.saf21a41_product_name = productInfo.psname;
                            vueObj.Saf21aItem.saf21a37_utax_price = parseFloat(productInfo.retail).toFixed(2);
                            vueObj.Saf21aItem.saf21a43_runit = productInfo.runit;
                            vueObj.Saf21aItem.saf21a55_cost = parseFloat(productInfo.cost).toFixed(2);
                            vueObj.Saf21aItem.saf21a13_tax = productInfo.tax / 100;
                            //vueObj.saf21aItem.saf21a16_total_qty = Saf21aItem_Total_Qty;
                            //vueObj.saf21aItem.saf21a39_total_price = Saf21aTotalPrice;
                            vueObj.Saf21aItem.saf21a11_unit_price = parseFloat(parseFloat(productInfo.retail));
                                //(parseFloat(productInfo.tax) / 100 + 1));
                            //vueObj.Saf21aItem.saf21a56_box_qty = productInfo.pqty_o === '' ? 0 : productInfo.pqty_o;
                            vueObj.Saf21aItem.saf21a12_tax_type = 1;
                            vueObj.Saf21aItem.saf21a61_chng_price = parseFloat(productInfo.retail).toFixed(2) * vueObj.Saf21Item.saf2129_exchange_rate;
                            vueObj.Saf21aItem.saf21a64_chg_sum = vueObj.Saf21aItem_Saf21a50OneAmt * vueObj.Saf21Item.saf2129_exchange_rate;
                            vueObj.Saf21aItem.saf21a63_chg_tax = (vueObj.Saf21aItem_Saf21a50OneAmt / (1 + vueObj.Saf21aItem.saf21a13_tax) * vueObj.Saf21aItem.saf21a13_tax) * vueObj.Saf21Item.saf2129_exchange_rate;
                            vueObj.Saf21aItem.adduser = loginUserName;
                            //vueObj.adddate = now.dateFormat(this.UiDateFormat);

                            vueObj.Inf29aItem.inf29a05_pcode = productInfo.pcode;
                            vueObj.Inf29aItem.inf29a05_shoes_code = productInfo.pclass;
                            vueObj.Inf29aItem.inf29a10_ocost_one = parseFloat(productInfo.cost).toFixed(2);
                            vueObj.Inf29aItem.inf29a39_price = parseFloat(productInfo.retail).toFixed(2);
                            vueObj.Inf29aItem.inf29a09_oretail_one = vueObj.Inf29aItem.inf29a39_price;
                            vueObj.Inf29aItem.inf29a17_runit = productInfo.runit;
                            vueObj.Inf29aItem.inf29a26_box_qty = productInfo.pqty_o;
                            vueObj.Inf29aItem.inf29a33_product_name = productInfo.psname;
                            vueObj.Inf29aItem.inf29a40_tax = productInfo.tax;
                            vueObj.Inf29aItem.inf29a41_pcat = productInfo.pcat;
                            vueObj.Inf29aItem.inf29a04_sizeno = productInfo.size;

                            if (parseFloat(productInfo.cost) == 0) {
                                if (confirm("您確定進價 = 0，回是(Y)繼續作業，回否(N)請修正進價")) {
                                }
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
                            window.dsap02101Search.Display = true;
                            this.Edit = false;
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
                            this.Saf21aList.sort(this.SortList);
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
                            vueObj.Saf21aItem.saf21a02_pcode = "";
                            vueObj.Saf21aItem.saf21a03_relative_no = "";
                            vueObj.Saf21aItem.saf21a37_utax_price = 0;
                            this.GetProductInfo(pcode)
                                .done(function (productInfoJson) {
                                    var productInfo = JSON.parse(productInfoJson);
                                    if (productInfo == null) {
                                        alert("商品代號不存在於商品基本資料檔中，請重新輸入");
                                    } else {
                                        vueObj.SetSaf21aItem(productInfo);
                                    }
                                });
                        },
                        OnCustomCodeChange: function () {
                            if (this.Saf21Item.saf2108_customer_code == null || this.Saf21Item.saf2108_customer_code == "") {
                                alert("客戶代號不能等於空白，請重新輸入");
                                this.Saf21Item.saf2108_customer_code = null;
                                this.Saf21Item.cmf0103_bname = null;
                                return;
                            }
                            //異動單位變更, 根據異動帶碼讀資料
                            var vueObj = this;
                            return $.ajax({
                                type: 'POST',
                                url: rootUrl + "Dsap02101/Ajax/GetCustomCodeInfo.ashx",
                                cache: false,
                                data: {
                                    customCode: this.Saf21Item.saf2108_customer_code
                                },
                                dataType: 'text',
                                success: function (customCodeName) {
                                    var customInfo = JSON.parse(customCodeName);
                                    if (customInfo.length == 0) {
                                        alert('客戶代號不存在於客戶基本資料檔中，請重新輸入');
                                    } else {
                                        vueObj.Saf21Item.cmf0103_bname = customInfo[0].cmf0103_bname;
                                        vueObj.Saf21Item.saf2123_delivery_place_no = customInfo[0].cmf0109_ozipcode;
                                        vueObj.Saf21Item.cmf0110_oaddress = customInfo[0].cmf0110_oaddress;
                                        //vueObj.Saf21Item.saf2147_recid = customInfo[0].cmf01a03_recid;
                                        vueObj.Saf21Item.cmf01a05_fname = customInfo[0].cmf01a05_fname;
                                        vueObj.Saf21Item.cmf01a17_telo1 = customInfo[0].cmf01a17_telo1;
                                        vueObj.Saf21Item.cmf01a23_cellphone = customInfo[0].cmf01a23_cellphone;

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
                                    exchangeCode: currencyInfo.cnf1002_fileorder
                                },
                                dataType: 'text',
                                success: function (exchangeInfoJson) {
                                    var exchangeInfo = JSON.parse(exchangeInfoJson);
                                    if (exchangeInfo == null) {
                                        vueObj.Saf21Item.saf2129_exchange_rate = 1;
                                    } else {
                                        vueObj.Saf21Item.saf2129_exchange_rate = exchangeInfo.cnf1406_exchange_fix;
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
                                        vueObj.Inf29Item.inf2952_project_no = null;
                                        vueObj.Inf29Item.ProjectFullname = null;
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
                        OnPaymentChange: function (paymentCode) {
                            //異動單位變更, 根據異動帶碼讀資料
                            var vueObj = this;
                            return $.ajax({
                                type: 'POST',
                                url: rootUrl + "Dsap02101/Ajax/GetPaymentInfo.ashx",
                                cache: false,
                                data: {
                                    payment: this.Saf21Item.saf2114_payment
                                },
                                dataType: 'text',
                                success: function (cnf1003_char01) {
                                    if (cnf1003_char01 == null || cnf1003_char01 == "") {
                                        alert('付款方式不存在於cnf10共用代號中，請詳查後重新輸入,謝謝');
                                        vueObj.Saf21Item.cnf1003_char01 = null;
                                    } else {
                                        vueObj.Saf21Item.cnf1003_char01 = cnf1003_char01;
                                    }
                                },
                                error: function (jqXhr, textStatus, errorThrown) {
                                    if (jqXhr.status == 0) {
                                        return;
                                    }
                                    LoadingHelper.hideLoading();
                                    console.error(errorThrown);
                                    alert("查詢付款方式單位失敗");
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
                        CurrencySelectLabel: function (currency) {
                            return currency.cnf1003_char01;
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
                        SetCopy: function (saf21) {
                            console.log(saf21);
                            var vueObj = this;
                            var now = new Date();
                            var asyncTasks = [];
                            LoadingHelper.showLoading();
                            if (saf21.saf2106_order_date == null) {
                                saf21.saf2106_order_date = "";
                            }
                            var currencyInfo = this.CurrencyList.filter(function (item, index, array) {
                                return item.cnf1002_fileorder == saf21.saf2128_currency;
                            }).shift();
                            console.log(saf21.saf2110_del_date);
                            this.Saf21Item = {
                                id: saf21.id,
                                BCodeInfo: null,
                                saf2101_bcode: null,
                                saf2101_docno: saf21.saf2101_docno,
                                status: '',
                                saf2101_docno_type: "OA",
                                saf2101_docno_date: saf21.saf2101_docno_date.substring(0, 10).replace(/[&\|\\\*^%$#@\-]/g, ""),
                                saf2101_docno_orderno: saf21.saf2101_docno_orderno,
                                saf2106_order_date: saf21.saf2106_order_date.substring(0, 10).replace(/[&\|\\\*^%$#@\-]/g,""),
                                saf2156_take_no: saf21.saf2156_take_no,
                                saf2108_customer_code: saf21.saf2108_customer_code,
                                saf2128_currency: saf21.saf2128_currency,
                                saf2150_one_amt: saf21.saf2150_one_amt,
                                saf2134_p_po_time: saf21.saf2134_p_po_time,
                                saf2147_recid: saf21.saf2147_recid,
                                cmf01a23_cellphone: saf21.cmf01a23_cellphone,
                                cmf01a17_telo1: saf21.cmf01a17_telo1,
                                saf2114_payment: saf21.saf2114_payment,
                                cmf0103_bname: null,
                                cnf1003_char01: null,
                                saf2129_exchange_rate: saf21.saf2129_exchange_rate,
                                saf2110_del_date: saf21.saf2110_del_date.substring(0, 10).replace(/[&\|\\\*^%$#@\-]/g, "/"),
                                saf2123_delivery_place_no: saf21.saf2123_delivery_place_no,
                                cmf0110_oaddress: null,
                                cmf01a05_fname: null,
                                Remark: saf21.remark,
                                adduser: saf21.adduser,
                                adddate: saf21.adddate,
                                moduser: loginUserName,
                                moddate: null,
                                verifyuser: null,
                                verifydate: null,


                                /*BCodeInfo: null, //公司代號相關資料
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
                                adduser: loginUserName,*/
                            };
                            this.Saf21Item.BCodeInfo = this.BcodeList.filter(function (item, index, array) {
                                return item.cnf0701_bcode == saf21.saf2101_bcode;
                            }).shift();
                            this.Saf21Item.SelectedCurrencyInfo = this.CurrencyList.filter(function (item, index, array) {
                                return item.cnf1002_fileorder == saf21.saf2128_currency;
                            }).shift();

                            //this.Inf29Item.BCodeInfo = this.BcodeList.filter(function (item, index, array) {
                            //    return item.cnf0701_bcode == inf29.inf2901_bcode;
                            //}).shift();
                            //this.Inf29Item.SelectedWherehouse = this.WherehouseList.filter(function (item, index, array) {
                            //    return item.cnf1002_fileorder == inf29.inf2906_wherehouse;
                            //}).shift();
                            //this.Inf29Item.SelectedInReason = this.InReasonList.filter(function (item, index, array) {
                            //    return item.cnf1002_fileorder == inf29.inf2910_in_reason;
                            //}).shift();
                            //if (inf29.inf2952_project_no != null && inf29.inf2952_project_no != '') {
                            //    this.GetProjectFullname(inf29.inf2952_project_no, this.Inf29Item.BCodeInfo);
                            //}
                            //if (inf29.inf2916_apr_empid != null && inf29.inf2916_apr_empid != '') {
                            //    this.GetEmpCname(inf29.inf2916_apr_empid);
                            //}

                            asyncTasks.push(window.dsap02101Search.GetSaf21aList(this.Saf21Item.saf2101_docno).done(function () {
                                var now = new Date();
                                var saf21aList = window.dsap02101Search.Saf21aList; // JSON.parse(saf21aListJson);
                                for (var i in saf21aList) {
                                    var saf21a = saf21aList[i];
                                    vueObj.Saf21aList.push({
                                        id: saf21a.id,
                                        saf21a57_qty: saf21a.saf21a57_qty,
                                        saf21a02_pcode: saf21a.saf21a02_pcode,
                                        saf21a03_relative_no: saf21a.saf21a03_relative_no,
                                        saf21a41_product_name: saf21a.saf21a41_product_name,
                                        saf21a37_utax_price: saf21a.saf21a37_utax_price,
                                        saf21a43_runit: saf21a.saf21a43_runit,
                                        saf21a55_cost: saf21a.saf21a55_cost,
                                        saf21a12_tax_type: saf21a.saf21a12_tax_type,
                                        saf21a13_tax: saf21a.saf21a13_tax,
                                        saf21a11_unit_price: saf21a.saf21a11_unit_price,
                                        saf21a61_chng_price: saf21a.saf21a61_chng_price,
                                        saf2129_exchange_rate: saf21a.saf2129_exchange_rate,
                                        saf21a16_total_qty: saf21a.saf21a16_total_qty,
                                        saf21a49_odds_amt: saf21a.saf21a49_odds_amt,
                                        saf21a50_one_amt: saf21a.saf21a50_one_amt,
                                        saf20a62_chg_sub: saf21a.saf20a62_chg_sub,
                                        saf2140_docno_seq: saf21a.saf2140_docno_seq,
                                        saf21a56_box_qty: saf21a.saf21a56_box_qty,
                                        saf21a51_gift_qty: saf21a.saf21a51_gift_qty,
                                        inf0164_dividend: saf21a.inf0164_dividend,
                                        saf21a02_seq: saf21a.saf21a02_seq,
                                        Remark: saf21a.remark,
                                        saf21a38_discount: saf21a.saf21a38_discount,
                                        saf21a63_chg_tax: saf21a.saf21a63_chg_tax,
                                        saf20a64_chg_sum: saf21a.saf20a64_chg_sum,




                                        /*saf21a02_seq: i,
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
                                        adddate: now.dateFormat(vueObj.UiDateFormat)*/
                                    });
                                }
                            }));
                            this.GetEmpCname(this.Saf21Item.saf2147_recid);
                            this.OnCustomCodeChange();
                            this.OnPaymentChange();
                            this.Edit = "true";
                            // 所有資料取完後用JSON備份, 用來檢查是否後續有被使用者修改
                            $.when.apply($, asyncTasks).then(function () {
                                LoadingHelper.hideLoading();
                                vueObj.Saf21Copy = JSON.stringify(vueObj.Saf21Item) + JSON.stringify(vueObj.Saf21aList);
                            });
                        },
                        SetBCodeList: function (bcodeList) {
                            this.BcodeList = bcodeList;
                        },
                        Reset: function () {
                            var asyncTasks = [];
                            var defaultBCodeInfo = this.BcodeList.filter(function (item, index, array) {
                                return item.cnf0751_tax_headoffice == "0";
                            }).shift();
                            var defaultCurrency = this.CurrencyList.filter(function (item, index, array) {
                                return item.cnf1003_char01 == "NTD";
                            }).shift();
                            this.Saf21Item = {
                                id: null,
                                BCodeInfo: defaultBCodeInfo,
                                saf2101_docno_type: "OA",
                                saf2101_docno_date: null,
                                saf2101_docno_orderno: null,
                                saf2106_order_date: null,
                                saf2156_take_no: null,
                                saf2108_customer_code: null,
                                saf2128_currency: null,
                                remark:"",
                                SelectedCurrencyInfo: defaultCurrency,
                                saf2150_one_amt: null,
                                saf2129_exchange_rate: 1,

                            };
                            this.Inf29Item = {
                                id: null,//儲存成功後從伺服器返回
                                BCodeInfo: defaultBCodeInfo, //公司代號相關資料
                                inf2902_docno_type: "XC", //單據分類編號. 組成異動單號
                                inf2902_docno_date: null, //異動單號_日期. 組成異動單號
                                inf2904_pro_date: null, //異動日期
                                inf2902_docno_seq: null,//異動單號_流水號, 儲存成功後從伺服器返回
                                SelectedWherehouse: null, //選中的倉庫代號
                                inf2952_project_no: null, //專案代號
                                ProjectFullname: null, //專案全名
                                inf2916_apr_empid: null, //員工ID
                                EmpCname: null, //員工Name
                                inf2903_customer_code: null, //客戶代碼
                                Inf2903CustomerCodeName: null, //異動單位
                                inf2906_ref_no_type: null, //單據來源
                                inf2906_ref_no_date: null, //單據來源
                                inf2906_ref_no_seq: null, //單據來源
                                SelectedInReason: null, //異動代號
                                inf2910_in_reason: null, //異動代號
                                SelectedCurrencyInfo: defaultCurrency, //幣別
                                inf2929_exchange_rate: 1, //匯率
                                remark: null,
                                adddate: null,
                                adduser: null,
                                moddate: null,
                                moduser: null,
                            };
                            if (this.Saf21aList && this.Saf21aList.length > 0) {
                                window.dsap02101Edit.Saf21aList = [];
                            }
                            if (defaultCurrency) {
                                asyncTasks.push(this.GetExchangeInfo(defaultCurrency));
                            }
                            this.Inf29Item.adduser = loginUserName;
                            this.Saf21Item.adduser = loginUserName;
                            this.Inf29Copy = null;

                            var now = new Date();
                            this.Inf29Item.inf2902_docno_date = now.dateFormat("Ymd");
                            this.Saf21Item.saf2101_docno_date = now.dateFormat("Ymd");
                            this.Inf29Item.inf2904_pro_date = now.dateFormat(this.UiDateFormat);
                            this.Saf21Item.saf2106_order_date = now.dateFormat("Ymd");
                            this.Inf29Item.adddate = now.dateFormat(this.UiDateFormat);
                            this.Saf21Item.adddate = now.dateFormat(this.UiDateFormat);
                            this.Inf29aList = [];
                            this.ResetSaf21a();
                            return $.when.apply($, asyncTasks);
                        },
                        ResetSaf21a: function () {
                            //                    var defaultCurrency = this.CurrencyList.filter(function(item, index, array){
                            //                        return item.cnf1003_char01=="NTD";
                            //                    }).shift();
                            this.Saf21aItem = {
                                saf21a37_utax_price: 0,
                                saf21a56_box_qty: 0,
                                saf21a11_unit_price: 0,
                                saf21a61_chng_price: 0,
                                saf21a16_total_qty: 0,
                                saf21a49_odds_amt: 0,
                                saf2110_del_date: null,
                                saf21a62_chg_amt: 0,
                                saf21a50_one_amt: 0,
                                saf21a51_gift_qty: 0,
                                inf0164_dividend: 0,
                                saf21a57_qty: 0,
                                saf21a13_tax: 0,
                                remark: ""
                            };
                            //                    if(defaultCurrency){
                            //                        this.GetExchangeInfo(defaultCurrency);
                            //                    }
                            this.SelectedInf29aItem = null;
                            this.Inf29aItem.adduser = loginUserName;
                            var now = new Date();
                            this.Inf29aItem.adddate = now.dateFormat(this.UiDateFormat);
                        },
                        ResetInf29a:function() {
                            //                    var defaultCurrency = this.CurrencyList.filter(function(item, index, array){
                            //                        return item.cnf1003_char01=="NTD";
                            //                    }).shift();
                            this.Inf29aItem = {
                                inf29a02_seq: null,//序號
                                inf29a04_sizeno: null,//尺碼
                                inf29a05_pcode: null, //產品編號
                                inf29a05_shoes_code: null, //貨號
                                inf29a09_retail_one: null,//換算後幣值售價
                                inf29a09_oretail_one: null, //售價
                                inf29a17_runit: null, //單位
                                inf29a10_ocost_one: 0, //原進價
                                inf29a10_cost_one: 0, //換算後幣值進價
                                inf29a26_box_qty: null,//箱入量
                                //                        SelectedCurrencyInfo: defaultCurrency, //幣別
                                //                        inf29a32_exchange_rate: 1, //匯率
                                inf29a33_product_name: null, //商品名稱
                                inf29a39_price: 0, //售價
                                inf29a40_tax: null,//營業稅率
                                inf29a41_pcat: null,//商品分類編號
                                inf29a13_sold_qty: 0, //數量
                                inf29a36_odds_amt: 0, //尾差
                                adddate: null,
                                adduser: null,
                                moddate: null,
                                moduser: null,
                                Confirmed: "N", //確認
                            };
                            //                    if(defaultCurrency){
                            //                        this.GetExchangeInfo(defaultCurrency);
                            //                    }
                            this.SelectedInf29aItem = null;
                            this.Inf29aItem.adduser = loginUserName;
                            var now = new Date();
                            this.Inf29aItem.adddate = now.dateFormat(this.UiDateFormat);
                        },
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
                    this.Reset();
                }
            });
    }

    function onError(error) {
        console.error(error);
    }

    define(requiredFiles, onLoaded, onError);

})();