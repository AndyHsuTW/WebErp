﻿<%@ Page Language="C#" MasterPageFile="~/master/BaseMasterPage.master" AutoEventWireup="true" CodeFile="Dsap02101.aspx.cs" Inherits="Dsap02101_Dsap02101" %>

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
            width: 125px;
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
            <li>{{"Dsap02101 客戶訂單資料查詢 <%=this.AppVersion %>"}}
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
                    v-on:click.native="OnDeleteALL()">
                            刪除
                        </function-button>
                <function-button id="CopyBtn"
                    hot-key="f4"
                    v-on:click.native="OnEdit()">
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
                                <input type="text" class="medium-field" v-model="Filter.DocnoStart"
                                    v-on:change="AutoFillFilter('DocnoEnd',Filter.DocnoStart)" />

                                迄~
                                <input type="text" class="medium-field" v-model="Filter.DocnoEnd" />
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
                                <input type="text" class="medium-field" v-model="Filter.Qty">
                            </td>
                            <td><span style="font-weight:bold">
                                筆數 : {{ Saf21List.length }}</span>
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
                                <th v-on:click="OnSaf21TableSorting('saf2133_seq2')">
                                    序號
                                    <span class="sort-item glyphicon" 
                                    v-bind:class="{'glyphicon-sort':Saf21SortColumn!='saf2133_seq2', 
                                    'glyphicon-chevron-up': Saf21SortColumn=='saf2133_seq2' && Saf21SortOrder=='asc',
                                    'glyphicon-chevron-down': Saf21SortColumn=='saf2133_seq2' && Saf21SortOrder=='desc'}">
                                </span>
                                <th v-on:click="OnSaf21TableSorting('Saf2101DocNoShort')">
                                    訂單單號
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Saf21SortColumn!='Saf2101DocNoShort', 
                                        'glyphicon-chevron-up': Saf21SortColumn=='Saf2101DocNoShort' && Saf21SortOrder=='asc',
                                        'glyphicon-chevron-down': Saf21SortColumn=='Saf2101DocNoShort' && Saf21SortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnSaf21TableSorting('saf2106_order_date')">
                                    訂單日期
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Saf21SortColumn!='saf2106_order_date', 
                                        'glyphicon-chevron-up': Saf21SortColumn=='saf2106_order_date' && Saf21SortOrder=='asc',
                                        'glyphicon-chevron-down': Saf21SortColumn=='saf2106_order_date' && Saf21SortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnSaf21TableSorting('saf2139_total_price')">
                                    金額總計
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Saf21SortColumn!='saf2139_total_price', 
                                        'glyphicon-chevron-up': Saf21SortColumn=='saf2139_total_price' && Saf21SortOrder=='asc',
                                        'glyphicon-chevron-down': Saf21SortColumn=='saf2139_total_price' && Saf21SortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnSaf21TableSorting('saf2108_customer_code')">
                                    客戶編號
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Saf21SortColumn!='saf2108_customer_code', 
                                        'glyphicon-chevron-up': Saf21SortColumn=='saf2108_customer_code' && Saf21SortOrder=='asc',
                                        'glyphicon-chevron-down': Saf21SortColumn=='saf2108_customer_code' && Saf21SortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnSaf21TableSorting('cnf0702_bname')">
                                    客戶名稱
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Saf21SortColumn!='saf2108_customer_code&bname', 
                                        'glyphicon-chevron-up': Saf21SortColumn=='cnf0702_bname' && Saf21SortOrder=='asc',
                                        'glyphicon-chevron-down': Saf21SortColumn=='cnf0702_bname' && Saf21SortOrder=='desc'}">
                                    </span>
                                </th>
                                </th>
                                <th v-on:click="OnSaf21TableSorting('saf2147_recid')">
                                    聯絡人
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Saf21SortColumn!='saf2147_recid', 
                                        'glyphicon-chevron-up': Saf21SortColumn=='saf2147_recid' && Saf21SortOrder=='asc',
                                        'glyphicon-chevron-down': Saf21SortColumn=='saf2147_recid' && Saf21SortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnSaf21TableSorting('taf1019_tel1')">
                                    連絡電話
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Saf21SortColumn!='taf1019_tel1', 
                                        'glyphicon-chevron-up': Saf21SortColumn=='taf1019_tel1' && Saf21SortOrder=='asc',
                                        'glyphicon-chevron-down': Saf21SortColumn=='taf1019_tel1' && Saf21SortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnSaf21TableSorting('taf1031_cellphone')">
                                    手機
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Saf21SortColumn!='taf1031_cellphone', 
                                        'glyphicon-chevron-up': Saf21SortColumn=='taf1031_cellphone' && Saf21SortOrder=='asc',
                                        'glyphicon-chevron-down': Saf21SortColumn=='taf1031_cellphone' && Saf21SortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnSaf21TableSorting('remark')">
                                    備註
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Saf21SortColumn!='remark', 
                                        'glyphicon-chevron-up': Saf21SortColumn=='remark' && Saf21SortOrder=='asc',
                                        'glyphicon-chevron-down': Saf21SortColumn=='remark' && Saf21SortOrder=='desc'}">
                                    </span>
                                </th>
                                <th>
                                    操作
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="(saf21Item, index) in Saf21List" 
                                v-on:click="OnMainRowClick(saf21Item)"
                                v-on:dblclick="OnEdit(saf21Item)"
                                v-bind:class="{'selected-row':saf21Item==SelectedSaf21Item}">
                                <td>{{index + 1 }}</td>
                                <td>{{saf21Item.saf2101_docno}}</td>
                                <td>{{saf21Item.saf2106_order_date.substring(0,10)}}</td>
                                <td>{{saf21Item.saf2139_total_price}}</td>
                                <td>{{saf21Item.saf2108_customer_code}}</td>
                                <td>{{saf21Item.cmf0103_bname }}</td>
                                <td>{{saf21Item.taf1002_firstname}}</td>
                                <td>{{saf21Item.taf1019_tel1}}</td>
                                <td>{{saf21Item.taf1031_cellphone}}</td>
                                <td>{{saf21Item.remark}}</td>
                                <td>
                                    <input type="button" value="刪除" v-on:click="OnDelete(saf21Item)">
                                </td>

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
                                <th v-on:click="OnSaf21aTableSorting('saf21a02_seq')">
                                    序號
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Saf21aSortColumn!='saf21a02_seq', 
                                        'glyphicon-chevron-up': Saf21aSortColumn=='saf21a02_seq' && Saf21aSortOrder=='asc',
                                        'glyphicon-chevron-down': Saf21aSortColumn=='saf21a02_seq' && Saf21aSortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnSaf21aTableSorting('saf21a02_pcode')">
                                    商品編號
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Saf21aSortColumn!='saf21a02_pcode', 
                                        'glyphicon-chevron-up': Saf21aSortColumn=='saf21a02_pcode' && Saf21aSortOrder=='asc',
                                        'glyphicon-chevron-down': Saf21aSortColumn=='saf21a02_pcode' && Saf21aSortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnSaf21aTableSorting('saf21a03_relative_no')">
                                    貨號
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Saf21aSortColumn!='saf21a03_relative_no', 
                                        'glyphicon-chevron-up': Saf21aSortColumn=='saf21a03_relative_no' && Saf21aSortOrder=='asc',
                                        'glyphicon-chevron-down': Saf21aSortColumn=='saf21a03_relative_no' && Saf21aSortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnSaf21aTableSorting('saf21a41_product_name')">
                                    產品簡稱
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Saf21aSortColumn!='saf21a41_product_name', 
                                        'glyphicon-chevron-up': Saf21aSortColumn=='saf21a41_product_name' && Saf21aSortOrder=='asc',
                                        'glyphicon-chevron-down': Saf21aSortColumn=='saf21a41_product_name' && Saf21aSortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnSaf21aTableSorting('saf21a43_runit')">
                                    單位
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Saf21aSortColumn!='saf21a43_runit', 
                                        'glyphicon-chevron-up': Saf21aSortColumn=='saf21a43_runit' && Saf21aSortOrder=='asc',
                                        'glyphicon-chevron-down': Saf21aSortColumn=='saf21a43_runit' && Saf21aSortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnSaf21aTableSorting('saf21a16_total_qty')">
                                    數量
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Saf21aSortColumn!='saf21a16_total_qty', 
                                        'glyphicon-chevron-up': Saf21aSortColumn=='saf21a16_total_qty' && Saf21aSortOrder=='asc',
                                        'glyphicon-chevron-down': Saf21aSortColumn=='saf21a16_total_qty' && Saf21aSortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnSaf21aTableSorting('saf21a51_gift_qty')">
                                    贈品數量
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Saf21aSortColumn!='saf21a51_gift_qty', 
                                        'glyphicon-chevron-up': Saf21aSortColumn=='saf21a51_gift_qty' && Saf21aSortOrder=='asc',
                                        'glyphicon-chevron-down': Saf21aSortColumn=='saf21a51_gift_qty' && Saf21aSortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnSaf21aTableSorting('saf21a56_box_qty')">
                                    大單位數量
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Saf21aSortColumn!='saf21a56_box_qty', 
                                        'glyphicon-chevron-up': Saf21aSortColumn=='saf21a56_box_qty' && Saf21aSortOrder=='asc',
                                        'glyphicon-chevron-down': Saf21aSortColumn=='saf21a56_box_qty' && Saf21aSortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnSaf21aTableSorting('inf0164_dividend')">
                                    大單位換算值
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Saf21aSortColumn!='inf0164_dividend', 
                                        'glyphicon-chevron-up': Saf21aSortColumn=='inf0164_dividend' && Saf21aSortOrder=='asc',
                                        'glyphicon-chevron-down': Saf21aSortColumn=='inf0164_dividend' && Saf21aSortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnSaf21aTableSorting('saf21a57_qty')">
                                    小單位
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Saf21aSortColumn!='saf21a57_qty', 
                                        'glyphicon-chevron-up': Saf21aSortColumn=='saf21a57_qty' && Saf21aSortOrder=='asc',
                                        'glyphicon-chevron-down': Saf21aSortColumn=='saf21a57_qty' && Saf21aSortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnSaf21aTableSorting('saf21a37_utax_price')">
                                    未稅單價
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Saf21aSortColumn!='saf21a37_utax_price', 
                                        'glyphicon-chevron-up': Saf21aSortColumn=='saf21a37_utax_price' && Saf21aSortOrder=='asc',
                                        'glyphicon-chevron-down': Saf21aSortColumn=='saf21a37_utax_price' && Saf21aSortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnSaf21aTableSorting('saf21a13_tax')">
                                    營業稅
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Saf21aSortColumn!='saf21a13_tax', 
                                        'glyphicon-chevron-up': Saf21aSortColumn=='saf21a13_tax' && Saf21aSortOrder=='asc',
                                        'glyphicon-chevron-down': Saf21aSortColumn=='saf21a13_tax' && Saf21aSortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnSaf21aTableSorting('saf21a11_unit_price')">
                                    含稅單價
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Saf21aSortColumn!='saf21a11_unit_price', 
                                        'glyphicon-chevron-up': Saf21aSortColumn=='saf21a11_unit_price' && Saf21aSortOrder=='asc',
                                        'glyphicon-chevron-down': Saf21aSortColumn=='saf21a11_unit_price' && Saf21aSortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnSaf21aTableSorting('saf21a50_one_amt')">
                                    金額小計
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Saf21aSortColumn!='saf21a50_one_amt', 
                                        'glyphicon-chevron-up': Saf21aSortColumn=='saf21a50_one_amt' && Saf21aSortOrder=='asc',
                                        'glyphicon-chevron-down': Saf21aSortColumn=='saf21a50_one_amt' && Saf21aSortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnSaf21aTableSorting('remark')">
                                    備註
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Saf21aSortColumn!='remark', 
                                        'glyphicon-chevron-up': Saf21aSortColumn=='remark' && Saf21aSortOrder=='asc',
                                        'glyphicon-chevron-down': Saf21aSortColumn=='remark' && Saf21aSortOrder=='desc'}">
                                    </span>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="saf21aItem in Saf21aList" 
                                v-on:click="OnSubRowClick(saf21aItem)"
                                v-bind:class="{'selected-row':saf21aItem==SelectedSaf21aItem}"
                                >
                                <td>{{saf21aItem.saf21a02_seq}}</td>
                                <td>{{saf21aItem.saf21a02_pcode}}</td>
                                <td>{{saf21aItem.saf21a03_relative_no }}</td>
                                <td>{{saf21aItem.saf21a41_product_name }}</td>
                                <td>{{saf21aItem.saf21a43_runit }}</td>
                                <td>{{saf21aItem.saf21a16_total_qty }}</td>
                                <td>{{saf21aItem.saf21a51_gift_qty }}</td>
                                <td>{{saf21aItem.saf21a56_box_qty }}</td>
                                <td>{{saf21aItem.inf0164_dividend }}</td>
                                <td>{{saf21aItem.saf21a57_qty }}</td>
                                <td>{{saf21aItem.saf21a37_utax_price }}</td>
                                <td>{{saf21aItem.saf21a13_tax }}</td>
                                <td>{{saf21aItem.saf21a11_unit_price }}</td>
                                <td>{{saf21aItem.saf21a50_one_amt }}</td>
                                <td>{{saf21aItem.remark }}</td>
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
            <li>{{"Dsap02101 客戶訂單資料維護 <%=this.AppVersion %>"}}
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
                    v-on:click.native="OnDelete(Saf21Item)">
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
                                    v-model="Saf21Item.BCodeInfo"
                                    v-bind:options="BcodeList"
                                    v-bind:close-on-select="true"
                                    v-bind:placeholder="''"
                                    v-bind:show-labels="false" 
                                    v-bind:custom-label="BcodeSelectLabel"
                                    track-by="cnf0701_bcode"
                                    label="cnf0703_bfname">
                                </multiselect>
                            </td>
                            <td>訂單單號
                            </td>
                            <td>
                                <input type="text" v-model="Saf21Item_Saf2101DocNo" disabled="disabled"/>
                            </td>
                            <td>訂單日期
                            </td>
                            <td>
                                <input type="text" v-model="Saf21Item.saf2106_order_date"  disabled="disabled"/>
                            </td>
                            <td>
                                    訂單人員
                            </td>
                            <td>
                                <span class="ref-inputs">
                                    <input type="text" v-model="Saf21Item.saf2147_recid" v-on:change="GetEmpCname(Saf21Item.saf2147_recid)"/>
                                    <input type="text" v-model="Inf29Item.EmpCname" disabled="disabled"/>

                                </span>
                            </td>
                           
                        </tr>
                        <tr>
                             <td>
                                客戶編號
                            </td>
                            <td>
                                <input type="text" v-model="Saf21Item.saf2108_customer_code" v-on:change="OnCustomCodeChange"/>
                                <input type="text" v-model="Saf21Item.cmf0103_bname" disabled="disabled"/>
                            </td>
                            <td>
                                客戶聯絡人
                            </td>
                            <td>
                                <input type="text" v-model="Saf21Item.cmf01a05_fname"  disabled="disabled"/>
                            </td>
                            <td>
                                連絡電話
                            </td>
                            <td>
                                <span class="key-value-inputs">
                                    <input type="text" v-model="Saf21Item.cmf01a17_telo1" disabled="disabled"/>
                                </span>
                            </td>
                            <td>
                                手機
                            </td>
                            <td >
                                <input type="text" style="width:99%;" v-model="Saf21Item.cmf01a23_cellphone" disabled="disabled"/>
                            </td>
                            
                        </tr>
                        <tr>
                            <td>
                                幣值別
                            </td>
                            <td >
                                <multiselect class="small-field"
                                    v-model="Saf21Item.SelectedCurrencyInfo"
                                    v-bind:options="CurrencyList"
                                    v-bind:close-on-select="true"
                                    v-bind:placeholder="''"
                                    v-bind:show-labels="false" 
                                    v-on:select="GetExchangeInfo"
                                    v-bind:custom-label="CurrencySelectLabel"
                                    track-by="cnf1002_fileorder"
                                    label="cnf1003_char01">
                                </multiselect>
                            </td>
                            <td>
                                匯率
                            </td>
                            <td>
                                <span>
                                    <input type="text" class="small-field" v-model="Saf21Item.saf2129_exchange_rate" disabled="disabled"/>
                                </span>
                            </td>
                            <td>
                                付款方式
                            </td>
                            <td>
                                <input type="text" v-model="Saf21Item.saf2114_payment" v-on:change="OnPaymentChange"/>
                                <input type="text" v-bind:value="Saf21Item.cnf1003_char01" disabled="disabled"/>
                            </td>
                            <td>
                                應交貨日期
                            </td>
                            <td>
                                <vue-datetimepicker placeholder="" ref="ProDate" v-model="Saf21Item.saf2110_del_date"></vue-datetimepicker>
                            </td>
                           
                        </tr>
                        <tr>
                             <td>
                                收貨地址
                            </td>
                            <td colspan ="5">
                                    <input type="text" style="width:100%;" v-bind:value="Saf21Item.cmf0110_oaddress" disabled="disabled" />
                            </td>
                            <td>
                                總金額
                            </td>
                            <td>
                                <input type="text"  v-model="Saf21aTotalPrice" disabled="disabled"/>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                備註
                            </td>
                            <td colspan="7">
                                    <input type="text" style="width:100%;" class="small-field" v-model="Saf21Item.Remark" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                新增者
                            </td>
                            <td>
                                <span class="key-value-inputs">
                                    <input type="text" v-model="Saf21Item.adduser" disabled ="disabled"/>
                                </span>
                            </td>
                            <td>
                                新增日期
                            </td>
                            <td>
                                    <input type="text" v-model="Saf21Item.adddate" disabled ="disabled"/>
                            </td>
                            <td>
                                修改者
                            </td>
                            <td>
                               <input type="text" v-model="Saf21Item.moduser" disabled ="disabled"/>
                            </td>
                            <td>
                                修改日期
                            </td>
                            <td>
                               <input type="text" v-model="Saf21Item.moddate" disabled ="disabled"/>

                            </td>
                        </tr>
                        <tr>
                            

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
                                    <input type="text" v-model="Saf21aItem.saf21a02_pcode" v-on:change="OnPcodeChange(Saf21aItem.saf21a02_pcode)"/>
                                    <input type="text" v-model="Saf21aItem.saf21a41_product_name" disabled="disabled"/>
                                    <button type="button" class="btn btn-default btn-xs" v-on:click="ShowDpCodeWindow">
                                        <i class="fa fa-search"></i>
                                    </button>
                                </span>
                                <span>
                                    貨號
                                </span>
                                <span>
                                    <input type="text" class="small-field" v-model="Saf21aItem.saf21a03_relative_no" disabled="disabled"/>
                                </span>
                            </td>
                            <td>
                                單位
                            </td>
                            <td>
                                <input type="text" class="x-small-field" v-model="Saf21aItem.saf21a43_runit" disabled="disabled"/>
                            </td>

                            <td>
                                未稅單價
                            </td>
                            <td>
                                <input type="text" class="small-field" v-model="Saf21aItem.saf21a37_utax_price" disabled="disabled"/>
                            </td>
                            <td>
                                營業稅
                            </td>
                            <td>
                                <input type="text" class="small-field" v-model="Saf21aItem.saf21a13_tax" disabled="disabled"/>
                            </td>

                        </tr>
                        <tr>
                            <td>
                                含稅單價
                            </td>
                            <td>
                                <input type="text" class="small-field" v-model="Saf21aItem.saf21a11_unit_price" disabled="disabled"/>
                            </td>
                            <td>
                                訂單數量
                            </td>
                            <td>
                                <input type="text" class="small-field" v-model="Saf21aItem_Total_Qty" />
                            </td>
                            <td>
                                贈品數量
                            </td>
                            <td>
                                <input type="text" class="small-field" v-model="Saf21aItem.saf21a51_gift_qty" />
                            </td>
                            <td>
                                大單位數
                            </td>
                            <td>
                                <input type="text" class="small-field" v-bind:value="Saf21aItem.saf21a56_box_qty" />
                            </td>
                            <td>
                                換算值
                            </td>
                            <td>
                                <input type="text" class="small-field" v-bind:value="Saf21aItem.inf0164_dividend" disabled="disabled"/>
                            </td>
                            <td>
                                小單位數量
                            </td>
                            <td>
                                <input type="text" class="small-field" v-model="Saf21aItem.saf21a57_qty"  />
                            </td>
                            

                        </tr>
                        <tr>
                            <td>
                                差額
                            </td>
                            <td>
                                <input type="text" class="small-field"v-model="Saf21aItem.saf21a49_odds_amt"/>
                            </td>
                            <td>
                            <td>
                                金額小記
                            </td>
                            <td>
                                <input type="text" class="small-field" v-bind:value="Saf21aItem_Saf21a50OneAmt" disabled="disabled"/>
                            </td>
                            <td>
                                備註
                            </td>
                            <td colspan="5">
                                <input type="text" class="small-field" v-model="Saf21aItem.Remark" style="width:100%;"/>
                            </td>
                            <td colspan="2">
                                <button type="button" class="btn btn-default" role='button' v-on:click="OnAddSaf21aItem()">
                                    輸入明細
                                </button>
                                <button type="button" class="btn btn-default" role='button' v-on:click="OnDeleteSaf21aItem">
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
                                <th v-on:click="OnTableSorting('saf21a02_seq')">
                                    項次
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':SortColumn!='saf21a02_seq', 
                                        'glyphicon-chevron-up': SortColumn=='saf21a02_seq' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='saf21a02_seq' && SortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnTableSorting('saf21a02_pcode')">
                                    產品編號
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':SortColumn!='saf21a02_pcode', 
                                        'glyphicon-chevron-up': SortColumn=='saf21a02_pcode' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='saf21a02_pcode' && SortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnTableSorting('saf21a41_product_name')">
                                    產品名稱
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':SortColumn!='saf21a41_product_name', 
                                        'glyphicon-chevron-up': SortColumn=='saf21a41_product_name' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='saf21a41_product_name' && SortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnTableSorting('saf21a43_runit')">
                                    單位
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':SortColumn!='saf21a43_runit', 
                                        'glyphicon-chevron-up': SortColumn=='saf21a43_runit' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='saf21a43_runit' && SortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnTableSorting('saf21a56_box_qty')">
                                    大單位數量
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':SortColumn!='saf21a56_box_qty', 
                                        'glyphicon-chevron-up': SortColumn=='saf21a56_box_qty' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='saf21a56_box_qty' && SortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnTableSorting('inf0164_dividend')">
                                    換算值
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':SortColumn!='inf0164_dividend', 
                                        'glyphicon-chevron-up': SortColumn=='inf0164_dividend' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='inf0164_dividend' && SortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnTableSorting('saf21a57_qty')">
                                    小單位數量
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':SortColumn!='saf21a57_qty', 
                                        'glyphicon-chevron-up': SortColumn=='saf21a57_qty' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='saf21a57_qty' && SortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnTableSorting('saf21a16_total_qty')">
                                    小計數量
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':SortColumn!='saf21a16_total_qty', 
                                        'glyphicon-chevron-up': SortColumn=='saf21a16_total_qty' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='saf21a16_total_qty' && SortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnTableSorting('saf21a11_unit_price')">
                                    單價
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':SortColumn!='saf21a11_unit_price', 
                                        'glyphicon-chevron-up': SortColumn=='saf21a11_unit_price' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='saf21a11_unit_price' && SortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnTableSorting('saf21a50_one_amt')">
                                    小計
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':SortColumn!='saf21a50_one_amt', 
                                        'glyphicon-chevron-up': SortColumn=='saf21a50_one_amt' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='saf21a50_one_amt' && SortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnTableSorting('Remark')">
                                    備註
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':SortColumn!='Remark', 
                                        'glyphicon-chevron-up': SortColumn=='Remark' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='Remark' && SortOrder=='desc'}">
                                    </span>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="saf21aItem in Saf21aList" 
                                v-on:click="OnRowClick(saf21aItem)"
                                v-bind:class="{'selected-row':saf21aItem==SelectedSaf21aItem}"
                                >
                                <!-- 項次 -->
                                <td>{{saf21aItem.saf21a02_seq}}</td>
                                <!-- 產品編號 -->
                                <td>{{saf21aItem.saf21a02_pcode}}</td>
                                <!-- 產品名稱 -->
                                <td>{{saf21aItem.saf21a41_product_name}}</td>
                                <!-- 單位 -->
                                <td>{{saf21aItem.saf21a43_runit }}</td>
                                <!-- 大單位數量 -->
                                <td>{{saf21aItem.saf21a56_box_qty }}</td>
                                <!-- 換算值 -->
                                <td>{{saf21aItem.inf0164_dividend }}</td>
                                <!-- 小單位數量 -->
                                <td>{{saf21aItem.saf21a57_qty }}</td>
                                <!-- 小計數量 -->
                                <td>{{saf21aItem.saf21a16_total_qty }}</td>
                                <!-- 單價 -->
                                <td>{{saf21aItem.saf21a11_unit_price }}</td>
                                <!-- 小計 -->
                                <td>{{saf21aItem.saf21a50_one_amt }}</td>
                                <!-- 備註 -->
                                <td>{{saf21aItem.Remark }}</td>
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
                    <input type="text" class="small-field" v-model="Saf21aTotalAmount" disabled="disabled"/>
                    <span>
                        總金額
                    </span>
                    <input type="text" class="small-field" v-model="Saf21aTotalPrice" disabled="disabled"/>
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
            <%--var InReasonList = JSON.parse("<%=HttpUtility.JavaScriptStringEncode(JsonConvert.SerializeObject(InReasonList),false)%>");--%>
            var CurrencyList = JSON.parse("<%=HttpUtility.JavaScriptStringEncode(JsonConvert.SerializeObject(CurrencyList),false)%>");

            requirejs.config({
                paths: {
                    "dsap02101Search": "Dsap02101/dsap02101Search",
                    "dsap02101Edit": "Dsap02101/dsap02101Edit",
                },
                shim: {}
            });

            var requiredFiles = ["dsap02101Search", "dsap02101Edit"];

            function onLoaded(dsap02101Search, dsap02101Edit) {
                window.dsap02101Search.SetBCodeList(BcodeList);
                window.dsap02101Edit.SetBCodeList(BcodeList);
                //window.dinp02301Search.WherehouseList = WherehouseList;
                //window.dinp02301Edit.WherehouseList = WherehouseList;
                //window.dsap02101Edit.InReasonList = InReasonList;
                window.dsap02101Edit.CurrencyList = CurrencyList;
            }

            function onError(error) {
                console.error(error);
            }

            require(requiredFiles, onLoaded, onError);
        })();
    </script>

</asp:Content>

