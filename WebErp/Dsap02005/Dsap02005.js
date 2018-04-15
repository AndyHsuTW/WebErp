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

        window.Dsap02005 = new Vue({
            el: "#content",
            data: {
                IsCheckAll: false,
                Filters: {
                    cuscode_start: "",
                    cuscode_end: "",
                    deli_date_start: "",
                    deli_date_end: "",
                    serial_start: "",
                    serial_end: "",

                    inv_date_start: "",
                    inv_date_end: "",

                    inv_no_start: "",
                    inv_no_end: "",

                    inv_no_y: "",
                    inv_no_n: "",

                },


                OrderList: [],
                SortColumn: "",
                SortOrder: "",
            },
            methods: {
                InvoicePrint: function () {
                    var vueObj = this;
                    
                    var OrderList = [];
                    var no_inv_no = false;
                    var Isprint = false;
                    for (var i in vueObj.OrderList) {
                        if (vueObj.OrderList[i].checked == true) {
                            if (vueObj.OrderList[i].saf20110_printmark == "Y") {
                                Isprint = true;

                            }
                            for (var j in vueObj.OrderList[i].OrderbodyDataList) {
                                if (vueObj.OrderList[i].OrderbodyDataList[j].saf20a38_inv_no == "") {
                                    no_inv_no = true;
                                    break;
                                } 
                            }
                            if (Isprint || no_inv_no) {
                                break;
                            }
                            OrderList.push(vueObj.OrderList[i]);

                        }
                    }
                    var alertmsg = "";
                    if (no_inv_no) {
                        alertmsg += "有選擇沒有開立發票\n"
                      
                    }
                    if (Isprint) {
                        alertmsg += "有選擇以印出發票，請重新選擇\n"

                    }
                    if (OrderList.length == 0) {
                        alertmsg += "至少選一項\n"
                    }
                    if (alertmsg != "") {
                        alert(alertmsg);
                        return;
                    }

                    var excelform = $('<form/>').attr('method', 'post').attr('action', rootUrl + 'Dsap02005/Ajax/InvoicePrint.ashx?v=' + i).appendTo($('body'));
                    $('<input/>').attr('type', 'hidden').attr('name', 'datalist').val(encodeURIComponent(JSON.stringify(OrderList))).appendTo(excelform);
                    $('<input/>').attr('type', 'hidden').attr('name', 'loginUserName').val(encodeURIComponent(loginUserName)).appendTo(excelform);
                    excelform.submit();

                   



                },
                Init: function () {
                    SaveEnterPageLog(rootUrl, loginUserName, "Dsap02005");

                    var today = new Date().getFullYear() + '/' + ('0' + (new Date().getMonth() + 1)).slice(-2) + '/' + ('0' + new Date().getDate()).slice(-2);
                    this.Filters.deli_date_start = today;
                    this.Filters.deli_date_end = today;
                    this.Filters.inv_no_n = true;
                }, InvoiceOpening: function () {
                    var vueObj = this;
                    if (vueObj.inv_no_y) {
                        alert("發票已經開立，不可以再開，請重新選擇，謝謝");
                        return;
                    }
                    
                    var OrderList = [];

                    for (var i in vueObj.OrderList) {
                        if (vueObj.OrderList[i].checked == true) {
                            OrderList.push(vueObj.OrderList[i]);
                        }

                    }
                    if (OrderList.length == 0) {
                        alert("至少選一項\n")
                    }
                    LoadingHelper.showLoading();
                    return $.ajax({
                        url: rootUrl + "Dsap02005/Ajax/InvoiceOpening.ashx",
                        type: 'POST',
                        cache: false,
                        data: {
                            datalist: JSON.stringify(OrderList),
                            loginUserName: loginUserName
                        }, success: function (result) {
                            LoadingHelper.hideLoading();
                            if (result == "Success") {
                                alert("開立成功")
                                vueObj.OnSearch();
                            } else {
                                alert(result)
                            }


                        }, error: function (jqXhr, textStatus, errorThrown) {
                            if (jqXhr.status == 0) {
                                return;
                            }
                            LoadingHelper.hideLoading();
                            console.error(errorThrown);
                            alert("開立出現錯誤");
                        }
                    })


                },
                OnTableSorting: function (column, $event) {
                    var vueObj = this;
                    $($event.currentTarget).parents("tr:first").find("i").each(function () {
                        $(this).attr("class", "fa fa-fw fa-sort")
                    })
                    if (vueObj.SortColumn == column) {
                        if (vueObj.SortOrder == "asc") {
                            vueObj.SortOrder = "desc";
                            $($event.currentTarget).find("i").attr("class", "fa fa-fw fa-sort-down")
                        } else {
                            vueObj.SortOrder = "asc";
                            $($event.currentTarget).find("i").attr("class", "fa fa-fw fa-sort-up")
                        }
                    } else {
                        vueObj.SortOrder = "asc";
                        $($event.currentTarget).find("i").attr("class", "fa fa-fw fa-sort-up")
                    }



                    this.SortColumn = column;

                    vueObj.OrderList.sort(function (a, b) {

                        if (a[vueObj.SortColumn] < b[vueObj.SortColumn]) {
                            return vueObj.SortOrder == 'asc' ? -1 : 1;

                        }
                        if (a[vueObj.SortColumn] > b[vueObj.SortColumn]) {
                            return vueObj.SortOrder == 'asc' ? 1 : -1;
                        }
                        return 0;
                    });

                },
                OnSearch: function () {
                    var vueObj = this;
                    LoadingHelper.showLoading();

                    vueObj.SortColumn = "";
                    vueObj.SortOrder = "";
                    $(".sort-item").find("i").each(function () {
                        $(this).attr("class", "fa fa-fw fa-sort")
                    })

                    return $.ajax({
                        url: rootUrl + "Dsap02005/Ajax/GetData.ashx",
                        type: 'POST',
                        cache: false,
                        data: {
                            Filters: JSON.stringify(vueObj.Filters)
                        }, success: function (result) {
                            LoadingHelper.hideLoading();

                            vueObj.OrderList = JSON.parse(result);
                            if (vueObj.OrderList.length == 0) {
                                alert("查無資料");
                            }
                            vueObj.OnCheckAll(true);

                        }, error: function (jqXhr, textStatus, errorThrown) {
                            if (jqXhr.status == 0) {
                                return;
                            }
                            LoadingHelper.hideLoading();
                            console.error(errorThrown);
                            alert("查詢失敗");
                        }
                    })

                },


                OnCheckAll: function (b) {
                    Vue.nextTick(function () {
                        for (var i in Dsap02005.OrderList) {
                            Dsap02005.OrderList[i].checked = b;
                        }
                    });
                }
            }, computed: {

            }
        })
    }

    function onError(error) {
        console.error(error);
    }

    define(requiredFiles, onLoaded, onError);
})();