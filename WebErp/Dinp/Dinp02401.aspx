<%@ Page Language="C#" MasterPageFile="~/master/BaseMasterPage.master" AutoEventWireup="true" CodeFile="Dinp02401.aspx.cs" Inherits="Dinp_Dinp02401" %>

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

    <div id="Dinp02401Search" v-if="Display" v-cloak>
        <ul class="app-title">
            <li>{{"Dinp02401 庫存異動資料查詢 <%=this.AppVersion %>"}}
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
                            <td>銷貨日期
                                <span>起~</span>
                            </td>
                            <td>
                                <vue-datetimepicker placeholder="" class="medium-field"
                                    v-model="Filter.ProDateStart"
                                    v-on:change="AutoFillFilter('ProDateEnd',Filter.ProDateStart,'datetime')"></vue-datetimepicker>
                                迄~
                                <vue-datetimepicker id="FilterProDateEnd" class="medium-field" ref="FilterProDateEnd" placeholder=""
                                    v-model="Filter.ProDateEnd"></vue-datetimepicker>
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
                            <td>專案代號
                                <span>起~</span>
                            </td>
                            <td>
                                <input type="text" class="medium-field" v-model="Filter.ProjectNoStart"
                                    v-on:change="AutoFillFilter('ProjectNoEnd',Filter.ProjectNoStart)" />
                                迄~
                                <input type="text" class="medium-field" v-model="Filter.ProjectNoEnd" />
                            </td>
                            <td>產品貨號
                                <span>起~</span>
                            </td>
                            <td>
                                <input type="text" class="medium-field" v-model="Filter.PCodeVStart"
                                    v-on:change="AutoFillFilter('PCodeVEnd',Filter.PCodeVStart)" />
                                迄~
                                <input type="text" class="medium-field" v-model="Filter.PCodeVEnd" />
                            </td>
                        </tr>
                        <tr>
                            <td>倉庫代號
                                <span>起~</span>
                            </td>
                            <td>
                                <multiselect class="medium-field"
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
                                <multiselect class="medium-field"
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
                                <input type="text" class="medium-field" v-model="Filter.InReasonStart"
                                    v-on:change="AutoFillFilter('InReasonEnd',Filter.InReasonStart)" />
                                迄~
                                <input type="text" class="medium-field" v-model="Filter.InReasonEnd" />
                            </td>
                        </tr>
                        <tr>
                            <td>異動單位
                                <span>起~</span>
                            </td>
                            <td>
                                <input type="text" class="medium-field" v-model="Filter.CustomerCodeStart"
                                    v-on:change="AutoFillFilter('CustomerCodeEnd',Filter.CustomerCodeStart)" />
                                迄~
                                <input type="text" class="medium-field" v-model="Filter.CustomerCodeEnd" />
                            </td>
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
                            <td>來源單據
                                <span>起~</span>
                            </td>
                            <td>
                                <span class="ref-inputs">
                                    <input type="text" v-model="Filter.RefNoTypeStart"
                                        v-on:change="AutoFillFilter('RefNoTypeEnd',Filter.RefNoTypeStart)" />
                                    <input type="text" v-model="Filter.RefNoDateStart"
                                        v-on:change="AutoFillFilter('RefNoDateEnd',Filter.RefNoDateStart)" />
                                    <input type="text" v-model="Filter.RefNoSeqStart"
                                        v-on:change="AutoFillFilter('RefNoSeqEnd',Filter.RefNoSeqStart)" />
                                </span>

                                迄~
                                <span class="ref-inputs">
                                    <input type="text" v-model="Filter.RefNoTypeEnd" />
                                    <input type="text" v-model="Filter.RefNoDateEnd" />
                                    <input type="text" v-model="Filter.RefNoSeqEnd" />
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <td>關鍵字
                            </td>
                            <td>
                                <input type="text" class="medium-field" v-model="Filter.Keyword">
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
                                <th v-on:click="OnSaf20TableSorting('Saf2002DocNoShort')">
                                    異動單號
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Saf20SortColumn!='Saf2002DocNoShort', 
                                        'glyphicon-chevron-up': Saf20SortColumn=='Saf2002DocNoShort' && Saf20SortOrder=='asc',
                                        'glyphicon-chevron-down': Saf20SortColumn=='Saf2002DocNoShort' && Saf20SortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnSaf20TableSorting('Saf2004_pro_date')">
                                    異動日期
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Saf20SortColumn!='Saf2004_pro_date', 
                                        'glyphicon-chevron-up': Saf20SortColumn=='Saf2004_pro_date' && Saf20SortOrder=='asc',
                                        'glyphicon-chevron-down': Saf20SortColumn=='Saf2004_pro_date' && Saf20SortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnSaf20TableSorting('Saf2006_wherehouse')">
                                    倉庫
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Saf20SortColumn!='Saf2006_wherehouse', 
                                        'glyphicon-chevron-up': Saf20SortColumn=='Saf2006_wherehouse' && Saf20SortOrder=='asc',
                                        'glyphicon-chevron-down': Saf20SortColumn=='Saf2006_wherehouse' && Saf20SortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnSaf20TableSorting('Qty')">
                                    數量
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Saf20SortColumn!='Qty', 
                                        'glyphicon-chevron-up': Saf20SortColumn=='Qty' && Saf20SortOrder=='asc',
                                        'glyphicon-chevron-down': Saf20SortColumn=='Qty' && Saf20SortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnSaf20TableSorting('Saf2052_project_no')">
                                    專案代號
                                    <span class="sort-item glyphicon" 
                                    v-bind:class="{'glyphicon-sort':Saf20SortColumn!='Saf2052_project_no', 
                                    'glyphicon-chevron-up': Saf20SortColumn=='Saf2052_project_no' && Saf20SortOrder=='asc',
                                    'glyphicon-chevron-down': Saf20SortColumn=='Saf2052_project_no' && Saf20SortOrder=='desc'}">
                                </span>
                                </th>
                                <th v-on:click="OnSaf20TableSorting('Saf2010_in_reason')">
                                    異動代號及中文
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Saf20SortColumn!='Saf2010_in_reason', 
                                        'glyphicon-chevron-up': Saf20SortColumn=='Saf2010_in_reason' && Saf20SortOrder=='asc',
                                        'glyphicon-chevron-down': Saf20SortColumn=='Saf2010_in_reason' && Saf20SortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnSaf20TableSorting('Saf2006RefNo')">
                                    來源單號
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Saf20SortColumn!='Saf2006RefNo', 
                                        'glyphicon-chevron-up': Saf20SortColumn=='Saf2006RefNo' && Saf20SortOrder=='asc',
                                        'glyphicon-chevron-down': Saf20SortColumn=='Saf2006RefNo' && Saf20SortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnSaf20TableSorting('Saf2003_customer_code')">
                                    客戶代號/名稱
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Saf20SortColumn!='Saf2003_customer_code', 
                                        'glyphicon-chevron-up': Saf20SortColumn=='Saf2003_customer_code' && Saf20SortOrder=='asc',
                                        'glyphicon-chevron-down': Saf20SortColumn=='Saf2003_customer_code' && Saf20SortOrder=='desc'}">
                                    </span>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="Saf20Item in Saf20List" 
                                v-on:click="OnMainRowClick(Saf20Item)"
                                v-bind:class="{'selected-row':Saf20Item==SelectedSaf20Item}">
                               <%-- <td>{{Saf20Item.Saf2002DocNoShort }}</td>
                                <td>{{Saf20Item.Saf2004_pro_date}}</td>
                                <td>{{ GetWherehouseName(Saf20Item.Saf2006_wherehouse)}}</td>
                                <td>{{Saf20Item.Qty}}</td>
                                <td>{{Saf20Item.Saf2052_project_no}}</td>
                                <td>{{Saf20Item.Saf2010_in_reason }}/{{Saf20Item.Saf2010InReasonName}}</td>
                                <td>{{Saf20Item.Saf2006RefNo}}
                                </td>
                                <td>{{Saf20Item.Saf2003_customer_code}}/{{Saf20Item.Saf2003CustomerCodeName}}</--%>td>

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
                                <th v-on:click="OnSaf20aTableSorting('Saf20a02_seq')">
                                    序號
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Saf20aSortColumn!='Saf20a02_seq', 
                                        'glyphicon-chevron-up': Saf20aSortColumn=='Saf20a02_seq' && Saf20aSortOrder=='asc',
                                        'glyphicon-chevron-down': Saf20aSortColumn=='Saf20a02_seq' && Saf20aSortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnSaf20aTableSorting('Saf20a05_pcode')">
                                    產品編號
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Saf20aSortColumn!='Saf20a05_pcode', 
                                        'glyphicon-chevron-up': Saf20aSortColumn=='Saf20a05_pcode' && Saf20aSortOrder=='asc',
                                        'glyphicon-chevron-down': Saf20aSortColumn=='Saf20a05_pcode' && Saf20aSortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnSaf20aTableSorting('Saf20a05_shoes_code')">
                                    貨號
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Saf20aSortColumn!='Saf20a05_shoes_code', 
                                        'glyphicon-chevron-up': Saf20aSortColumn=='Saf20a05_shoes_code' && Saf20aSortOrder=='asc',
                                        'glyphicon-chevron-down': Saf20aSortColumn=='Saf20a05_shoes_code' && Saf20aSortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnSaf20aTableSorting('Saf20a33_product_name')">
                                    產品簡稱
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Saf20aSortColumn!='Saf20a33_product_name', 
                                        'glyphicon-chevron-up': Saf20aSortColumn=='Saf20a33_product_name' && Saf20aSortOrder=='asc',
                                        'glyphicon-chevron-down': Saf20aSortColumn=='Saf20a33_product_name' && Saf20aSortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnSaf20aTableSorting('Saf20a17_runit')">
                                    單位
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Saf20aSortColumn!='Saf20a17_runit', 
                                        'glyphicon-chevron-up': Saf20aSortColumn=='Saf20a17_runit' && Saf20aSortOrder=='asc',
                                        'glyphicon-chevron-down': Saf20aSortColumn=='Saf20a17_runit' && Saf20aSortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnSaf20aTableSorting('Saf20a13_sold_qty')">
                                    數量
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Saf20aSortColumn!='Saf20a13_sold_qty', 
                                        'glyphicon-chevron-up': Saf20aSortColumn=='Saf20a13_sold_qty' && Saf20aSortOrder=='asc',
                                        'glyphicon-chevron-down': Saf20aSortColumn=='Saf20a13_sold_qty' && Saf20aSortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnSaf20aTableSorting('Saf20a11_dis_rate')">
                                    折扣
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Saf20aSortColumn!='Saf20a11_dis_rate', 
                                        'glyphicon-chevron-up': Saf20aSortColumn=='Saf20a11_dis_rate' && Saf20aSortOrder=='asc',
                                        'glyphicon-chevron-down': Saf20aSortColumn=='Saf20a11_dis_rate' && Saf20aSortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnSaf20aTableSorting('Saf20a10_ocost_one')">
                                    原價
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Saf20aSortColumn!='Saf20a10_ocost_one', 
                                        'glyphicon-chevron-up': Saf20aSortColumn=='Saf20a10_ocost_one' && Saf20aSortOrder=='asc',
                                        'glyphicon-chevron-down': Saf20aSortColumn=='Saf20a10_ocost_one' && Saf20aSortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnSaf20aTableSorting('Saf20a10_cost_one')">
                                    進價
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Saf20aSortColumn!='Saf20a10_cost_one', 
                                        'glyphicon-chevron-up': Saf20aSortColumn=='Saf20a10_cost_one' && Saf20aSortOrder=='asc',
                                        'glyphicon-chevron-down': Saf20aSortColumn=='Saf20a10_cost_one' && Saf20aSortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnSaf20aTableSorting('Saf20a38_one_amt')">
                                    金額小計
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Saf20aSortColumn!='Saf20a38_one_amt', 
                                        'glyphicon-chevron-up': Saf20aSortColumn=='Saf20a38_one_amt' && Saf20aSortOrder=='asc',
                                        'glyphicon-chevron-down': Saf20aSortColumn=='Saf20a38_one_amt' && Saf20aSortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnSaf20aTableSorting('remark')">
                                    備註
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':Saf20aSortColumn!='remark', 
                                        'glyphicon-chevron-up': Saf20aSortColumn=='remark' && Saf20aSortOrder=='asc',
                                        'glyphicon-chevron-down': Saf20aSortColumn=='remark' && Saf20aSortOrder=='desc'}">
                                    </span>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="Saf20aItem in Saf20aList" 
                                v-on:click="OnSubRowClick(Saf20aItem)"
                                v-bind:class="{'selected-row':Saf20aItem==SelectedSaf20aItem}"
                                >
                               <%-- <!-- 項次 -->
                                <td>{{Saf20aItem.Saf20a02_seq}}</td>
                                <!-- 產品編號 -->
                                <td>{{Saf20aItem.Saf20a05_pcode}}</td>
                                <!-- 貨號 -->
                                <td>{{Saf20aItem.Saf20a05_shoes_code}}</td>
                                <!-- 產品簡稱 -->
                                <td>{{Saf20aItem.Saf20a33_product_name }}</td>
                                <!-- 單位 -->
                                <td>{{Saf20aItem.Saf20a17_runit }}</td>
                                <!-- 數量 -->
                                <td>{{Saf20aItem.Saf20a13_sold_qty }}</td>
                                <!-- 折扣 -->
                                <td>{{Saf20aItem.Saf20a11_dis_rate }}%</td>
                                <!-- 原價 -->
                                <td>{{Saf20aItem.Saf20a10_ocost_one }}</td>
                                <!-- 進價 -->
                                <td>{{Saf20aItem.Saf20a10_cost_one }}</td>
                                <!-- 金額小計 -->
                                <td>{{Saf20aItem.Saf20a38_one_amt }}</td>
                                <!-- 備註 -->
                                <td>{{Saf20aItem.remark }}</td>--%>
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
                                    <h4>Saf20</h4>
                                    <button type="button" class="btn btn-default" v-on:click="OnExportAllFieldClick(true)">
                                        全選
                                    </button>
                                    <button type="button" class="btn btn-default" v-on:click="OnExportAllFieldClick(false)">
                                        全不選
                                    </button>
                                    <div class="checkbox" v-for="Saf20Field in Export.Saf20List">
                                        <label>
                                            <input type="checkbox" v-bind:value="Saf20Field.cnf0502_field" v-model="Export.SelectedSaf20List">
                                            {{Saf20Field.cnf0503_fieldname_tw}}
                                        </label>
                                    </div>
                                </div>
                                <div class="col-xs-6">
                                    <h4>Saf20a</h4>
                                    <button type="button" class="btn btn-default" v-on:click="OnExportAllFieldClick(null,true)">
                                        全選
                                    </button>
                                    <button type="button" class="btn btn-default" v-on:click="OnExportAllFieldClick(null,false)">
                                        全不選
                                    </button>
                                    <div class="checkbox" v-for="Saf20aField in Export.Saf20aList">
                                        <label>
                                            <input type="checkbox" v-bind:value="Saf20aField.cnf0502_field" v-model="Export.SelectedSaf20aList">
                                            {{Saf20aField.cnf0503_fieldname_tw}}
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

    <div id="dinp02401Edit" v-if="Display" v-cloak>
        <ul class="app-title">
            <li>{{"Dinp02401 庫存異動資料維護 <%=this.AppVersion %>"}}
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
                                    v-model="Saf20Item.BCodeInfo"
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
                                <input type="text" v-model="Saf20Item_Saf2002DocNo" disabled="disabled"/>
                            </td>
                            <td>異動日期
                            </td>
                            <td>
                                <vue-datetimepicker placeholder="" ref="ProDate"
                                    v-model="Saf20Item.Saf2004_pro_date"></vue-datetimepicker>
                                <span>
                                    單據來源
                                </span>
                                <span class="ref-inputs">
                                    <input type="text" v-model="Saf20Item.Saf2006_ref_no_type" />
                                    <input type="text" v-model="Saf20Item.Saf2006_ref_no_date" />
                                    <input type="text" v-model="Saf20Item.Saf2006_ref_no_seq" />
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                倉庫代號
                            </td>
                            <td>
                                <multiselect
                                    v-model="Saf20Item.SelectedWherehouse"
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
                                    v-model="Saf20Item.SelectedInReason"
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
                                    <input type="text" v-model="Saf20Item.Saf2052_project_no" 
                                        v-on:change="GetProjectFullname(Saf20Item.Saf2052_project_no, Saf20Item.BCodeInfo)"/>
                                    <input type="text" v-model="Saf20Item.ProjectFullname" disabled="disabled"/>
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                備註
                            </td>
                            <td colspan="3">
                                <input type="text" style="width:99%;" v-model="Saf20Item.remark"/>
                            </td>
                            <td>
                                員工
                            </td>
                            <td colspan="3">
                                <span class="key-value-inputs">
                                    <input type="text" v-model="Saf20Item.Saf2016_apr_empid" 
                                        v-on:change="GetEmpCname(Saf20Item.Saf2016_apr_empid)"/>
                                    <input type="text" v-model="Saf20Item.EmpCname" disabled="disabled"/>
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                新增者
                            </td>
                            <td colspan="3">
                                <span>
                                    <input type="text" class="small-field" v-model="Saf20Item.adduser" disabled="disabled"/>
                                </span>
                                新增日期
                                <span>
                                    <input type="text" class="small-field" v-model="Saf20Item.adddate" disabled="disabled"/>
                                </span>
                                修改者
                                <span>
                                    <input type="text" class="small-field" v-model="Saf20Item.moduser" disabled="disabled"/>
                                </span>
                                修改日期
                                <span>
                                    <input type="text" class="small-field" v-model="Saf20Item.moddate" disabled="disabled"/>
                                </span>
                            </td>
                            
                            <td>
                                異動單位
                            </td>
                            <td>
                                <span class="key-value-inputs">
                                    <input type="text" v-model="Saf20Item.Saf2003_customer_code" v-on:change="OnCustomCodeChange"/>
                                    <input type="text" v-model="Saf20Item.Saf2003CustomerCodeName" disabled="disabled"/>
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                幣值別
                            </td>
                            <td>
                                <multiselect class="small-field"
                                    v-model="Saf20Item.SelectedCurrencyInfo"
                                    v-bind:options="CurrencyList"
                                    v-bind:close-on-select="true"
                                    v-bind:placeholder="''"
                                    v-bind:show-labels="false" 
                                    v-on:select="GetExchangeInfo"
                                    track-by="cnf1003_char01"
                                    label="cnf1003_char01">
                                </multiselect>
                                匯率
                                <input type="text" class="small-field" v-model="Saf20Item.Saf2029_exchange_rate" disabled="disabled"/>
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
                                    <input type="text" v-model="Saf20aItem.Saf20a05_pcode" v-on:change="OnPcodeChange(Saf20aItem.Saf20a05_pcode)"/>
                                    <input type="text" v-model="Saf20aItem.Saf20a33_product_name" disabled="disabled"/>
                                    <button type="button" class="btn btn-default btn-xs" v-on:click="ShowDpCodeWindow">
                                        <i class="fa fa-search"></i>
                                    </button>
                                </span>
                                <span>
                                    貨號
                                </span>
                                <span>
                                    <input type="text" class="small-field" v-model="Saf20aItem.Saf20a05_shoes_code" disabled="disabled"/>
                                </span>
                            </td>
                            <td>
                                單位
                            </td>
                            <td>
                                <input type="text" class="x-small-field" v-model="Saf20aItem.Saf20a17_runit" disabled="disabled"/>
                            </td>

                            <td>
                                原進價
                            </td>
                            <td>
                                <input type="text" class="small-field" v-model="Saf20aItem.Saf20a10_ocost_one" disabled="disabled"/>
                            </td>
                            <td>
                                售價
                            </td>
                            <td>
                                <input type="text" class="small-field" v-model="Saf20aItem.Saf20a09_retail_one" disabled="disabled"/>
                            </td>
                            <td>
                                尾差
                            </td>
                            <td>
                                <input type="text" class="small-field" v-model="Saf20aItem.Saf20a36_odds_amt" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                進價
                            </td>
                            <td>
                                <input type="text" class="small-field" v-model="Saf20aItem.Saf20a10_cost_one" disabled="disabled"/>
                            </td>
                            <td>
                                數量
                            </td>
                            <td>
                                <input type="text" class="small-field" v-model="Saf20aItem.Saf20a13_sold_qty" />
                            </td>
                            <td>
                                金額
                            </td>
                            <td>
                                <input type="text" class="small-field" v-bind:value="Saf20aItem_Saf20a38OneAmt" disabled="disabled"/>
                            </td>
                            <td>
                                確認
                            </td>
                            <td>
                                <multiselect class="small-field"
                                    v-model="Saf20aItem.Confirmed"
                                    v-bind:options="ConfirmList"
                                    v-bind:close-on-select="true"
                                    v-bind:placeholder="''"
                                    v-bind:show-labels="false" >
                                </multiselect>
                            </td>
                            <td colspan="2">
                                <button type="button" class="btn btn-default" role='button' v-on:click="OnAddSaf20aItem()">
                                    輸入明細
                                </button>
                                <button type="button" class="btn btn-default" role='button' v-on:click="OnDeleteSaf20aItem">
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
                                <th v-on:click="OnTableSorting('Saf20a02_seq')">
                                    項次
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':SortColumn!='Saf20a02_seq', 
                                        'glyphicon-chevron-up': SortColumn=='Saf20a02_seq' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='Saf20a02_seq' && SortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnTableSorting('Saf20a05_pcode')">
                                    產品編號
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':SortColumn!='Saf20a05_pcode', 
                                        'glyphicon-chevron-up': SortColumn=='Saf20a05_pcode' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='Saf20a05_pcode' && SortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnTableSorting('Saf20a05_shoes_code')">
                                    貨號
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':SortColumn!='Saf20a05_shoes_code', 
                                        'glyphicon-chevron-up': SortColumn=='Saf20a05_shoes_code' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='Saf20a05_shoes_code' && SortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnTableSorting('Saf20a33_product_name')">
                                    產品簡稱
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':SortColumn!='Saf20a33_product_name', 
                                        'glyphicon-chevron-up': SortColumn=='Saf20a33_product_name' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='Saf20a33_product_name' && SortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnTableSorting('Saf20a13_sold_qty')">
                                    數量
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':SortColumn!='Saf20a13_sold_qty', 
                                        'glyphicon-chevron-up': SortColumn=='Saf20a13_sold_qty' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='Saf20a13_sold_qty' && SortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnTableSorting('Saf20a11_dis_rate')">
                                    折扣
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':SortColumn!='Saf20a11_dis_rate', 
                                        'glyphicon-chevron-up': SortColumn=='Saf20a11_dis_rate' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='Saf20a11_dis_rate' && SortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnTableSorting('Saf20a17_runit')">
                                    單位
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':SortColumn!='Saf20a17_runit', 
                                        'glyphicon-chevron-up': SortColumn=='Saf20a17_runit' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='Saf20a17_runit' && SortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnTableSorting('Saf20a10_ocost_one')">
                                    原價
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':SortColumn!='Saf20a10_ocost_one', 
                                        'glyphicon-chevron-up': SortColumn=='Saf20a10_ocost_one' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='Saf20a10_ocost_one' && SortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnTableSorting('Saf20a10_cost_one')">
                                    進價
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':SortColumn!='Saf20a10_cost_one', 
                                        'glyphicon-chevron-up': SortColumn=='Saf20a10_cost_one' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='Saf20a10_cost_one' && SortOrder=='desc'}">
                                    </span>
                                </th>
                                <th v-on:click="OnTableSorting('Saf20a38_one_amt')">
                                    金額小計
                                    <span class="sort-item glyphicon" 
                                        v-bind:class="{'glyphicon-sort':SortColumn!='Saf20a38_one_amt', 
                                        'glyphicon-chevron-up': SortColumn=='Saf20a38_one_amt' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='Saf20a38_one_amt' && SortOrder=='desc'}">
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
                            <tr v-for="Saf20aItem in Saf20aList" 
                                v-on:click="OnRowClick(Saf20aItem)"
                                v-bind:class="{'selected-row':Saf20aItem==SelectedSaf20aItem}"
                                >
                                <!-- 項次 -->
                                <td>{{Saf20aItem.Saf20a02_seq}}</td>
                                <!-- 產品編號 -->
                                <td>{{Saf20aItem.Saf20a05_pcode}}</td>
                                <!-- 貨號 -->
                                <td>{{Saf20aItem.Saf20a05_shoes_code}}</td>
                                <!-- 產品簡稱 -->
                                <td>{{Saf20aItem.Saf20a33_product_name }}</td>
                                <!-- 數量 -->
                                <td>{{Saf20aItem.Saf20a13_sold_qty }}</td>
                                <!-- 折扣 -->
                                <td>{{Saf20aItem.Saf20a11_dis_rate }}%</td>
                                <!-- 單位 -->
                                <td>{{Saf20aItem.Saf20a17_runit }}</td>
                                <!-- 原價 -->
                                <td>{{Saf20aItem.Saf20a10_ocost_one }}</td>
                                <!-- 進價 -->
                                <td>{{Saf20aItem.Saf20a10_cost_one }}</td>
                                <!-- 金額小計 -->
                                <td>{{Saf20aItem.Saf20a38_one_amt }}</td>
                                <!-- 確認 -->
                                <td>{{Saf20aItem.Confirmed }}</td>
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
            var WherehouseList = JSON.parse("<%=HttpUtility.JavaScriptStringEncode(JsonConvert.SerializeObject(WherehouseList),false)%>");
            var InReasonList = JSON.parse("<%=HttpUtility.JavaScriptStringEncode(JsonConvert.SerializeObject(InReasonList),false)%>");
            var CurrencyList = JSON.parse("<%=HttpUtility.JavaScriptStringEncode(JsonConvert.SerializeObject(CurrencyList),false)%>");

            console.log("BcodeList:"+BcodeList);
            console.log("WherehouseList:"+WherehouseList);
            console.log("InReasonList:"+InReasonList);
            console.log("CurrencyList:"+CurrencyList);

            requirejs.config({
                paths: {
                    "dinp02401Search": "Dinp/dinp02401Search",
                    "dinp02401Edit": "Dinp/dinp02401Edit",
                },
                shim: {}
            });

            var requiredFiles = ["dinp02401Search", "dinp02401Edit"];

            function onLoaded(dinp02401Search, dinp02401Edit) {
                console.log("function onLoaded(dinp02401Search, dinp02401Edit)");
                window.dinp02401Search.SetBCodeList(BcodeList);
                window.dinp02401Edit.SetBCodeList(BcodeList);
                window.dinp02401Search.WherehouseList = WherehouseList;
                window.dinp02401Edit.WherehouseList = WherehouseList;
                window.dinp02401Edit.InReasonList = InReasonList;
                window.dinp02401Edit.CurrencyList = CurrencyList;
            }

            function onError(error) {
                console.error(error);
            }

            require(requiredFiles, onLoaded, onError);
        })();
    </script>

</asp:Content>

