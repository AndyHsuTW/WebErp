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
                Momo: {
                    type:"MOMO",
                    open:false,
                    saf25FileInfo:{}
                },
                PChome: {
                    type: "PChome",
                    open: false,
                    saf25FileInfo: {}
                }  
            },
            methods: {
               
                Submit: function () {
                    LoadingHelper.showLoading();


                    if (this.DateTime.trim() == "") {
                        alert("未填日期")
                        return;
                    }


                    


                    var vueobj = this;
                    for (var i = 0; i < this.MultipleFile.length; i++) {
                        var formData = new FormData();
                        formData.append("file", this.MultipleFile[i])
                        if (this.MultipleFile[i].name.indexOf("MOMO.CSV")) {

                            ImportExcelsAjax(formData, function (result) {
                                vueobj.Momo.open = true;
                                vueobj.saf25FileInfo = JSON.parse(result);
                            })
                        }
                    }

                  
                    
                   
                    LoadingHelper.hideLoading();


                }, ImportExcelsAjax: function (formData,callback) {

                    $.ajax({
                        url: "/WebErp/Dsap92501/Ajax/ImportExcels.ashx?DateTime=" + this.DateTime,
                        type: 'POST',
                        data: formData,
                        cache: false,
                        dataType: 'text',
                        processData: false,
                        contentType: false,
                        success: function (result) {
                            if (typeof (callback) === "function") {
                                callback(result);
                            }
                        },
                        error: function (jqXhr, textStatus, errorThrown) {

                            console.error(errorThrown);
                            //alert("匯入失敗");
                        }
                    });
                },

                Upload: function () {

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