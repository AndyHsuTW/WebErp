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

        window.Dspa92501 = new Vue({
            el: "#Dspa92501",
            data: {
                MultipleFile: [],
                DateTime: "",
                
                StepOpen:false
            },
            methods: {
               
                Submit: function () {
                    LoadingHelper.showLoading();


                    if (this.DateTime.trim() == "") {
                        alert("未填日期")
                        return;
                    }

                    this.Step = 2;
                    this.StepOpen = true;
                    LoadingHelper.hideLoading();


                }, Upload: function () {

                    $("#ImportExcelInput").trigger("click");
                }, onMultipleFileChange: function (e) {
                    var files = e.target.files || e.dataTransfer.files;
                    this.MultipleFile = files
                }, bytesToSize: function (bytes) {
                    var sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB'];
                    if (bytes == 0) return '0 Byte';
                    var i = parseInt(Math.floor(Math.log(bytes) / Math.log(1024)));
                    return Math.round(bytes / Math.pow(1024, i), 2) + ' ' + sizes[i];
                }
            }
        })

        window.Dspa92501.DateTime = new Date().getFullYear() + '/' + ('0' + (new Date().getMonth() + 1)).slice(-2) + '/' + ('0' + new Date().getDate()).slice(-2);


    }
    function onError(error) {
        console.error(error);
    }

    define(requiredFiles, onLoaded, onError);

})();