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
                MOMO: {
                    checked:true,
                    open: false,
                    File:[],
                    FileName: "",
                    saf25FileInfo:{}
                },
                PChome: {
                    checked: true,
                    open: false,
                    File:[],
                    FileName: "",
                    saf25FileInfo: {}
                }  
            },
            methods: {
               
                MultipleSubmit: function () {
                    LoadingHelper.showLoading();

                    if (this.DateTime.trim() == "") {
                        alert("未填日期")
                        return;
                    }
                    var vueobj = this;
                    for (var i = 0; i < vueobj.MultipleFile.length; i++) {
                        var formData = new FormData();
                        formData.append("file", vueobj.MultipleFile[i])

                        if (vueobj.MultipleFile[i].name.toUpperCase().indexOf("02. MOMO.CSV")>-1) {
                            vueobj.MOMO.FileName = vueobj.MultipleFile[i].name;
                            vueobj.ImportExcelsAjax(formData, function (result) {
                                vueobj.MOMO.open = true;
                                vueobj.MOMO.saf25FileInfo = JSON.parse(result);
                            })
                        }
                        else if (vueobj.MultipleFile[i].name.toUpperCase().indexOf("03. PCHOME.CSV") > -1) {


                            vueobj.PChome.FileName = vueobj.MultipleFile[i].name;
                            vueobj.ImportExcelsAjax(formData, function (result) {
                                vueobj.PChome.open = true;
                                vueobj.PChome.saf25FileInfo = JSON.parse(result);
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
                    //e.target.value = "";
                }, onFileChange: function (type, e) {
                    var vueobj = this
                    var files = e.target.files || e.dataTransfer.files;

                    var formData = new FormData();
                    formData.append("file", files[0])

                    if (type == "MOMO" && files[0].name.toUpperCase().indexOf("02. MOMO.CSV") > -1) {
                        vueobj.MOMO.FileName = files[0].name;
                        vueobj.ImportExcelsAjax(formData, function (result) {
                            vueobj.MOMO.open = true;
                            vueobj.MOMO.saf25FileInfo = JSON.parse(result);
                        })

                    }
                    if (type == "PChome" && files[0].name.toUpperCase().indexOf("03. PCHOME.CSV") > -1) {
                        vueobj.MOMO.FileName = files[0].name;
                        vueobj.ImportExcelsAjax(formData, function (result) {
                            vueobj.MOMO.open = true;
                            vueobj.MOMO.saf25FileInfo = JSON.parse(result);
                        })

                    }

                    e.target.value = "";
                }, bytesToSize: function (bytes) {
                    var sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB'];
                    if (bytes == 0) return '0 Byte';
                    var i = parseInt(Math.floor(Math.log(bytes) / Math.log(1024)));
                    return Math.round(bytes / Math.pow(1024, i), 2) + ' ' + sizes[i];
                },
            }
        })

        window.Dspa92501.DateTime = new Date().getFullYear() + '/' + ('0' + (new Date().getMonth() + 1)).slice(-2) + '/' + ('0' + new Date().getDate()).slice(-2);


    }
    function onError(error) {
        console.error(error);
    }

    define(requiredFiles, onLoaded, onError);

})();