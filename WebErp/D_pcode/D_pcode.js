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

    var requiredFiles = ["bootstrap", "functionButton", "uibPagination", "vueDatetimepicker", "LoadingHelper"];
  
    function onLoaded(bootstrap, functionButton, uibPagination, vueDatetimepicker, loadingHelper) {

        var HTML='<div>'

        HTML += '<ul class="app-title">\<li>商品資料查詢</li></ul>';
        HTML += '<div class="app-body">';
        HTML += "ABC";
        HTML += '</div>'
        HTML += '</div>'
        window.d_pcode = new Vue({
            el: '#example',
            components: {
                'd_pcode_component': {
                    template:
'\
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
                        <td><input type="text" v-model="Filter.Mcode">\
                        </td>\
                        <td>&nbsp廠商貨號&nbsp起&nbsp\
                        </td>\
                        <td><input type="text" v-model="Filter.RelativeNo_start">&nbsp訖&nbsp<input type="text" v-model="Filter.RelativeNo_end">\
                        </td>\
                    </tr>\
                    <tr>\
                        <td>商品條碼&nbsp\
                        </td>\
                        <td><input type="text" v-model="Filter.Pcode">\
                        </td>\
                        <td>&nbsp中文名稱&nbsp\
                        </td>\
                        <td><input type="text" v-model="Filter.Psname">\
                        </td>\
                    </tr>\
                    <tr>\
                        <td>關鍵字&nbsp\
                        </td>\
                        <td><input type="text" v-model="Filter.Keyword">\
                        </td>\
                        <td>&nbsp售價&nbsp起&nbsp\
                        </td>\
                        <td><input type="text" v-model="Filter.Retail_start">&nbsp訖&nbsp<input type="text" v-model="Filter.Retail_end">\
                        </td>\
                    </tr>\
                </table>\
            </div>\
    </div>\
</div>\
'

                    , data:function() {
                        return{
                            Filter: {
                                Mcode: "",
                                RelativeNo_start: "",
                                RelativeNo_end: "",
                                Pcode:"",
                                Psname: "",
                                Keyword: "",
                                Retail_start: "",
                                Retail_end:""

                            }
                        }
                       
                    },
                    methods: {
                        OnSearch: function () {
                            alert("ABC")

                        }
                    }
                }
            }
        })


    }
    function onError(error) {
        console.error(error);
    }

    define(requiredFiles, onLoaded, onError);

})();