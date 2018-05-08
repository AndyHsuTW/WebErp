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
        SaveEnterPageLog(rootUrl, localStorage.getItem("USER_ID"), "Dsap92501");
        Array.prototype.remove = function (val) {
            var index = this.indexOf(val);
            if (index > -1) {
                this.splice(index, 1);
            }
        };
        window.Dspa92501 = new Vue({
            el: "#Dspa92501",
            data: {
                MultipleFile: [],
                DateTime: "",
                ModalError: [],
                one7P: {
                    SortColumn: "",
                    SortOrder: "",
                    reverse: false,
                    checked: true,
                    open: false,
                    File: [],
                    FileName: "",
                    saf25FileInfo: {}
                },
                MOMO: {
                    SortColumn: "",
                    SortOrder: "",
                    reverse: false,
                    checked: true,
                    open: false,
                    File: [],
                    FileName: "",
                    saf25FileInfo: {}
                },
                MOMO_Specified: { //MOMO指定貨運
                    SortColumn: "",
                    SortOrder: "",
                    reverse: false,
                    checked: true,
                    open: false,
                    File: [],
                    FileName: "",
                    saf25FileInfo: {}
                },
                PChome: {
                    checked: true,
                    open: false,
                    File: [],
                    FileName: "",
                    saf25FileInfo: {}
                },
                Formosa_Plastics: { //台塑
                    checked: true,
                    open: false,
                    File: [],
                    FileName: "",
                    saf25FileInfo: {}
                },
                Taiwan_Mobile: { //台灣大哥大
                    checked: true,
                    open: false,
                    File: [],
                    FileName: "",
                    saf25FileInfo: {}
                },
                Buy123: { //生活市集
                    checked: true,
                    open: false,
                    File: [],
                    FileName: "",
                    saf25FileInfo: {}
                },
                Eastern: { //東森
                    checked: true,
                    open: false,
                    File: [],
                    FileName: "",
                    saf25FileInfo: {}
                },
                Pcone: { //松果
                    checked: true,
                    open: false,
                    File: [],
                    FileName: "",
                    saf25FileInfo: {}
                },
                PconeMart: { //松果超取 24
                    checked: true,
                    open: false,
                    File: [],
                    FileName: "",
                    saf25FileInfo: {}
                },
                Symphox: { //神坊
                    checked: true,
                    open: false,
                    File: [],
                    FileName: "",
                    saf25FileInfo: {}
                },
                Gomaji: { //夠麻吉
                    checked: true,
                    open: false,
                    File: [],
                    FileName: "",
                    saf25FileInfo: {}
                },
                PayEasy: { //康迅
                    checked: true,
                    open: false,
                    File: [],
                    FileName: "",
                    saf25FileInfo: {}
                },
                UniPresiden: { //統一
                    checked: true,
                    open: false,
                    File: [],
                    FileName: "",
                    saf25FileInfo: {}
                },
                Dingding: { //鼎鼎
                    checked: true,
                    open: false,
                    File: [],
                    FileName: "",
                    saf25FileInfo: {}
                },
                Crazymike: { //瘋狂賣克
                    checked: true,
                    open: false,
                    File: [],
                    FileName: "",
                    saf25FileInfo: {}
                },
                Xingqi: { //興奇
                    checked: true,
                    open: false,
                    File: [],
                    FileName: "",
                    saf25FileInfo: {}
                },
                Lianhebao: { //聯合報
                    checked: true,
                    open: false,
                    File: [],
                    FileName: "",
                    saf25FileInfo: {}
                },
                Lutian: { //露天
                    checked: true,
                    open: false,
                    File: [],
                    FileName: "",
                    saf25FileInfo: {}
                },
                Yahoo: { //YAHOO拍賣
                    SortColumn: "",
                    SortOrder: "",
                    checked: true,
                    open: false,
                    File: [],
                    FileName: "",
                    saf25FileInfo: {}
                },
                YahooMart: { // 奇摩超級商城
                    checked: true,
                    open: false,
                    File: [],
                    FileName: "",
                    saf25FileInfo: {}
                },
                Motian: { // 摩天
                    checked: true,
                    open: false,
                    File: [],
                    FileName: "",
                    saf25FileInfo: {}
                },
                Letian: { // 摩天
                    checked: true,
                    open: false,
                    File: [],
                    FileName: "",
                    saf25FileInfo: {}
                },
                Pc: { // Pc
                    checked: true,
                    open: false,
                    File: [],
                    FileName: "",
                    saf25FileInfo: {}
                },
                PcHome_Delivery: { // pchome 宅配
                    checked: true,
                    open: false,
                    File: [],
                    FileName: "",
                    saf25FileInfo: {}
                },
                Yahoo_MartDelivery: { // Yahoo 超取
                    checked: true,
                    open: false,
                    File: [],
                    FileName: "",
                    saf25FileInfo: {}
                },
                Shopee: { // 蝦皮
                    checked: true,
                    open: false,
                    File: [],
                    FileName: "",
                    saf25FileInfo: {}
                },
                YahooMart_MartDelivery: { // 蝦皮
                    checked: true,
                    open: false,
                    File: [],
                    FileName: "",
                    saf25FileInfo: {}
                },


                requests: [],
                ImportDBLoadding: false
            },
            methods: {
                OnExit: function() {


                    if ($(this.$refs.modalDialog).hasClass('in') || $(this.$refs.HelpDialog).hasClass('in')) {
                        return;
                    }

                    window.close();
                    setTimeout(function() {
                            window.location.href = "about:blank";
                        },
                        500);
                },
                sortBy: function(Object, column, $event) {

                    $($event.target).parents("tr:first").find("th").each(function() {
                        $(this).attr("class", "");

                    });
                    $($event.target).attr("class", "orderby");

                    if (Object.SortColumn == column) {
                        if (Object.SortOrder == "asc") {
                            Object.SortOrder = "desc";

                        } else {
                            Object.SortOrder = "asc";

                        }
                    } else {
                        Object.SortOrder = "asc";

                    }
                    Object.SortColumn = column;
                    Object.saf25FileInfo.saf25List.sort(function(a, b) {

                        if (a[Object.SortColumn] < b[Object.SortColumn]) {
                            return Object.SortOrder == 'asc' ? -1 : 1;

                        }
                        if (a[Object.SortColumn] > b[Object.SortColumn]) {
                            return Object.SortOrder == 'asc' ? 1 : -1;
                        }
                        return 0;
                    });
                },
                ImportAll: function() {
                    var vueobj = this;
                    if (vueobj.ImportDBLoadding) {
                        alert("還在寫入中");
                        return;
                    }


                    var Msg = "";
                    if (confirm("確定匯入?")) {
                        vueobj.ImportDBLoadding = true;
                        var List = [];
                        //01
                        if (vueobj.one7P.checked && vueobj.one7P.open) {
                            List.push(vueobj.one7P.saf25FileInfo);
                        }
                        //02
                        if (vueobj.MOMO.checked && vueobj.MOMO.open) {
                            List.push(vueobj.MOMO.saf25FileInfo);
                        }
                        //03
                        if (vueobj.PChome.checked && vueobj.PChome.open) {
                            List.push(vueobj.PChome.saf25FileInfo);
                        }

                        //04
                        if (vueobj.Formosa_Plastics.checked && vueobj.Formosa_Plastics.open) {
                            List.push(vueobj.Formosa_Plastics.saf25FileInfo);
                        }
                        //05
                        if (vueobj.Taiwan_Mobile.checked && vueobj.Taiwan_Mobile.open) {
                            List.push(vueobj.Taiwan_Mobile.saf25FileInfo);
                        }
                        //06
                        if (vueobj.Buy123.checked && vueobj.Buy123.open) {
                            List.push(vueobj.Buy123.saf25FileInfo);
                        }
                        //07
                        if (vueobj.Eastern.checked && vueobj.Eastern.open) {
                            List.push(vueobj.Eastern.saf25FileInfo);
                        }

                        //08
                        if (vueobj.Pcone.checked && vueobj.Pcone.open) {
                            List.push(vueobj.Pcone.saf25FileInfo);
                        }
                        //09
                        if (vueobj.Symphox.checked && vueobj.Symphox.open) {
                            List.push(vueobj.Symphox.saf25FileInfo);
                        }
                        //10
                        if (vueobj.Gomaji.checked && vueobj.Gomaji.open) {
                            List.push(vueobj.Gomaji.saf25FileInfo);
                        }
                        //11
                        if (vueobj.PayEasy.checked && vueobj.PayEasy.open) {
                            List.push(vueobj.PayEasy.saf25FileInfo);
                        }

                        //12
                        if (vueobj.UniPresiden.checked && vueobj.UniPresiden.open) {
                            List.push(vueobj.UniPresiden.saf25FileInfo);
                        }
                        //13
                        if (vueobj.Dingding.checked && vueobj.Dingding.open) {
                            List.push(vueobj.Dingding.saf25FileInfo);
                        }
                        //14
                        if (vueobj.Crazymike.checked && vueobj.Crazymike.open) {
                            List.push(vueobj.Crazymike.saf25FileInfo);
                        }
                        //15
                        if (vueobj.Xingqi.checked && vueobj.Xingqi.open) {
                            List.push(vueobj.Xingqi.saf25FileInfo);
                        }
                        //16
                        if (vueobj.Lianhebao.checked && vueobj.Lianhebao.open) {
                            List.push(vueobj.Lianhebao.saf25FileInfo);
                        }
                        //17
                        if (vueobj.MOMO_Specified.checked && vueobj.MOMO_Specified.open) {
                            List.push(vueobj.MOMO_Specified.saf25FileInfo);
                        }
                        //18
                        if (vueobj.YahooMart.checked && vueobj.YahooMart.open) {
                            List.push(vueobj.YahooMart.saf25FileInfo);
                        }
                        //19
                        if (vueobj.Motian.checked && vueobj.Motian.open) {
                            List.push(vueobj.Motian.saf25FileInfo);
                        }
                        //20
                        if (vueobj.Letian.checked && vueobj.Letian.open) {
                            List.push(vueobj.Letian.saf25FileInfo);
                        }


                        //21
                        if (vueobj.Pc.checked && vueobj.Pc.open) {
                            List.push(vueobj.Pc.saf25FileInfo);
                        }
                        //22
                        if (vueobj.Lutian.checked && vueobj.Lutian.open) {
                            List.push(vueobj.Lutian.saf25FileInfo);
                        }

                        //23
                        if (vueobj.Yahoo.checked && vueobj.Yahoo.open) {
                            List.push(vueobj.Yahoo.saf25FileInfo);
                        }
                        //24
                        if (vueobj.PconeMart.checked && vueobj.PconeMart.open) {
                            List.push(vueobj.PconeMart.saf25FileInfo);
                        }
                        //25
                        if (vueobj.YahooMart_MartDelivery.checked && vueobj.YahooMart_MartDelivery.open) {
                            List.push(vueobj.YahooMart_MartDelivery.saf25FileInfo);
                        }
                        //缺25

                        //26
                        if (vueobj.PcHome_Delivery.checked && vueobj.PcHome_Delivery.open) {
                            List.push(vueobj.PcHome_Delivery.saf25FileInfo)
                        }
                        //27
                        if (vueobj.Shopee.checked && vueobj.Shopee.open) {
                            List.push(vueobj.Shopee.saf25FileInfo)
                        }
                        //28
                        if (vueobj.Yahoo_MartDelivery.checked) {
                            List.push(vueobj.Yahoo_MartDelivery.saf25FileInfo);
                        }


                        LoadingHelper.showLoading();
                        $.ajax({
                            url: rootUrl + "Dsap92501/Ajax/Import_saf25.ashx",
                            type: 'POST',
                            cache: false,
                            async: true,
                            data: {
                                List: JSON.stringify(List),
                                Loginuser: localStorage.getItem("USER_ID")
                            },
                            success: function(result) {
                                LoadingHelper.hideLoading();
                                vueobj.ImportDBLoadding = false;
                                var List = JSON.parse(result);
                                if (List.length > 0) {
                                    var Msg = "";
                                    for (var i = 0; i < List.length; i++) {
                                        Msg += List[i] + "有錯誤\n";

                                    }
                                    alert(Msg);


                                } else {
                                    alert("匯入成功");
                                }

                            },
                            error: function(jqXhr, textStatus, errorThrown) {
                                LoadingHelper.hideLoading();
                                vueobj.ImportDBLoadding = false;
                                console.error(errorThrown);
                            }
                        });


                    }

                }
                , guid: function () {
                    function s4() {
                        return Math.floor((1 + Math.random()) * 0x10000)
                            .toString(16)
                            .substring(1);
                    }

                    return s4() +
                        s4() +
                        '-' +
                        s4() +
                        '-' +
                        s4() +
                        '-' +
                        s4() +
                        '-' +
                        s4() +
                        s4() +
                        s4();
                },
                MultipleSubmit: function () {


                    if (this.DateTime.trim() == "") {
                        alert("未填日期");
                        return;
                    }
                    var vueobj = this;

                    for (var i = 0; i < vueobj.MultipleFile.length; i++) {
                        LoadingHelper.showLoading();


                        this.checkAjax(vueobj.MultipleFile[i]);

                        //vueobj.companiestojudge(vueobj.MultipleFile[i])
                    }


                },
                checkAjax: function (File) {
                    var vueobj = this;

                    setTimeout(function () {
                        if (vueobj.requests.length < 6) {
                            vueobj.companiestojudge(File);
                        } else {
                            vueobj.checkAjax(File);

                        }


                    },
                        1000);

                },
                companiestojudge: function (File) {
                    var formData = new FormData();
                    formData.append("file", File);

                    var vueobj = this;

                    var filenumber = File.name.substring(0, 2);

                    if (filenumber == "01") {
                        vueobj.one7P.FileName = File.name;
                        vueobj.ImportExcelsAjax(formData,
                            function (result) {
                                vueobj.one7P.open = true;
                                vueobj.one7P.saf25FileInfo = JSON.parse(result);
                            });
                    } else if (filenumber == "02") {
                        vueobj.MOMO.FileName = File.name;
                        vueobj.ImportExcelsAjax(formData,
                            function (result) {
                                vueobj.MOMO.open = true;
                                vueobj.MOMO.saf25FileInfo = JSON.parse(result);
                            });
                    } else if (filenumber == "03") {
                        vueobj.PChome.FileName = File.name;
                        vueobj.ImportExcelsAjax(formData,
                            function (result) {
                                vueobj.PChome.open = true;
                                vueobj.PChome.saf25FileInfo = JSON.parse(result);
                            });
                    } else if (filenumber == "04") {
                        vueobj.Formosa_Plastics.FileName = File.name;
                        vueobj.ImportExcelsAjax(formData,
                            function (result) {
                                vueobj.Formosa_Plastics.open = true;
                                vueobj.Formosa_Plastics.saf25FileInfo = JSON.parse(result);
                            });
                    } else if (filenumber == "05") {
                        vueobj.Taiwan_Mobile.FileName = File.name;
                        vueobj.ImportExcelsAjax(formData,
                            function (result) {
                                vueobj.Taiwan_Mobile.open = true;
                                vueobj.Taiwan_Mobile.saf25FileInfo = JSON.parse(result);
                            });
                    } else if (filenumber == "06") {
                        vueobj.Buy123.FileName = File.name;
                        vueobj.ImportExcelsAjax(formData,
                            function (result) {
                                vueobj.Buy123.open = true;
                                vueobj.Buy123.saf25FileInfo = JSON.parse(result);
                            });
                    } else if (filenumber == "07") {
                        vueobj.Eastern.FileName = File.name;
                        vueobj.ImportExcelsAjax(formData,
                            function (result) {
                                vueobj.Eastern.open = true;
                                vueobj.Eastern.saf25FileInfo = JSON.parse(result);
                            });
                    } else if (filenumber == "08") {
                        vueobj.Pcone.FileName = File.name;
                        vueobj.ImportExcelsAjax(formData,
                            function (result) {
                                vueobj.Pcone.open = true;
                                vueobj.Pcone.saf25FileInfo = JSON.parse(result);
                            });
                    } else if (filenumber == "09") {
                        vueobj.Symphox.FileName = File.name;
                        vueobj.ImportExcelsAjax(formData,
                            function (result) {
                                vueobj.Symphox.open = true;
                                vueobj.Symphox.saf25FileInfo = JSON.parse(result);
                            });
                    } else if (filenumber == "10") {
                        vueobj.Gomaji.FileName = File.name;
                        vueobj.ImportExcelsAjax(formData,
                            function (result) {
                                vueobj.Gomaji.open = true;
                                vueobj.Gomaji.saf25FileInfo = JSON.parse(result);
                            });
                    } else if (filenumber == "11") {
                        vueobj.PayEasy.FileName = File.name;
                        vueobj.ImportExcelsAjax(formData,
                            function (result) {
                                vueobj.PayEasy.open = true;
                                vueobj.PayEasy.saf25FileInfo = JSON.parse(result);
                            });
                    } else if (filenumber == "12") {
                        vueobj.UniPresiden.FileName = File.name;
                        vueobj.ImportExcelsAjax(formData,
                            function (result) {
                                vueobj.UniPresiden.open = true;
                                vueobj.UniPresiden.saf25FileInfo = JSON.parse(result);
                            });
                    } else if (filenumber == "13") {
                        vueobj.Dingding.FileName = File.name;
                        vueobj.ImportExcelsAjax(formData,
                            function (result) {
                                vueobj.Dingding.open = true;
                                vueobj.Dingding.saf25FileInfo = JSON.parse(result);
                            });
                    } else if (filenumber == "14") {
                        vueobj.Crazymike.FileName = File.name;
                        vueobj.ImportExcelsAjax(formData,
                            function (result) {
                                vueobj.Crazymike.open = true;
                                vueobj.Crazymike.saf25FileInfo = JSON.parse(result);
                            });
                    } else if (filenumber == "15") {
                        vueobj.Xingqi.FileName = File.name;
                        vueobj.ImportExcelsAjax(formData,
                            function (result) {
                                vueobj.Xingqi.open = true;
                                vueobj.Xingqi.saf25FileInfo = JSON.parse(result);
                            });
                    } else if (filenumber == "16") {
                        vueobj.Lianhebao.FileName = File.name;
                        vueobj.ImportExcelsAjax(formData,
                            function (result) {
                                vueobj.Lianhebao.open = true;
                                vueobj.Lianhebao.saf25FileInfo = JSON.parse(result);
                            });
                    } else if (filenumber == "17") {
                        vueobj.MOMO_Specified.FileName = File.name;
                        vueobj.ImportExcelsAjax(formData,
                            function (result) {
                                vueobj.MOMO_Specified.open = true;
                                vueobj.MOMO_Specified.saf25FileInfo = JSON.parse(result);
                            });
                    } else if (filenumber == "18") {
                        vueobj.YahooMart.FileName = File.name;
                        vueobj.ImportExcelsAjax(formData,
                            function (result) {
                                vueobj.YahooMart.open = true;
                                vueobj.YahooMart.saf25FileInfo = JSON.parse(result);
                            });
                    } else if (filenumber == "19") {
                        vueobj.Motian.FileName = File.name;
                        vueobj.ImportExcelsAjax(formData,
                            function (result) {
                                vueobj.Motian.open = true;
                                vueobj.Motian.saf25FileInfo = JSON.parse(result);
                            });
                    } else if (filenumber == "20") {
                        vueobj.Letian.FileName = File.name;
                        vueobj.ImportExcelsAjax(formData,
                            function (result) {
                                vueobj.Letian.open = true;
                                vueobj.Letian.saf25FileInfo = JSON.parse(result);
                            });
                    } else if (filenumber == "21") {
                        vueobj.Pc.FileName = File.name;
                        vueobj.ImportExcelsAjax(formData,
                            function (result) {
                                vueobj.Pc.open = true;
                                vueobj.Pc.saf25FileInfo = JSON.parse(result);
                            });
                    } else if (filenumber == "22") {
                        vueobj.Lutian.FileName = File.name;
                        vueobj.ImportExcelsAjax(formData,
                            function (result) {
                                vueobj.Lutian.open = true;
                                vueobj.Lutian.saf25FileInfo = JSON.parse(result);
                            });
                    } else if (filenumber == "23") {

                        vueobj.PChome.FileName = File.name;
                        vueobj.ImportExcelsAjax(formData,
                            function (result) {
                                vueobj.Yahoo.open = true;
                                vueobj.Yahoo.saf25FileInfo = JSON.parse(result);
                            });
                    } else if (filenumber == "24") {
                        vueobj.PconeMart.FileName = File.name;
                        vueobj.ImportExcelsAjax(formData,
                            function (result) {
                                vueobj.PconeMart.open = true;
                                vueobj.PconeMart.saf25FileInfo = JSON.parse(result);
                            });
                    } else if (filenumber == "25") {
                        vueobj.YahooMart_MartDelivery.FileName = File.name;
                        vueobj.ImportExcelsAjax(formData,
                            function (result) {
                                vueobj.YahooMart_MartDelivery.open = true;
                                vueobj.YahooMart_MartDelivery.saf25FileInfo = JSON.parse(result);
                            });
                    } else if (filenumber == "26") {
                        vueobj.PcHome_Delivery.FileName = File.name;
                        vueobj.ImportExcelsAjax(formData,
                            function (result) {
                                vueobj.PcHome_Delivery.open = true;
                                vueobj.PcHome_Delivery.saf25FileInfo = JSON.parse(result);
                            });
                    } else if (filenumber == "27") {
                        vueobj.Shopee.FileName = File.name;
                        vueobj.ImportExcelsAjax(formData,
                            function (result) {
                                vueobj.Shopee.open = true;
                                vueobj.Shopee.saf25FileInfo = JSON.parse(result);
                            });
                    } else if (filenumber == "28") {
                        vueobj.Yahoo_MartDelivery.FileName = File.name;
                        vueobj.ImportExcelsAjax(formData,
                            function (result) {
                                vueobj.Yahoo_MartDelivery.open = true;
                                vueobj.Yahoo_MartDelivery.saf25FileInfo = JSON.parse(result);
                            });
                    }

                    if (vueobj.requests.length == 0) {
                        LoadingHelper.hideLoading();
                    }


                },
                ImportExcelsAjax: function (formData, callback) {


                    var vueobj = this;
                    var guid = vueobj.guid();
                    vueobj.requests.push(guid);


                    $.ajax({
                        url: rootUrl + "Dsap92501/Ajax/ImportExcels.ashx?DateTime=" + this.DateTime + "&v=" + guid,
                        type: 'POST',
                        data: formData,
                        cache: false,
                        dataType: 'text',
                        processData: false,
                        contentType: false,
                        success: function (result) {
                            LoadingHelper.hideLoading();
                            vueobj.requests.remove(guid);
                            if (typeof (callback) === "function") {
                                callback(result);

                            }
                            if (vueobj.requests.length == 0) {
                                LoadingHelper.hideLoading();

                            }
                        },
                        error: function (jqXhr, textStatus, errorThrown) {
                            LoadingHelper.hideLoading();

                            vueobj.requests.remove(guid);
                            console.log(errorThrown);
                            var a = {};
                            a.FileName = "",
                                a.CompanyName = "",
                                a.cnf1004_char02 = "error",
                                a.ErrorMsg = [];
                            a.saf25List = [];
                            var b = {};
                            b.column = "",
                                b.messenge = "解析過程出錯，請聯繫資訊人員"
                            a.ErrorMsg.push(b);

                            callback(JSON.stringify(a));


                            //alert("匯入失敗");
                        }
                    });
                },
                Upload: function () {

                    $("#ImportExcelInput").trigger("click");
                },
                onMultipleFileChange: function (e) {
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


                    this.MultipleFile = files;
                    //e.target.value = "";
                },
                onFileChange: function (type, e) {
                    var vueobj = this;
                    var files = e.target.files || e.dataTransfer.files;
                    if (files.length == 0) return;
                    var filenumber = files[0].name.substring(0, 2);


                    if (filenumber.indexOf(type) > -1) {
                        LoadingHelper.showLoading();
                        vueobj.companiestojudge(files[0]);
                    } else {

                    }


                    e.target.value = "";
                },
                bytesToSize: function (bytes) {
                    var sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB'];
                    if (bytes == 0) return '0 Byte';
                    var i = parseInt(Math.floor(Math.log(bytes) / Math.log(1024)));
                    return Math.round(bytes / Math.pow(1024, i), 2) + ' ' + sizes[i];
                }
            }
            

        });

window.Dspa92501.DateTime = new Date().getFullYear() + '/' + ('0' + (new Date().getMonth() + 1)).slice(-2) + '/' + ('0' + new Date().getDate()).slice(-2);


}
function onError(error) {
    console.error(error);
}

define(requiredFiles, onLoaded, onError);

})();