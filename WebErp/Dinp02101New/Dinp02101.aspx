﻿<%@ Page Language="C#" MasterPageFile="~/master/BaseMasterPage.master" AutoEventWireup="true" CodeFile="Dinp02101.aspx.cs" Inherits="Dinp02101New_Dinp02101" %>

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

    <div id="Dinp02101" v-cloak>
        <ul class="app-title">
            <li>{{"進(退)貨單輸入及列印 <%=this.AppVersion %>"}}
            </li>
        </ul>
        <div class="app-body" v-if="DisplaySearch">
            <div class="common-button-div">
                <function-button
                    hot-key="f1"
                    v-on:click.native="OnSearch()">
                            查詢
                        </function-button>
                <function-button
                    hot-key="f2"
                    v-on:click.native="OnAdd()">
                            新增
                        </function-button>
                <function-button
                    hot-key="f3"
                    v-on:click.native="OnDelete()">
                            刪除
                        </function-button>
                <function-button
                    hot-key="f4"
                    v-on:click.native="OnCopy()">
                            複製
                        </function-button>
                <function-button
                    hot-key="f6"
                    v-on:click.native="OnPrint()">
                            印表
                        </function-button>
                <function-button data-toggle="modal" href='#ExportDialog'
                    hot-key="f7"
                    v-on:click.native="OnExport()">
                            匯出
                        </function-button>
                <function-button data-toggle="modal" href='#ImportExcelDialog'
                    hot-key="f8"
                    v-on:click.native="OnImport()">
                            匯入Excel
                </function-button>
                <function-button data-toggle="modal" href='#HelpDialog'
                    hot-key="f11">
                            求助
                </function-button>
                <function-button
                    hot-key="f12"
                    v-on:click.native="OnExit()">
                            離開
                </function-button>
            </div>
            <div class="filter-div">
                <table>
                    <tbody>
                        <tr>
                            <td>進貨日期
                                <span>起~</span>
                            </td>
                            <td>
                                <vue-datetimepicker placeholder="" class="small-field"
                                    v-model="Filter.ProDateStart"
                                    v-on:change="AutoFillFilter('ProDateEnd',Filter.ProDateStart,'datetime')"></vue-datetimepicker>
                                迄~
                                <vue-datetimepicker id="FilterProDateEnd" class="small-field" ref="FilterProDateEnd" placeholder=""
                                    v-model="Filter.ProDateEnd"></vue-datetimepicker>
                            </td>
                            <td>商品編號
                                <span>起~</span>
                            </td>
                            <td>
                                <input type="text" class="small-field" v-model="Filter.PcodeStart"
                                    v-on:change="AutoFillFilter('PcodeEnd',Filter.PcodeStart)" />
                                迄~
                                <input type="text" class="small-field" v-model="Filter.PcodeEnd" />
                            </td>
                            <td>產品貨號
                                <span>起~</span>
                            </td>
                            <td>
                                <input type="text" class="small-field" v-model="Filter.ShoesCodeStart"
                                    v-on:change="AutoFillFilter('ShoesCodeEnd',Filter.ShoesCodeStart)" />
                                迄~
                                <input type="text" class="small-field" v-model="Filter.ShoesCodeEnd" />
                            </td>
                        </tr>
                        <tr>
                            <td>倉庫代號
                                <span>起~</span>
                            </td>
                            <td>
                                <multiselect class="small-field"
                                    v-model="Filter.WherehouseStart"
                                    v-bind:options="WherehouseList"
                                    v-bind:close-on-select="true"
                                    v-bind:placeholder="''"
                                    v-bind:show-labels="false"
                                    v-bind:custom-label="WherehouseSelectLabel"
                                    v-on:input="AutoFillFilter('WherehouseEnd',Filter.WherehouseStart)"
                                    track-by="cnf1002_fileorder"
                                    label="cnf1003_char01">
                                </multiselect>
                                迄~
                                <multiselect class="small-field"
                                    v-model="Filter.WherehouseEnd"
                                    v-bind:options="WherehouseList"
                                    v-bind:close-on-select="true"
                                    v-bind:placeholder="''"
                                    v-bind:show-labels="false"
                                    v-bind:custom-label="WherehouseSelectLabel"
                                    track-by="cnf1002_fileorder"
                                    label="cnf1003_char01">
                                </multiselect>
                            </td>
                            <td>異動代碼
                                <span>起~</span>
                            </td>
                            <td>
                                <input type="text" class="small-field" v-model="Filter.InReasonStart"
                                    v-on:change="AutoFillFilter('InReasonEnd',Filter.InReasonStart)" />
                                迄~
                                <input type="text" class="small-field" v-model="Filter.InReasonEnd" />
                            </td>
                            <td>廠商代號
                                <span>起~</span>
                            </td>
                            <td>
                                <input type="text" class="small-field" v-model="Filter.VCodeStart"
                                    v-on:change="AutoFillFilter('VCodeEnd',Filter.VCodeStart)" />
                                迄~
                                <input type="text" class="small-field" v-model="Filter.VCodeEnd" />
                            </td>
                            <tr>
                                <td>新增日期
                                <span>起~</span>
                                </td>
                                <td>
                                    <vue-datetimepicker class="small-field" placeholder=""
                                        v-model="Filter.AddDateStart"
                                        v-on:change="AutoFillFilter('AddDateEnd',Filter.AddDateStart,'datetime')"></vue-datetimepicker>
                                    迄~
                                <vue-datetimepicker id="FilterAddDateEnd" class="small-field" ref="FilterAddDateEnd" placeholder=""
                                    v-model="Filter.AddDateEnd"></vue-datetimepicker>
                                </td>
                                <td>公司代號
                                <span>起~</span>
                                </td>
                                <td>
                                    <multiselect class="small-field"
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
                                <multiselect class="small-field"
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
                                <td>採購單號
                                </td>
                                <td>
                                    <input type="text" v-model="Filter.Srcdocno" />
                                </td>
                            </tr>
                            <tr>
                                <td>關鍵字
                                </td>
                                <td colspan="5">
                                    <input type="text" class="small-field" v-model="Filter.Keyword" />
                                    筆數:
                                <label id="lbCount">0</label>
                                </td>
                            </tr>
                    </tbody>
                </table>
            </div>
            <div class="result-div">
                <div class="main-result-div">
                    <div class="scroll-table">
                        <table id="tbdinp02101" class="table table-bordered sortable">
                            <thead>
                                <tr class="bg-primary text-light">
                                    <th class="no-sortable">操作</th>
                                    <th v-on:click="OnInf29TableSorting('id')">序號
                                        <span class="sort-item glyphicon  "
                                            v-bind:class="{'glyphicon-sort':Inf29SortColumn!='id', 
                                            'glyphicon-chevron-up': Inf29SortColumn=='id' && Inf29SortOrder=='asc',
                                            'glyphicon-chevron-down': Inf29SortColumn=='id' && Inf29SortOrder=='desc'}"></span>
                                    </th>
                                    <th v-on:click="OnInf29TableSorting('inf2904_pro_date')">進貨日期
                                        <span class="sort-item glyphicon  "
                                            v-bind:class="{'glyphicon-sort':Inf29SortColumn!='inf2904_pro_date', 
                                            'glyphicon-chevron-up': Inf29SortColumn=='inf2904_pro_date' && Inf29SortOrder=='asc',
                                            'glyphicon-chevron-down': Inf29SortColumn=='inf2904_pro_date' && Inf29SortOrder=='desc'}"></span>
                                    </th>
                                    <th v-on:click="OnInf29TableSorting('inf2901_docno')">進貨單號
                                        <span class="sort-item glyphicon  "
                                            v-bind:class="{'glyphicon-sort':Inf29SortColumn!='inf2901_docno', 
                                            'glyphicon-chevron-up': Inf29SortColumn=='inf2901_docno' && Inf29SortOrder=='asc',
                                            'glyphicon-chevron-down': Inf29SortColumn=='inf2901_docno' && Inf29SortOrder=='desc'}"></span>
                                    </th>
                                    <th v-on:click="OnInf29TableSorting('inf2964_src_docno')">採購單號
                                        <span class="sort-item glyphicon  "
                                            v-bind:class="{'glyphicon-sort':Inf29SortColumn!='inf2964_src_docno', 
                                            'glyphicon-chevron-up': Inf29SortColumn=='inf2964_src_docno' && Inf29SortOrder=='asc',
                                            'glyphicon-chevron-down': Inf29SortColumn=='inf2964_src_docno' && Inf29SortOrder=='desc'}"></span>
                                    </th>
                                    <th v-on:click="OnInf29TableSorting('inf2911_sub_amt')">合計金額
                                        <span class="sort-item glyphicon  "
                                            v-bind:class="{'glyphicon-sort':Inf29SortColumn!='inf2935_total', 
                                            'glyphicon-chevron-up': Inf29SortColumn=='inf2935_total' && Inf29SortOrder=='asc',
                                            'glyphicon-chevron-down': Inf29SortColumn=='inf2935_total' && Inf29SortOrder=='desc'}"></span>
                                    </th>
                                    <th v-on:click="OnInf29TableSorting('inf2903_customer_code')">廠商代號
                                        <span class="sort-item glyphicon  "
                                            v-bind:class="{'glyphicon-sort':Inf29SortColumn!='inf2903_customer_code', 
                                            'glyphicon-chevron-up': Inf29SortColumn=='inf2903_customer_code' && Inf29SortOrder=='asc',
                                            'glyphicon-chevron-down': Inf29SortColumn=='inf2903_customer_code' && Inf29SortOrder=='desc'}"></span>
                                    </th>
                                    <th v-on:click="OnInf29TableSorting('inf2903_customer_name')">廠商名稱
                                        <span class="sort-item glyphicon"
                                            v-bind:class="{'glyphicon-sort':Inf29SortColumn!='inf2903_customer_name', 
                                            'glyphicon-chevron-up': Inf29SortColumn=='inf2903_customer_name' && Inf29SortOrder=='asc',
                                            'glyphicon-chevron-down': Inf29SortColumn=='inf2903_customer_name' && Inf29SortOrder=='desc'}"></span>
                                    </th>
                                    <th v-on:click="OnInf29TableSorting('remark')">備註
                                        <span class="sort-item glyphicon  "
                                            v-bind:class="{'glyphicon-sort':Inf29SortColumn!='inf1504_end_date', 
                                            'glyphicon-chevron-up': Inf29SortColumn=='remark' && Inf29SortOrder=='asc',
                                            'glyphicon-chevron-down': Inf29SortColumn=='remark' && Inf29SortOrder=='desc'}"></span>
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="inf29Item in Inf29List" 
                                v-on:click="OnMainRowClick(inf29Item)"
                                v-bind:class="{'selected-row':inf29Item==SelectedInf29Item}">
                                    <td>
                                        <button type="button" class="btn btn-default" v-on:click="OnDelete(inf29Item)">
                                            <span class="glyphicon glyphicon-remove"></span>
                                        </button>
                                        <button type="button" class="btn btn-default" data-toggle="modal" href='#EditDialog' v-on:click="OnCopy(SelectedInf29Item)">
                                            <span class="glyphicon glyphicon-copy"></span>
                                        </button>
                                    </td>
                                    <td>{{inf29Item.id}}</td>
                                    <td>{{inf29Item.inf2904_pro_date}}</td>
                                    <td>{{inf29Item.inf2901_docno}}</td>
                                    <td>{{inf29Item.inf2964_src_docno}}</td>
                                    <td>{{inf29Item.inf2911_sub_amt}}</td>
                                    <td>{{inf29Item.inf2903_customer_code}}</td>
                                    <td>{{inf29Item.inf2903_customer_name}}</td>
                                    <td>{{inf29Item.remark}}</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="sub-result-div">
                    <div class="scroll-table">
                        <table id="tbDetaildinp02101" class="table table-bordered sortable">
                            <thead>
                                <tr class="bg-primary text-light">
                                    <th v-on:click="OnInf29aTableSorting('inf29a02_seq')">序號
                                        <span class="sort-item glyphicon"
                                            v-bind:class="{'glyphicon-sort':Inf29aSortColumn!='inf29a02_seq', 
                                            'glyphicon-chevron-up': Inf29aSortColumn=='inf29a02_seq' && Inf29aSortOrder=='asc',
                                            'glyphicon-chevron-down': Inf29aSortColumn=='inf29a02_seq' && Inf29aSortOrder=='desc'}"></span>
                                    </th>
                                    <th v-on:click="OnInf29aTableSorting('inf29a05_pcode')">產品編號
                                        <span class="sort-item glyphicon"
                                            v-bind:class="{'glyphicon-sort':Inf29aSortColumn!='inf29a05_pcode', 
                                            'glyphicon-chevron-up': Inf29aSortColumn=='inf29a05_pcode' && Inf29aSortOrder=='asc',
                                            'glyphicon-chevron-down': Inf29aSortColumn=='inf29a05_pcode' && Inf29aSortOrder=='desc'}"></span>
                                    </th>
                                    <th v-on:click="OnInf29aTableSorting('inf29a05_shoes_code')">產品貨號
                                        <span class="sort-item glyphicon"
                                            v-bind:class="{'glyphicon-sort':Inf29aSortColumn!='inf29a05_shoes_code', 
                                            'glyphicon-chevron-up': Inf29aSortColumn=='inf29a05_shoes_code' && Inf29aSortOrder=='asc',
                                            'glyphicon-chevron-down': Inf29aSortColumn=='inf29a05_shoes_code' && Inf29aSortOrder=='desc'}"></span>
                                    </th>
                                    <th v-on:click="OnInf29aTableSorting('inf29a33_product_name')">產品名稱
                                        <span class="sort-item glyphicon"
                                            v-bind:class="{'glyphicon-sort':Inf29aSortColumn!='inf29a33_product_name', 
                                            'glyphicon-chevron-up': Inf29aSortColumn=='inf29a33_product_name' && Inf29aSortOrder=='asc',
                                            'glyphicon-chevron-down': Inf29aSortColumn=='inf29a33_product_name' && Inf29aSortOrder=='desc'}"></span>
                                    </th>
                                    <th v-on:click="OnInf29aTableSorting('inf29a17_runit')">銷售單位
                                        <span class="sort-item glyphicon"
                                            v-bind:class="{'glyphicon-sort':Inf29aSortColumn!='inf29a17_runit', 
                                            'glyphicon-chevron-up': Inf29aSortColumn=='inf29a17_runit' && Inf29aSortOrder=='asc',
                                            'glyphicon-chevron-down': Inf29aSortColumn=='inf29a17_runit' && Inf29aSortOrder=='desc'}"></span>
                                    </th>
                                    <th v-on:click="OnInf29aTableSorting('inf29a13_sold_qty')">進貨數量
                                        <span class="sort-item glyphicon"
                                            v-bind:class="{'glyphicon-sort':Inf29aSortColumn!='inf29a13_sold_qty', 
                                            'glyphicon-chevron-up': Inf29aSortColumn=='inf29a13_sold_qty' && Inf29aSortOrder=='asc',
                                            'glyphicon-chevron-down': Inf29aSortColumn=='inf29a13_sold_qty' && Inf29aSortOrder=='desc'}"></span>
                                    </th>
                                    <th v-on:click="OnInf29aTableSorting('inf29a24_retrn_qty')">退貨數量
                                        <span class="sort-item glyphicon"
                                            v-bind:class="{'glyphicon-sort':Inf29aSortColumn!='inf29a24_retrn_qty', 
                                            'glyphicon-chevron-up': Inf29aSortColumn=='inf29a24_retrn_qty' && Inf29aSortOrder=='asc',
                                            'glyphicon-chevron-down': Inf29aSortColumn=='inf29a24_retrn_qty' && Inf29aSortOrder=='desc'}"></span>
                                    </th>
                                    <th v-on:click="OnInf29aTableSorting('inf29a16_gift_qty')">贈品數量
                                        <span class="sort-item glyphicon"
                                            v-bind:class="{'glyphicon-sort':Inf29aSortColumn!='inf29a16_gift_qty', 
                                            'glyphicon-chevron-up': Inf29aSortColumn=='inf29a16_gift_qty' && Inf29aSortOrder=='asc',
                                            'glyphicon-chevron-down': Inf29aSortColumn=='inf29a16_gift_qty' && Inf29aSortOrder=='desc'}"></span>
                                    </th>
                                    <th v-on:click="OnInf29aTableSorting('inf29a26_box_qty')">大單位數量
                                        <span class="sort-item glyphicon"
                                            v-bind:class="{'glyphicon-sort':Inf29aSortColumn!='inf29a26_box_qty', 
                                            'glyphicon-chevron-up': Inf29aSortColumn=='inf29a26_box_qty' && Inf29aSortOrder=='asc',
                                            'glyphicon-chevron-down': Inf29aSortColumn=='inf29a26_box_qty' && Inf29aSortOrder=='desc'}"></span>
                                    </th>
                                    <th v-on:click="OnInf29aTableSorting('inf29a10_cost_one')">大單位換算值
                                        <span class="sort-item glyphicon"
                                            v-bind:class="{'glyphicon-sort':Inf29aSortColumn!='inf29a10_cost_one', 
                                            'glyphicon-chevron-up': Inf29aSortColumn=='inf29a10_cost_one' && Inf29aSortOrder=='asc',
                                            'glyphicon-chevron-down': Inf29aSortColumn=='inf29a10_cost_one' && Inf29aSortOrder=='desc'}"></span>
                                    </th>
                                    <th v-on:click="OnInf29aTableSorting('inf29a06_qty')">小單位數量
                                        <span class="sort-item glyphicon"
                                            v-bind:class="{'glyphicon-sort':Inf29aSortColumn!='inf29a06_qty', 
                                            'glyphicon-chevron-up': Inf29aSortColumn=='inf29a06_qty' && Inf29aSortOrder=='asc',
                                            'glyphicon-chevron-down': Inf29aSortColumn=='inf29a06_qty' && Inf29aSortOrder=='desc'}"></span>
                                    </th>
                                    <th v-on:click="OnInf29aTableSorting('inf29a10_cost_one0')">未稅單價
                                        <span class="sort-item glyphicon"
                                            v-bind:class="{'glyphicon-sort':Inf29aSortColumn!='inf29a10_cost_one0', 
                                            'glyphicon-chevron-up': Inf29aSortColumn=='inf29a10_cost_one0' && Inf29aSortOrder=='asc',
                                            'glyphicon-chevron-down': Inf29aSortColumn=='inf29a10_cost_one0' && Inf29aSortOrder=='desc'}"></span>
                                    </th>
                                    <th v-on:click="OnInf29aTableSorting('inf29a40_tax')">營業稅
                                        <span class="sort-item glyphicon"
                                            v-bind:class="{'glyphicon-sort':Inf29aSortColumn!='inf29a40_tax', 
                                            'glyphicon-chevron-up': Inf29aSortColumn=='inf29a40_tax' && Inf29aSortOrder=='asc',
                                            'glyphicon-chevron-down': Inf29aSortColumn=='inf29a40_tax' && Inf29aSortOrder=='desc'}"></span>
                                    </th>
                                    <th v-on:click="OnInf29aTableSorting('inf29a10_ocost_one')">含稅單價
                                        <span class="sort-item glyphicon"
                                            v-bind:class="{'glyphicon-sort':Inf29aSortColumn!='inf29a10_ocost_one', 
                                            'glyphicon-chevron-up': Inf29aSortColumn=='inf29a10_ocost_one' && Inf29aSortOrder=='asc',
                                            'glyphicon-chevron-down': Inf29aSortColumn=='inf29a10_ocost_one' && Inf29aSortOrder=='desc'}"></span>
                                    </th>
                                    <th v-on:click="OnInf29aTableSorting('inf29a38_one_amt')">金額小計
                                        <span class="sort-item glyphicon"
                                            v-bind:class="{'glyphicon-sort':Inf29aSortColumn!='inf29a38_one_amt', 
                                            'glyphicon-chevron-up': Inf29aSortColumn=='inf29a38_one_amt' && Inf29aSortOrder=='asc',
                                            'glyphicon-chevron-down': Inf29aSortColumn=='inf29a38_one_amt' && Inf29aSortOrder=='desc'}"></span>
                                    </th>
                                    <th v-on:click="OnInf29aTableSorting('remark')">備註
                                        <span class="sort-item glyphicon"
                                            v-bind:class="{'glyphicon-sort':Inf29aSortColumn!='remark', 
                                            'glyphicon-chevron-up': Inf29aSortColumn=='remark' && Inf29aSortOrder=='asc',
                                            'glyphicon-chevron-down': Inf29aSortColumn=='remark' && Inf29aSortOrder=='desc'}"></span>
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="inf29aItem in Inf29aList"
                                    v-on:click="OnSubRowClick(inf29aItem)"
                                    v-bind:class="{'selected-row':inf29aItem==SelectedInf29aItem}">
                                    <!-- 序號 -->
                                    <td>{{inf29aItem.inf29a02_seq}}</td>
                                    <!-- 商品條碼 -->
                                    <td>{{inf29aItem.inf29a05_pcode}}</td>
                                    <!-- 產品貨號 -->
                                    <td>{{inf29aItem.inf29a05_shoes_code}}</td>
                                    <!-- 產品名稱 -->
                                    <td>{{inf29aItem.inf29a33_product_name }}</td>
                                    <!-- 銷售單位 -->
                                    <td>{{inf29aItem.inf29a17_runit }}</td>
                                    <!-- 進貨數量 -->
                                    <td>{{inf29aItem.inf29a13_sold_qty }}</td>
                                    <!-- 退貨數量 -->
                                    <td>{{inf29aItem.inf29a24_retrn_qty }}</td>
                                    <!-- 贈品數量 -->
                                    <td>{{inf29aItem.inf29a16_gift_qty }}</td>
                                    <!-- 大單位數量 -->
                                    <td>{{inf29aItem.inf29a26_box_qty }}</td>
                                    <!-- 大單位換算值 -->
                                    <td>{{inf29aItem.inf29a10_cost_one }}</td>
                                    <!-- 小單位數量 -->
                                    <td>{{inf29aItem.inf29a06_qty }}</td>
                                    <!-- 未稅單價 -->
                                    <td>{{inf29aItem.inf29a10_cost_one0 }}</td>
                                    <!-- 營業稅 -->
                                    <td>{{inf29aItem.inf29a40_tax }}</td>
                                    <!-- 含稅單價 -->
                                    <td>{{inf29aItem.inf29a10_ocost_one }}</td>
                                    <!-- 金額小計 -->
                                    <td>{{inf29aItem.inf29a38_one_amt }}</td>
                                    <!-- 備註 -->
                                    <td>{{inf29aItem.remark }}</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
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
        <div class="app-body" v-show="DisplayUpdate">
            <div class="common-button-div">
                <function-button id="Function-button3"
                    hot-key="f1"
                    v-on:click.native="OnSearch()">
                    查詢
                </function-button>
                <function-button id="Function-button4" 
                    hot-key="f2"
                    v-on:click.native="OnAdd()">
                    新增
                </function-button>
                <function-button
                    hot-key="f3"
                    v-on:click.native="OnDelete()">
                    刪除
                </function-button>
                <function-button
                    hot-key="f5"
                    v-on:click.native="OnSave()">
                    存檔
                </function-button>
                <function-button 
                    hot-key="f6"
                    v-on:click.native="OnPrint()">
                    印表
                </function-button>
                <function-button id="HelpBtn" data-toggle="modal" href='#HelpDialog'
                    hot-key="f11">
                    求助
                </function-button>
                <function-button
                    hot-key="f12"
                    v-on:click.native="OnIUExit()">
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
                                    v-model="Inf29Item.inf2901_bcode"
                                    v-bind:options="BcodeList"
                                    v-bind:close-on-select="true"
                                    v-bind:placeholder="''"
                                    v-bind:show-labels="false" 
                                    v-bind:custom-label="BcodeSelectLabel"
                                    track-by="cnf0701_bcode"
                                    label="cnf0703_bfname">
                                </multiselect>
                            </td>
                            <td>進貨單號
                            </td>
                            <td>
                                <input id="IUDocno" type="text" disabled="disabled" />
                            </td>
                            <td>進貨日期
                            </td>
                            <td>
                                <input id="IUProDate" placeholder="" class="small-field" />
                            </td>
                            <td>
                                所屬帳款月份
                            </td>
                            <td>
                                <input id="IUAcctMonth" placeholder="" class="small-field" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                倉庫代號
                            </td>
                            <td>
                                <multiselect
                                    v-model="Inf29Item.inf2906_wherehouse"
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
                                廠商代號
                            </td>
                            <td>
                                <multiselect
                                    v-model="Inf29Item.inf2903_customer_code"
                                    v-bind:options="CcodeList"
                                    v-bind:close-on-select="true"
                                    v-bind:placeholder="''"
                                    v-bind:show-labels="false" 
                                    v-bind:custom-label="CcodeSelectLabel"
                                    track-by="cmf0102_cuscode"
                                    label="cmf0103_bname">
                                </multiselect>
                            </td>
                             <td>
                                採購單號
                            </td>
                            <td>
                                <input type="text" id="IUSrcDocno" class="small-field" v-model="Inf29Item.inf2964_src_docno" />
                            </td>
                            <td>
                                幣別
                            </td>
                            <td>
                                <multiselect class="small-field"
                                    v-model="Inf29Item.inf2928_currency"
                                    v-bind:options="CurrencyList"
                                    v-bind:close-on-select="true"
                                    v-bind:placeholder="''"
                                    v-bind:show-labels="false" 
                                    v-on:select="GetExchangeInfo"
                                    track-by="cnf1003_char01"
                                    label="cnf1003_char01">
                                </multiselect>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                備註
                            </td>
                            <td colspan="3">
                                <input type="text" id="IURemark" style="width:99%;" v-model="Inf29Item.remark"/>
                            </td>
                             <td>
                                匯率
                            </td>
                            <td>
                                <input type="text" id="IURate" class="small-field" v-model="Inf29Item.inf2929_exchange_rate" />
                            </td>
                            <td>
                                折讓金額
                            </td>
                            <td>
                                <input type="text" id="IUAllowances" class="small-field" v-model="Inf29Item.inf2951_allowances" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                新增者
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
                                未稅單價
                            </td>
                            <td>
                                <input type="text" class="small-field" v-model="Inf29aItem.inf29a10_cost_one0"/>
                            </td>
                            <td>
                                含稅單價
                            </td>
                            <td>
                                <input type="text" class="small-field" v-model="Inf29aItem.inf29a10_ocost_one"/>
                            </td>
                            <td>
                                營業稅
                            </td>
                            <td>
                                <input type="text" class="small-field" v-model="Inf29aItem.inf29a40_tax" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                進貨數量
                            </td>
                            <td>
                                <input type="text" class="small-field" v-model="Inf29aItem.inf29a13_sold_qty" v-on:change="OnDetailTotalAmt()" />
                            </td>
                            <td>
                                退貨數量
                            </td>
                            <td>
                                <input type="text" class="small-field" v-model="Inf29aItem.inf29a24_retrn_qty" v-on:change="OnDetailTotalAmt()" />
                            </td>
                            <td>
                                贈品數量
                            </td>
                            <td>
                                <input type="text" class="small-field" v-model="Inf29aItem.inf29a16_gift_qty"/>
                            </td>
                            <td>
                                大單位數量
                            </td>
                            <td>
                                <input type="text" class="small-field" v-model="Inf29aItem.inf29a26_box_qty"/>
                            </td>
                            <td>
                                換算值
                            </td>
                            <td>
                                <input type="text" class="small-field" v-model="Inf29aItem.inf29a10_cost_one"/>
                            </td>
                             <td>
                                小單位數量
                            </td>
                            <td>
                                <input type="text" class="small-field" v-model="Inf29aItem.inf29a06_qty"/>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                金額小計
                            </td>
                            <td>
                                <input type="text" class="small-field" v-model="Inf29aItem.inf29a38_one_amt" disabled="disabled"/>
                            </td>
                            <td>
                                備註
                            </td>
                            <td>
                                <input type="text" v-model="Inf29aItem.remark"/>
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
                    <table id="tbAddDetaildinp02101" class="table table-bordered sortable">
                        <thead>
                            <tr class="bg-primary text-light">
                                <th v-on:click="OnTableSorting('inf29a02_seq')">序號
                                    <span class="sort-item glyphicon"
                                        v-bind:class="{'glyphicon-sort':SortColumn!='inf29a02_seq', 
                                        'glyphicon-chevron-up': SortColumn=='inf29a02_seq' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='inf29a02_seq' && SortOrder=='desc'}"></span>
                                </th>
                                <th v-on:click="OnTableSorting('inf29a05_pcode')">商品編號
                                    <span class="sort-item glyphicon"
                                        v-bind:class="{'glyphicon-sort':SortColumn!='inf29a05_pcode', 
                                        'glyphicon-chevron-up': SortColumn=='inf29a05_pcode' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='inf29a05_pcode' && SortOrder=='desc'}"></span>
                                </th>
                                <th v-on:click="OnTableSorting('inf29a05_shoes_code')">產品貨號
                                    <span class="sort-item glyphicon"
                                        v-bind:class="{'glyphicon-sort':SortColumn!='inf29a05_shoes_code', 
                                        'glyphicon-chevron-up': SortColumn=='inf29a05_shoes_code' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='inf29a05_shoes_code' && SortOrder=='desc'}"></span>
                                </th>
                                <th v-on:click="OnTableSorting('inf29a33_product_name')">產品名稱
                                    <span class="sort-item glyphicon"
                                        v-bind:class="{'glyphicon-sort':SortColumn!='inf29a33_product_name', 
                                        'glyphicon-chevron-up': SortColumn=='inf29a33_product_name' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='inf29a33_product_name' && SortOrder=='desc'}"></span>
                                </th>
                                <th v-on:click="OnTableSorting('inf29a17_runit')">單位
                                    <span class="sort-item glyphicon"
                                        v-bind:class="{'glyphicon-sort':SortColumn!='inf29a17_runit', 
                                        'glyphicon-chevron-up': SortColumn=='inf29a17_runit' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='inf29a17_runit' && SortOrder=='desc'}"></span>
                                </th>
                                <th v-on:click="OnTableSorting('inf29a13_sold_qty')">進貨數量
                                    <span class="sort-item glyphicon"
                                        v-bind:class="{'glyphicon-sort':SortColumn!='inf29a13_sold_qty', 
                                        'glyphicon-chevron-up': SortColumn=='inf29a13_sold_qty' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='inf29a13_sold_qty' && SortOrder=='desc'}"></span>
                                </th>
                                <th v-on:click="OnTableSorting('inf29a24_retrn_qty')">退貨數量
                                    <span class="sort-item glyphicon"
                                        v-bind:class="{'glyphicon-sort':SortColumn!='inf29a24_retrn_qty', 
                                        'glyphicon-chevron-up': SortColumn=='inf29a24_retrn_qty' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='inf29a24_retrn_qty' && SortOrder=='desc'}"></span>
                                </th>
                                <th v-on:click="OnTableSorting('inf29a16_gift_qty')">贈品數量
                                    <span class="sort-item glyphicon"
                                        v-bind:class="{'glyphicon-sort':SortColumn!='inf29a16_gift_qty', 
                                        'glyphicon-chevron-up': SortColumn=='inf29a16_gift_qty' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='inf29a16_gift_qty' && SortOrder=='desc'}"></span>
                                </th>
                                <th v-on:click="OnTableSorting('inf29a26_box_qty')">大單位數量
                                    <span class="sort-item glyphicon"
                                        v-bind:class="{'glyphicon-sort':SortColumn!='inf29a26_box_qty', 
                                        'glyphicon-chevron-up': SortColumn=='inf29a26_box_qty' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='inf29a26_box_qty' && SortOrder=='desc'}"></span>
                                </th>
                                <th v-on:click="OnTableSorting('inf29a10_cost_one')">大單位換算值
                                    <span class="sort-item glyphicon"
                                        v-bind:class="{'glyphicon-sort':SortColumn!='inf29a10_cost_one', 
                                        'glyphicon-chevron-up': SortColumn=='inf29a10_cost_one' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='inf29a10_cost_one' && SortOrder=='desc'}"></span>
                                </th>
                                <th v-on:click="OnTableSorting('inf29a06_qty')">小單位數量
                                    <span class="sort-item glyphicon"
                                        v-bind:class="{'glyphicon-sort':SortColumn!='inf29a06_qty', 
                                        'glyphicon-chevron-up': SortColumn=='inf29a06_qty' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='inf29a06_qty' && SortOrder=='desc'}"></span>
                                </th>
                                <th v-on:click="OnTableSorting('inf29a10_cost_one0')">未稅單價
                                    <span class="sort-item glyphicon"
                                        v-bind:class="{'glyphicon-sort':SortColumn!='inf29a10_cost_one0', 
                                        'glyphicon-chevron-up': SortColumn=='inf29a10_cost_one0' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='inf29a10_cost_one0' && SortOrder=='desc'}"></span>
                                </th>
                                <th v-on:click="OnTableSorting('inf29a40_tax')">營業稅
                                    <span class="sort-item glyphicon"
                                        v-bind:class="{'glyphicon-sort':SortColumn!='inf29a40_tax', 
                                        'glyphicon-chevron-up': SortColumn=='inf29a40_tax' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='inf29a40_tax' && SortOrder=='desc'}"></span>
                                </th>
                                <th v-on:click="OnTableSorting('inf29a10_ocost_one')">含稅單價
                                    <span class="sort-item glyphicon"
                                        v-bind:class="{'glyphicon-sort':SortColumn!='inf29a10_ocost_one', 
                                        'glyphicon-chevron-up': SortColumn=='inf29a10_ocost_one' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='inf29a10_ocost_one' && SortOrder=='desc'}"></span>
                                </th>
                                <th v-on:click="OnTableSorting('inf29a38_one_amt')">金額小計
                                    <span class="sort-item glyphicon"
                                        v-bind:class="{'glyphicon-sort':SortColumn!='inf29a38_one_amt', 
                                        'glyphicon-chevron-up': SortColumn=='inf29a38_one_amt' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='inf29a38_one_amt' && SortOrder=='desc'}"></span>
                                </th>
                                <th v-on:click="OnTableSorting('remark')">備註
                                    <span class="sort-item glyphicon"
                                        v-bind:class="{'glyphicon-sort':SortColumn!='remark', 
                                        'glyphicon-chevron-up': SortColumn=='remark' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='remark' && SortOrder=='desc'}"></span>
                                </th>
                            </tr>
                            
                        </thead>
                        <tbody>
                            <tr v-for="inf29aItem in Inf29aList" 
                                v-on:click="OnRowClick(inf29aItem)"
                                v-bind:class="{'selected-row':inf29aItem==SelectedInf29aItem}"
                                >
                                <!-- 序號 -->
                                <td>{{inf29aItem.inf29a02_seq}}</td>
                                <!-- 商品編號 -->
                                <td>{{inf29aItem.inf29a05_pcode}}</td>
                                <!-- 貨號 -->
                                <td>{{inf29aItem.inf29a05_shoes_code}}</td>
                                <!-- 商品名稱 -->
                                <td>{{inf29aItem.inf29a33_product_name }}</td>
                                <!-- 單位 -->
                                <td>{{inf29aItem.inf29a17_runit }}</td>
                                <!-- 進貨數量 -->
                                <td>{{inf29aItem.inf29a13_sold_qty }}</td>
                                <!-- 退貨數量 -->
                                <td>{{inf29aItem.inf29a24_retrn_qty }}</td>
                                <!-- 贈品數量 -->
                                <td>{{inf29aItem.inf29a16_gift_qty }}</td>
                                <!-- 大單位數量 -->
                                <td>{{inf29aItem.inf29a26_box_qty }}</td>
                                <!-- 大單位換算值 -->
                                <td>{{inf29aItem.inf29a10_cost_one }}</td>
                                <!-- 小單位數量 -->
                                <td>{{inf29aItem.inf29a06_qty }}</td>
                                <!-- 未稅單價 -->
                                <td>{{inf29aItem.inf29a10_cost_one0 }}</td>
                                <!-- 營業稅 -->
                                <td>{{inf29aItem.inf29a40_tax }}</td>
                                <!-- 含稅單價 -->
                                <td>{{inf29aItem.inf29a10_ocost_one }}</td>
                                <!-- 金額小計 -->
                                <td>{{inf29aItem.inf29a38_one_amt }}</td>
                                <!-- 備註 -->
                                <td>{{inf29aItem.remark }}</td>
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
            <d_pcode_component id="dpCodeWindow" v-show="IsDpCodeDisplay" v-bind:callback="OnDPCodeResult" v-bind:leavefunction="OnDPCodeResult">
        </d_pcode_component>
        </div>
    </div>


    <script>
        (function () {
            var BcodeList = JSON.parse("<%=HttpUtility.JavaScriptStringEncode(JsonConvert.SerializeObject(BcodeList),false)%>");
            var WherehouseList = JSON.parse("<%=HttpUtility.JavaScriptStringEncode(JsonConvert.SerializeObject(WherehouseList),false)%>");
            var InReasonList = JSON.parse("<%=HttpUtility.JavaScriptStringEncode(JsonConvert.SerializeObject(InReasonList),false)%>");
            var CurrencyList = JSON.parse("<%=HttpUtility.JavaScriptStringEncode(JsonConvert.SerializeObject(CurrencyList),false)%>");
            var CcodeList = JSON.parse("<%=HttpUtility.JavaScriptStringEncode(JsonConvert.SerializeObject(CcodeList),false)%>");

            requirejs.config({
                paths: {
                    "dinp02101": "Dinp02101New/dinp02101",
                    //"dinp02101Search": "Dinp02101New/dinp02101Search",
                    //"dinp02101Edit": "Dinp02101New/dinp02101Edit",
                    "jqueryDatetimepicker": "public/scripts/jquery.datetimepicker/jquery.datetimepicker.full",
                    "jqueryDatetimepicker-css": "public/scripts/jquery.datetimepicker/jquery.datetimepicker",
                },
                shim: {
                    "jqueryDatetimepicker": {
                        "deps": ["css!jqueryDatetimepicker-css"]
                    }
                }
            });

            //var requiredFiles = ["dinp02101Search", "dinp02101Edit"];
            var requiredFiles = ["dinp02101"];

            function onLoaded(dinp02101) {
                window.dinp02101.BcodeList = BcodeList;
                window.dinp02101.WherehouseList = WherehouseList;
                window.dinp02101.InReasonList = InReasonList;
                window.dinp02101.CurrencyList = CurrencyList;
                window.dinp02101.CcodeList = CcodeList;
                $('#IUProDate').datetimepicker({
                    timepicker: false,
                    format: 'Y/m/d'
                });
                $('#IUAcctMonth').datetimepicker({
                    timepicker: false,
                    format: 'Y/m'
                });
                $("#tbdinp02101").tableHeadFixer();
                $("#tbDetaildinp02101").tableHeadFixer();
                $("#tbAddDetaildinp02101").tableHeadFixer();
            }

            function onError(error) {
                console.error(error);
            }

            require(requiredFiles, onLoaded, onError);
        })();
    </script>

</asp:Content>
