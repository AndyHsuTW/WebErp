<%@ Page Language="C#" MasterPageFile="~/master/BaseMasterPage.master" AutoEventWireup="true" CodeFile="Dsap02101.aspx.cs" Inherits="Dsap02101_Dsap02101" %>

<%@ Import Namespace="System.Web.Hosting" %>
<%@ Import Namespace="Newtonsoft.Json" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <style>
        /* override multiselect default*/
        .app-body .multiselect__option--highlight
        {
            background: #3097D1;
            outline: none;
            color: white;
        }
        .app-body .multiselect__tags
        {
            border-color: #A8A8A8;
            border-radius: 0;
        }
        .app-body .multiselect
        {
            display: inline-block;
        }
        
        /* multiselect default end */

        .app-title
        {
            background-color: #3097D1;
            color: #FFF;
        }

        .app-body
        {
            padding-left: 5px;
            min-width: 1080px;
        }

        .filter-div,
        .editParam-div
        {
            margin-top: 5px;
        }
        .filter-div .medium-field,
        .editParam-div .medium-field
        {
            width: 175px;
        }
        .filter-div .small-field,
        .editParam-div .small-field
        {
            width: 100px;
        }
        .filter-div .x-small-field,
        .editParam-div .x-small-field
        {
            width: 50px;
        }
            .filter-div td> *,
            .editParam-div td> *
            {
                margin-bottom: 2px;
                margin-left: 3px;
            }
            .filter-div > table td, 
            .editParam-div > table td
            {
                white-space: nowrap;
            }
            .filter-div > table td:nth-child(even), 
            .editParam-div > table td:nth-child(even)
            {
                padding-right: 7px;
            }
            .filter-div > table .ref-inputs > input:nth-child(odd), 
            .editParam-div > table .ref-inputs > input:nth-child(odd)
            {
                width: 50px;
            }

            .filter-div > table .ref-inputs > input:nth-child(even), 
            .editParam-div> table .ref-inputs > input:nth-child(even)
            {
                width: 70px;
            }

            .filter-div > table .key-value-inputs > input:nth-child(1), 
            .editParam-div> table .key-value-inputs > input:nth-child(1)
            {
                width: 100px;
            }

            .filter-div > table .key-value-inputs > input:nth-child(2), 
            .editParam-div> table .key-value-inputs > input:nth-child(2)
            {
                width: 200px;
            }
        .no-margin
        {
            margin: 0 !important;
        }

        .no-padding
        {
            padding: 0 !important;
        }

        .scroll-table
        {
            height: 450px;
            overflow-y: auto;
            overflow-y: overlay;
            border: solid 1px #CCC;
        }
        .scroll-div
        {
            overflow-y: auto;
            overflow-y: overlay;
        }
        #ExportDialog .scroll-div
        {
            height: 300px;
        }

        .main-result-div .scroll-table,
        .sub-result-div .scroll-table
        {
            height: 200px;
        }

        .vuetable > thead > tr > th,
        .table-borderless > tbody > tr > td,
        .table-borderless > tbody > tr > th,
        .table-borderless > tfoot > tr > td,
        .table-borderless > tfoot > tr > th,
        .table-borderless > thead > tr > td,
        .table-borderless > thead > tr > th
        {
            border: none;
        }

        .table.sortable > thead > tr > th
        {
            cursor: pointer;
            white-space: nowrap;
            position: relative;
            padding-right: 16px;
        }

        .table.sortable .no-sortable
        {
            cursor: default;
        }

        .table.sortable .sort-item
        {
            position: absolute;
            right: 2px;
            top: 35%;
        }
        tr.selected-row{
            background:#AAE;
        }
        #dpCodeWindow
        {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background: #fff;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <% string rootUrl = HostingEnvironment.ApplicationVirtualPath.Length > 1 ? HostingEnvironment.ApplicationVirtualPath + "/" : HostingEnvironment.ApplicationVirtualPath; %>

    <div id="Dsap02101Search" v-if="Display" v-cloak>
        <ul class="app-title">
            <li>{{"Dsap02101 庫存異動資料查詢 <%=this.AppVersion %>"}}
            </li>
        </ul>
        <div class="app-body">
            <div class="common-button-div">
                <function-button id="SearchBtn"
                    hot-key="f1"
                    v-on:click.native="OnSearch()">
                            查詢
                        </function-button>
                <function-button id="AddBtn" 
                    hot-key="f2"
                    v-on:click.native="OnAdd()">
                            新增
                        </function-button>
                <function-button id="DeleteBtn"
                    hot-key="f3"
                    v-on:click.native="OnDelete()">
                            刪除
                        </function-button>
                <function-button id="CopyBtn"
                    hot-key="f4"
                    v-on:click.native="OnCopy()">
                            複製
                        </function-button>
                <function-button id="PrintBtn" 
                    hot-key="f6"
                    v-on:click.native="OnPrint()">
                            印表
                        </function-button>
                <function-button id="ExportBtn" data-toggle="modal" href='#ExportDialog'
                    hot-key="f7"
                    v-on:click.native="OnExport()">
                            匯出
                        </function-button>
                <function-button id="ImportBtn" data-toggle="modal" href='#ImportExcelDialog'
                    hot-key="f8"
                    v-on:click.native="OnImport()">
                            匯入Excel
                </function-button>
                <function-button id="HelpBtn" data-toggle="modal" href='#HelpDialog'
                    hot-key="f11">
                            求助
                </function-button>
                <function-button id="HelpBtn"
                    hot-key="f12"
                    v-on:click.native="OnExit()">
                            離開
                </function-button>
            </div>
            <div class="filter-div">
                <table class="">
                    <tbody>
                        <tr>
                            <td>訂單日期
                                <span>起~</span>
                            </td>
                            <td>
                                <vue-datetimepicker placeholder="" class="medium-field"
                                    v-model="Filter.OrderDateStart"
                                    v-on:change="AutoFillFilter('ProDateEnd',Filter.OrderDateStart,'datetime')"></vue-datetimepicker>
                                迄~
                                <vue-datetimepicker id="FilterOrderDateEnd" class="medium-field" ref="FilterProDateEnd" placeholder=""
                                    v-model="Filter.OrderDateEnd"></vue-datetimepicker>
                            </td>
                            <td>商品編號
                                <span>起~</span>
                            </td>
                            <td>
                                <input type="text" class="medium-field" v-model="Filter.PcodeStart"
                                    v-on:change="AutoFillFilter('PcodeEnd',Filter.PcodeStart)" />
                                迄~
                                <input type="text" class="medium-field" v-model="Filter.PcodeEnd" />
                            </td>
                        </tr>
                        <tr>
                            <td>產品貨號
                                <span>起~</span>
                            </td>
                            <td>
                                <input type="text" class="medium-field" v-model="Filter.RelativenoStart"
                                    v-on:change="AutoFillFilter('RelativenoEnd',Filter.RelativenoStart)" />
                                迄~
                                <input type="text" class="medium-field" v-model="Filter.RelativenoEnd" />
                            </td>
                            <td>客戶代號
                                <span>起~</span>
                            </td>
                            <td>
                                <input type="text" class="medium-field" v-model="Filter.CustomerCodeStart"
                                    v-on:change="AutoFillFilter('CustomerCodeEnd',Filter.CustomerCodeStart)" />
                                迄~
                                <input type="text" class="medium-field" v-model="Filter.CustomerCodeEnd" />
                            </td>
                        </tr>
                        <tr>
                            <td>新增日期
                                <span>起~</span>
                            </td>
                            <td>
                                <vue-datetimepicker class="medium-field" placeholder=""
                                    v-model="Filter.AddDateStart"
                                    v-on:change="AutoFillFilter('AddDateEnd',Filter.AddDateStart,'datetime')"></vue-datetimepicker>
                                迄~
                                <vue-datetimepicker id="FilterAddDateEnd" class="medium-field" ref="FilterAddDateEnd" placeholder=""
                                    v-model="Filter.AddDateEnd"></vue-datetimepicker>
                            </td>
                            <td>訂單單號
                                <span>起~</span>
                            </td>
                            <td>
                                <span class="ref-inputs">
                                    <input type="text" v-model="Filter.DocnoTypeStart"
                                        v-on:change="AutoFillFilter('DocnoTypeEnd',Filter.DocnoTypeStart)" />
                                    <input type="text" v-model="Filter.DocnoDateStart"
                                        v-on:change="AutoFillFilter('RefNoDateEnd',Filter.DocnoDateStart)" />
                                    <input type="text" v-model="Filter.DocnoOrderNoStart"
                                        v-on:change="AutoFillFilter('DocnoOrderNoEnd',Filter.DocnoOrderNoStart)" />
                                </span>

                                迄~
                                <span class="ref-inputs">
                                    <input type="text" v-model="Filter.DocnoTypeEnd" />
                                    <input type="text" v-model="Filter.RefNoDateEnd" />
                                    <input type="text" v-model="Filter.DocnoOrderNoEnd" />
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <td>公司代號
                                <span>起~</span>
                            </td>
                            <td>
                                <multiselect class="medium-field"
                                    v-model="Filter.BcodeStart"
                                    v-bind:options="BcodeList"
                                    v-bind:close-on-select="true"
                                    v-bind:placeholder="''"
                                    v-bind:show-labels="false" 
                                    v-bind:custom-label="BcodeSelectLabel"
                                    v-on:input="AutoFillFilter('BcodeEnd',Filter.BcodeStart)"
                                    track-by="cnf0701_bcode"
                                    label="cnf0703_bfname">
                                </multiselect>
                                迄~
                                <multiselect class="medium-field"
                                    v-model="Filter.BcodeEnd"
                                    v-bind:options="BcodeList"
                                    v-bind:close-on-select="true"
                                    v-bind:placeholder="''"
                                    v-bind:show-labels="false" 
                                    v-bind:custom-label="BcodeSelectLabel"
                                    track-by="cnf0701_bcode"
                                    label="cnf0703_bfname">
                                </multiselect>
                            </td>
                            <td>關鍵字
                            </td>
                            <td>
                                <input type="text" class="medium-field" v-model="Filter.Keyword">
                            </td>
                        </tr>
                        <tr>
                                                        <td>
                                <span>數量大(等)於</span>
                            </td>
                            <td>
                                <input type="text" class="medium-field" v-model="Filter.GreaterOrEqual">
                            </td>
                            </td>
                        </tr>

                    </tbody>
                </table>
            </div>
            <div class="main-result-div">
                <div class="scroll-table">
                    <table class="table table-bordered sortable">
                        <thead>
                            <tr class="bg-primary text-light">
                                <th v-on:click="OnInf29TableSorting('Saf21DocNoShort')">
                                    異動單號
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Inf29SortColumn!='Saf21DocNoShort', 
                                        'glyphicon-chevron-up': Inf29SortColumn=='Inf2902DocNoShort' && Inf29SortOrder=='asc',
                                        'glyphicon-chevron-down': Inf29SortColumn=='Inf2902DocNoShort' && Inf29SortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnInf29TableSorting('inf2904_pro_date')">
                                    異動日期
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Inf29SortColumn!='inf2904_pro_date', 
                                        'glyphicon-chevron-up': Inf29SortColumn=='inf2904_pro_date' && Inf29SortOrder=='asc',
                                        'glyphicon-chevron-down': Inf29SortColumn=='inf2904_pro_date' && Inf29SortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnInf29TableSorting('inf2906_wherehouse')">
                                    倉庫
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Inf29SortColumn!='inf2906_wherehouse', 
                                        'glyphicon-chevron-up': Inf29SortColumn=='inf2906_wherehouse' && Inf29SortOrder=='asc',
                                        'glyphicon-chevron-down': Inf29SortColumn=='inf2906_wherehouse' && Inf29SortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnInf29TableSorting('Qty')">
                                    數量
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Inf29SortColumn!='Qty', 
                                        'glyphicon-chevron-up': Inf29SortColumn=='Qty' && Inf29SortOrder=='asc',
                                        'glyphicon-chevron-down': Inf29SortColumn=='Qty' && Inf29SortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnInf29TableSorting('inf2952_project_no')">
                                    專案代號
                                    <span class="sort-item glyphicon" 
                                    v-bind:class="{'glyphicon-sort':Inf29SortColumn!='inf2952_project_no', 
                                    'glyphicon-chevron-up': Inf29SortColumn=='inf2952_project_no' && Inf29SortOrder=='asc',
                                    'glyphicon-chevron-down': Inf29SortColumn=='inf2952_project_no' && Inf29SortOrder=='desc'}">
                                </span>
                                </th>
                                <th v-on:click="OnInf29TableSorting('inf2910_in_reason')">
                                    異動代號及中文
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Inf29SortColumn!='inf2910_in_reason', 
                                        'glyphicon-chevron-up': Inf29SortColumn=='inf2910_in_reason' && Inf29SortOrder=='asc',
                                        'glyphicon-chevron-down': Inf29SortColumn=='inf2910_in_reason' && Inf29SortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnInf29TableSorting('Inf2906RefNo')">
                                    來源單號
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Inf29SortColumn!='Inf2906RefNo', 
                                        'glyphicon-chevron-up': Inf29SortColumn=='Inf2906RefNo' && Inf29SortOrder=='asc',
                                        'glyphicon-chevron-down': Inf29SortColumn=='Inf2906RefNo' && Inf29SortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnInf29TableSorting('inf2903_customer_code')">
                                    客戶代號/名稱
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Inf29SortColumn!='inf2903_customer_code', 
                                        'glyphicon-chevron-up': Inf29SortColumn=='inf2903_customer_code' && Inf29SortOrder=='asc',
                                        'glyphicon-chevron-down': Inf29SortColumn=='inf2903_customer_code' && Inf29SortOrder=='desc'}">
                                    </span>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="inf29Item in Inf29List" 
                                v-on:click="OnMainRowClick(inf29Item)"
                                v-bind:class="{'selected-row':inf29Item==SelectedInf29Item}">
                                <td>{{inf29Item.Inf2902DocNoShort }}</td>
                                <td>{{inf29Item.inf2904_pro_date}}</td>
                                <td>{{ GetWherehouseName(inf29Item.inf2906_wherehouse)}}</td>
                                <td>{{inf29Item.Qty}}</td>
                                <td>{{inf29Item.inf2952_project_no}}</td>
                                <td>{{inf29Item.inf2910_in_reason }}/{{inf29Item.Inf2910InReasonName}}</td>
                                <td>{{inf29Item.Inf2906RefNo}}
                                </td>
                                <td>{{inf29Item.inf2903_customer_code}}/{{inf29Item.Inf2903CustomerCodeName}}</td>

                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="sub-result-div">
                <div class="scroll-table">
                    <table class="table table-bordered sortable">
                        <thead>
                            <tr class="bg-primary text-light">
                                <th v-on:click="OnInf29aTableSorting('inf29a02_seq')">
                                    序號
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Inf29aSortColumn!='inf29a02_seq', 
                                        'glyphicon-chevron-up': Inf29aSortColumn=='inf29a02_seq' && Inf29aSortOrder=='asc',
                                        'glyphicon-chevron-down': Inf29aSortColumn=='inf29a02_seq' && Inf29aSortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnInf29aTableSorting('inf29a05_pcode')">
                                    產品編號
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Inf29aSortColumn!='inf29a05_pcode', 
                                        'glyphicon-chevron-up': Inf29aSortColumn=='inf29a05_pcode' && Inf29aSortOrder=='asc',
                                        'glyphicon-chevron-down': Inf29aSortColumn=='inf29a05_pcode' && Inf29aSortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnInf29aTableSorting('inf29a05_shoes_code')">
                                    貨號
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Inf29aSortColumn!='inf29a05_shoes_code', 
                                        'glyphicon-chevron-up': Inf29aSortColumn=='inf29a05_shoes_code' && Inf29aSortOrder=='asc',
                                        'glyphicon-chevron-down': Inf29aSortColumn=='inf29a05_shoes_code' && Inf29aSortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnInf29aTableSorting('inf29a33_product_name')">
                                    產品簡稱
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Inf29aSortColumn!='inf29a33_product_name', 
                                        'glyphicon-chevron-up': Inf29aSortColumn=='inf29a33_product_name' && Inf29aSortOrder=='asc',
                                        'glyphicon-chevron-down': Inf29aSortColumn=='inf29a33_product_name' && Inf29aSortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnInf29aTableSorting('inf29a17_runit')">
                                    單位
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Inf29aSortColumn!='inf29a17_runit', 
                                        'glyphicon-chevron-up': Inf29aSortColumn=='inf29a17_runit' && Inf29aSortOrder=='asc',
                                        'glyphicon-chevron-down': Inf29aSortColumn=='inf29a17_runit' && Inf29aSortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnInf29aTableSorting('inf29a13_sold_qty')">
                                    數量
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Inf29aSortColumn!='inf29a13_sold_qty', 
                                        'glyphicon-chevron-up': Inf29aSortColumn=='inf29a13_sold_qty' && Inf29aSortOrder=='asc',
                                        'glyphicon-chevron-down': Inf29aSortColumn=='inf29a13_sold_qty' && Inf29aSortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnInf29aTableSorting('inf29a11_dis_rate')">
                                    折扣
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Inf29aSortColumn!='inf29a11_dis_rate', 
                                        'glyphicon-chevron-up': Inf29aSortColumn=='inf29a11_dis_rate' && Inf29aSortOrder=='asc',
                                        'glyphicon-chevron-down': Inf29aSortColumn=='inf29a11_dis_rate' && Inf29aSortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnInf29aTableSorting('inf29a10_ocost_one')">
                                    原價
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Inf29aSortColumn!='inf29a10_ocost_one', 
                                        'glyphicon-chevron-up': Inf29aSortColumn=='inf29a10_ocost_one' && Inf29aSortOrder=='asc',
                                        'glyphicon-chevron-down': Inf29aSortColumn=='inf29a10_ocost_one' && Inf29aSortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnInf29aTableSorting('inf29a10_cost_one')">
                                    進價
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Inf29aSortColumn!='inf29a10_cost_one', 
                                        'glyphicon-chevron-up': Inf29aSortColumn=='inf29a10_cost_one' && Inf29aSortOrder=='asc',
                                        'glyphicon-chevron-down': Inf29aSortColumn=='inf29a10_cost_one' && Inf29aSortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnInf29aTableSorting('inf29a38_one_amt')">
                                    金額小計
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Inf29aSortColumn!='inf29a38_one_amt', 
                                        'glyphicon-chevron-up': Inf29aSortColumn=='inf29a38_one_amt' && Inf29aSortOrder=='asc',
                                        'glyphicon-chevron-down': Inf29aSortColumn=='inf29a38_one_amt' && Inf29aSortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnInf29aTableSorting('remark')">
                                    備註
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Inf29aSortColumn!='remark', 
                                        'glyphicon-chevron-up': Inf29aSortColumn=='remark' && Inf29aSortOrder=='asc',
                                        'glyphicon-chevron-down': Inf29aSortColumn=='remark' && Inf29aSortOrder=='desc'}">
                                    </span>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="inf29aItem in Inf29aList" 
                                v-on:click="OnSubRowClick(inf29aItem)"
                                v-bind:class="{'selected-row':inf29aItem==SelectedInf29aItem}"
                                >
                                <!-- 項次 -->
                                <td>{{inf29aItem.inf29a02_seq}}</td>
                                <!-- 產品編號 -->
                                <td>{{inf29aItem.inf29a05_pcode}}</td>
                                <!-- 貨號 -->
                                <td>{{inf29aItem.inf29a05_shoes_code}}</td>
                                <!-- 產品簡稱 -->
                                <td>{{inf29aItem.inf29a33_product_name }}</td>
                                <!-- 單位 -->
                                <td>{{inf29aItem.inf29a17_runit }}</td>
                                <!-- 數量 -->
                                <td>{{inf29aItem.inf29a13_sold_qty }}</td>
                                <!-- 折扣 -->
                                <td>{{inf29aItem.inf29a11_dis_rate }}%</td>
                                <!-- 原價 -->
                                <td>{{inf29aItem.inf29a10_ocost_one }}</td>
                                <!-- 進價 -->
                                <td>{{inf29aItem.inf29a10_cost_one }}</td>
                                <!-- 金額小計 -->
                                <td>{{inf29aItem.inf29a38_one_amt }}</td>
                                <!-- 備註 -->
                                <td>{{inf29aItem.remark }}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="modal fade" id="ExportDialog" ref="ExportDialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title">選擇匯出欄位</h4>
                        </div>
                        <div class="modal-body">
                            <div class="row scroll-div">
                                <div class="col-xs-6">
                                    <h4>Inf29</h4>
                                    <button type="button" class="btn btn-default" v-on:click="OnExportAllFieldClick(true)">
                                        全選
                                    </button>
                                    <button type="button" class="btn btn-default" v-on:click="OnExportAllFieldClick(false)">
                                        全不選
                                    </button>
                                    <div class="checkbox" v-for="inf29Field in Export.Inf29List">
                                        <label>
                                            <input type="checkbox" v-bind:value="inf29Field.cnf0502_field" v-model="Export.SelectedInf29List">
                                            {{inf29Field.cnf0503_fieldname_tw}}
                                        </label>
                                    </div>
                                </div>
                                <div class="col-xs-6">
                                    <h4>Inf29a</h4>
                                    <button type="button" class="btn btn-default" v-on:click="OnExportAllFieldClick(null,true)">
                                        全選
                                    </button>
                                    <button type="button" class="btn btn-default" v-on:click="OnExportAllFieldClick(null,false)">
                                        全不選
                                    </button>
                                    <div class="checkbox" v-for="inf29aField in Export.Inf29aList">
                                        <label>
                                            <input type="checkbox" v-bind:value="inf29aField.cnf0502_field" v-model="Export.SelectedInf29aList">
                                            {{inf29aField.cnf0503_fieldname_tw}}
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <function-button data-dismiss="modal"
                                hot-key="f12">
                                離開
                            </function-button>
                            <button type="button" class="btn btn-primary"
                                v-on:click="OnExportSubmit()">
                                開始匯出</button>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="modal fade" id="ImportExcelDialog" ref="ImportExcelDialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title"></h4>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="ImportExcelInput">匯入Excel</label>
                                <input type="file" id="ImportExcelInput" ref="ImportExcelInput" accept=".xls,.xlsx">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <function-button data-dismiss="modal"
                                hot-key="f12">
                        離開
                    </function-button>
                            <button type="button" class="btn btn-primary"
                                v-on:click="OnImportSubmit()">
                                開始匯入</button>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="modal fade" id="HelpDialog" ref="HelpDialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title">求助</h4>
                        </div>
                        <div class="modal-body">
                            <div style="padding: 100px;">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <function-button data-dismiss="modal"
                                hot-key="f12">
                        離開
                    </function-button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="Dinp02301Edit" v-if="Display" v-cloak>
        <ul class="app-title">
            <li>{{"Dinp02301 庫存異動資料維護 <%=this.AppVersion %>"}}
            </li>
        </ul>
        <div class="app-body" v-show="IsAppBodyDisplay">
            <div class="common-button-div">
                <function-button id="Function-button3"
                    hot-key="f1"
                    v-on:click.native="OnExit()">
                    查詢
                </function-button>
                <function-button id="Function-button4" 
                    hot-key="f2"
                    v-on:click.native="OnAdd()">
                    新增
                </function-button>
                <function-button id="DeleteBtn"
                    hot-key="f3"
                    v-on:click.native="OnDelete()">
                    刪除
                </function-button>
                <function-button id="SaveBtn"
                    hot-key="f5"
                    v-on:click.native="OnSave()">
                    存檔
                </function-button>
                <function-button id="PrintBtn" 
                    hot-key="f6"
                    v-on:click.native="OnPrint()">
                    印表
                </function-button>
                <function-button id="HelpBtn" data-toggle="modal" href='#HelpDialog'
                    hot-key="f11">
                    求助
                </function-button>
                <function-button id="ExitBtn" 
                    hot-key="f12"
                    v-on:click.native="OnExit()">
                    離開
                </function-button>
            </div>
            <div class="editParam-div">
                <table class="">
                    <tbody>
                        <tr>
                            <td>公司代號
                            </td>
                            <td>
                                <multiselect
                                    v-model="Inf29Item.BCodeInfo"
                                    v-bind:options="BcodeList"
                                    v-bind:close-on-select="true"
                                    v-bind:placeholder="''"
                                    v-bind:show-labels="false" 
                                    v-bind:custom-label="BcodeSelectLabel"
                                    track-by="cnf0701_bcode"
                                    label="cnf0703_bfname">
                                </multiselect>
                            </td>
                            <td>異動單號
                            </td>
                            <td>
                                <input type="text" v-model="Inf29Item_Inf2902DocNo" disabled="disabled"/>
                            </td>
                            <td>異動日期
                            </td>
                            <td>
                                <vue-datetimepicker placeholder="" ref="ProDate"
                                    v-model="Inf29Item.inf2904_pro_date"></vue-datetimepicker>
                                <span>
                                    單據來源
                                </span>
                                <span class="ref-inputs">
                                    <input type="text" v-model="Inf29Item.inf2906_ref_no_type" />
                                    <input type="text" v-model="Inf29Item.inf2906_ref_no_date" />
                                    <input type="text" v-model="Inf29Item.inf2906_ref_no_seq" />
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                倉庫代號
                            </td>
                            <td>
                                <multiselect
                                    v-model="Inf29Item.SelectedWherehouse"
                                    v-bind:options="WherehouseList"
                                    v-bind:close-on-select="true"
                                    v-bind:placeholder="''"
                                    v-bind:show-labels="false" 
                                    v-bind:custom-label="WherehouseSelectLabel"
                                    track-by="cnf1002_fileorder"
                                    label="cnf1003_char01">
                                </multiselect>
                            </td>
                            <td>
                                異動代號
                            </td>
                            <td>
                                <multiselect
                                    v-model="Inf29Item.SelectedInReason"
                                    v-bind:options="InReasonList"
                                    v-bind:close-on-select="true"
                                    v-bind:placeholder="''"
                                    v-bind:show-labels="false" 
                                    v-bind:custom-label="InReasonSelectLabel"
                                    track-by="cnf1002_fileorder"
                                    label="cnf1003_char01">
                                </multiselect>
                            </td>
                            <td>
                                專案代號
                            </td>
                            <td colspan="3">
                                <span class="key-value-inputs">
                                    <input type="text" v-model="Inf29Item.inf2952_project_no" 
                                        v-on:change="GetProjectFullname(Inf29Item.inf2952_project_no, Inf29Item.BCodeInfo)"/>
                                    <input type="text" v-model="Inf29Item.ProjectFullname" disabled="disabled"/>
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                備註
                            </td>
                            <td colspan="3">
                                <input type="text" style="width:99%;" v-model="Inf29Item.remark"/>
                            </td>
                            <td>
                                員工
                            </td>
                            <td colspan="3">
                                <span class="key-value-inputs">
                                    <input type="text" v-model="Inf29Item.inf2916_apr_empid" 
                                        v-on:change="GetEmpCname(Inf29Item.inf2916_apr_empid)"/>
                                    <input type="text" v-model="Inf29Item.EmpCname" disabled="disabled"/>
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                新增者
                            </td>
                            <td colspan="3">
                                <span>
                                    <input type="text" class="small-field" v-model="Inf29Item.adduser" disabled="disabled"/>
                                </span>
                                新增日期
                                <span>
                                    <input type="text" class="small-field" v-model="Inf29Item.adddate" disabled="disabled"/>
                                </span>
                                修改者
                                <span>
                                    <input type="text" class="small-field" v-model="Inf29Item.moduser" disabled="disabled"/>
                                </span>
                                修改日期
                                <span>
                                    <input type="text" class="small-field" v-model="Inf29Item.moddate" disabled="disabled"/>
                                </span>
                            </td>
                            
                            <td>
                                異動單位
                            </td>
                            <td>
                                <span class="key-value-inputs">
                                    <input type="text" v-model="Inf29Item.inf2903_customer_code" v-on:change="OnCustomCodeChange"/>
                                    <input type="text" v-model="Inf29Item.Inf2903CustomerCodeName" disabled="disabled"/>
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                幣值別
                            </td>
                            <td>
                                <multiselect class="small-field"
                                    v-model="Inf29Item.SelectedCurrencyInfo"
                                    v-bind:options="CurrencyList"
                                    v-bind:close-on-select="true"
                                    v-bind:placeholder="''"
                                    v-bind:show-labels="false" 
                                    v-on:select="GetExchangeInfo"
                                    track-by="cnf1003_char01"
                                    label="cnf1003_char01">
                                </multiselect>
                                匯率
                                <input type="text" class="small-field" v-model="Inf29Item.inf2929_exchange_rate" disabled="disabled"/>
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <table>
                    <tbody>
                        
                    </tbody>
                </table>
                <hr/>
                <table>
                    <tbody>
                        <tr>
                            <td>
                                產品編號
                            </td>
                            <td colspan="5">
                                <span class="key-value-inputs">
                                    <input type="text" v-model="Inf29aItem.inf29a05_pcode" v-on:change="OnPcodeChange(Inf29aItem.inf29a05_pcode)"/>
                                    <input type="text" v-model="Inf29aItem.inf29a33_product_name" disabled="disabled"/>
                                    <button type="button" class="btn btn-default btn-xs" v-on:click="ShowDpCodeWindow">
                                        <i class="fa fa-search"></i>
                                    </button>
                                </span>
                                <span>
                                    貨號
                                </span>
                                <span>
                                    <input type="text" class="small-field" v-model="Inf29aItem.inf29a05_shoes_code" disabled="disabled"/>
                                </span>
                            </td>
                            <td>
                                單位
                            </td>
                            <td>
                                <input type="text" class="x-small-field" v-model="Inf29aItem.inf29a17_runit" disabled="disabled"/>
                            </td>

                            <td>
                                原進價
                            </td>
                            <td>
                                <input type="text" class="small-field" v-model="Inf29aItem.inf29a10_ocost_one" disabled="disabled"/>
                            </td>
                            <td>
                                售價
                            </td>
                            <td>
                                <input type="text" class="small-field" v-model="Inf29aItem.inf29a09_retail_one" disabled="disabled"/>
                            </td>
                            <td>
                                尾差
                            </td>
                            <td>
                                <input type="text" class="small-field" v-model="Inf29aItem.inf29a36_odds_amt" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                進價
                            </td>
                            <td>
                                <input type="text" class="small-field" v-model="Inf29aItem.inf29a10_cost_one" disabled="disabled"/>
                            </td>
                            <td>
                                數量
                            </td>
                            <td>
                                <input type="text" class="small-field" v-model="Inf29aItem.inf29a13_sold_qty" />
                            </td>
                            <td>
                                金額
                            </td>
                            <td>
                                <input type="text" class="small-field" v-bind:value="Inf29aItem_Inf29a38OneAmt" disabled="disabled"/>
                            </td>
                            <td>
                                確認
                            </td>
                            <td>
                                <multiselect class="small-field"
                                    v-model="Inf29aItem.Confirmed"
                                    v-bind:options="ConfirmList"
                                    v-bind:close-on-select="true"
                                    v-bind:placeholder="''"
                                    v-bind:show-labels="false" >
                                </multiselect>
                            </td>
                            <td colspan="2">
                                <button type="button" class="btn btn-default" role='button' v-on:click="OnAddInf29aItem()">
                                    輸入明細
                                </button>
                                <button type="button" class="btn btn-default" role='button' v-on:click="OnDeleteInf29aItem">
                                    刪除明細
                                </button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="result-div">
                <div class="scroll-table">
                    <table class="table table-bordered sortable">
                        <thead>
                            <tr class="bg-primary text-light">
                                <th v-on:click="OnTableSorting('inf29a02_seq')">
                                    項次
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':SortColumn!='inf29a02_seq', 
                                        'glyphicon-chevron-up': SortColumn=='inf29a02_seq' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='inf29a02_seq' && SortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnTableSorting('inf29a05_pcode')">
                                    產品編號
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':SortColumn!='inf29a05_pcode', 
                                        'glyphicon-chevron-up': SortColumn=='inf29a05_pcode' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='inf29a05_pcode' && SortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnTableSorting('inf29a05_shoes_code')">
                                    貨號
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':SortColumn!='inf29a05_shoes_code', 
                                        'glyphicon-chevron-up': SortColumn=='inf29a05_shoes_code' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='inf29a05_shoes_code' && SortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnTableSorting('inf29a33_product_name')">
                                    產品簡稱
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':SortColumn!='inf29a33_product_name', 
                                        'glyphicon-chevron-up': SortColumn=='inf29a33_product_name' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='inf29a33_product_name' && SortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnTableSorting('inf29a13_sold_qty')">
                                    數量
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':SortColumn!='inf29a13_sold_qty', 
                                        'glyphicon-chevron-up': SortColumn=='inf29a13_sold_qty' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='inf29a13_sold_qty' && SortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnTableSorting('inf29a11_dis_rate')">
                                    折扣
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':SortColumn!='inf29a11_dis_rate', 
                                        'glyphicon-chevron-up': SortColumn=='inf29a11_dis_rate' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='inf29a11_dis_rate' && SortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnTableSorting('inf29a17_runit')">
                                    單位
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':SortColumn!='inf29a17_runit', 
                                        'glyphicon-chevron-up': SortColumn=='inf29a17_runit' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='inf29a17_runit' && SortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnTableSorting('inf29a10_ocost_one')">
                                    原價
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':SortColumn!='inf29a10_ocost_one', 
                                        'glyphicon-chevron-up': SortColumn=='inf29a10_ocost_one' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='inf29a10_ocost_one' && SortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnTableSorting('inf29a10_cost_one')">
                                    進價
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':SortColumn!='inf29a10_cost_one', 
                                        'glyphicon-chevron-up': SortColumn=='inf29a10_cost_one' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='inf29a10_cost_one' && SortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnTableSorting('inf29a38_one_amt')">
                                    金額小計
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':SortColumn!='inf29a38_one_amt', 
                                        'glyphicon-chevron-up': SortColumn=='inf29a38_one_amt' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='inf29a38_one_amt' && SortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnTableSorting('Confirmed')">
                                    確認
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':SortColumn!='Confirmed', 
                                        'glyphicon-chevron-up': SortColumn=='Confirmed' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='Confirmed' && SortOrder=='desc'}">
                                    </span>
                                </th>

                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="inf29aItem in Inf29aList" 
                                v-on:click="OnRowClick(inf29aItem)"
                                v-bind:class="{'selected-row':inf29aItem==SelectedInf29aItem}"
                                >
                                <!-- 項次 -->
                                <td>{{inf29aItem.inf29a02_seq}}</td>
                                <!-- 產品編號 -->
                                <td>{{inf29aItem.inf29a05_pcode}}</td>
                                <!-- 貨號 -->
                                <td>{{inf29aItem.inf29a05_shoes_code}}</td>
                                <!-- 產品簡稱 -->
                                <td>{{inf29aItem.inf29a33_product_name }}</td>
                                <!-- 數量 -->
                                <td>{{inf29aItem.inf29a13_sold_qty }}</td>
                                <!-- 折扣 -->
                                <td>{{inf29aItem.inf29a11_dis_rate }}%</td>
                                <!-- 單位 -->
                                <td>{{inf29aItem.inf29a17_runit }}</td>
                                <!-- 原價 -->
                                <td>{{inf29aItem.inf29a10_ocost_one }}</td>
                                <!-- 進價 -->
                                <td>{{inf29aItem.inf29a10_cost_one }}</td>
                                <!-- 金額小計 -->
                                <td>{{inf29aItem.inf29a38_one_amt }}</td>
                                <!-- 確認 -->
                                <td>{{inf29aItem.Confirmed }}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-6">
                </div>
                <div class="col-xs-6">
                    <span>
                        總數量
                    </span>
                    <input type="text" class="small-field" v-model="TotalAmount" disabled="disabled"/>
                    <span>
                        總金額
                    </span>
                    <input type="text" class="small-field" v-model="TotalPrice" disabled="disabled"/>
                </div>
            </div>
            <div class="modal fade" id="HelpDialog" ref="HelpDialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title">求助</h4>
                        </div>
                        <div class="modal-body">
                            <div style="padding: 100px;">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <function-button data-dismiss="modal"
                                hot-key="f12">
                        離開
                    </function-button>
                        </div>
                    </div>
                </div>
            </div>
            
        </div>
        <d_pcode_component 
            id="dpCodeWindow" v-show="IsDpCodeDisplay"
            v-bind:callback="OnDPCodeResult"
            v-bind:leavefunction="OnDPCodeResult"
            >
        </d_pcode_component>
    </div>

    <script>
        (function () {
            var BcodeList = JSON.parse("<%=HttpUtility.JavaScriptStringEncode(JsonConvert.SerializeObject(BcodeList),false)%>");
            var InReasonList = JSON.parse("<%=HttpUtility.JavaScriptStringEncode(JsonConvert.SerializeObject(InReasonList),false)%>");
            var CurrencyList = JSON.parse("<%=HttpUtility.JavaScriptStringEncode(JsonConvert.SerializeObject(CurrencyList),false)%>");

            requirejs.config({
                paths: {
                    "dsap02101Search": "Dsap02101/dsap02101Search",
                    "dinp02301Edit": "Dinp/dinp02301Edit",
                },
                shim: {}
            });

            var requiredFiles = ["dsap02101Search", "dinp02301Edit"];

            function onLoaded(dsap02101Search, dinp02301Edit) {
                window.dsap02101Search.SetBCodeList(BcodeList);
                window.dinp02301Edit.SetBCodeList(BcodeList);
                //window.dinp02301Search.WherehouseList = WherehouseList;
                //window.dinp02301Edit.WherehouseList = WherehouseList;
                window.dinp02301Edit.InReasonList = InReasonList;
                window.dinp02301Edit.CurrencyList = CurrencyList;
            }

            function onError(error) {
                console.error(error);
            }

            require(requiredFiles, onLoaded, onError);
        })();
    </script>

</asp:Content>

