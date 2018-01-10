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
    var requiredFiles = ["bootstrap", "functionButton", "uibPagination", "vueDatetimepicker", "LoadingHelper", "UserLog"];
    function onLoaded(bootstrap, functionButton, uibPagination, vueDatetimepicker, loadingHelper) {
        SaveEnterPageLog(rootUrl, localStorage.getItem("USER_ID"), "Dsap92001");
      

        window.dsap92001 = new Vue({
            el: "#Dsap92001",
            data: {
               
                sendAjax: null,
                Filter: {
                    StartDate: "",
                    EndDate: "",
                },
                CompanyList: [],
                IsCheckAll: false,
                Count: 0,
               
            },
            methods: {
                Init: function () {
                   
                    var today =new Date().getFullYear() + '/' + ('0' + (new Date().getMonth() + 1)).slice(-2) + '/' + ('0' + new Date().getDate()).slice(-2);
                    this.Filter.StartDate = today;
                    this.Filter.EndDate = today;

                    
                },
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

                }, OnExport: function () {

                    var dataList = [];
                    for (var i in this.CompanyList) {
                        var Company = this.CompanyList[i];
                        if (Company.checked) {
                            dataList.push(Company);
                        }
                    }
                    var alertmsg = "";
                    if (dataList.length == 0) {
                        alertmsg += "請至少勾選一家物流公司\n"

                    }
                    if (this.Filter.StartDate == "") {
                        alertmsg += "請選擇開始日期\n"
                    }
                    if (this.Filter.EndDate == "") {
                        alertmsg += "請選擇結束日期"
                    }
                    if (alertmsg != "") {
                        alert(alertmsg);
                        return
                    }


                    var FilterOption = this.Filter;

                    var excelform = $('<form/>').attr('method', 'post').attr('action', rootUrl + 'Dsap/Ajax/ExportHandler.ashx?v=' + i).appendTo($('body'));
                    $('<input/>').attr('type', 'hidden').attr('name', 'Company').val(encodeURIComponent(JSON.stringify(dataList))).appendTo(excelform);
                    $('<input/>').attr('type', 'hidden').attr('name', 'FilterOption').val(encodeURIComponent(JSON.stringify(FilterOption))).appendTo(excelform);
                    excelform.submit();


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

        window.dsap92001.Init();
    }

    function onError(error) {
        console.error(error);
    }

    define(requiredFiles, onLoaded, onError);
})();