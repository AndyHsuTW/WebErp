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

    function onLoaded(bootstrap, functionButton, uibPagination, vueDatetimepicker, loadingHelper, D_pcodeCss) {

      

         Vue.component('d_pcode_component', {
            template: '\
                        <div>\
                            <ul class="app-title">\<li>商品資料查詢</li></ul>\
                            <div class="app-body">\
                                <div class="common-button-div">\
                                    <function-button id="SearchBtn" hot-key="f1" v-on:click.native="OnSearch()">查詢</function-button>\
                                </div>\
                                    <div class="filter-div">\
                                        <table class="">\
                                            <tr>\
                                                <td>廠商代號&nbsp\
                                                </td>\
                                                <td><input type="text" v-model="Filter.Mcode">&nbsp(Like 用 * 查詢)\
                                                </td>\
                                                <td>&nbsp&nbsp&nbsp廠商貨號&nbsp起&nbsp\
                                                </td>\
                                                <td><input type="text" v-model="Filter.RelativeNo_start">&nbsp訖&nbsp<input type="text" v-model="Filter.RelativeNo_end">\
                                                </td>\
                                            </tr>\
                                            <tr>\
                                                <td>商品條碼&nbsp\
                                                </td>\
                                                <td><input type="text" v-model="Filter.Pcode">&nbsp(Like 用 * 查詢)\
                                                </td>\
                                                <td>&nbsp;&nbsp;&nbsp;商品名稱&nbsp\
                                                </td>\
                                                <td><input type="text" v-model="Filter.Psname">&nbsp(Like 用 * 查詢)\
                                                </td>\
                                            </tr>\
                                            <tr>\
                                                <td>關鍵字&nbsp\
                                                </td>\
                                                <td><input type="text" v-model="Filter.Keyword">\
                                                </td>\
                                                <td>&nbsp;&nbsp;&nbsp;售價&nbsp起&nbsp\
                                                </td>\
                                                <td><input type="text" v-model="Filter.Retail_start">&nbsp訖&nbsp<input type="text" v-model="Filter.Retail_end">\
                                                </td>\
                                            </tr>\
                                        </table>\
                                    </div>\
                                    <div class="result-div" >\
                                        <div class="">\
                                            <table class="table table-bordered table-fixed">\
                                                <thead>\
                                                    <tr class="bg-primary text-light header">\
                                                        <th class="col-xs-1" v-if="typeof callback == \'function\'"></th>\
                                                        <th class="col-xs-1">商品條碼</th>\
                                                        <th class="col-xs-1">商品名稱</th>\
                                                        <th class="col-xs-1">品名規格</th>\
                                                        <th class="col-xs-1">顏色</th>\
                                                        <th class="col-xs-1">單位</th>\
                                                        <th class="col-xs-1">商品部門</th>\
                                                        <th class="col-xs-1">商品分類</th>\
                                                        <th class="col-xs-1">售價(含稅)</th>\
                                                        <th class="col-xs-1">現有庫存數</th>\
                                                        <th class="col-xs-1">廠商</th>\
                                                        <th class="col-xs-1">連結圖片</th>\
                                                    </tr>\
                                                </thead>\
                                                <tbody v-on:scroll="OnScroll" id="table-content" v-bind:style={width:tbodywidth}>\
                                                    <tr class="rowclass" v-for="D_pcodeData in D_pcodeList" >\
                                                        <td class="col-xs-1" v-if="typeof callback == \'function\'">\
                                                        <button type="button" role="button" class="btn btn-default" @click="callback(D_pcodeData)">送出</button>\
                                                        </td>\
                                                        <td class="col-xs-1">{{D_pcodeData.pcode}}</td>\
                                                        <td class="col-xs-1">{{D_pcodeData.psname}}</td>\
                                                        <td class="col-xs-1">{{D_pcodeData.pname}}</td>\
                                                        <td class="col-xs-1">{{D_pcodeData.color}}</td>\
                                                        <td class="col-xs-1">{{D_pcodeData.runit}}</td>\
                                                        <td class="col-xs-1">{{D_pcodeData.pdept}}</td>\
                                                        <td class="col-xs-1">{{D_pcodeData.pcat}}</td>\
                                                        <td class="col-xs-1">{{D_pcodeData.retail}}</td>\
                                                        <td class="col-xs-1">{{D_pcodeData.inv_qty}}</td>\
                                                        <td class="col-xs-1">{{D_pcodeData.bname}}</td>\
                                                        <th class="col-xs-1"><img v-bind:src="D_pcodeData.graphy" v-if="D_pcodeData.graphy!=\'\'"></th>\
                                                    </tr>\
                                                </tbody>\
                                            </table>\
                                        </div>\
                                    </div>\
                            </div>\
                        </div>\
                        ',
            props: {
                callback: null,
               
            },
            data: function () {
                
                return {
                    Filter: {
                        Mcode: "",
                        RelativeNo_start: "",
                        RelativeNo_end: "",
                        Pcode: "",
                        Psname: "",
                        Keyword: "",
                        Retail_start: "",
                        Retail_end: ""
                    },
                    D_pcodeList: [],
                    StartRow: 0,
                    ajaxXhr: null,
                    Searching: false,
                    ajaxFilter: {},
                    IsEnd: false,
                    tbodywidth:'calc(100% - 18px)',
                }

            },
            methods: {
                OnScroll: function () {

                   
                    var scrollTop = $("#table-content").scrollTop();
                    var $terms = $("#table-content");

                    var scrollBottom = $terms.prop('scrollHeight') - (($terms.height() + scrollTop));
                    if (scrollBottom < 200) {
                        this.SeachAjax();
                    }

                },
                OnSearch: function () {

                    
                    this.StartRow = 0;
                    this.D_pcodeList = [];
                    this.Searching = false,
                    this.ajaxFilter = JSON.parse(JSON.stringify(this.Filter));
                    this.SeachAjax();

                }, SeachAjax: function () {
                    if (this.Searching) {
                        return;
                    }

                    if (this.ajaxXhr != null) {
                        this.ajaxXhr.abort();
                    }
                    this.Searching = true;

                    var vueObj = this;

                    this.ajaxXhr = $.ajax({
                        type: 'POST',
                        url: rootUrl + "D_pcode/Ajax/D_pcodeHandler.ashx",
                        cache: false,
                        data: {
                            filterOption: encodeURIComponent(JSON.stringify(this.ajaxFilter)),
                            StartRow: this.StartRow
                        },
                        beforeSend: function () {
                            LoadingHelper.showLoading();
                        },
                        success: function (result) {

                            vueObj.Searching = false;
                            var list = JSON.parse(result);

                            for (var i in list) {
                                vueObj.D_pcodeList.push(list[i]);
                            }
                            vueObj.StartRow += list.length;

                            if (list.length == 0) {
                                alert("查無資料");
                                vueObj.Searching = true;
                            }
                            Vue.nextTick(function () {
                                if ($("#table-content").scrollTop() == 0 && $("#table-content").prop('scrollHeight') == 400) {
                                    vueObj.tbodywidth = "calc(100% - 18px)";
                                } else {
                                    vueObj.tbodywidth = "100%";
                                }
                            })

                          


                        },
                        error: function (jqXhr, textStatus, errorThrown) {
                            if (jqXhr.status == 0) {
                                return;
                            }
                            vueObj.Searching = false;
                            console.error(errorThrown);
                            alert("查詢失敗");
                        }, complete: function () {
                            LoadingHelper.hideLoading();

                        }
                    });



                }
            }
        });


        


        //window.d_pcode = new Vue({
        //    el: '#d_pcode',
        //    components: {

        //        'd_pcode_component': {
        //            props: ['initialCounter'],
        //            template:
        //                '\
        //                <div>\
        //                    <ul class="app-title">\<li>商品資料查詢</li></ul>\
        //                    <div class="app-body">\
        //                        <div class="common-button-div">\
        //                            <function-button id="SearchBtn" hot-key="f1" v-on:click.native="OnSearch()">查詢</function-button>\
        //                        </div>\
        //                            <div class="filter-div">\
        //                                <table class="">\
        //                                    <tr>\
        //                                        <td>廠商代號&nbsp\
        //                                        </td>\
        //                                        <td><input type="text" v-model="Filter.Mcode">&nbsp(Like 用 * 查詢)\
        //                                        </td>\
        //                                        <td>&nbsp&nbsp&nbsp廠商貨號&nbsp起&nbsp\
        //                                        </td>\
        //                                        <td><input type="text" v-model="Filter.RelativeNo_start">&nbsp訖&nbsp<input type="text" v-model="Filter.RelativeNo_end">\
        //                                        </td>\
        //                                    </tr>\
        //                                    <tr>\
        //                                        <td>商品條碼&nbsp\
        //                                        </td>\
        //                                        <td><input type="text" v-model="Filter.Pcode">&nbsp(Like 用 * 查詢)\
        //                                        </td>\
        //                                        <td>&nbsp;&nbsp;&nbsp;商品名稱&nbsp\
        //                                        </td>\
        //                                        <td><input type="text" v-model="Filter.Psname">&nbsp(Like 用 * 查詢)\
        //                                        </td>\
        //                                    </tr>\
        //                                    <tr>\
        //                                        <td>關鍵字&nbsp\
        //                                        </td>\
        //                                        <td><input type="text" v-model="Filter.Keyword">\
        //                                        </td>\
        //                                        <td>&nbsp;&nbsp;&nbsp;售價&nbsp起&nbsp\
        //                                        </td>\
        //                                        <td><input type="text" v-model="Filter.Retail_start">&nbsp訖&nbsp<input type="text" v-model="Filter.Retail_end">\
        //                                        </td>\
        //                                    </tr>\
        //                                </table>\
        //                            </div>\
        //                            <div class="result-div" >\
        //                                <div class="">\
        //                                    <table class="table table-bordered table-fixed">\
        //                                        <thead>\
        //                                            <tr class="bg-primary text-light header">\
        //                                                <th class="col-xs-1">商品條碼{{needClickButton}}</th>\
        //                                                <th class="col-xs-1">商品名稱</th>\
        //                                                <th class="col-xs-1">品名規格</th>\
        //                                                <th class="col-xs-1">顏色</th>\
        //                                                <th class="col-xs-1">單位</th>\
        //                                                <th class="col-xs-1">商品部門</th>\
        //                                                <th class="col-xs-1">商品分類</th>\
        //                                                <th class="col-xs-1">售價(含稅)</th>\
        //                                                <th class="col-xs-1">現有庫存數</th>\
        //                                                <th class="col-xs-1">廠商</th>\
        //                                            </tr>\
        //                                        </thead>\
        //                                        <tbody v-on:scroll="OnScroll" id="table-content">\
        //                                            <tr class="rowclass" v-for="D_pcodeData in D_pcodeList" >\
        //                                                <td class="col-xs-1">{{D_pcodeData.pcode}}</td>\
        //                                                <td class="col-xs-1">{{D_pcodeData.psname}}</td>\
        //                                                <td class="col-xs-1">{{D_pcodeData.pname}}</td>\
        //                                                <td class="col-xs-1">{{D_pcodeData.color}}</td>\
        //                                                <td class="col-xs-1">{{D_pcodeData.runit}}</td>\
        //                                                <td class="col-xs-1">{{D_pcodeData.pdept}}</td>\
        //                                                <td class="col-xs-1">{{D_pcodeData.pcat}}</td>\
        //                                                <td class="col-xs-1">{{D_pcodeData.retail}}</td>\
        //                                                <td class="col-xs-1">{{D_pcodeData.inv_qty}}</td>\
        //                                                <td class="col-xs-1">{{D_pcodeData.bname}}</td>\
        //                                            </tr>\
        //                                        </tbody>\
        //                                    </table>\
        //                                </div>\
        //                            </div>\
        //                    </div>\
        //                </div>\
        //                '

        //            , data: function () {
        //                return {
        //                    Filter: {
        //                        Mcode: "",
        //                        RelativeNo_start: "",
        //                        RelativeNo_end: "",
        //                        Pcode: "",
        //                        Psname: "",
        //                        Keyword: "",
        //                        Retail_start: "",
        //                        Retail_end: ""},
        //                    D_pcodeList: [],
        //                    StartRow:0,
        //                    ajaxXhr: null,
        //                    Searching: false,
        //                    ajaxFilter: {},
        //                    IsEnd: false,
        //                    needClickButton: this.initialCounter
        //                }

        //            },
        //            methods: {

        //                OnScroll: function () {

        //                        var scrollLeft = $("#table-content").scrollLeft();
        //                        var scrollTop = $("#table-content").scrollTop();
        //                        var $terms = $("#table-content");

        //                        var scrollBottom = $terms.prop('scrollHeight') - (($terms.height() + scrollTop));
        //                        if (scrollBottom < 200) {
        //                            this.SeachAjax();
        //                        }

        //                },
        //                OnSearch: function () {

        //                    d_pcodeCallback();
        //                    this.StartRow = 0;
        //                    this.D_pcodeList = [];
        //                    this.Searching = false,
        //                    this.ajaxFilter = JSON.parse(JSON.stringify(this.Filter));
        //                    this.SeachAjax();

        //                }, SeachAjax: function () {
        //                    if (this.Searching) {
        //                        return;
        //                    }

        //                    if (this.ajaxXhr != null) {
        //                        this.ajaxXhr.abort();
        //                    }
        //                    this.Searching = true;

        //                    var vueObj = this;

        //                    this.ajaxXhr = $.ajax({
        //                        type: 'POST',
        //                        url: rootUrl + "D_pcode/Ajax/D_pcodeHandler.ashx",
        //                        cache: false,
        //                        data: {
        //                            filterOption: encodeURIComponent(JSON.stringify(this.ajaxFilter)),
        //                            StartRow: this.StartRow
        //                        },
        //                        beforeSend: function () {
        //                            LoadingHelper.showLoading();
        //                        },
        //                        success: function (result) {

        //                            vueObj.Searching = false;
        //                            var list = JSON.parse(result);

        //                            for (var i in list) {
        //                                vueObj.D_pcodeList.push(list[i]);
        //                            }
        //                            vueObj.StartRow += list.length;

        //                            if (list.length == 0) {
        //                                alert("查無資料");
        //                                vueObj.Searching = true;
        //                            }
        //                        },
        //                        error: function (jqXhr, textStatus, errorThrown) {
        //                            if (jqXhr.status == 0) {
        //                                return;
        //                            }
        //                            vueObj.Searching = false;
        //                            console.error(errorThrown);
        //                            alert("查詢失敗");
        //                        }, complete: function () {
        //                            LoadingHelper.hideLoading();

        //                        }
        //                    });



        //                }
        //            }
        //        }
        //    }
        //});



    }
    function onError(error) {
        console.error(error);
    }

    define(requiredFiles, onLoaded, onError);

})();