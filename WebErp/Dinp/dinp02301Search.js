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

    var requiredFiles = ["bootstrap", "FunctionButton", "vuejs-uib-pagination", "vue-jQuerydatetimepicker", "LoadingHelper", "jquery.mousewheel"];

    function onLoaded(bootstrap, functionButton, uibPagination, vueDatetimepicker, loadingHelper) {
        window.dinp02301Search = new Vue({
            el: "#Dinp02301Search",
            data: {
                Display:true,
                Filter: {
                    ProDateStart: null,
                    ProDateEnd: null,
                    PcodeStart: null,
                    PcodeEnd: null,
                    ProjectNoStart: null,
                    ProjectNoEnd: null,
                    ShoesCodeStart: null,
                    ShoesCodeEnd: null,
                    WherehouseStart: null,
                    WherehouseEnd: null,
                    InReasonStart: null,
                    InReasonEnd: null,
                    CustomerCodeStart: null,
                    CustomerCodeEnd: null,
                    AdddateStart: null,
                    AdddateEnd: null,
                    BcodeStart: null,
                    BcodeEnd: null,
                    RefNoTypeStart: null,
                    RefNoTypeDateStart: null,
                    RefNoTypeSeqStart: null,
                    RefNoTypeEnd: null,
                    RefNoTypeDateEnd: null,
                    RefNoTypeSeqEnd: null,
                    Keyword: null,
                },
                Inf29List: [],// source data from server
                Inf29aList: [],// source data from server
                SelectedInf29Item:null,
                SelectedInf29aItem:null,
                UiDateFormat: "Y/m/d",
            },
            components: {},
            computed: {
                
            },
            methods: {
                OnSearch: function () {
                    console.log("OnSearch");
                    this.SelectedInf29Item = null;
                    this.SelectedInf29aItem = null;
                    this.Inf29aList= [];
                    
                    var filterOption = {
                        keyword: this.Filter.Keyword,
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
                        success: function (inf29ListJson) {
                            LoadingHelper.hideLoading();
                            var inf29List = JSON.parse(inf29ListJson);
                            vueObj.Inf29List = inf29List;
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
                OnMainRowClick:function(inf29Item){
                    this.SelectedInf29Item = inf29Item;
                    this.GetInf29aList(inf29Item.inf2901_docno);
                },
                OnSubRowClick:function(inf29aItem){
                    this.SelectedInf29aItem = inf29aItem;
                },
                OnAdd: function () {
                    console.log("OnAdd");
                    this.Display = false;
                    window.dinp02301Edit.Display = true;
                },
                OnDelete:function(){
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
                            }else{
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
                OnCopy: function() {

                },
                OnPrint:function() {
                    
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
                GetTotalQty: function (inf29Item) {
                    return 123;
                },
                GetInReasonName: function (inReason) {
                    return "inReason";
                },
                GetCustomerName: function (customerCode) {
                    return "customerCode";
                },
                GetInf29aList:function(docno){
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
            },
            directives: {

            },
            mounted: function() {
                var now = new Date();
                this.Filter.ProDateStart = now.dateFormat(this.UiDateFormat);
            }
        });
    }

    function onError(error) {
        console.error(error);
    }

    define(requiredFiles, onLoaded, onError);

})();