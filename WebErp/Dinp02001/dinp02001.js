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
            "d_pcode-css": "D_pcode/D_pcodeCss"
        },
        shim: {
            "jquery.datetimepicker": {
                "deps": ["css!jqueryDatetimepicker-css"]
            },
            "vue-jQuerydatetimepicker": {
                "deps": ['jquery.datetimepicker']
            }, "d_pcode": {
                "deps": ["css!d_pcode-css"]
            }
        },
        map: {
            '*': {
                'jquery-mousewheel': 'jquery.mousewheel'
            }
        }
    });

    var requiredFiles = [
        "bootstrap",
        "FunctionButton",
        "vue-jQuerydatetimepicker",
        "LoadingHelper",
        "jquery.mousewheel",
        "UserLog",
        "print-js",
        "vue-multiselect",
        "d_pcode"
    ];


    function onLoaded(bootstrap,
        functionButton,
        vueDatetimepicker,
        loadingHelper,
        jqMousewheel,
        userLog,
        printJs,
        vueMultiselect, dPcode) {
        if (vueMultiselect == null) {
            console.error("vueMultiselect fallback");
            vueMultiselect = window.VueMultiselect;
        }

        var selectObj = {
            BcodeList: [],
            InReasonList: [],
            CurrencyList: [],
            WherehouseList: [],
            EmpList: [],
            ManufacturerList: [],
            PayList: [],
            ManufacturerEmpList:[]

        }

       
      
        $.ajax({
            type: "POST",
            async: false,
            url: rootUrl + "Dinp02001/Ajax/GetSelectObj.ashx",
            dataType: "text",
            success: function (result) {
                var Data = JSON.parse(result);

                selectObj.BcodeList = Data.BcodeList;
                selectObj.InReasonList = Data.InReasonList;
                selectObj.CurrencyList = Data.CurrencyList;
                selectObj.WherehouseList = Data.WherehouseList;
                selectObj.EmpList = Data.EmpList;
                selectObj.ManufacturerList = Data.ManufacturerList;
                selectObj.ManufacturerEmpList = Data.ManufacturerEmpList;
                selectObj.PayList = Data.PayList;
            },
            error: function (jqXhr, textStatus, errorThrown) {

            }
        });

        $.ajax({
            url: rootUrl + "Dinp02001/Dinp02001.html?" + Date.now(),
            async: false,
            type: "get",
            success: function (html) {
                var appversion = "V18.07.19";
                SaveEnterPageLog(rootUrl, loginUserName, "Dinp02001");
                $("#dinp02001").html(html);
                dinp02001Search(appversion);
                dinp02001Edit(appversion);
            },
            dataType: "html"
        });


        function dinp02001Search(appversion) {

            var today = new Date().getFullYear() + '/' + ('0' + (new Date().getMonth() + 1)).slice(-2) + '/' + ('0' + new Date().getDate()).slice(-2);

            window.dinp02001Search = new Vue({
                el: "#Dinp02001Search",
                data: {
                    Inf20List: [],
                    Inf20aList: [],
                    BcodeList: selectObj.BcodeList,
                    Filter: {
                        OrderDate_Start: today,
                        OrderDate_End: today,
                        Pcode_Start: null,
                        Pcode_End: null,
                        Pclass_Start: null,
                        Pclass_End: null,
                        Mcode_Start: null,
                        Mcode_End: null,
                        AddDate_Start: null,
                        AddDate_End: null,
                        Docno_Type_Start: null,
                        Docno_Date_Start: null,
                        Docno_seq_Start: null,
                        Docno_Type_End: null,
                        Docno_Date_End: null,
                        Docno_seq_End: null,
                        Bcode_Start: null,
                        Bcode_End: null,
                        KeyWord: null,
                        Qty: 0
                    }, Export: {
                        Inf20List: [],
                        Inf20aList: [],
                        SelectedInf20List: [],
                        SelectedInf20aList: []
                    },
                    AppVersion: appversion,
                    Display: true,
                    SelectedInf20Item: null,
                    SelectedInf20aItem: null,
                }, components: {
                    Multiselect: vueMultiselect.default
                },
                mounted: function () {

                    this.GetExportFields();
                },
                methods: {
                   
                    BcodeSelectLabel: function (bcode) {
                        return bcode.cnf0701_bcode + "-" + bcode.cnf0703_bfname;
                    },
                    OnAdd: function () {

                        this.Display = false;
                        window.dinp02001Edit.Display = true;
                        //window.dinp02301Edit.Reset();
                    },
                    OnPrint: function () {
                        var inf20idList = [];
                        var bcodeInfo = null;
                        if (this.Filter.Bcode_Start == this.Filter.Bcode_End) {
                            bcodeInfo = this.Filter.Bcode_Start;
                        }
                        for (var i in this.Inf20List) {
                            var inf20Item = this.Inf20List[i];
                            inf20idList.push(inf20Item.id);
                        }
                        if (inf20idList.length == 0) {
                            alert("無查詢資料");
                            return;
                        }

                        LoadingHelper.showLoading();
                        return $.ajax({
                            type: "POST",
                            url: rootUrl + "Dinp02001/Ajax/Inf20Handler.ashx",
                            cache: false,
                            data: {
                                act: "print",
                                data: JSON.stringify(inf20idList),
                                printBcode: JSON.stringify(bcodeInfo),
                            },
                            dataType: "text",
                            success: function (result) {
                                if (result != "") {
                                    printJS({
                                        printable: rootUrl + "Dinp02001/Ajax/Inf20Print.ashx?session=" + result,
                                        type: "pdf",
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
                    OnImport: function () {
                        // reset dialog
                        this.$refs.ImportExcelInput.value = null;
                    },
                    OnExit: function () {
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
                    GetExportFields: function () {
                        var vueObj = this;
                        return $.ajax({
                            type: 'GET',
                            url: rootUrl + "Dinp02001/Ajax/GetExportFields.ashx",
                            cache: true,
                            dataType: 'text',
                            success: function (exportFieldsJson) {
                                var exportFields = JSON.parse(exportFieldsJson);
                                vueObj.Export.Inf20List = exportFields[0];
                                vueObj.Export.Inf20aList = exportFields[1];
                            },
                            error: function (jqXhr, textStatus, errorThrown) {
                                if (jqXhr.status == 0) {
                                    return;
                                }
                                console.error(errorThrown);
                            }
                        });

                    },
                    OnExportSubmit: function () {
                        var vueObj = this;
                        // Get inf20 id list
                        var inf20idList = [];
                        for (var i in this.Inf20List) {
                            var inf20Item = this.Inf20List[i];
                            inf20idList.push(inf20Item.id);
                        }
                        if (inf20idList.length == 0) {
                            $(this.$refs.ExportDialog).modal('hide');
                            return $.when(null);
                        }

                        var inf20fields = this.Export.Inf20List.filter(function (item, index, array) {
                            return vueObj.Export.SelectedInf20List.indexOf(item.cnf0502_field) >= 0;
                        });
                        var inf20afields = this.Export.Inf20aList.filter(function (item, index, array) {
                            return vueObj.Export.SelectedInf20aList.indexOf(item.cnf0502_field) >= 0;
                        });

                        LoadingHelper.showLoading();
                        return $.ajax({
                            type: "POST",
                            url: rootUrl + "Dinp02001/Ajax/Inf20Handler.ashx",
                            cache: false,
                            data: {
                                act: "export",
                                inf20fields: JSON.stringify(inf20fields),
                                inf20afields: JSON.stringify(inf20afields),
                                data: JSON.stringify(inf20idList)
                            },
                            dataType: 'text',
                            success: function (result) {
                                LoadingHelper.hideLoading();
                                if (result == "ok") {
                                    $(vueObj.$refs.ExportDialog).modal('hide');
                                    location.href = rootUrl + "Dinp02001/Ajax/Inf20Export.ashx";
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
                    }, OnExport: function () {


                    },
                    OnDelete: function () {
                        console.log("A");

                        if (this.SelectedInf20Item == null) {
                            return;
                        }
                        if (this.SelectedInf20Item.adduser.toLowerCase() != loginUserName.toLowerCase()) {
                            alert("只可以刪除自己的資料");
                            return;
                        }
                        if (!confirm("是否確認刪除?")) {
                            return;
                        }
                        LoadingHelper.showLoading();
                        var vueObj = this;

                        return $.ajax({
                            type: "POST",
                            url: rootUrl + "Dinp02001/Ajax/Inf20Handler.ashx",
                            cache: false,
                            data: {
                                act: "del",
                                data: this.SelectedInf20Item.inf2001_docno
                            },
                            dataType: "text",
                            success: function (result) {
                                LoadingHelper.hideLoading();
                                if (result != "ok") {
                                    console.log(result);
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
                    OnSubRowClick: function (inf20aItem) {
                        if (this.SelectedInf20aItem == inf20aItem) {
                            this.SelectedInf20aItem = null;
                        } else {
                            this.SelectedInf20aItem = inf20aItem;
                        }
                    },
                    OnMainRowClick: function (inf20Item) {
                        if (this.SelectedInf20Item == inf20Item) {
                            this.SelectedInf20Item = null;
                            this.SelectedInf20aItem = null;
                            this.Inf20aList = [];
                        } else {
                            this.SelectedInf20Item = inf20Item;
                            this.GetInf20aList(inf20Item.inf2001_docno);
                        }
                    },
                    GetInf20aList: function (docno) {
                        LoadingHelper.showLoading();
                        var vueObj = this;
                        return $.ajax({
                            type: "POST",
                            url: rootUrl + "Dinp02001/Ajax/Inf20Handler.ashx",
                            cache: false,
                            data: {
                                act: "getdetail",
                                data: docno
                            },
                            dataType: "text",
                            success: function (inf20aListJson) {
                                LoadingHelper.hideLoading();
                                var inf20aList = JSON.parse(inf20aListJson);
                                vueObj.Inf20aList = inf20aList;
                                if (vueObj.SortColumn != null) {
                                    console.warn("todo sort");
                                    // inf20List.sort(vueObj.SortCnf05List);
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
                    OnSearch: function () {
                        var vueObj = this;
                        console.log("OnSearch");
                        vueObj.SelectedInf20Item = null;
                        vueObj.SelectedInf20aItem = null;
                        vueObj.Inf20aList = [];
                        LoadingHelper.showLoading();



                        return $.ajax({
                            type: "POST",
                            url: rootUrl + "Dinp02001/Ajax/Inf20Handler.ashx",
                            cache: false,
                            data: {
                                act: "get",
                                data: JSON.stringify(vueObj.Filter)
                            },
                            dataType: "text",
                            success: function (inf20ListJson) {
                                LoadingHelper.hideLoading();
                                var inf20List = JSON.parse(inf20ListJson);
                                vueObj.Inf20List = inf20List;


                                if (vueObj.Inf20List.length == 0) {
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




                    }

                }

            });


        }
        function dinp02001Edit(appversion) {

            window.dinp02001Edit = new Vue({
                el: "#Dinp02001Edit",
                data: {
                    AppVersion: appversion,
                    Inf20Item: {
                        id: null,//儲存成功後從伺服器返回
                        BCodeInfo: null, //公司代號相關資料
                        inf2002_docno_type: "PO", //單據分類編號. 組成採購單號
                        inf2002_docno_date: null, //異動單號_日期. 組成採購單號
                        inf2002_docno_seq: null,//採購單號_流水號, 儲存成功後從伺服器返回
                        inf2009_order_date: null,//採購日期
                        inf2022_cmp_empid: null,//採購人員
                        inf2044_bname: null,//廠商聯絡人
                        inf2037_recid:null,//廠商聯絡人序號
                        inf03a18_tel01:null,//廠商連絡電話
                        inf03a24_cellphone:null,//廠商連絡手機
                        SelectedCurrencyInfo: null, //幣別
                        inf2025_exchnge_rate: 1, //匯率
                        inf2033_delivery_place: null,//交貨地址
                        EmpInfo: null,//採購人員資訊
                        ManufacturerInfo: null,//廠商資訊
                        ManufacturerEmpInfo: null,//廠商聯絡人資訊
                        PayInfo: null,//付款資訊
                        remark: null,//備註
                        adddate: null,
                        adduser: null,
                        moddate: null,
                        moduser: null
                    },
                    Inf20aItem: {
                        inf20a01_docno: null,//單據編號
                        inf20a02_seq: null,//序號
                        inf20a04_pcode: null, //產品編號
                        inf20a38_product_name: null,//產品名稱
                        inf20a57_pclass: null,//貨號
                        inf20a16_punit: null,//進貨單位
                        inf20a58_cost_notax: null,//未稅單價,
                        inf20a07_ocost: null,//含稅單價,
                        inf20a41_tax: null,//營業稅率
                        inf20a24_tax: null,//稅碼
                        inf20a06_qty: null,//採購數量
                        inf20a12_dis_qty: null,//贈品數量
                        inf20a23_box_qty: null,//大單位數量
                        inf0164_dividend: null,//換算值
                        inf20a23_qty: null,//小單位數量
                        inf20a09_sub_amt: null,//金額小計
                        remar: null,
                        adddate: null,
                        adduser: null,
                        moddate: null,
                        moduser: null,
                    },
                    IsDpCodeDisplay: false,
                    Display: false,
                    Inf29aItem: [],
                    PayList: selectObj.PayList,//付款方式下拉選單資料
                    ManufacturerList: selectObj.ManufacturerList,//廠商下拉選單資料
                    ManufacturerEmpList: selectObj.ManufacturerEmpList,//所有廠商聯絡人資料
                    thisManufacturerEmpList: [],//選擇的廠商聯絡人所有資料
                    EmpList: selectObj.EmpList,//採購人員下拉選單資料
                    BcodeList: selectObj.BcodeList, //公司代號下拉選單資料
                    WherehouseList: [], //倉庫代號下拉選單資料
                    InReasonList: [], //異動代號下拉選單資料
                    CurrencyList: [], //幣別下拉選單來源
                    UiDateFormat: "Y/m/d",
                    ConfirmList: ["N", "Y"],
                    SelectedInf20aItem: null, //table被選中的row
                    Inf20Copy: null, //儲存複製的備份
                    SortColumn: null,
                    SortOrder: null,
                }, components: {
                    Multiselect: vueMultiselect.default
                }, mounted: function () {


                }, methods: {
                    OnPcodeChange: function (pcode) {

                    },
                    OnDPCodeResult: function (productInfo) {
                        this.Display = true;
                        this.IsDpCodeDisplay = false;
                        if (productInfo == null) {
                            return;
                        }

                        var vueObj = this;
                        vueObj.Inf20aItem.inf20a57_pclass = productInfo.pclass;
                        vueObj.Inf20aItem.inf20a16_punit = productInfo.runit;
                        vueObj.Inf20aItem.inf20a58_cost_notax = productInfo.runit;

                    },
                    OnAdd: function () {
                        if (this.IsDpCodeDisplay) {
                            return;
                        }
                        this.Reset();
                    },
                    Reset: function () {
                        var asyncTasks = [];
                        //預設公司
                        var defaultBCodeInfo = this.BcodeList.filter(function (item, index, array) {
                            return item.cnf0751_tax_headoffice == "0";
                        }).shift();

                        
                        //預設幣別
                        var defaultCurrency = this.CurrencyList.filter(function (item, index, array) {
                            return item.cnf1003_char01 == "NTD";
                        }).shift();


                        this.Inf20Item = {
                            id: null,//儲存成功後從伺服器返回
                            BCodeInfo: defaultBCodeInfo, //公司代號相關資料
                            inf2002_docno_type: "PO", //單據分類編號. 組成採購單號
                            inf2002_docno_date: null, //異動單號_日期. 組成採購單號
                            inf2002_docno_seq: null,//採購單號_流水號, 儲存成功後從伺服器返回
                            inf2009_order_date: null,//採購日期
                            inf2022_cmp_empid: null,//採購人員
                            inf2044_bname: null,//廠商聯絡人
                            inf2037_recid: null,//廠商聯絡人序號
                            inf03a18_tel01: null,//廠商連絡電話
                            inf03a24_cellphone: null,//廠商連絡手機
                            SelectedCurrencyInfo: defaultCurrency, //幣別
                            inf2025_exchnge_rate: 1, //匯率
                            inf2033_delivery_place: null,//交貨地址
                            EmpInfo: null,//採購人員資訊
                            ManufacturerInfo: null,//廠商資訊
                            ManufacturerEmpInfo: null,//廠商聯絡人資訊
                            PayInfo: null,//付款資訊
                            remark: null,//備註
                            adddate: null,
                            adduser: null,
                            moddate: null,
                            moduser: null

                        };
                        this.Inf20Item.adduser = loginUserName;
                        //重設時間
                        var now = new Date();
                        this.Inf20Item.inf2002_docno_date = now.dateFormat("Ymd");
                        this.Inf20Item.adddate = now.dateFormat(this.UiDateFormat);

                        //重設Inf20a
                        this.ResetInf20a();


                    },
                    ResetInf20a: function () {
                        this.Inf20aItem = {
                            inf20a01_docno: null,//單據編號
                            inf20a02_seq: null,//序號
                            inf20a04_pcode: null, //產品編號
                            inf20a38_product_name: null,//產品名稱
                            inf20a57_pclass: null,//貨號
                            inf20a16_punit: null,//進貨單位
                            inf20a58_cost_notax: null,//未稅單價,
                            inf20a07_ocost: null,//含稅單價,
                            inf20a41_tax: null,//營業稅率
                            inf20a24_tax: null,//稅碼
                            inf20a06_qty: null,//採購數量
                            inf20a12_dis_qty: null,//贈品數量
                            inf20a23_box_qty: null,//大單位數量
                            inf0164_dividend: null,//換算值
                            inf20a23_qty: null,//小單位數量
                            inf20a09_sub_amt: null,//金額小計

                            remark: null,
                            adddate: null,
                            adduser: null,
                            moddate: null,
                            moduser: null,
                        }
                        this.SelectedInf20aItem = null;
                        this.Inf20aItem.adduser = loginUserName;
                        var now = new Date();
                        this.Inf20aItem.adddate = now.dateFormat(this.UiDateFormat);
                    },
                    OnExit: function () {

                        this.Display = false;
                        window.dinp02001Search.Display = true;
                    },
                    OnDelete: function() {
                        console.log("B");
                        window.dinp02001Search.OnDelete();
                    },
                    OnDeleteInf20aItem: function () {//刪除明細
                        if (this.SelectedInf20aItem == null) {
                            return;
                        }
                        if (confirm("是否確認刪除明細?")) {
                            var index = this.Inf20aList.indexOf(this.SelectedInf20aItem);
                            this.Inf20aList.splice(index, 1);
                        }
                    },
                    PaySelectLabel: function (pay) {
                        return pay.cnf1002_fileorder + "-" + pay.cnf1003_char01;
                    },
                    BcodeSelectLabel: function (bcode) {
                        return bcode.cnf0701_bcode + "-" + bcode.cnf0703_bfname;
                    },
                    EmpSelectLabel: function (emp) {
                        return emp.taf1001_empid + "-" + emp.taf1004_cname;
                    },
                    getthisManufacturerEmpList: function () {
                        var vueobj = this;
                        vueobj.thisManufacturerEmpList = [];
                        vueobj.Inf20Item.ManufacturerEmpInfo = null;
                        vueobj.Inf20Item.inf03a18_tel01 = null;
                        vueobj.Inf20Item.inf03a24_cellphone = null;
                        if (vueobj.Inf20Item.ManufacturerInfo) {
                            vueobj.thisManufacturerEmpList = vueobj.ManufacturerEmpList.filter(function(data) {
                                return data.inf03a01_bcode === vueobj.Inf20Item.ManufacturerInfo.inf0302_mcode;

                            });
                            vueobj.Inf20Item.ManufacturerEmpInfo = vueobj.thisManufacturerEmpList[0];
                            this.Inf20Item.inf03a18_tel01 = this.Inf20Item.ManufacturerEmpInfo.inf03a18_tel01;
                            this.Inf20Item.inf03a24_cellphone = this.Inf20Item.ManufacturerEmpInfo.inf03a24_cellphone;
                        } 

                       

                    },
                    getthisManufacturerEmpTel: function () {
                        this.Inf20Item.inf03a18_tel01 = null;
                        this.Inf20Item.inf03a24_cellphone = null;
                        if (this.Inf20Item.ManufacturerEmpInfo) {
                            this.Inf20Item.inf03a18_tel01 = this.Inf20Item.ManufacturerEmpInfo.inf03a18_tel01;
                            this.Inf20Item.inf03a24_cellphone = this.Inf20Item.ManufacturerEmpInfo.inf03a24_cellphone;
                        }

                        
                    },

                    ManufacturerSelectLabel: function (manufacturer) {

                        return manufacturer.inf0302_mcode + "-" + manufacturer.inf0302_bname;
                    },
                    ManufacturerEmpSelectLabel: function (emp) {
                       

                        return emp.inf03a03_rec_id + "-" + emp.inf03a06_fname;
                    },

                    WherehouseSelectLabel: function (wherehouse) {
                        return wherehouse.cnf1002_fileorder + "-" + wherehouse.cnf1003_char01;
                    },
                    InReasonSelectLabel: function (inReason) {
                        return inReason.cnf1002_fileorder + "-" + inReason.cnf1003_char01;
                    }, OnCustomCodeChange: function () {

                    }, GetExchangeInfo: function () {

                    }, ShowDpCodeWindow: function () {
                        this.Display = false;
                        this.IsDpCodeDisplay = true;
                    }

                }, computed: {
                   
                    Inf20Item_Inf2001DocNo: function () {
                        var seq = "";
                        if (this.Inf20Item.inf2002_docno_seq == null ||
                            this.Inf20Item.inf2002_docno_seq === "") {
                        } else {
                            seq = (this.Inf20Item.inf2002_docno_seq + "").padStart("4", "0");
                        }
                        return this.Inf20Item.inf2002_docno_type + this.Inf20Item.inf2002_docno_date + seq;
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
                        return this.Inf29aItem.inf29a39_price * this.Inf29aItem.inf29a13_sold_qty + this.Inf29aItem.inf29a36_odds_amt * 1;
                    },
                    Inf29aItem_Inf29a12SubAmt: function () { //換算後幣值小計
                        return this.Inf29aItem.inf29a09_retail_one * this.Inf29aItem.inf29a13_sold_qty;
                    }
                },
            });
        }


    }

    function onError(error) {
        console.error(error);
    }

    define(requiredFiles, onLoaded, onError);

})();