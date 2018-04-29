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
        window.dinp02301Search = new Vue({
            el: "#Dinp02301Search",
            data: {
                Display: true,
                Filter: {
                    OrderDateStart: null,
                    OrderDateEnd: null,
                    PcodeStart: null,
                    PcodeEnd: null,
                    RelativenoStart: null,
                    RelativenoEnd: null,
                    WherehouseStart: null,
                    WherehouseEnd: null,
                    InReasonStart: null,
                    InReasonEnd: null,
                    CustomerCodeStart: null,
                    CustomerCodeEnd: null,
                    AddDateStart: null,
                    AddDateEnd: null,
                    BcodeStart: null,
                    BcodeEnd: null,
                    DocnoTypeStart: null,
                    DocnoTypeEnd: null,
                    DocnoDateStart: null,
                    DocnoDateEnd: null,
                    DocnoOrderNoStart: null,
                    DocnoOrderNoEnd: null,
                    Keyword: null,
                    GreaterOrEqual:null
                },
                BcodeList: [], //公司代號下拉選單資料
                WherehouseList: [], //倉庫代號下拉選單資料
                Saf21List: [], // source data from server
                Saf21aList: [], // source data from server
                Export: {
                    Saf21List: [],
                    Saf21aList: [],
                    SelectedSaf21List: [],
                    SelectedSaf21aList: []
                },
                SelectedSaf21Item: null,
                SelectedSaf21aItem: null,
                UiDateFormat: "Y/m/d",
                Saf21SortColumn:null,
                Saf21SortOrder:null,
                Saf21aSortColumn:null,
                Saf21aSortOrder:null,
            },
            components: {
                Multiselect: vueMultiselect.default
            },
            computed: {

            },
            methods: {
                OnSearch: function () {
                    console.log("OnSearch");
                    this.SelectedSaf21Item = null;
                    this.SelectedSaf21aItem = null;
                    this.Saf21aList = [];

                    var filterOption = {
                        keyword: this.Filter.Keyword,
                        inf2904_pro_date_start:this.Filter.ProDateStart,
                        inf2904_pro_date_end:this.Filter.ProDateEnd,
                        inf29a05_pcode_start:this.Filter.PcodeStart,
                        inf29a05_pcode_end:this.Filter.PcodeEnd,
                        inf29a05_shoes_code_start:this.Filter.ShoesCodeStart,
                        inf29a05_shoes_code_end:this.Filter.ShoesCodeEnd,
                        inf2952_project_no_start:this.Filter.ProjectNoStart,
                        inf2952_project_no_end:this.Filter.ProjectNoEnd,
                        inf2906_wherehouse_start:(this.Filter.WherehouseStart||{}).cnf1002_fileorder,
                        inf2906_wherehouse_end:(this.Filter.WherehouseEnd||{}).cnf1002_fileorder,
                        inf2910_in_reason_start:this.Filter.InReasonStart,
                        inf2910_in_reason_end:this.Filter.InReasonEnd,
                        inf2903_customer_code_start:this.Filter.CustomerCodeStart,
                        inf2903_customer_code_end:this.Filter.CustomerCodeEnd,
                        inf2901_bcode_start:(this.Filter.BcodeStart||{}).cnf0701_bcode,
                        inf2901_bcode_end:(this.Filter.BcodeEnd||{}).cnf0701_bcode,
                        inf2906_ref_no_type_start:this.Filter.RefNoTypeStart,
                        inf2906_ref_no_type_end:this.Filter.RefNoTypeEnd,
                        inf2906_ref_no_date_start:this.Filter.RefNoDateStart,
                        inf2906_ref_no_date_end:this.Filter.RefNoDateEnd,
                        adddate_start:this.Filter.AddDateStart,
                        adddate_end:this.Filter.AddDateEnd,
                    };
                    LoadingHelper.showLoading();
                    var vueObj = this;
                    return $.ajax({
                        type: 'POST',
                        url: rootUrl + "Dinp/Ajax/Inf29Handler.ashx",
                        cache: false,
                        data: {
                            act: "get",
                            data: JSON.stringify(filterOption)
                        },
                        dataType: 'text',
                        success: function (saf21ListJson) {
                            LoadingHelper.hideLoading();
                            var saf21List = JSON.parse(saf21ListJson);
                            vueObj.Saf21List = saf21List;
                            if (vueObj.SortColumn != null) {
                                console.warn("todo sort");
                                // inf29List.sort(vueObj.SortCnf05List);
                            }
                            for (var i in saf21List) {
                                saf21List[i].adddate = new Date(saf21List[i].adddate).dateFormat('Y/m/d');
                                if (saf21List[i].moddate) {
                                    saf21List[i].moddate = new Date(saf21List[i].moddate).dateFormat('Y/m/d');
                                }
                                if (saf21List[i].inf2904_pro_date) {
                                    saf21List[i].inf2904_pro_date = new Date(saf21List[i].inf2904_pro_date).dateFormat('Ymd');
                                }

                            }
                            if (saf21List.length == 0) {
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
                    if(this.SelectedInf29Item==inf29Item){
                        this.SelectedInf29Item = null;
                        this.SelectedInf29aItem = null;
                        this.Inf29aList = [];
                    } else {
                        this.SelectedInf29Item = inf29Item;
                        this.GetInf29aList(inf29Item.inf2901_docno);
                    }
                    
                },
                OnSubRowClick: function (inf29aItem) {
                    if(this.SelectedInf29aItem==inf29aItem){
                        this.SelectedInf29aItem = null;
                    } else {
                        this.SelectedInf29aItem = inf29aItem;
                    }
                },
                OnAdd: function () {
                    console.log("OnAdd");
                    this.Display = false;
                    window.dinp02301Edit.Display = true;
                    window.dinp02301Edit.Reset();
                },
                OnDelete: function () {
                    if (this.SelectedInf29Item == null) {
                        return;
                    }
                    if (this.SelectedInf29Item.adduser.toLowerCase() != loginUserName.toLowerCase()) {
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

                    var inf29fields = this.Export.Inf29List.filter(function(item, index, array){
                        return vueObj.Export.SelectedInf29List.indexOf(item.cnf0502_field)>=0;
                    });
                    var inf29afields = this.Export.Inf29aList.filter(function(item, index, array){
                        return vueObj.Export.SelectedInf29aList.indexOf(item.cnf0502_field)>=0;
                    });

                    LoadingHelper.showLoading();
                    return $.ajax({
                        type: 'POST',
                        url: rootUrl + "Dinp/Ajax/Inf29Handler.ashx",
                        cache: false,
                        data: {
                            act: "export",
                            inf29fields: JSON.stringify(inf29fields),
                            inf29afields: JSON.stringify(inf29afields),
                            data:JSON.stringify(inf29idList)
                        },
                        dataType: 'text',
                        success: function (result) {
                            LoadingHelper.hideLoading();
                            if (result == "ok") {
                                $(vueObj.$refs.ExportDialog).modal('hide');
                                location.href = rootUrl + "Dinp/Ajax/Inf29Export.ashx";
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
                OnCopy: function () {
                    if(this.SelectedInf29Item==null){
                        return;
                    }
                    var vueObj = this;
                    var resetTask = window.dinp02301Edit.Reset();
                    window.dinp02301Edit.Display = true;
                    window.dinp02301Search.Display = false;
                    // send selected inf29 to dinpEdit object
                    resetTask.done(function() {
                        window.dinp02301Edit.SetCopy(vueObj.SelectedInf29Item);
                    });
                    // get inf29alist from server, remove id...

                    var inf29Item = {
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
                    };
                },
                OnPrint: function () {
                    var vueObj = this;
                    var bcodeInfo = null;
                    if(this.Filter.BcodeStart==this.Filter.BcodeEnd){
                        bcodeInfo = this.Filter.BcodeStart;
                    }
                    var inf29idList = [];
                    for (var i in this.Inf29List) {
                        var inf29Item = this.Inf29List[i];
                        inf29idList.push(inf29Item.id);
                    }
                    if(inf29idList.length==0){
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
                            data:JSON.stringify(inf29idList),
                            printBcode:JSON.stringify(bcodeInfo),
                        },
                        dataType: 'text',
                        success: function (result) {
                            if (result != "") {
                                printJS({printable: rootUrl + "Dinp/Ajax/Inf29Print.ashx?session="+result,
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
                    console.log(field+"="+value);
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
                SortInf29List:function(a, b){
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
                SortInf29aList:function(a, b){
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
                BcodeSelectLabel: function (bcode) {
                    return bcode.cnf0701_bcode + "-" + bcode.cnf0703_bfname;
                },
                WherehouseSelectLabel: function (wherehouse) {
                    return wherehouse.cnf1002_fileorder + "-" + wherehouse.cnf1003_char01;
                },
                SetBCodeList: function(bcodeList) {
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
                SaveEnterPageLog(rootUrl, loginUserName, "Dinp02101");
                this.GetExportFields();
            }
        });
    }

    function onError(error) {
        console.error(error);
    }

    define(requiredFiles, onLoaded, onError);

})();