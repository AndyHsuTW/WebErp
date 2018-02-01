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
                },
                Formosa_Plastics: {//台塑
                    checked: true,
                    open: false,
                    File:[],
                    FileName: "",
                    saf25FileInfo: {}
                },
                Taiwan_Mobile: {//台灣大哥大
                    checked: true,
                    open: false,
                    File:[],
                    FileName: "",
                    saf25FileInfo: {}
                },
                Buy123: {//生活市集
                    checked: true,
                    open: false,
                    File:[],
                    FileName: "",
                    saf25FileInfo: {}
                },
                Eastern: {//東森
                    checked: true,
                    open: false,
                    File: [],
                    FileName: "",
                    saf25FileInfo: {}
                }, Pcone: {//松果
                    checked: true,
                    open: false,
                    File: [],
                    FileName: "",
                    saf25FileInfo: {}
                },
                Symphox: {//神坊
                    checked: true,
                    open: false,
                    File: [],
                    FileName: "",
                    saf25FileInfo: {}
                },
                Gomaji: {//夠麻吉
                    checked: true,
                    open: false,
                    File: [],
                    FileName: "",
                    saf25FileInfo: {}
                },
                PayEasy: {//康迅
                    checked: true,
                    open: false,
                    File: [],
                    FileName: "",
                    saf25FileInfo: {}
                },
                UniPresiden: {//統一
                    checked: true,
                    open: false,
                    File: [],
                    FileName: "",
                    saf25FileInfo: {}
                },
                Dingding: {//鼎鼎
                    checked: true,
                    open: false,
                    File: [],
                    FileName: "",
                    saf25FileInfo: {}
                },Crazymike:{//瘋狂賣克
                    checked: true,
                    open: false,
                    File: [],
                    FileName: "",
                    saf25FileInfo: {}
                }, Xingqi: {//興奇
                    checked: true,
                    open: false,
                    File: [],
                    FileName: "",
                    saf25FileInfo: {}
                }, Lianhebao: {//聯合報
                    checked: true,
                    open: false,
                    File: [],
                    FileName: "",
                    saf25FileInfo: {}
                }, Lutian: {//露天
                    checked: true,
                    open: false,
                    File: [],
                    FileName: "",
                    saf25FileInfo: {}
                },
                Yahoo: {//YAHOO拍賣
                    checked: true,
                    open: false,
                    File: [],
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

                        vueobj.companiestojudge(vueobj.MultipleFile[i])

                       


                    }

                  
                    
                   
                    LoadingHelper.hideLoading();


                }, companiestojudge: function (File) {
                    var formData = new FormData();
                    formData.append("file", File)

                    var vueobj = this;

                    if (File.name.toUpperCase().indexOf("02. MOMO.CSV") > -1) {
                        vueobj.MOMO.FileName = File.name;
                        vueobj.ImportExcelsAjax(formData, function (result) {
                            vueobj.MOMO.open = true;
                            vueobj.MOMO.saf25FileInfo = JSON.parse(result);
                        })
                    }
                    else if (File.name.toUpperCase().indexOf("03. PCHOME.CSV") > -1) {


                        vueobj.PChome.FileName = File.name;
                        vueobj.ImportExcelsAjax(formData, function (result) {
                            vueobj.PChome.open = true;
                            vueobj.PChome.saf25FileInfo = JSON.parse(result);
                        })
                    } else if (File.name.toUpperCase().indexOf("23. YAHOO拍賣.CSV") > -1) {

                        vueobj.PChome.FileName = File.name;
                        vueobj.ImportExcelsAjax(formData, function (result) {
                            vueobj.Yahoo.open = true;
                            vueobj.Yahoo.saf25FileInfo = JSON.parse(result);
                        })
                    } else if (File.name.toUpperCase().indexOf("22. 露天.CSV") > -1) {
                        vueobj.Lutian.FileName = File.name;
                        vueobj.ImportExcelsAjax(formData, function (result) {
                            vueobj.Lutian.open = true;
                            vueobj.Lutian.saf25FileInfo = JSON.parse(result);
                        })
                    } else if (File.name.toUpperCase().indexOf("16. 聯合報.CSV") > -1) {
                        vueobj.Lianhebao.FileName = File.name;
                        vueobj.ImportExcelsAjax(formData, function (result) {
                            vueobj.Lianhebao.open = true;
                            vueobj.Lianhebao.saf25FileInfo = JSON.parse(result);
                        })
                    } else if (File.name.toUpperCase().indexOf("15. 興奇.CSV") > -1) {
                        vueobj.Xingqi.FileName = File.name;
                        vueobj.ImportExcelsAjax(formData, function (result) {
                            vueobj.Xingqi.open = true;
                            vueobj.Xingqi.saf25FileInfo = JSON.parse(result);
                        })
                    } else if (File.name.toUpperCase().indexOf("14. 瘋狂賣客.CSV") > -1) {
                        vueobj.Crazymike.FileName = File.name;
                        vueobj.ImportExcelsAjax(formData, function (result) {
                            vueobj.Crazymike.open = true;
                            vueobj.Crazymike.saf25FileInfo = JSON.parse(result);
                        })
                    } else if (File.name.toUpperCase().indexOf("13. 鼎鼎.CSV") > -1) {
                        vueobj.Dingding.FileName = File.name;
                        vueobj.ImportExcelsAjax(formData, function (result) {
                            vueobj.Dingding.open = true;
                            vueobj.Dingding.saf25FileInfo = JSON.parse(result);
                        })
                    }
                    else if (File.name.toUpperCase().indexOf("12. 統一.CSV") > -1) {
                        vueobj.UniPresiden.FileName = File.name;
                        vueobj.ImportExcelsAjax(formData, function (result) {
                            vueobj.UniPresiden.open = true;
                            vueobj.UniPresiden.saf25FileInfo = JSON.parse(result);
                        })
                    }
                    else if (File.name.toUpperCase().indexOf("11. 康迅.CSV") > -1) {
                        vueobj.PayEasy.FileName = File.name;
                        vueobj.ImportExcelsAjax(formData, function (result) {
                            vueobj.PayEasy.open = true;
                            vueobj.PayEasy.saf25FileInfo = JSON.parse(result);
                        })
                    } else if (File.name.toUpperCase().indexOf("10. 夠麻吉.CSV") > -1) {
                        vueobj.Gomaji.FileName = File.name;
                        vueobj.ImportExcelsAjax(formData, function (result) {
                            vueobj.Gomaji.open = true;
                            vueobj.Gomaji.saf25FileInfo = JSON.parse(result);
                        })
                    } else if (File.name.toUpperCase().indexOf("09. 神坊.CSV") > -1) {
                        vueobj.Symphox.FileName = File.name;
                        vueobj.ImportExcelsAjax(formData, function (result) {
                            vueobj.Symphox.open = true;
                            vueobj.Symphox.saf25FileInfo = JSON.parse(result);
                        })
                    } else if (File.name.toUpperCase().indexOf("08. 松果.CSV") > -1) {
                        vueobj.Pcone.FileName = File.name;
                        vueobj.ImportExcelsAjax(formData, function (result) {
                            vueobj.Pcone.open = true;
                            vueobj.Pcone.saf25FileInfo = JSON.parse(result);
                        })
                    } else if (File.name.toUpperCase().indexOf("07. 東森 森森.CSV") > -1) {
                        vueobj.Eastern.FileName = File.name;
                        vueobj.ImportExcelsAjax(formData, function (result) {
                            vueobj.Eastern.open = true;
                            vueobj.Eastern.saf25FileInfo = JSON.parse(result);
                        })
                    } else if (File.name.toUpperCase().indexOf("06. 生活市集.CSV") > -1) {
                        vueobj.Buy123.FileName = File.name;
                        vueobj.ImportExcelsAjax(formData, function (result) {
                            vueobj.Buy123.open = true;
                            vueobj.Buy123.saf25FileInfo = JSON.parse(result);
                        })
                    } else if (File.name.toUpperCase().indexOf("05. 台灣大哥大.CSV") > -1) {
                        vueobj.Taiwan_Mobile.FileName = File.name;
                        vueobj.ImportExcelsAjax(formData, function (result) {
                            vueobj.Taiwan_Mobile.open = true;
                            vueobj.Taiwan_Mobile.saf25FileInfo = JSON.parse(result);
                        })
                    } else if (File.name.toUpperCase().indexOf("04. 台塑.CSV") > -1) {
                        vueobj.Taiwan_Mobile.FileName = File.name;
                        vueobj.ImportExcelsAjax(formData, function (result) {
                            vueobj.Taiwan_Mobile.open = true;
                            vueobj.Taiwan_Mobile.saf25FileInfo = JSON.parse(result);
                        })
                    }

                },ImportExcelsAjax: function (formData,callback) {

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
                    if (files.length == 0) return;

                    //檔案排序
                    [].slice.call(files).sort(function (a, b) {
                        var keyA = a.name,
                            keyB = b.name;
                        // Compare the 2 dates
                        if (keyA < keyB) return -1;
                        if (keyA > keyB) return 1;
                        return 0;
                    });



                    this.MultipleFile = files
                    //e.target.value = "";
                }, onFileChange: function (type, e) {
                    var vueobj = this
                    var files = e.target.files || e.dataTransfer.files;
                    if (files.length == 0) return;

                    if (type == files[0].name.toUpperCase()) {
                        vueobj.companiestojudge(files[0]);
                    } else {

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