'use strict';
(function () {
    requirejs.config({
        paths: {
            "functionButton": isIE ? "VueComponent/FunctionButton.babel" : "VueComponent/FunctionButton",
            "uibPagination": "public/scripts/VueComponent/vuejs-uib-pagination",
            "vueDatetimepicker": isIE ? "public/scripts/VueComponent/vue-jQuerydatetimepicker.babel" : "public/scripts/VueComponent/vue-jQuerydatetimepicker",
            "jqueryDatetimepicker": "public/scripts/jquery.datetimepicker/jquery.datetimepicker.full",
            "jqueryDatetimepicker-css": "public/scripts/jquery.datetimepicker/jquery.datetimepicker",
            "jquery-mousewheel": "public/scripts/jquery.mousewheel.min",
        },
        shim: {
            "jqueryDatetimepicker": {
                "deps": ["css!jqueryDatetimepicker-css"]
            },
            "vueDatetimepicker": {
                "deps": ['jqueryDatetimepicker']
            },
        }
    });

    var requiredFiles = ["bootstrap", "functionButton", "uibPagination", "vueDatetimepicker", "LoadingHelper"];

    function onLoaded(bootstrap, functionButton, uibPagination, vueDatetimepicker, loadingHelper) {
        window.dsap92001 = new Vue({
            el: "#Dsap92001",
            data: {
                sendAjax:null,
                Filter: {
                   
                    StartDate: '',
                    EndDate: '',
                   
                },
                CompanyList: [],
                IsCheckAll: false,

            },
            methods: {
               
                OnSearch: function () {
                    console.log("OnSearch");
                    var filterOption = {
                        StartDate: this.Filter.StartDate,
                        EndDate: this.Filter.EndDate
                    }

                    if (this.sendAjax != null) {
                        this.sendAjax.abort();
                    }
                    LoadingHelper.showLoading();
                    this.sendAjax = $.ajax({
                        url: rootUrl + "Dsap/Ajax/CompanyHandler.ashx",
                        cache: false,
                        async: true,
                        customData: {
                            vueObj: this
                        },
                        success: function (result) {
                            LoadingHelper.hideLoading();
                            this.customData.vueObj.CompanyList = JSON.parse(result);
                            if (this.customData.vueObj.CompanyList.length == 0) {
                                alert("查無資料");
                            }
                        }, error: function (jqXhr, textStatus, errorThrown) {
                            if (jqXhr.status == 0) {
                                return;
                            }
                            LoadingHelper.hideLoading();
                            console.error(textStatus);
                            alert("查詢失敗");
                        }
                    })

                },OnExport: function () {
                    var dataList = [];
                    for (var i in this.CompanyList) {
                        var Company = this.CompanyList[i];
                        if (Company.checked) {
                            dataList.push(Company);
                        }
                    }
                    if (dataList.length == 0 || this.Filter.StartDate == "" || this.Filter.EndDate == "") {
                        return
                    }

                    var count = dataList.length;
                    var FilterOption = this.Filter;
                    for (var i in dataList) {
                        var data = dataList[i];

                        var excelform = $('<form/>').attr('method', 'post').attr('action', rootUrl + 'Dsap/Ajax/ExportHandler.ashx').appendTo($('body'));
                        $('<input/>').attr('type', 'hidden').attr('name', 'Company').val(encodeURIComponent(JSON.stringify(data))).appendTo(excelform);
                        $('<input/>').attr('type', 'hidden').attr('name', 'FilterOption').val(encodeURIComponent(JSON.stringify(FilterOption))).appendTo(excelform);
                        excelform.submit();
                    }

                }, OnCheckAll: function () {
                    Vue.nextTick(function () {
                        console.log(dsap92001.IsCheckAll ? "true" : "false");
                        for (var i in dsap92001.CompanyList) {
                            dsap92001.CompanyList[i].checked = dsap92001.IsCheckAll;
                        }
                    });
                },
            }
        })
    }

    function onError(error) {
        console.error(error);
    }

    define(requiredFiles, onLoaded, onError);
})();