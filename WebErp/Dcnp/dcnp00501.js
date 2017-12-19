'use strict';
(function () {

    requirejs.config({
        paths: {
            "functionButton": isIE ? "VueComponent/FunctionButton.babel" : "VueComponent/FunctionButton",
            "uibPagination": "public/scripts/VueComponent/vuejs-uib-pagination",
            "vueDatetimepicker": isIE ? "public/scripts/VueComponent/vue-jQuerydatetimepicker.babel" : "public/scripts/VueComponent/vue-jQuerydatetimepicker",
            "jqueryDatetimepicker": "public/scripts/jquery.datetimepicker/jquery.datetimepicker.full",
            "jqueryDatetimepicker-css":"public/scripts/jquery.datetimepicker/jquery.datetimepicker",
            "jquery-mousewheel": "public/scripts/jquery.mousewheel.min",
        },
        shim: {
            "jqueryDatetimepicker":{
                "deps":["css!jqueryDatetimepicker-css"]
            },
            "vueDatetimepicker": {
                "deps": ['jqueryDatetimepicker']
            },
        }
    });

    var requiredFiles = ["bootstrap", "functionButton", "uibPagination", "vueDatetimepicker", "LoadingHelper"];

    function onLoaded(bootstrap, functionButton, uibPagination, vueDatetimepicker, loadingHelper) {
        window.dcnp00501 = new Vue({
            el: "#Dcnp00501",
            data: {
                Pagination: {},
                Filter: {
                    AddDateStart: null,
                    AddDateEnd: null,
                    Keyword: null,
                    Cnf0501FileStart: null,
                    Cnf0501FileEnd: null,
                    Cnf0506ProgramStart: null,
                    Cnf0506ProgramEnd: null,
                },
                EditDialog: {
                    display: true,
                    editingItem: {},
                    cnf0501_file: "",
                    cnf0502_field: "",
                    cnf0503_fieldname_tw: "",
                    cnf0504_fieldname_cn: "",
                    cnf0505_fieldname_en: "",
                    cnf0506_program: "",
                    remark: "",
                    adduser: "",
                    adddate: null,
                    moduser: "",
                    moddate: null,
                },
                Cnf05List: [],
                IsCheckAll: false,
                Export: {
                    cnf0501_file: true,
                    cnf0502_field: true,
                    cnf0503_fieldname_tw: true,
                    cnf0506_program: true,
                    adddate: true,
                    cnf0504_fieldname_cn: true,
                    cnf0505_fieldname_en: true
                }
            },
            components: {},
            computed: {

            },
            methods: {
                OnCheckAll: function () {
                    Vue.nextTick(function () {
                        console.log(dcnp00501.IsCheckAll ? "true" : "false");
                        for (var i in dcnp00501.Cnf05List) {
                            dcnp00501.Cnf05List[i].checked = dcnp00501.IsCheckAll;
                        }
                    });
                },
                OnSearch: function () {
                    console.log("OnSearch");
                    var filterOption = {
                        keyword: this.Filter.Keyword,
                        cnf0501_file_start: this.Filter.Cnf0501FileStart,
                        cnf0501_file_end: this.Filter.Cnf0501FileEnd,
                        cnf0506_program_start: this.Filter.Cnf0506ProgramStart,
                        cnf0506_program_end: this.Filter.Cnf0506ProgramEnd,
                        adddate_start: this.Filter.AddDateStart,
                        adddate_end: this.Filter.AddDateEnd
                    }
                    LoadingHelper.showLoading();
                    return $.ajax({
                        type: 'POST',
                        url: rootUrl + "Dcnp/Ajax/Cnf05Handler.ashx",
                        cache: false,
                        data: {
                            act: "get",
                            data: JSON.stringify(filterOption)
                        },
                        customData: {
                            vueObj: this
                        },
                        dataType: 'text',
                        success: function (result) {
                            LoadingHelper.hideLoading();
                            this.customData.vueObj.Cnf05List = JSON.parse(result);
                            if(this.customData.vueObj.Cnf05List.length==0){
                                alert("查無資料");
                            }
                        },
                        error: function (jqXhr, textStatus, errorThrown) {
                            if (jqXhr.status == 0) {
                                return;
                            }
                            LoadingHelper.hideLoading();
                            console.error(textStatus);
                            alert("查詢失敗");
                        }
                    });

                },
                OnAdd: function () {
                    console.log("OnAdd");
                    this.ResetEditDialog();
                    this.EditDialog.display = true;
                    var dateNow = new Date().dateFormat('Y/m/d');
                    this.EditDialog.adddate = dateNow;
                    this.$refs.AddDate.setValue(dateNow);
                    this.EditDialog.adduser = loginUserName;

                },
                OnModify: function (cnf05Item) {
                    this.ResetEditDialog();
                    this.EditDialog.display = true;
                    this.EditDialog.editingItem = cnf05Item;
                    this.EditDialog.cnf0501_file = cnf05Item.cnf0501_file;
                    this.EditDialog.cnf0502_field = cnf05Item.cnf0502_field;
                    this.EditDialog.cnf0503_fieldname_tw = cnf05Item.cnf0503_fieldname_tw;
                    this.EditDialog.cnf0504_fieldname_cn = cnf05Item.cnf0504_fieldname_cn;
                    this.EditDialog.cnf0505_fieldname_en = cnf05Item.cnf0505_fieldname_en;
                    this.EditDialog.cnf0506_program = cnf05Item.cnf0506_program;
                    this.EditDialog.remark = cnf05Item.remark;

                    var dateNow = new Date().dateFormat('Y/m/d');
                    this.EditDialog.adddate = new Date(cnf05Item.adddate).dateFormat('Y/m/d');
                    this.$refs.AddDate.setValue(this.EditDialog.adddate);
                    this.EditDialog.moddate = dateNow;
                    this.$refs.ModDate.setValue(dateNow);
                    this.EditDialog.adduser = cnf05Item.adduser;
                    this.EditDialog.moduser = loginUserName;
                },
                OnCopy: function (cnf05Item) {
                    this.ResetEditDialog();
                    this.EditDialog.display = true;
                    this.EditDialog.cnf0501_file = cnf05Item.cnf0501_file;
                    this.EditDialog.cnf0502_field = cnf05Item.cnf0502_field;
                    this.EditDialog.cnf0503_fieldname_tw = cnf05Item.cnf0503_fieldname_tw;
                    this.EditDialog.cnf0504_fieldname_cn = cnf05Item.cnf0504_fieldname_cn;
                    this.EditDialog.cnf0505_fieldname_en = cnf05Item.cnf0505_fieldname_en;
                    this.EditDialog.cnf0506_program = cnf05Item.cnf0506_program;
                    this.EditDialog.remark = cnf05Item.remark;

                    var dateNow = new Date().dateFormat('Y/m/d');
                    this.EditDialog.adddate = dateNow;
                    this.$refs.AddDate.setValue(dateNow);
                    this.EditDialog.adduser = loginUserName;
                },
                OnDelete: function (cnf05Item) {
                    console.log("OnDelete");

                    var cnf05List = [];
                    var type = "";
                    if (!cnf05Item) {
                        type = "list";
                        for (var i in this.Cnf05List) {
                            if (this.Cnf05List[i].checked) {
                                cnf05List.push(this.Cnf05List[i].id);
                            }
                        }
                        if (cnf05List.length == 0)
                            return;
                    }
                    if (!confirm("確定刪除資料?")) {
                        return;
                    }
                    return $.ajax({
                        type: 'POST',
                        url: rootUrl + "Dcnp/Ajax/Cnf05Handler.ashx",
                        cache: false,
                        data: {
                            act: "del",
                            type: type,
                            data: cnf05Item ? cnf05Item.id : JSON.stringify(cnf05List)
                        },
                        customData: {
                            vueObj: this
                        },
                        dataType: 'text',
                        success: function (result) {
                            if (result == "ok") {
                                this.customData.vueObj.OnSearch();
                            } else {
                                alert("刪除失敗");
                            }
                        },
                        error: function (jqXhr, textStatus, errorThrown) {
                            if (jqXhr.status == 0) {
                                return;
                            }
                            console.error(textStatus);
                            alert("刪除失敗");
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
                        cnf0504_fieldname_cn: true,
                        cnf0505_fieldname_en: true
                    };
                },
                OnExportSubmit: function () {
                    var fields = [];
                    var dataList = [];
                    for (var i in this.Cnf05List) {
                        var cnf05Item = this.Cnf05List[i];
                        if (cnf05Item.checked) {
                            dataList.push(cnf05Item);
                        }
                    }
                    if (dataList.length == 0) {
                        dataList = this.Cnf05List;
                    }
                    for (var i in this.Export) {
                        if (this.Export[i]) {
                            fields.push(i);
                        }
                    }
                    if (dataList.length == 0 || fields.length == 0) {
                        $(this.customData.vueObj.$refs.EditDialog).modal('hide');
                        return $.when(null);
                    }
                    return $.ajax({
                        type: 'POST',
                        url: rootUrl + "Dcnp/Ajax/Cnf05Handler.ashx",
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
                            if (result == "ok") {
                                $(this.customData.vueObj.$refs.ExportDialog).modal('hide');
                                location.href = rootUrl + "Dcnp/Ajax/Cnf05Export.ashx";
                            } else {
                                alert("匯出失敗");
                            }
                        },
                        error: function (jqXhr, textStatus, errorThrown) {
                            if (jqXhr.status == 0) {
                                return;
                            }
                            console.error(textStatus);
                            alert("匯出失敗");
                        }
                    });
                },
                OnImportSubmit: function () {
                    var formData = new FormData();
                    // 取得UploadFile元件的檔案
                    var files = this.$refs.ImportExcelInput.files;
                    // 將指定的檔案放在formData內
                    formData.append("file", files[0]);

                    //發送http請求
                    return $.ajax({
                        url: rootUrl + "Dcnp/Ajax/Cnf05Handler.ashx",
                        type: 'POST',
                        data: formData,
                        customData: {
                            vueObj: this
                        },
                        cache: false,
                        dataType: 'text',
                        processData: false,
                        contentType: false,
                        success: function (result) {
                            if (result == "ok") {
                                $(this.customData.vueObj.$refs.ImportExcelDialog).modal('hide');
                                this.customData.vueObj.$refs.ImportExcelInput.value = "";
                                this.customData.vueObj.OnSearch();
                            } else {
                                alert("匯入失敗");
                            }
                        },
                        error: function (jqXhr, textStatus, errorThrown) {
                            if (jqXhr.status == 0) {
                                return;
                            }
                            console.error(textStatus);
                            alert("匯入失敗");
                        }
                    });

                },
                OnEditDialogSubmit: function () {
                    if (this.EditDialog.cnf0501_file == "") {
                        alert("檔案代號不可以是空白.");
                        return;
                    }
                    if (this.EditDialog.cnf0502_field == "") {
                        alert("欄位名稱不可以是空白.");
                        return;
                    }
                    if (this.EditDialog.cnf0503_fieldname_tw == "") {
                        alert("中文說明不可以是空白.");
                        return;
                    }
                    var cnf05Data = {
                        id: this.EditDialog.editingItem.id,
                        cnf0501_file: this.EditDialog.cnf0501_file,
                        cnf0502_field: this.EditDialog.cnf0502_field,
                        cnf0503_fieldname_tw: this.EditDialog.cnf0503_fieldname_tw,
                        cnf0504_fieldname_cn: this.EditDialog.cnf0504_fieldname_cn,
                        cnf0505_fieldname_en: this.EditDialog.cnf0505_fieldname_en,
                        cnf0506_program: this.EditDialog.cnf0506_program,
                        remark: this.EditDialog.remark,
                        adduser: this.EditDialog.adduser,
                        adddate: this.EditDialog.adddate,
                        moduser: this.EditDialog.moduser,
                        moddate: this.EditDialog.moddate
                    };
                    return $.ajax({
                        type: 'POST',
                        url: rootUrl + "Dcnp/Ajax/Cnf05Handler.ashx",
                        cache: false,
                        data: {
                            act: this.EditDialog.editingItem.id ? "update" : "add",
                            data: JSON.stringify(cnf05Data)
                        },
                        customData: {
                            vueObj: this
                        },
                        dataType: 'text',
                        success: function (result) {
                            if (result == "ok") {
                                $(this.customData.vueObj.$refs.EditDialog).modal('hide');
                                this.customData.vueObj.OnSearch();
                            } else {
                                alert("存檔失敗");
                            }
                        },
                        error: function (jqXhr, textStatus, errorThrown) {
                            if (jqXhr.status == 0) {
                                return;
                            }
                            console.error(textStatus);
                            alert("存檔失敗");
                        }
                    });
                },
                ResetEditDialog: function () {
                    this.EditDialog = {
                        display: true,
                        editingItem: {},
                        cnf0501_file: "",
                        cnf0502_field: "",
                        cnf0503_fieldname_tw: "",
                        cnf0504_fieldname_cn: "",
                        cnf0505_fieldname_en: "",
                        cnf0506_program: "",
                        remark: "",
                        adduser: "",
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
            mounted: function () {}
        });
    }

    function onError(error) {
        console.error(error);
    }

    define(requiredFiles, onLoaded, onError);

})();