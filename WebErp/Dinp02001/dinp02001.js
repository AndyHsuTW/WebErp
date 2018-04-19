'use strict';
(function() {

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

    var requiredFiles = [
        "bootstrap",
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

        $.ajax({
            url: rootUrl + "Dinp02001/Dinp02001.html?" + Date.now(),
            async: false,
            type: "get",
            success: function (html) {
                
                dinp02001Init(html);
            },
            dataType: "html"
        });


        function dinp02001Init(html) {
            var appversion = "V18.04.19";
            $("#dinp02001").html(html);


            var today = new Date().getFullYear() + '/' + ('0' + (new Date().getMonth() + 1)).slice(-2) + '/' + ('0' + new Date().getDate()).slice(-2);

            window.dinp02001Search = new Vue({
                el: "#Dinp02001Search",
                data: {
                    Inf20List: [],
                    Inf20aList: [],
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
                        KeyWord:null,
                        Qty:0
                    },
                    AppVersion: appversion,
                    Display: true,
                    SelectedInf20Item: null,
                    SelectedInf20aItem: null,
                },
                methods: {
                    OnSearch: function () {
                        var vueobj = this;
                        console.log("OnSearch");
                        vueobj.SelectedInf29Item = null;
                        vueobj.SelectedInf29aItem = null;
                        vueobj.Inf29aList = [];
                        LoadingHelper.showLoading();



                        return $.ajax({
                            type: "POST",
                            url: rootUrl + "Dinp02001/Ajax/Inf20Handler.ashx",
                            cache: false,
                            data: {
                                act: "get",
                                data: JSON.stringify(vueobj.Filter)
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




                    },OnAdd: function() {


                    }

                }

            });


        }


    }

    function onError(error) {
        console.error(error);
    }

    define(requiredFiles, onLoaded, onError);

})();