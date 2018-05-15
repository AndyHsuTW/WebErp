'use strict';
(function () {
    requirejs.config({
        paths: {
            "FunctionButton": isIE ? "VueComponent/FunctionButton.babel" : "VueComponent/FunctionButton",
            "uibPagination": "public/scripts/VueComponent/vuejs-uib-pagination", 
        },
        shim: {
           
        }
    });

    var requiredFiles = ["bootstrap", "FunctionButton", "uibPagination", "LoadingHelper", "UserLog"];

    function onLoaded(bootstrap, FunctionButton, uibPagination, loadingHelper, UserLog) {


        Vue.component('d_pcode_component',
            {
                template: '\
                        <div>\
                            <ul class="app-title">\<li>dsaq02101客戶訂單資料查詢v18.05.08</li></ul>\
                            <div class="app-body">\
                                <div class="common-button-div">\
                                    <function-button id="SearchBtn" hot-key="f1" v-on:click.native="OnSearch()">查詢</function-button>\
                                    <function-button hot-key="f2" v-if="typeof leavefunction == \'function\'" v-on:click.native="leavefunction()">離開</function-button>\
                                </div>\
                                    <div class="filter-div">\
                                        <table class="">\
                                            <tr>\
                                                <td>訂單日期\
                                                </td>\
                                                <td><input type="date" v-model="Filter.OrderDateStart">&nbsp訖&nbsp<input type="date" v-model="Filter.OrderDateEnd">\
                                                </td>\
                                                <td>&nbsp&nbsp&nbsp商品編號\
                                                </td>\
                                                <td><input type="text" v-model="Filter.PcodeStart">&nbsp訖&nbsp<input type="text" v-model="Filter.PcodeEnd">\
                                                </td>\
                                            </tr>\
                                            <tr>\
                                                <td>產品貨號\
                                                </td>\
                                                <td><input type="text" v-model="Filter.RelativenoStart">&nbsp訖&nbsp<input type="text" v-model="Filter.RelativenoStart">\
                                                </td>\
                                                <td>&nbsp;&nbsp;&nbsp;客戶代號\
                                                </td>\
                                                <td><input type="text" v-model="Filter.CustomerCodeStart">&nbsp訖&nbsp<input type="text" v-model="Filter.CustomerCodeEnd">\
                                                </td>\
                                            </tr>\
                                            <tr>\
                                                <td>新增日期&nbsp\
                                                </td>\
                                                <td><input type="date" v-model="Filter.AddDateStart">&nbsp訖&nbsp<input type="date" v-model="Filter.AddDateEnd">\
                                                </td>\
                                                <td>&nbsp;&nbsp;&nbsp;訂單單號&nbsp\
                                                </td>\
                                                <td>\
                                                    <input type="text" v-model="Filter.DocnoTypeStart"><input type="date" v-model="Filter.DocnoDateStart"><input type="text" v-model="Filter.DocnoOrderNoStart">&nbsp訖&nbsp\
                                                    <input type="text" v-model="Filter.DocnoTypeEnd"><input type="date" v-model="Filter.DocnoDateEnd"><input type="text" v-model="Filter.DocnoOrderNoEnd">\
                                                </td>\
                                            </tr>\
                                            <tr>\
                                                <td>公司代號&nbsp\
                                                </td>\
                                                <td><input type="text" v-model="Filter.BcodeStart">&nbsp訖&nbsp<input type="text" v-model="Filter.BcodeEnd">\
                                                </td>\
                                                <td>&nbsp;&nbsp;&nbsp;關鍵字&nbsp\
                                                </td>\
                                                <td><input type="text" v-model="Filter.Keyword">&nbsp(Like 用 * 查詢)\
                                                </td>\
                                            </tr>\
                                        </table>\
                                    </div>\
                                    <div class="result-div" >\
                                        <div class="scroll-table">\
                                            <table class="table table-bordered ">\
                                                <thead>\
                                                    <tr class="bg-primary text-light">\
                                                        <th class="" v-if="typeof callback == \'function\'"></th>\
                                                        <th class="col-xs-1">序號</th>\
                                                        <th class="col-xs-1">訂單單號</th>\
                                                        <th class="col-xs-1">訂單日期</th>\
                                                        <th class="col-xs-1">金額總計</th>\
                                                        <th class="col-xs-1">客戶編號</th>\
                                                        <th class="col-xs-1">客戶名稱</th>\
                                                        <th class="col-xs-1">聯絡人</th>\
                                                        <th class="col-xs-1">連絡電話</th>\
                                                        <th class="col-xs-1">手機</th>\
                                                        <th class="col-xs-1">備註</th>\
                                                    </tr>\
                                                </thead>\
                                                <tbody  id="table-content" v-bind:style={width:tbodywidth}>\
                                                    <tr class="rowclass" v-for="D_pcodeData in Saf21List" >\
                                                        <td class="" v-if="typeof callback == \'function\'">\
                                                        <button type="button" role="button" class="btn btn-default" @click="callback(D_pcodeData)">送出</button>\
                                                        </td>\
                                                        <td class="col-xs-1">{{D_pcodeData.saf2133_seq2}}</td>\
                                                        <td class="col-xs-1">{{D_pcodeData.saf2101_docno}}</td>\
                                                        <td class="col-xs-1">{{D_pcodeData.saf2101_docno_date}}</td>\
                                                        <td class="col-xs-1">{{D_pcodeData.saf2139_total_price}}</td>\
                                                        <td class="col-xs-1">{{D_pcodeData.saf2108_customer_code}}</td>\
                                                        <td class="col-xs-1">{{D_pcodeData.cmf0103_bname}}</td>\
                                                        <td class="col-xs-1">{{D_pcodeData.taf1002_firstname}}</td>\
                                                        <td class="col-xs-1">{{D_pcodeData.taf1019_tel1}}</td>\
                                                        <td class="col-xs-1">{{D_pcodeData.taf1031_cellphone}}</td>\
                                                        <td class="col-xs-1">{{D_pcodeData.remark}}</td>\
                                                        <td class="col-xs-1"><a href="/Program_Files/inf01/Dinq00101.aspx" target="_blank">詳細資料</a></td>\
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
                    leavefunction: null,
                },
                data: function() {

                    return {
                        Filter: {
                            OrderDateStart: null,
                            OrderDateEnd: null,
                            PcodeStart: null,
                            PcodeEnd: null,
                            RelativenoStart: null,
                            RelativenoEnd: null,
                            CustomerCodeStart: null,
                            CustomerCodeEnd: null,
                            AddDateStart: null,
                            AddDateEnd: null,
                            BcodeStart: null,
                            BcodeEnd: null,
                            DocnoTypeStart: null,
                            DocnoTypeEnd: null,
                            DocnoDateStart: null,
                            DocnoDateEnd: null,
                            DocnoOrderNoStart: null,
                            DocnoOrderNoEnd: null,
                            Keyword: null,
                        },
                        Saf21List: [],
                        StartRow: 0,
                        ajaxXhr: null,
                        Searching: false,
                        ajaxFilter: {},
                        IsEnd: false,
                        tbodywidth: 'calc(100% - 18px)',
                    }

                },
                methods: {
                    OnScroll: function() {


                        var scrollTop = $("#table-content").scrollTop();
                        var $terms = $("#table-content");

                        var scrollBottom = $terms.prop('scrollHeight') - (($terms.height() + scrollTop));
                        if (scrollBottom < 200) {
                            this.SeachAjax();
                        }

                    },
                    OnSearch: function() {


                        this.StartRow = 0;
                        this.Saf21List = [];
                        this.Searching = false;
                            //this.ajaxFilter = JSON.parse(JSON.stringify(this.Filter));
                        var filterOption = {
                            keyword: this.Filter.Keyword,
                            saf2106_order_date_start: this.Filter.OrderDateStart,
                            saf2106_order_date_end: this.Filter.OrderDateEnd,
                            saf21a02_pcode_start: this.Filter.PcodeStart,
                            saf21a02_pcode_end: this.Filter.PcodeEnd,
                            saf21a03_relative_no_start: this.Filter.RelativenoStart,
                            saf21a03_relative_no_end: this.Filter.RelativenoEnd,
                            saf2108_customer_code_start: this.Filter.CustomerCodeStart,
                            saf2108_customer_code_end: this.Filter.CustomerCodeEnd,
                            adddate_start: this.Filter.AddDateStart,
                            adddate_end: this.Filter.AddDateEnd,
                            saf2101_docno_type_start: this.Filter.DocnoTypeStart,
                            saf2101_docno_type_end: this.Filter.DocnoTypeEnd,
                            saf2101_docno_date_start: this.Filter.DocnoDateStart,
                            saf2101_docno_date_end: this.Filter.DocnoDateEnd,
                            saf2101_docno_orderno_start: this.Filter.DocnoOrderNoStart,
                            saf2101_docno_orderno_end: this.Filter.DocnoOrderNoEnd,
                            saf2101_bcode_start: (this.Filter.BcodeStart || {}).cnf0701_bcode,
                            saf2101_bcode_end: (this.Filter.BcodeEnd || {}).cnf0701_bcode,
                            Qty: this.Filter.Qty
                        };
                        this.SeachAjax(filterOption);

                    },
                    SeachAjax: function(data) {
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
                            url: rootUrl + "Dsap02101Search/Ajax/D_pcodeHandler.ashx",
                            cache: false,
                            data: {
                                filterOption: JSON.stringify(data),
                                StartRow: this.StartRow
                            },
                            beforeSend: function() {
                                LoadingHelper.showLoading();
                            },
                            success: function(result) {

                                vueObj.Searching = false;
                                var list = JSON.parse(result);

                                for (var i in list) {
                                    vueObj.Saf21List.push(list[i]);
                                }
                                vueObj.StartRow += list.length;

                                if (list.length == 0) {
                                    alert("查無資料");
                                    vueObj.Searching = true;
                                }
                                Vue.nextTick(function() {
                                    if ($("#table-content").scrollTop() == 0 &&
                                        $("#table-content").prop('scrollHeight') == 400) {
                                        vueObj.tbodywidth = "calc(100% - 18px)";
                                    } else {
                                        vueObj.tbodywidth = "100%";
                                    }
                                })


                            },
                            error: function(jqXhr, textStatus, errorThrown) {
                                if (jqXhr.status == 0) {
                                    return;
                                }
                                vueObj.Searching = false;
                                console.error(errorThrown);
                                alert("查詢失敗");
                            },
                            complete: function() {
                                LoadingHelper.hideLoading();

                            }
                        });


                    }
                }
            });

    }
    function onError(error) {
        console.error(error);
    }

    define(requiredFiles, onLoaded, onError);

})();