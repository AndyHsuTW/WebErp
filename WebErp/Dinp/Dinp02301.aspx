<%@ Page Language="C#" MasterPageFile="~/master/BaseMasterPage.master" AutoEventWireup="true" CodeFile="Dinp02301.aspx.cs" Inherits="Dinp_Dinp02301" %>

<%@ Import Namespace="System.Web.Hosting" %>
<%@ Import Namespace="Newtonsoft.Json" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.3500.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

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
        /* multiselect default end */

        .app-title
        {
            background-color: #3097D1;
            color: #FFF;
        }

        .app-body,
        {
            padding-left: 5px;
            min-width: 1080px;
        }

        .filter-div,
        .editParam-div
        {
            margin-top: 5px;
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
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <% string rootUrl = HostingEnvironment.ApplicationVirtualPath.Length > 1 ? HostingEnvironment.ApplicationVirtualPath + "/" : HostingEnvironment.ApplicationVirtualPath; %>

    <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="true" />

    <div id="Dinp02301Search" v-if="Display" v-cloak>
        <ul class="app-title">
            <li>{{"庫存異動資料查詢 <%=this.AppVersion %>"}}
            </li>
        </ul>
        <div class="app-body">
            <div class="common-button-div">
                <function-button id="SearchBtn"
                    hot-key="f1"
                    v-on:click.native="OnSearch()">
                            查詢
                        </function-button>
                <function-button id="AddBtn" data-toggle="modal" href='#EditDialog'
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
                <function-button id="PrintBtn" data-toggle="modal" href='#ExportDialog'
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
                    hot-key="f8">
                            匯入Excel
                        </function-button>
                <function-button id="HelpBtn" data-toggle="modal" href='#HelpDialog'
                    hot-key="f11">
                            求助
                        </function-button>
            </div>
            <div class="filter-div">
                <table class="">
                    <tbody>
                        <tr>
                            <td>異動日期
                                <span>起~</span>
                            </td>
                            <td>
                                <vue-datetimepicker placeholder=""
                                    v-model="Filter.ProDateStart"
                                    v-on:change="AutoFillFilter('ProDateEnd',Filter.ProDateStart,'datetime')"></vue-datetimepicker>
                                迄~
                                <vue-datetimepicker id="FilterProDateEnd" ref="FilterProDateEnd" placeholder=""
                                    v-model="Filter.ProDateEnd"></vue-datetimepicker>
                            </td>
                            <td>商品編號
                                <span>起~</span>
                            </td>
                            <td>
                                <input type="text" v-model="Filter.PcodeStart"
                                    v-on:change="AutoFillFilter('PcodeEnd',Filter.PcodeStart)" />
                                迄~
                                <input type="text" v-model="Filter.PcodeEnd" />
                            </td>
                        </tr>
                        <tr>
                            <td>專案代號
                                <span>起~</span>
                            </td>
                            <td>
                                <input type="text" v-model="Filter.ProjectNoStart"
                                    v-on:change="AutoFillFilter('ProjectNoEnd',Filter.ProjectNoStart)" />
                                迄~
                                <input type="text" v-model="Filter.ProjectNoEnd" />
                            </td>
                            <td>產品貨號
                                <span>起~</span>
                            </td>
                            <td>
                                <input type="text" v-model="Filter.ShoesCodeStart"
                                    v-on:change="AutoFillFilter('ShoesCodeEnd',Filter.ShoesCodeStart)" />
                                迄~
                                <input type="text" v-model="Filter.ShoesCodeEnd" />
                            </td>
                        </tr>
                        <tr>
                            <td>倉庫代號
                                <span>起~</span>
                            </td>
                            <td>
                                <input type="text" v-model="Filter.WherehouseStart"
                                    v-on:change="AutoFillFilter('WherehouseEnd',Filter.WherehouseStart)" />
                                迄~
                                <input type="text" v-model="Filter.WherehouseEnd" />
                            </td>
                            <td>異動代碼
                                <span>起~</span>
                            </td>
                            <td>
                                <input type="text" v-model="Filter.InReasonStart"
                                    v-on:change="AutoFillFilter('InReasonEnd',Filter.InReasonStart)" />
                                迄~
                                <input type="text" v-model="Filter.InReasonEnd" />
                            </td>
                        </tr>
                        <tr>
                            <td>異動單位
                                <span>起~</span>
                            </td>
                            <td>
                                <input type="text" v-model="Filter.CustomerCodeStart"
                                    v-on:change="AutoFillFilter('CustomerCodeEnd',Filter.CustomerCodeStart)" />
                                迄~
                                <input type="text" v-model="Filter.CustomerCodeEnd" />
                            </td>
                            <td>新增日期
                                <span>起~</span>
                            </td>
                            <td>
                                <vue-datetimepicker placeholder=""
                                    v-model="Filter.AdddateStart"
                                    v-on:change="AutoFillFilter('AdddateEnd',Filter.AdddateStart,'datetime')"></vue-datetimepicker>
                                迄~
                                <vue-datetimepicker id="FilterAdddateEnd" ref="FilterAdddateEnd" placeholder=""
                                    v-model="Filter.AdddateEnd"></vue-datetimepicker>
                            </td>
                        </tr>
                        <tr>
                            <td>公司代號
                                <span>起~</span>
                            </td>
                            <td>
                                <input type="text" v-model="Filter.BcodeStart"
                                    v-on:change="AutoFillFilter('BcodeEnd',Filter.BcodeStart)" />
                                迄~
                                <input type="text" v-model="Filter.BcodeEnd" />
                            </td>
                            <td>來源單據
                                <span>起~</span>
                            </td>
                            <td>
                                <span class="ref-inputs">
                                    <input type="text" v-model="Filter.RefNoTypeStart"
                                        v-on:change="AutoFillFilter('RefNoTypeEnd',Filter.RefNoTypeStart)" />
                                    <input type="text" v-model="Filter.RefNoTypeDateStart"
                                        v-on:change="AutoFillFilter('RefNoTypeDateEnd',Filter.RefNoTypeDateStart)" />
                                    <input type="text" v-model="Filter.RefNoTypeSeqStart"
                                        v-on:change="AutoFillFilter('RefNoTypeSeqEnd',Filter.RefNoTypeSeqStart)" />
                                </span>

                                迄~
                                <span class="ref-inputs">
                                    <input type="text" v-model="Filter.RefNoTypeEnd" />
                                    <input type="text" v-model="Filter.RefNoTypeDateEnd" />
                                    <input type="text" v-model="Filter.RefNoTypeSeqEnd" />
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <td>關鍵字
                            </td>
                            <td>
                                <input type="text" v-model="Filter.Keyword">
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
                                <th v-on:click="OnTableSorting('Inf2902DocNoShort')">異動單號

                                </th>
                                <th v-on:click="OnTableSorting('inf2904_pro_date')">異動日期
                                    
                                </th>
                                <th v-on:click="OnTableSorting('inf2906_wherehouse')">倉庫
                                    
                                </th>
                                <th v-on:click="OnTableSorting('cnf0506_program')">數量
                                    
                                </th>
                                <th v-on:click="OnTableSorting('adddate')">專案代號
                                   
                                </th>
                                <th v-on:click="OnTableSorting('adduser')">異動代號及中文

                                </th>
                                <th v-on:click="OnTableSorting('moddate')">來源單號

                                </th>
                                <th v-on:click="OnTableSorting('moduser')">客戶代號/名稱

                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="inf29Item in Inf29List" 
                                v-on:click="OnMainRowClick(inf29Item)"
                                v-bind:class="{'selected-row':inf29Item==SelectedInf29Item}">
                                <td>{{inf29Item.Inf2902DocNoShort }}</td>
                                <td>{{inf29Item.inf2904_pro_date}}</td>
                                <td>{{inf29Item.inf2906_wherehouse}}</td>
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
                                <th v-on:click="OnTableSorting('Inf2902DocNoShort')">
                                    序號
                                </th>
                                <th v-on:click="OnTableSorting('inf2904_pro_date')">
                                    產品編號
                                </th>
                                <th v-on:click="OnTableSorting('inf2906_wherehouse')">
                                    貨號
                                </th>
                                <th v-on:click="OnTableSorting('cnf0506_program')">
                                    產品簡稱
                                </th>
                                <th v-on:click="OnTableSorting('adduser')">
                                    單位
                                </th>
                                <th v-on:click="OnTableSorting('adddate')">
                                    數量
                                </th>
                                <th v-on:click="OnTableSorting('adddate')">
                                    折扣
                                </th>
                                <th v-on:click="OnTableSorting('moddate')">
                                    原價
                                </th>
                                <th v-on:click="OnTableSorting('moduser')">
                                    進價
                                </th>
                                <th v-on:click="OnTableSorting('moduser')">
                                    金額小記
                                </th>
                                <th v-on:click="OnTableSorting('moduser')">
                                    備註
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
                                <!-- 金額小記 -->
                                <td>{{inf29aItem.inf29a38_one_amt }}</td>
                                <!-- 備註 -->
                                <td>{{inf29aItem.remark }}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <div id="Dinp02301Edit" v-if="Display" v-cloak>
        <ul class="app-title">
            <li>{{"庫存異動資料維護 <%=this.AppVersion %>"}}
            </li>
        </ul>
        <div class="app-body">
            <div class="common-button-div">
                <function-button id="Function-button3"
                    hot-key="f1"
                    v-on:click.native="OnExit()">
                    查詢
                </function-button>
                <function-button id="Function-button4" data-toggle="modal" href='#EditDialog'
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
                <function-button id="SaveBtn"
                    hot-key="f5"
                    v-on:click.native="OnSave()">
                    存檔
                </function-button>
                <function-button id="PrintBtn" data-toggle="modal" href='#ExportDialog'
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
                    hot-key="f8">
                    匯入Excel
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
                                    <button type="button" class="btn btn-default btn-xs" role='button' data-toggle="modal" href='#DPcodeDialog'>
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
                                幣值別
                            </td>
                            <td>
                                <multiselect class="small-field"
                                    v-model="Inf29aItem.SelectedCurrencyInfo"
                                    v-bind:options="CurrencyList"
                                    v-bind:close-on-select="true"
                                    v-bind:placeholder="''"
                                    v-bind:show-labels="false" 
                                    v-on:select="GetExchangeInfo"
                                    track-by="cnf1003_char01"
                                    label="cnf1003_char01">
                                </multiselect>
                            </td>
                            <td>
                                匯率
                            </td>
                            <td>
                                <input type="text" class="small-field" v-model="Inf29aItem.inf29a32_exchange_rate" disabled="disabled"/>
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
                                <th v-on:click="OnTableSorting('Inf2902DocNoShort')">
                                    項次
                                </th>
                                <th v-on:click="OnTableSorting('inf2904_pro_date')">
                                    產品編號
                                </th>
                                <th v-on:click="OnTableSorting('inf2906_wherehouse')">
                                    貨號
                                </th>
                                <th v-on:click="OnTableSorting('cnf0506_program')">
                                    產品簡稱
                                </th>
                                <th v-on:click="OnTableSorting('adddate')">
                                    數量
                                </th>
                                <th v-on:click="OnTableSorting('adddate')">
                                    折扣
                                </th>
                                <th v-on:click="OnTableSorting('adduser')">
                                    單位
                                </th>
                                <th v-on:click="OnTableSorting('moddate')">
                                    原價
                                </th>
                                <th v-on:click="OnTableSorting('moduser')">
                                    進價
                                </th>
                                <th v-on:click="OnTableSorting('moduser')">
                                    金額小記
                                </th>
                                <th v-on:click="OnTableSorting('moduser')">
                                    確認
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
                                <!-- 金額小記 -->
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
            <div class="modal fade" id="DPcodeDialog">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title">商品資料查詢</h4>
                        </div>
                        <div class="modal-body">
                            <iframe src="<%=rootUrl %>D_pcode/D_pcode.aspx" style="width:100%;height: 500px;">
                            </iframe>
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


    <script>
        (function () {
            var BcodeList = JSON.parse("<%=HttpUtility.JavaScriptStringEncode(JsonConvert.SerializeObject(BcodeList),false)%>");
            var WherehouseList = JSON.parse("<%=HttpUtility.JavaScriptStringEncode(JsonConvert.SerializeObject(WherehouseList),false)%>");
            var InReasonList = JSON.parse("<%=HttpUtility.JavaScriptStringEncode(JsonConvert.SerializeObject(InReasonList),false)%>");
            var CurrencyList = JSON.parse("<%=HttpUtility.JavaScriptStringEncode(JsonConvert.SerializeObject(CurrencyList),false)%>");

            requirejs.config({
                paths: {
                    "dinp02301Search": "Dinp/dinp02301Search",
                    "dinp02301Edit": "Dinp/dinp02301Edit",
                },
                shim: {}
            });

            var requiredFiles = ["dinp02301Search", "dinp02301Edit"];

            function onLoaded(dinp02301Search, dinp02301Edit) {
                window.dinp02301Edit.BcodeList = BcodeList;
                window.dinp02301Edit.WherehouseList = WherehouseList;
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

