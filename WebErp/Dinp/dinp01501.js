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
        SaveEnterPageLog(rootUrl, localStorage.getItem("USER_ID"), "Dinp01501");

        if (vueMultiselect == null) {
            console.error("vueMultiselect fallback");
            vueMultiselect = window.VueMultiselect;
        }

        window.dinp01501 = new Vue({
            el: "#Dinp01501",
            data: {
                Inf15HandlerUrl: rootUrl + 'Dinp/Ajax/Inf15Handler.ashx',
                Inf15List: [],// source data from server
                EditDialog: {
                    display: true,
                    isCopyMode: false,
                    editingItem: {},
                    status: "",
                    inf1501_bcode: "10001",
                    inf1501_ccode: "",
                    inf1502_app: "",
                    inf1502_pmonth: null,
                    inf1502_close_type: "",
                    inf1502_seq: "",
                    inf1503_beg_date: null,
                    inf1504_end_date: null,
                    inf1505_this_date: null,
                    inf1506_last_date: null,
                    inf1507_sal_flag1: "",
                    inf1508_inv_flag2: "",
                    inf1509_pas_flag3: "",
                    inf1510_clo_flag4: "",
                    inf1511_trx_flag5: "",
                    inf1511_rev_flag6: "",
                    inf1512_inv_date: null,
                    remark: "",
                    adduser: "",
                    adddate: null,
                    moduser: "",
                    moddate: null,
                },
                Export: {
                    adddate: true,
                    adduser: true,
                    moddate: true,
                    moduser: true
                },
                Filter: {
                    keyword: null,
                    inf1503_beg_date: null,
                    inf1504_end_date: null,
                    inf1502_app_start: null,
                    inf1502_app_end: null,
                    inf1501_bcode_start: null,
                    inf1501_bcode_end: null
                },
                BcodeList: [], //公司代號下拉選單資料
                CcodeList: [], //客戶代號下拉選單資料
                AppCodeList: [],//系統代碼下拉選單
                IsCheckAll: false,
                UiDateFormat: "Y/m/d",
                UiMonthFormat: "Y/m",
                SortColumn: null,
                SortOrder: null
            },
            components: {
                Multiselect: vueMultiselect.default
            },
            computed: {
                IsEditDialogAddMode: function () {
                    return this.EditDialog.editingItem.id == null;
                }
            },
            methods: {
                OnCheckAll: function () {
                    Vue.nextTick(function () {
                        for (var i in dinp01501.Inf15List) {
                            dinp01501.Inf15List[i].checked = dinp01501.IsCheckAll;
                        }
                    });
                },
                OnSearch: function () {
                    var filterOption = {
                        keyword: this.Filter.keyword,
                        inf1503_beg_date: this.Filter.inf1503BegDate,
                        inf1504_end_date: this.Filter.inf1504EndDate,
                        inf1501_bcode_start: (this.Filter.inf1501BcodeBeg || {}).cnf0701_bcode,
                        inf1501_bcode_end: (this.Filter.inf1501BcodeEnd || {}).cnf0701_bcode,
                        inf1502_app_start: (this.Filter.inf1502AppBeg || {}).id,
                        inf1502_app_end: (this.Filter.inf1502AppEnd || {}).id,
                    };
                    LoadingHelper.showLoading();
                    var vueObj = this;
                    return $.ajax({
                        type: 'POST',
                        url: rootUrl + "Dinp/Ajax/Inf15Handler.ashx",
                        cache: false,
                        data: {
                            act: "get",
                            data: JSON.stringify(filterOption)
                        },
                        dataType: 'text',
                        success: function (result) {
                            LoadingHelper.hideLoading();
                            vueObj.Inf15List = JSON.parse(result);
                            $("#lbCount").html(vueObj.Inf15List.length);
                            if (vueObj.SortColumn != null) {
                                vueObj.Inf15List.sort(vueObj.SortInf15List);
                            }

                            if (vueObj.Inf15List.length == 0) {
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
                OnAdd: function () {
                    this.ResetEditDialog();
                    this.EditDialog.display = true;
                    this.EditDialog.isCopyMode = false;
                    var dateNow = new Date().dateFormat(this.UiDateFormat);
                    this.EditDialog.adddate = dateNow;
                    this.$refs.AddDate.setValue(dateNow);
                    this.EditDialog.adduser = loginUserName;

                    LoadingHelper.showLoading();
                    var vueObj = this;
                    return $.ajax({
                        type: 'POST',
                        url: rootUrl + "Dinp/Ajax/Inf15Handler.ashx",
                        cache: false,
                        data: {
                            act: "last"
                        },
                        dataType: 'text',
                        success: function (result) {
                            LoadingHelper.hideLoading();
                            var tmpInf15List = JSON.parse(result);
                            $("#inf1503_beg_date").val(tmpInf15List.inf1503_beg_date);
                            $("#inf1504_end_date").val(tmpInf15List.inf1504_end_date);
                            $("#inf1505_this_date").val(tmpInf15List.inf1505_this_date);
                            $("#inf1506_last_date").val(tmpInf15List.inf1506_last_date);
                        },
                        error: function (jqXhr, textStatus, errorThrown) {
                            if (jqXhr.status == 0) {
                                return;
                            }
                            LoadingHelper.hideLoading();
                            console.error(errorThrown);
                            alert("取得預設日期失敗");
                        }
                    });
                },
                OnModify: function (inf15Item) {
                    var tmpbcode = inf15Item.inf1501_bcode;
                    var tmpccode = inf15Item.inf1501_ccode;
                    var tmpappcode = inf15Item.inf1502_app;
                    var defaultBCodeInfo = this.BcodeList.filter(function (item, index, array) {
                        return item.cnf0701_bcode == tmpbcode;
                    }).shift();
                    var defaultCCodeInfo = this.CcodeList.filter(function (item, index, array) {
                        return item.cmf0102_cuscode == tmpccode;
                    }).shift();
                    var defaultAppCodeInfo = this.AppCodeList.filter(function (item, index, array) {
                        return item.id == tmpappcode;
                    }).shift();
                    this.EditDialog.display = true;
                    this.EditDialog.isCopyMode = false;
                    this.EditDialog.editingItem = inf15Item;
                    this.EditDialog.status = inf15Item.status;
                    this.EditDialog.inf1501_bcode = defaultBCodeInfo;
                    this.EditDialog.inf1501_ccode = defaultCCodeInfo;
                    this.EditDialog.inf1502_app = defaultAppCodeInfo;
                    this.EditDialog.inf1502_pmonth = inf15Item.inf1502_pmonth;
                    $("#EditMonth").val(inf15Item.inf1502_pmonth);
                    this.EditDialog.inf1502_close_type = inf15Item.inf1502_close_type;
                    this.EditDialog.inf1502_seq = inf15Item.inf1502_seq;
                    this.EditDialog.inf1503_beg_date = inf15Item.inf1503_beg_date;
                    this.EditDialog.inf1504_end_date = inf15Item.inf1504_end_date;
                    this.EditDialog.inf1505_this_date = inf15Item.inf1505_this_date;
                    this.EditDialog.inf1506_last_date = inf15Item.inf1506_last_date;
                    $("#inf1503_beg_date").val(inf15Item.inf1503_beg_date);
                    $("#inf1504_end_date").val(inf15Item.inf1504_end_date);
                    $("#inf1505_this_date").val(inf15Item.inf1505_this_date);
                    $("#inf1506_last_date").val(inf15Item.inf1506_last_date);

                    this.EditDialog.inf1507_sal_flag1 = inf15Item.inf1507_sal_flag1;
                    this.EditDialog.inf1508_inv_flag2 = inf15Item.inf1508_inv_flag2;
                    this.EditDialog.inf1509_pas_flag3 = '';
                    this.EditDialog.inf1510_clo_flag4 = inf15Item.inf1510_clo_flag4;
                    this.EditDialog.inf1511_trx_flag5 = inf15Item.inf1511_trx_flag5;
                    this.EditDialog.inf1511_rev_flag6 = null;
                    this.EditDialog.inf1511_rev_flag7 = null;
                    this.EditDialog.inf1512_inv_date = inf15Item.inf1512_inv_date;
                    $("#inf1512_inv_date").val(inf15Item.inf1512_inv_date);
                    this.EditDialog.remark = inf15Item.remark;
                    this.EditDialog.remark = inf15Item.remark;

                    var dateNow = new Date().dateFormat(this.UiDateFormat);
                    this.EditDialog.adddate = new Date(inf15Item.adddate).dateFormat(this.UiDateFormat);
                    this.$refs.AddDate.setValue(this.EditDialog.adddate);
                    this.EditDialog.moddate = dateNow;
                    this.$refs.ModDate.setValue(dateNow);
                    this.EditDialog.adduser = inf15Item.adduser;
                    this.EditDialog.moduser = loginUserName;
                },
                OnCopy: function (inf15Item) {
                    var inf15List = [];
                    if (!inf15Item) {
                        for (var i in this.Inf15List) {
                           
                            if (this.Inf15List[i].checked) {
                                var tmpbcode = this.Inf15List[i].inf1501_bcode;
                                var tmpccode = this.Inf15List[i].inf1501_ccode;
                                var tmpappcode = this.Inf15List[i].inf1502_app;
                                var defaultBCodeInfo = this.BcodeList.filter(function (item, index, array) {
                                     return item.cnf0701_bcode == tmpbcode;
                                }).shift();
                                var defaultCCodeInfo = this.CcodeList.filter(function (item, index, array) {
                                    return item.cmf0102_cuscode == tmpccode;
                                }).shift();
                                var defaultAppCodeInfo = this.AppCodeList.filter(function (item, index, array) {
                                    return item.id == tmpappcode;
                                }).shift();
                                this.EditDialog.display = true;
                                this.EditDialog.isCopyMode = true;
                                this.EditDialog.status = this.Inf15List[i].status;
                                this.EditDialog.inf1501_bcode = defaultBCodeInfo;
                                this.EditDialog.inf1501_ccode = defaultCCodeInfo;
                                this.EditDialog.inf1502_app = defaultAppCodeInfo;
                                this.EditDialog.inf1502_pmonth = this.Inf15List[i].inf1502_pmonth;
                                $("#EditMonth").val(this.Inf15List[i].inf1502_pmonth);
                                this.EditDialog.inf1502_close_type = this.Inf15List[i].inf1502_close_type;
                                this.EditDialog.inf1502_seq = this.Inf15List[i].inf1502_seq;
                                this.EditDialog.inf1503_beg_date = this.Inf15List[i].inf1503_beg_date;
                                this.EditDialog.inf1504_end_date = this.Inf15List[i].inf1504_end_date;
                                this.EditDialog.inf1505_this_date = this.Inf15List[i].inf1505_this_date;
                                this.EditDialog.inf1506_last_date = this.Inf15List[i].inf1506_last_date;
                                $("#inf1503_beg_date").val(this.Inf15List[i].inf1503_beg_date);
                                $("#inf1504_end_date").val(this.Inf15List[i].inf1504_end_date);
                                $("#inf1505_this_date").val(this.Inf15List[i].inf1505_this_date);
                                $("#inf1506_last_date").val(this.Inf15List[i].inf1506_last_date);
                                this.EditDialog.inf1507_sal_flag1 = this.Inf15List[i].inf1507_sal_flag1;
                                this.EditDialog.inf1508_inv_flag2 = this.Inf15List[i].inf1508_inv_flag2;
                                this.EditDialog.inf1509_pas_flag3 = '';
                                this.EditDialog.inf1510_clo_flag4 = this.Inf15List[i].inf1510_clo_flag4;
                                this.EditDialog.inf1511_trx_flag5 = this.Inf15List[i].inf1511_trx_flag5;
                                this.EditDialog.inf1511_rev_flag6 = null;
                                this.EditDialog.inf1511_rev_flag7 = null;
                                this.EditDialog.inf1512_inv_date = this.Inf15List[i].inf1512_inv_date;
                                $("#inf1512_inv_date").val(this.Inf15List[i].inf1512_inv_date);
                                this.EditDialog.remark = this.Inf15List[i].remark;

                                var dateNow = new Date().dateFormat(this.UiDateFormat);
                                this.EditDialog.adddate = dateNow;
                                this.$refs.AddDate.setValue(dateNow);
                                this.EditDialog.adduser = loginUserName;
                                $("#EditDialog").modal();
                            }
                        }
                    }
                },
                OnDelete: function (inf15Item) {
                    console.log("OnDelete");

                    var inf15List = [];
                    var type = "";
                    if (!inf15Item) {
                        type = "list";
                        for (var i in this.Inf15List) {
                            if (this.Inf15List[i].checked) {
                                inf15List.push(this.Inf15List[i].id);
                            }
                        }
                    }
                    if (inf15List.length == 0) {
                        for (var i in dinp01501.Inf15List) {
                            inf15List.push(dinp01501.Inf15List[i].id);
                        }
                        if (!confirm("確定刪除所有資料?")) {
                            return;
                        }
                    } else {
                        if (!confirm("確定刪除資料?")) {
                            return;
                        }
                    }
                    return $.ajax({
                        type: 'POST',
                        url: rootUrl + "Dinp/Ajax/Inf15Handler.ashx",
                        cache: false,
                        data: {
                            act: "del",
                            type: type,
                            data: inf15Item ? inf15Item.id : JSON.stringify(inf15List)
                        },
                        customData: {
                            vueObj: this
                        },
                        dataType: 'text',
                        success: function (result) {
                            if (result == "ok") {
                                this.customData.vueObj.OnSearch();
                                alert("刪除成功");
                            } else {
                                alert("刪除失敗");
                            }
                        },
                        error: function (jqXhr, textStatus, errorThrown) {
                            if (jqXhr.status == 0) {
                                return;
                            }
                            console.error(errorThrown);
                            alert("刪除失敗");
                        }
                    });

                },
                OnExport: function () {
                    // reset dialog
                    this.Export = {
                        adddate: true,
                        adduser: true,
                        moddate: true,
                        moduser: true
                    };
                },
                OnExportSubmit: function () {
                    var fields = [];
                    var dataList = [];
                    for (var i in this.Inf15List) {
                        var inf15Item = this.Inf15List[i];
                        if (inf15Item.checked) {
                            dataList.push(inf15Item);
                        }
                    }
                    if (dataList.length == 0) {
                        dataList = this.Inf15List;
                    }
                    for (var i in this.Export) {
                        if (this.Export[i]) {
                            fields.push(i);
                        }
                    }
                    if (dataList.length == 0 || fields.length == 0) {
                        $(this.$refs.ExportDialog).modal('hide');
                        return $.when(null);
                    }
                    LoadingHelper.showLoading();
                    return $.ajax({
                        type: 'POST',
                        url: rootUrl + "Dinp/Ajax/Inf15Handler.ashx",
                        cache: false,
                        data: {
                            act: "export",
                            data: JSON.stringify(dataList),
                            fields: JSON.stringify(fields),
                        },
                        customData: {
                            vueObj: this
                        },
                        dataType: 'text',
                        success: function (result) {
                            LoadingHelper.hideLoading();
                            if (result == "ok") {
                                $(this.customData.vueObj.$refs.ExportDialog).modal('hide');
                                location.href = rootUrl + "Dinp/Ajax/Inf15Export.ashx";
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
                OnEditDialogSubmit: function () {
                    this.EditDialogSubmit();
                },
                EditDialogSubmit: function () {
                    if (this.EditDialog.status == "") {
                        if (this.EditDialog.inf1501_bcode == null) {
                            alert("公司代號不允許空白，請重新輸入.");
                            return;
                        }
                    }
                    else if (this.EditDialog.status == "1") {
                        if (this.EditDialog.inf1501_ccode == null) {
                            alert("客戶代號不允許空白，請重新輸入.");
                            return;
                        }
                    }
                    if (this.EditDialog.inf1502_app == null) {
                        alert("系統代號不允許空白，請重新輸入.");
                    }
                    if ($("#EditMonth").val().trim() == "") {
                        alert("結帳年月不允許空白，請重新輸入.");
                        return;
                    }
                    if (this.EditDialog.inf1502_seq == null) {
                        alert("序號不允許空白，請重新輸入.");
                        return;
                    }


                    // construct upload data
                    var act = this.EditDialog.editingItem.id ? "update" : "add";

                    var inf15Data = {
                        id: this.EditDialog.editingItem.id,
                        status: this.EditDialog.status,
                        inf1501_bcode: this.EditDialog.status == "" ? this.EditDialog.inf1501_bcode.cnf0701_bcode : "",
                        inf1501_ccode: this.EditDialog.status == "1" ? this.EditDialog.inf1501_ccode.cmf0102_cuscode : "",
                        inf1502_app: this.EditDialog.inf1502_app.id,
                        inf1502_pmonth: $("#EditMonth").val(),
                        inf1502_close_type: this.EditDialog.inf1502_close_type,
                        inf1502_seq: this.EditDialog.inf1502_seq,
                        inf1503_beg_date: this.EditDialog.inf1503_beg_date,
                        inf1504_end_date: this.EditDialog.inf1504_end_date,
                        inf1505_this_date: $("#inf1505_this_date").val(),
                        inf1506_last_date: $("#inf1506_last_date").val(),
                        inf1507_sal_flag1: this.EditDialog.inf1507_sal_flag1,
                        inf1508_inv_flag2: this.EditDialog.inf1508_inv_flag2,
                        inf1509_pas_flag3: '',
                        inf1510_clo_flag4: this.EditDialog.inf1510_clo_flag4,
                        inf1511_trx_flag5: this.EditDialog.inf1511_trx_flag5,
                        inf1511_rev_flag6: null,
                        inf1511_rev_flag7: null,
                        inf1512_inv_date: $("#inf1512_inv_date").val(),
                        remark: this.EditDialog.remark,
                        adduser: this.EditDialog.adduser,
                        adddate: this.EditDialog.adddate + new Date().dateFormat(" H:i"),
                        moduser: this.EditDialog.moduser,
                        moddate: act == "update" ? this.EditDialog.moddate + new Date().dateFormat(" H:i") : null
                    };
                    var vueObj = this;
                    LoadingHelper.showLoading();
                    return $.ajax({
                        type: 'POST',
                        url: rootUrl + "Dinp/Ajax/Inf15Handler.ashx",
                        cache: false,
                        data: {
                            act: act,
                            data: JSON.stringify(inf15Data)
                        },
                        dataType: 'text',
                        success: function (result) {
                            LoadingHelper.hideLoading();
                            if (result.indexOf("insert duplicate key") >= 0) {
                                alert("欄位重複了,請檢查並重新輸入");
                                return;
                            }
                            if (act == "update") {
                                if (result == "ok") {
                                    alert("存檔成功");
                                } else {
                                    alert("存檔失敗");
                                }
                            } else if (act == "add") {
                                var inf15Item = JSON.parse(result);
                                if (inf15Item) {
                                    alert("存檔成功");
                                } else {
                                    alert("存檔失敗");
                                }
                            }
                        },
                        error: function (jqXhr, textStatus, errorThrown) {
                            LoadingHelper.hideLoading();
                            if (jqXhr.status == 0) {
                                return;
                            }
                            console.error(errorThrown);
                            alert("存檔失敗");
                        }
                    });
                },
                BcodeSelectLabel: function (bcode) {
                    return bcode.cnf0701_bcode + "-" + bcode.cnf0703_bfname;
                },
                GetCompanyName: function (bcode) {
                    var BCodeInfo = this.BcodeList.filter(function (item, index, array) {
                        return item.cnf0701_bcode == bcode;
                    }).shift();
                    return (BCodeInfo || {}).cnf0702_bname;
                },
                CcodeSelectLabel: function (ccode) {
                    return ccode.cmf0102_cuscode + "-" + ccode.cmf0103_bname;
                },
                GetCustomerName: function (ccode) {
                    var CCodeInfo = this.CcodeList.filter(function (item, index, array) {
                        return item.cmf0102_cuscode == ccode;
                    }).shift();
                    return (CCodeInfo || {}).cmf0103_bname;
                },
                AppCodeSelectLabel: function (appcode) {
                    return appcode.cnf1002_fileorder + "-" + appcode.cnf1003_char01;
                },
                GetAppName: function (appcode) {
                    var AppCodeInfo = this.AppCodeList.filter(function (item, index, array) {
                        return item.id == appcode;
                    }).shift();
                    return (AppCodeInfo || {}).cnf1002_fileorder + "-" + (AppCodeInfo || {}).cnf1003_char01;
                },
                AutoFillFilter: function (field, value, type) {
                    this.Filter[field] = value;
                    if (type == "datetime") {
                        this.$refs["Filter" + field].setValue(value);
                    }
                },
                OnBegDateStartChange: function () {
                    if (!this.Filter.inf1504EndDate) {
                        this.Filter.inf1504EndDate = this.Filter.inf1503BegDate;
                        this.$refs.FilterEndDate.setValue(this.Filter.inf1504EndDate);
                    }
                },
                OnEditBegDateChange: function () {
                    $("#inf1506_last_date").val($("#inf1503_beg_date").val());
                },
                OnEditEndDateChange: function () {
                    var tmpEndDate = $("#inf1504_end_date").val();
                    var myEndDate = new Date(tmpEndDate);
                    myEndDate.setDate(myEndDate.getDate() + 1);
                    var yyyy = myEndDate.toLocaleDateString().slice(0, 4)
                    var MM = (myEndDate.getMonth() + 1 < 10 ? '0' : '') + (myEndDate.getMonth() + 1);
                    var dd = (myEndDate.getDate() < 10 ? '0' : '') + myEndDate.getDate();
                    $("#inf1505_this_date").val(yyyy + "/" + MM + "/" + dd);
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

                    this.Inf15List.sort(this.SortInf15List);
                },
                SortInf15List: function (a, b) {
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
                OnExportAllFieldClick: function (checkAll) {
                    this.Export = {
                        status: checkAll,
                        inf1501_bcode: checkAll,
                        inf1502_app: checkAll,
                        inf1502_pmonth: checkAll,
                        inf1502_close_type: checkAll,
                        inf1502_seq: checkAll,
                        inf1503_beg_date: checkAll,
                        inf1504_end_date: checkAll,
                        inf1505_this_date: checkAll,
                        inf1506_last_date: checkAll,
                        inf1507_sal_flag1: checkAll,
                        inf1508_inv_flag2: checkAll,
                        inf1509_pas_flag3: checkAll,
                        inf1510_clo_flag4: checkAll,
                        inf1511_trx_flag5: checkAll,
                        inf1511_rev_flag6: checkAll,
                        inf1512_inv_date: checkAll,
                        remark: checkAll,
                        adddate: checkAll,
                        adduser: checkAll,
                        moddate: checkAll,
                        moduser: checkAll
                    };
                },
                ResetEditDialog: function () {
                    var defaultBCodeInfo = this.BcodeList.filter(function (item, index, array) {
                        return item.cnf0751_tax_headoffice == "0";
                    }).shift();
                    this.EditDialog = {
                        display: true,
                        editingItem: {},
                        status: '',
                        inf1501_bcode: defaultBCodeInfo,
                        inf1501_ccode: null,
                        inf1502_app: null,
                        inf1502_pmonth: null,
                        inf1502_close_type: '1',
                        inf1502_seq: null,
                        inf1503_beg_date: null,
                        inf1504_end_date: null,
                        inf1505_this_date: null,
                        inf1506_last_date: null,
                        inf1507_sal_flag1: '1',
                        inf1508_inv_flag2: '3',
                        inf1509_pas_flag3: '',
                        inf1510_clo_flag4: '0',
                        inf1511_trx_flag5: '1',
                        inf1511_rev_flag6: null,
                        inf1512_inv_date: null,
                        remark: "",
                        adduser: null,
                        adddate: null,
                        moduser: "",
                        moddate: null,
                    };
                    this.$refs.AddDate.setValue("");
                    this.$refs.ModDate.setValue("");
                },
            },
            directives: {

            },
            mounted: function () { }
        });
    }

    function onError(error) {
        console.error(error);
    }

    define(requiredFiles, onLoaded, onError);

})();