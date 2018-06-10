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


        Vue.component('d_empid_component',
            {
                template: '\
                        <div>\
                            <ul class="app-title">\<li>員工基本資料查詢v18.06.06</li></ul>\
                            <div class="app-body">\
                                <div class="common-button-div">\
                                    <function-button id="SearchBtn" hot-key="f1" v-on:click.native="OnSearch()">查詢</function-button>\
                                    <function-button hot-key="f2" v-if="typeof leavefunction == \'function\'" v-on:click.native="leavefunction()">離開</function-button>\
                                </div>\
                                    <br><div class="filter-div">\
                                        <table class="">\
                                            <tr>\
                                                <td>員工代號&nbsp\
                                                </td>\
                                                <td><input type="text" v-model="Filter.EmpId">&nbsp(Like 用 * 查詢)\
                                                </td>\
                                                <td>&nbsp;&nbsp;&nbsp;中文名稱&nbsp\
                                                </td>\
                                                <td><input type="text" v-model="Filter.EmpCnName">&nbsp(Like 用 * 查詢)\
                                                </td>\
                                            </tr>\
                                            <tr>\
                                                <td>First Name&nbsp\
                                                </td>\
                                                <td><input type="text" v-model="Filter.FirstName">&nbsp(Like 用 * 查詢)\
                                                </td>\
                                                <td>&nbsp;&nbsp;&nbsp;Last Name&nbsp\
                                                </td>\
                                                <td><input type="text" v-model="Filter.LastName">&nbsp(Like 用 * 查詢)\
                                                </td>\
                                            </tr>\
                                            <tr>\
                                                <td>公司代號&nbsp\
                                                </td>\
                                                <td><input type="text" v-model="Filter.BCode">&nbsp\
                                                </td>\
                                                <td>&nbsp;&nbsp;&nbsp;關鍵字&nbsp\
                                                </td>\
                                                <td><input type="text" v-model="Filter.Keyword">&nbsp;&nbsp;<span style="font-weight:bold">筆數 : {{D_EmpIdList.length}}</span>\
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
                                                        <th class="col-xs-1">公司代號</th>\
                                                        <th class="col-xs-1">員工代號</th>\
                                                        <th class="col-xs-1">員工姓名</th>\
                                                        <th class="col-xs-1">行動電話</th>\
                                                        <th class="col-xs-1">電話</th>\
                                                        <th class="col-xs-1">郵遞區號</th>\
                                                        <th class="col-xs-1">通訊地址</th>\
                                                        <th class="col-xs-1">Email</th>\
                                                        <th class="col-xs-1">到職日期</th>\
                                                        <th class="col-xs-1">部門</th>\
                                                        <th class="col-xs-1">職稱</th>\
                                                        <th class="col-xs-1">照片</th>\
                                                        <th class="col-xs-1">詳細資料</th>\
                                                    </tr>\
                                                </thead>\
                                                <tbody  id="table-content" v-bind:style={width:tbodywidth}>\
                                                    <tr class="rowclass" v-for="D_EmpIdData in D_EmpIdList" >\
                                                        <td class="" v-if="typeof callback == \'function\'">\
                                                        <button type="button" role="button" class="btn btn-default" @click="callback(D_EmpIdData)">送出</button>\
                                                        </td>\
                                                        <td class="col-xs-1">{{D_EmpIdData.BCode}}</td>\
                                                        <td class="col-xs-1">{{D_EmpIdData.EmpId}}</td>\
                                                        <td class="col-xs-1">{{D_EmpIdData.EmpCnName}}</td>\
                                                        <td class="col-xs-1">{{D_EmpIdData.Mobile}}</td>\
                                                        <td class="col-xs-1">{{D_EmpIdData.Phone}}</td>\
                                                        <td class="col-xs-1">{{D_EmpIdData.ZipCode}}</td>\
                                                        <td class="col-xs-1">{{D_EmpIdData.CAddress}}</td>\
                                                        <td class="col-xs-1">{{D_EmpIdData.Email}}</td>\
                                                        <td class="col-xs-1">{{D_EmpIdData.OnBoardDate}}</td>\
                                                        <td class="col-xs-1">{{D_EmpIdData.Dept}}</td>\
                                                        <td class="col-xs-1">{{D_EmpIdData.Title}}</td>\
                                                        <td class="col-xs-1"><img v-bind:src="D_EmpIdData.Photo" v-if="D_EmpIdData.Photo!=\'\'"></td>\
                                                        <td class="col-xs-1"><a href="/Program_Files/inf01/Dtap01001.aspx" target="_blank">詳細資料</a></td>\
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
                data: function () {

                    return {
                        Filter: {
                            BCode: "",
                            EmpId:"",
                            EmpCnName: "",
                            FirstName: "",
                            LastName: "",                            
                            Keyword: ""
                        },
                        D_EmpIdList: [],
                        StartRow: 0,
                        ajaxXhr: null,
                        Searching: false,
                        ajaxFilter: {},
                        IsEnd: false,
                        tbodywidth: 'calc(100% - 18px)',
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
                        this.D_EmpIdList = [];
                        this.Searching = false,
                            this.ajaxFilter = JSON.parse(JSON.stringify(this.Filter));
                        this.SeachAjax();

                    },
                    SeachAjax: function () {
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
                            url: rootUrl + "CommonObjFunc/D_EmpId/Ajax/D_EmpIdHandler.ashx",
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
                                    vueObj.D_EmpIdList.push(list[i]);
                                }
                                vueObj.StartRow += list.length;

                                if (list.length == 0) {
                                    alert("查無資料");
                                    vueObj.Searching = true;
                                }
                                Vue.nextTick(function () {
                                    if ($("#table-content").scrollTop() == 0 &&
                                        $("#table-content").prop('scrollHeight') == 400) {
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
                            },
                            complete: function () {
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