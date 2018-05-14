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
        },
        shim: {
            "jquery.datetimepicker": {
                "deps": ["css!jqueryDatetimepicker-css"]
            },
            "vue-jQuerydatetimepicker": {
                "deps": ['jquery.datetimepicker']
            },
        },
        map: {
            '*': {
                'jquery-mousewheel': 'jquery.mousewheel'
            }
        }
    });

    var requiredFiles = ["bootstrap",
        "FunctionButton",
        "vue-jQuerydatetimepicker",
        "LoadingHelper",
        "jquery.mousewheel",
        "UserLog",
        "print-js",
        "vue-multiselect"
    ];

    function onLoaded(bootstrap,
        functionButton,
        vueDatetimepicker,
        loadingHelper,
        jqMousewheel,
        userLog,
        printJs,
        vueMultiselect) {
        if (vueMultiselect == null) {
            console.error("vueMultiselect fallback");
            vueMultiselect = window.VueMultiselect;
        }
        console.log("dinp02401Search");
        window.dinp02401Search = new Vue({
            el: "#Dinp02401Search",
            data: {
                Display: true,
                Filter: {
                    ProDateStart: null,
                    ProDateEnd: null,

                    PcodeStart: null,
                    PcodeEnd: null,

                    PCodeVStart: null,
                    PCodeVEnd: null,

                    WherehouseStart: null,
                    WherehouseEnd: null,

                    ShoesCodeStart: null,
                    ShoesCodeEnd: null,

                    CustomerCodeStart: null,
                    CustomerCodeEnd: null,

                    AddDateStart: null,
                    AddDateEnd: null,

                    BcodeStart: null,
                    BcodeEnd: null,

                    OrderNoStart: null,
                    OrderNoEnd: null,

                    Upbound: 0,
                    Keyword: null,
                },
                BcodeList: [], //公司代號下拉選單資料
                WherehouseList: [], //倉庫代號下拉選單資料
                Saf20List: [], // source data from server
                Saf20aList: [], // source data from server
                Export: {
                    Saf20List: [],
                    Saf20aList: [],
                    SelectedSaf20List: [],
                    SelectedSaf20aList: []
                },
                SelectedSaf20Item: null,
                SelectedSaf20aItem: null,
                UiDateFormat: "Y/m/d",
                Saf20SortColumn:null,
                Saf20SortOrder:null,
                Saf20aSortColumn:null,
                Saf20aSortOrder:null,
            },
            components: {
                Multiselect: vueMultiselect.default
            },
            computed: {

            },
            methods: {
                OnSearch: function () {
                    console.log("OnSearch");
                    this.SelectedSaf20Item = null;
                    this.SelectedSaf20aItem = null;
                    this.Saf20aList = [];

                    var filterOption = {

                        saf2023_ship_date_start:this.Filter.ProDateStart,
                        saf2023_ship_date_end: this.Filter.ProDateEnd,

                        saf20a37_pcode_start:this.Filter.PcodeStart,
                        saf20a37_pcode_end: this.Filter.PcodeEnd,

                        saf20a36_pcode_v_start:this.Filter.PCodeVStart,
                        saf20a36_pcode_v_end: this.Filter.PCodeVEnd,

                        saf20a107_wherehouse_start: (this.Filter.WherehouseStart || {}).cnf1002_fileorder,
                        saf20a107_wherehouse_end: (this.Filter.WherehouseEnd || {}).cnf1002_fileorder,

                        saf20111_cuscode_start: this.Filter.CustomerCodeStart,
                        saf20111_cuscode_end: this.Filter.CustomerCodeEnd,

                        adddate_start: this.Filter.AddDateStart,
                        adddate_end: this.Filter.AddDateEnd,

                        saf20115_bcode_start: (this.Filter.BcodeStart || {}).cnf0701_bcode,
                        saf20115_bcode_end: (this.Filter.BcodeEnd || {}).cnf0701_bcode,

                        saf20116_src_docno_no_start: this.Filter.OrderNoStart,
                        saf20116_src_docno_end: this.Filter.OrderNoEnd,

                        keyword: this.Filter.Keyword,
                        saf20a41_ord_qty: this.Filter.Upbound,
                       
                    };

                    LoadingHelper.showLoading();
                    var vueObj = this;
                    return $.ajax({
                        type: 'POST',
                        url: rootUrl + "Dinp/Ajax/Saf20Handler.ashx",
                        cache: false,
                        data: {
                            act: "get",
                            data: JSON.stringify(filterOption)
                        },
                        dataType: 'text',
                        success: function (Saf20ListJson) {
                            LoadingHelper.hideLoading();
                            var Saf20List = JSON.parse(Saf20ListJson);
                            vueObj.Saf20List = Saf20List;
                            if (vueObj.SortColumn != null) {
                                console.warn("todo sort");
                                // Saf20List.sort(vueObj.SortCnf05List);
                            }
                            for (var i in Saf20List) {
                                Saf20List[i].adddate = new Date(Saf20List[i].adddate).dateFormat('Y/m/d');
                                if (Saf20List[i].moddate) {
                                    Saf20List[i].moddate = new Date(Saf20List[i].moddate).dateFormat('Y/m/d');
                                }
                                if (Saf20List[i].Saf2004_pro_date) {
                                    Saf20List[i].Saf2004_pro_date = new Date(Saf20List[i].Saf2004_pro_date).dateFormat('Ymd');
                                }

                            }
                            if (Saf20List.length == 0) {
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
                OnMainRowClick: function (saf20Item) {
                    if(this.SelectedSaf20Item==saf20Item){
                        this.SelectedSaf20Item = null;
                        this.SelectedSaf20aItem = null;
                        this.Saf20aList = [];
                    } else {
                        this.SelectedSaf20Item = saf20Item;
                        this.GetSaf20aList(saf20Item.Saf2001_docno);
                    }
                    
                },
                OnSubRowClick: function (Saf20aItem) {
                    if(this.SelectedSaf20aItem==Saf20aItem){
                        this.SelectedSaf20aItem = null;
                    } else {
                        this.SelectedSaf20aItem = Saf20aItem;
                    }
                },
                OnAdd: function () {
                    console.log("OnAdd");
                    this.Display = false;
                    window.dinp02401Edit.Display = true;
                    window.dinp02401Edit.Reset();
                },
                OnDelete: function () {
                    if (this.SelectedSaf20Item == null) {
                        return;
                    }
                    if (this.SelectedSaf20Item.adduser.toLowerCase() != loginUserName.toLowerCase()) {
                        alert("只可以刪除自己的資料");
                        return;
                    }
                    if (!confirm("是否確認刪除?")) {
                        return;
                    }
                    LoadingHelper.showLoading();
                    var vueObj = this;
                    return $.ajax({
                        type: 'POST',
                        url: rootUrl + "Dinp/Ajax/Saf20Handler.ashx",
                        cache: false,
                        data: {
                            act: "del",
                            data: this.SelectedSaf20Item.Saf2001_docno
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
                OnExportAllFieldClick: function (checkAllSaf20, checkAllSaf20a) {
                    if (checkAllSaf20 == null) {
                        this.Export.SelectedSaf20aList = [];
                        if (checkAllSaf20a) {
                            for (var i in this.Export.Saf20aList) {
                                var field = this.Export.Saf20aList[i];
                                this.Export.SelectedSaf20aList.push(field.cnf0502_field);
                            }
                        } 
                    } else {
                        this.Export.SelectedSaf20List = [];
                        if (checkAllSaf20) {
                            for (var i in this.Export.Saf20List) {
                                var field = this.Export.Saf20List[i];
                                this.Export.SelectedSaf20List.push(field.cnf0502_field);
                            }
                        } 
                    }
                },
                OnExportSubmit: function () {
                    var vueObj = this;
                    // Get Saf20 id list
                    var Saf20idList = [];
                    for (var i in this.Saf20List) {
                        var saf20Item = this.Saf20List[i];
                        Saf20idList.push(saf20Item.id);
                    }
                    if (Saf20idList.length == 0) {
                        $(this.$refs.ExportDialog).modal('hide');
                        return $.when(null);
                    }

                    var Saf20fields = this.Export.Saf20List.filter(function(item, index, array){
                        return vueObj.Export.SelectedSaf20List.indexOf(item.cnf0502_field)>=0;
                    });
                    var Saf20afields = this.Export.Saf20aList.filter(function(item, index, array){
                        return vueObj.Export.SelectedSaf20aList.indexOf(item.cnf0502_field)>=0;
                    });

                    LoadingHelper.showLoading();
                    return $.ajax({
                        type: 'POST',
                        url: rootUrl + "Dinp/Ajax/Saf20Handler.ashx",
                        cache: false,
                        data: {
                            act: "export",
                            Saf20fields: JSON.stringify(Saf20fields),
                            Saf20afields: JSON.stringify(Saf20afields),
                            data:JSON.stringify(Saf20idList)
                        },
                        dataType: 'text',
                        success: function (result) {
                            LoadingHelper.hideLoading();
                            if (result == "ok") {
                                $(vueObj.$refs.ExportDialog).modal('hide');
                                location.href = rootUrl + "Dinp/Ajax/Saf20Export.ashx";
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
                    if(files.length==0){
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
                        url: rootUrl + "Dinp/Ajax/Saf20Handler.ashx",
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
                OnCopy: function () {
                    if(this.SelectedSaf20Item==null){
                        return;
                    }
                    var vueObj = this;
                    var resetTask = window.dinp02401Edit.Reset();
                    window.dinp02401Edit.Display = true;
                    window.dinp02401Search.Display = false;
                    // send selected Saf20 to dinpEdit object
                    resetTask.done(function() {
                        window.dinp02401Edit.SetCopy(vueObj.SelectedSaf20Item);
                    });
                    // get Saf20aList from server, remove id...

                    var saf20Item = {
                        id:null,//儲存成功後從伺服器返回
                        BCodeInfo: null, //公司代號相關資料
                        Saf2002_docno_type: "XC", //單據分類編號. 組成異動單號
                        Saf2002_docno_date: null, //異動單號_日期. 組成異動單號
                        Saf2004_pro_date: null, //異動日期
                        Saf2002_docno_seq:null,//異動單號_流水號, 儲存成功後從伺服器返回
                        SelectedWherehouse: null, //選中的倉庫代號
                        Saf2052_project_no: null, //專案代號
                        ProjectFullname: null, //專案全名
                        Saf2016_apr_empid: null, //員工ID
                        EmpCname: null, //員工Name
                        Saf2003_customer_code: null, //客戶代碼
                        Saf2003CustomerCodeName: null, //cmf0104_fname客戶名稱
                        Saf2006_ref_no_type: null, //單據來源
                        Saf2006_ref_no_date: null, //單據來源
                        Saf2006_ref_no_seq: null, //單據來源
                        SelectedInReason: null, //異動代號
                        Saf2010_in_reason: null, //異動代號
                        remark: null,
                        adddate: null,
                        adduser: null,
                        moddate: null,
                        moduser: null,
                    };
                },
                OnPrint: function () {
                    var vueObj = this;
                    var bcodeInfo = null;
                    if(this.Filter.BcodeStart==this.Filter.BcodeEnd){
                        bcodeInfo = this.Filter.BcodeStart;
                    }
                    var Saf20idList = [];
                    for (var i in this.Saf20List) {
                        var saf20Item = this.Saf20List[i];
                        Saf20idList.push(saf20Item.id);
                    }
                    if(Saf20idList.length==0){
                        alert("無查詢資料");
                        return;
                    }
                    LoadingHelper.showLoading();
                    return $.ajax({
                        type: 'POST',
                        url: rootUrl + "Dinp/Ajax/Saf20Handler.ashx",
                        cache: false,
                        data: {
                            act: "print",
                            data:JSON.stringify(Saf20idList),
                            printBcode:JSON.stringify(bcodeInfo),
                        },
                        dataType: 'text',
                        success: function (result) {
                            if (result != "") {
                                printJS({printable: rootUrl + "Dinp/Ajax/Saf20Print.ashx?session="+result,
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
                },
                OnImport:function(){
                    // reset dialog
                    this.$refs.ImportExcelInput.value = null
                },
                OnExit:function(){
                    //igonre if other exit event triggered
                    if($(this.$refs.ExportDialog).hasClass('in')
                        || $(this.$refs.ImportExcelDialog).hasClass('in')
                        || $(this.$refs.HelpDialog).hasClass('in') ){
                        return;
                    }
                    window.close();
                    setTimeout(function(){
                        window.location.href="about:blank";
                    },500);
                },
                AutoFillFilter: function (field, value, type) {
                    this.Filter[field] = value;
                    if (type == "datetime") {
                        this.$refs["Filter" + field].setValue(value);
                    }
                },
                OnSaf20TableSorting: function (column) {
                    if (this.Saf20SortColumn == column) {
                        if (this.Saf20SortOrder == "asc") {
                            this.Saf20SortOrder = "desc";
                        } else {
                            this.Saf20SortOrder = "asc";
                        }
                    } else {
                        this.Saf20SortOrder = "asc";
                    }
                    this.Saf20SortColumn = column;

                    this.Saf20List.sort(this.SortSaf20List);
                },
                OnSaf20aTableSorting: function (column) {
                    if (this.Saf20aSortColumn == column) {
                        if (this.Saf20aSortOrder == "asc") {
                            this.Saf20aSortOrder = "desc";
                        } else {
                            this.Saf20aSortOrder = "asc";
                        }
                    } else {
                        this.Saf20aSortOrder = "asc";
                    }
                    this.Saf20aSortColumn = column;

                    this.Saf20aList.sort(this.SortSaf20aList);
                },
                SortSaf20List:function(a, b){
                    var paramA = a[this.Saf20SortColumn] || "";
                    var paramB = b[this.Saf20SortColumn] || "";
                    if (paramA < paramB) {
                        return this.Saf20SortOrder == 'asc' ? -1 : 1;
                    }
                    if (paramA > paramB) {
                        return this.Saf20SortOrder == 'asc' ? 1 : -1;
                    }
                    if (a["id"] < b["id"]) {
                        return this.Saf20SortOrder == 'asc' ? -1 : 1;

                    }
                    if (a["id"] > b["id"]) {
                        return this.Saf20SortOrder == 'asc' ? 1 : -1;
                    }
                    return 0;
                },
                SortSaf20aList:function(a, b){
                    var paramA = a[this.Saf20aSortColumn] || "";
                    var paramB = b[this.Saf20aSortColumn] || "";
                    if (paramA < paramB) {
                        return this.Saf20aSortOrder == 'asc' ? -1 : 1;
                    }
                    if (paramA > paramB) {
                        return this.Saf20aSortOrder == 'asc' ? 1 : -1;
                    }
                    if (a["id"] < b["id"]) {
                        return this.Saf20aSortOrder == 'asc' ? -1 : 1;

                    }
                    if (a["id"] > b["id"]) {
                        return this.Saf20aSortOrder == 'asc' ? 1 : -1;
                    }
                    return 0;
                },
                GetWherehouseName: function (wherehouse) {
                    var wherehouseInfo = this.WherehouseList.filter(function(item, index, array){
                        return item.cnf1002_fileorder==wherehouse;
                    }).shift();
                    return (wherehouseInfo || {}).cnf1003_char01;
                },
                GetInReasonName: function (inReason) {
                    return "inReason";
                },
                GetCustomerName: function (customerCode) {
                    return "customerCode";
                },
                GetSaf20aList: function (docno) {
                    LoadingHelper.showLoading();
                    var vueObj = this;
                    return $.ajax({
                        type: 'POST',
                        url: rootUrl + "Dinp/Ajax/Saf20Handler.ashx",
                        cache: false,
                        data: {
                            act: "getdetail",
                            data: docno
                        },
                        dataType: 'text',
                        success: function (Saf20aListJson) {
                            LoadingHelper.hideLoading();
                            var Saf20aList = JSON.parse(Saf20aListJson);
                            vueObj.Saf20aList = Saf20aList;
                            if (vueObj.SortColumn != null) {
                                console.warn("todo sort");
                                // Saf20List.sort(vueObj.SortCnf05List);
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
                            vueObj.Export.Saf20List = exportFields[0];
                            vueObj.Export.Saf20aList = exportFields[1];
                        },
                        error: function (jqXhr, textStatus, errorThrown) {
                            if (jqXhr.status == 0) {
                                return;
                            }
                            console.error(errorThrown);
                        }
                    });
                },
                BcodeSelectLabel: function (bcode) {
                    return bcode.cnf0701_bcode + "-" + bcode.cnf0703_bfname;
                },
                WherehouseSelectLabel: function (wherehouse) {
                    return wherehouse.cnf1002_fileorder + "-" + wherehouse.cnf1003_char01;
                },
                SetBCodeList: function (bcodeList) {
                    this.BcodeList = bcodeList;
                    //預設公司代號
                    var defaultBCodeInfo = this.BcodeList.filter(function (item, index, array) {
                        return item.cnf0751_tax_headoffice == "0";
                    }).shift();
                    if (defaultBCodeInfo) {
                        this.Filter.BcodeStart = defaultBCodeInfo;
                        this.Filter.BcodeEnd = defaultBCodeInfo;
                    }
                },
            },
            directives: {

            },
            mounted: function () {
                SaveEnterPageLog(rootUrl, loginUserName, "Dinp02401");
                this.GetExportFields();
            }
        });
    }

    function onError(error) {
        console.error(error);
    }

    define(requiredFiles, onLoaded, onError);

})();