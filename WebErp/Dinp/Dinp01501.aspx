<%@ Page Language="C#" MasterPageFile="~/master/BaseMasterPage.master" AutoEventWireup="true" CodeFile="Dinp01501.aspx.cs" Inherits="Dinp_Dinp01501" %>

<%@ Import Namespace="Newtonsoft.Json" %>
<%@ Import Namespace="System.Web.Hosting" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        /* override multiselect default*/
        .app-body .multiselect__option--highlight {
            background: #3097D1;
            outline: none;
            color: white;
        }

        .app-body .multiselect__tags {
            border-color: #A8A8A8;
            border-radius: 0;
        }

        .app-body .multiselect {
            display: inline-block;
        }

        /* multiselect default end */

        .app-title {
            background-color: #3097D1;
            color: #FFF;
        }

        .app-body {
            padding-left: 5px;
            min-width: 1080px;
        }

        .filter-div,
        .editParam-div {
            margin-top: 5px;
        }

            .filter-div .medium-field,
            .editParam-div .medium-field {
                width: 175px;
            }

            .filter-div .small-field,
            .editParam-div .small-field {
                width: 100px;
            }

            .filter-div .x-small-field,
            .editParam-div .x-small-field {
                width: 50px;
            }

            .filter-div td > *,
            .editParam-div td > * {
                margin-bottom: 2px;
                margin-left: 3px;
            }

            .filter-div > table td,
            .editParam-div > table td {
                white-space: nowrap;
            }

                .filter-div > table td:nth-child(even),
                .editParam-div > table td:nth-child(even) {
                    padding-right: 7px;
                }

            .filter-div > table .ref-inputs > input:nth-child(odd),
            .editParam-div > table .ref-inputs > input:nth-child(odd) {
                width: 50px;
            }

            .filter-div > table .ref-inputs > input:nth-child(even),
            .editParam-div > table .ref-inputs > input:nth-child(even) {
                width: 70px;
            }

            .filter-div > table .key-value-inputs > input:nth-child(1),
            .editParam-div > table .key-value-inputs > input:nth-child(1) {
                width: 100px;
            }

            .filter-div > table .key-value-inputs > input:nth-child(2),
            .editParam-div > table .key-value-inputs > input:nth-child(2) {
                width: 200px;
            }

        .no-margin {
            margin: 0 !important;
        }

        .no-padding {
            padding: 0 !important;
        }

        .scroll-table {
            height: 450px;
            overflow-y: auto;
            overflow-y: overlay;
            border: solid 1px #CCC;
        }

        .scroll-div {
            overflow-y: auto;
            overflow-y: overlay;
        }

        #ExportDialog .scroll-div {
            height: 300px;
        }

        .main-result-div .scroll-table,
        .sub-result-div .scroll-table {
            height: 200px;
        }

        .vuetable > thead > tr > th,
        .table-borderless > tbody > tr > td,
        .table-borderless > tbody > tr > th,
        .table-borderless > tfoot > tr > td,
        .table-borderless > tfoot > tr > th,
        .table-borderless > thead > tr > td,
        .table-borderless > thead > tr > th {
            border: none;
        }

        .table.sortable > thead > tr > th {
            cursor: pointer;
            white-space: nowrap;
            position: relative;
            padding-right: 16px;
        }

        .table.sortable .no-sortable {
            cursor: default;
        }

        .table.sortable .sort-item {
            position: absolute;
            right: 2px;
            top: 35%;
        }

        tr.selected-row {
            background: #AAE;
        }

        #dpCodeWindow {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background: #fff;
        }

        .ui-datepicker table {
            display: none;
        }

        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <% string rootUrl = HostingEnvironment.ApplicationVirtualPath.Length > 1 ? HostingEnvironment.ApplicationVirtualPath + "/" : HostingEnvironment.ApplicationVirtualPath; %>
    <div id="Dinp01501" v-cloak>
        <ul class="app-title">
            <li><%=Title %>
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
                <function-button id="ExportBtn" data-toggle="modal" href='#ExportDialog'
                    hot-key="f7"
                    v-on:click.native="OnExport()">
                            匯出
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
                            <td>結帳年月
                                <span>起~</span>
                            </td>
                            <td>
                                <vue-datetimepicker id="inf1503BegDate" placeholder="" class="medium-field" v-model="Filter.inf1503BegDate" v-on:change="OnBegDateStartChange()"></vue-datetimepicker>
                                迄~
                                <vue-datetimepicker id="inf1504EndDate" ref="FilterEndDate" placeholder="" class="medium-field" v-model="Filter.inf1504EndDate"></vue-datetimepicker>
                            </td>
                            <td>系統代號
                                <span>起~</span>
                            </td>
                            <td>
                                <span class="ref-inputs">
                                    <multiselect class="medium-field"
                                        v-model="Filter.inf1502AppBeg"
                                        v-bind:options="AppCodeList"
                                        v-bind:close-on-select="true"
                                        v-bind:placeholder="''"
                                        v-bind:show-labels="false"
                                        v-bind:custom-label="AppCodeSelectLabel"
                                        v-on:input="AutoFillFilter('inf1502AppEnd',Filter.inf1502AppBeg)"
                                        track-by="cnf1002_fileorder"
                                        label="cnf1003_char01">
                                    </multiselect>
                                </span>
                                迄~
                                <span class="ref-inputs">
                                    <multiselect class="medium-field"
                                        v-model="Filter.inf1502AppEnd"
                                        v-bind:options="AppCodeList"
                                        v-bind:close-on-select="true"
                                        v-bind:placeholder="''"
                                        v-bind:show-labels="false"
                                        v-bind:custom-label="AppCodeSelectLabel"
                                        track-by="cnf1002_fileorder"
                                        label="cnf1003_char01">
                                    </multiselect>
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <td>公司代號
                                <span>起~</span>
                            </td>
                            <td>
                                <multiselect class="medium-field"
                                    v-model="Filter.inf1501BcodeBeg"
                                    v-bind:options="BcodeList"
                                    v-bind:close-on-select="true"
                                    v-bind:placeholder="''"
                                    v-bind:show-labels="false"
                                    v-bind:custom-label="BcodeSelectLabel"
                                    v-on:input="AutoFillFilter('BcodeEnd',Filter.inf1501BcodeBeg)"
                                    track-by="cnf0701_bcode"
                                    label="cnf0703_bfname">
                                </multiselect>
                                迄~
                                <multiselect class="medium-field"
                                    v-model="Filter.inf1501BcodeEnd"
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
                                <input type="text" id="ttt" v-model="Filter.keyword" />

                                筆數:
                                <label id="lbCount">0</label>
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
                                <th class="no-sortable">
                                    <input type="checkbox" value="" v-on:click="OnCheckAll" v-model="IsCheckAll">
                                </th>
                                <th v-on:click="OnTableSorting('status')">狀態碼
                                    <span class="sort-item glyphicon  "
                                        v-bind:class="{'glyphicon-sort':SortColumn!='status', 
                                        'glyphicon-chevron-up': SortColumn=='status' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='status' && SortOrder=='desc'}"></span>
                                </th>
                                <th v-on:click="OnTableSorting('inf1501_bcode')">公司或客戶代號
                                    <span class="sort-item glyphicon  "
                                        v-bind:class="{'glyphicon-sort':SortColumn!='inf1501_bcode', 
                                        'glyphicon-chevron-up': SortColumn=='inf1501_bcode' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='inf1501_bcode' && SortOrder=='desc'}"></span>
                                </th>
                                <th v-on:click="OnTableSorting('inf1502_app')">系統代號
                                    <span class="sort-item glyphicon  "
                                        v-bind:class="{'glyphicon-sort':SortColumn!='inf1502_app', 
                                        'glyphicon-chevron-up': SortColumn=='inf1502_app' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='inf1502_app' && SortOrder=='desc'}"></span>
                                </th>
                                <th v-on:click="OnTableSorting('inf1502_pmonth')">結帳年月
                                    <span class="sort-item glyphicon  "
                                        v-bind:class="{'glyphicon-sort':SortColumn!='inf1502_pmonth', 
                                        'glyphicon-chevron-up': SortColumn=='inf1502_pmonth' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='inf1502_pmonth' && SortOrder=='desc'}"></span>
                                </th>
                                <th v-on:click="OnTableSorting('inf1502_close_type')">結帳別
                                    <span class="sort-item glyphicon  "
                                        v-bind:class="{'glyphicon-sort':SortColumn!='inf1502_close_type', 
                                        'glyphicon-chevron-up': SortColumn=='inf1502_close_type' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='inf1502_close_type' && SortOrder=='desc'}"></span>
                                </th>
                                <th v-on:click="OnTableSorting('inf1502_seq')">序號
                                    <span class="sort-item glyphicon  "
                                        v-bind:class="{'glyphicon-sort':SortColumn!='inf1502_seq', 
                                        'glyphicon-chevron-up': SortColumn=='inf1502_seq' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='inf1502_seq' && SortOrder=='desc'}"></span>
                                </th>
                                <th v-on:click="OnTableSorting('inf1503_beg_date')">結帳開始日期
                                    <span class="sort-item glyphicon  "
                                        v-bind:class="{'glyphicon-sort':SortColumn!='inf1503_beg_date', 
                                        'glyphicon-chevron-up': SortColumn=='inf1503_beg_date' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='inf1503_beg_date' && SortOrder=='desc'}"></span>
                                </th>
                                <th v-on:click="OnTableSorting('inf1504_end_date')">結帳結束日期
                                    <span class="sort-item glyphicon  "
                                        v-bind:class="{'glyphicon-sort':SortColumn!='inf1504_end_date', 
                                        'glyphicon-chevron-up': SortColumn=='inf1504_end_date' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='inf1504_end_date' && SortOrder=='desc'}"></span>
                                </th>
                                <th v-on:click="OnTableSorting('inf1505_this_date')">本次結轉日期
                                    <span class="sort-item glyphicon  "
                                        v-bind:class="{'glyphicon-sort':SortColumn!='inf1505_this_date', 
                                        'glyphicon-chevron-up': SortColumn=='inf1505_this_date' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='inf1505_this_date' && SortOrder=='desc'}"></span>
                                </th>
                                <th v-on:click="OnTableSorting('inf1506_last_date')">上次結轉日期
                                    <span class="sort-item glyphicon  "
                                        v-bind:class="{'glyphicon-sort':SortColumn!='inf1506_last_date', 
                                        'glyphicon-chevron-up': SortColumn=='inf1506_last_date' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='inf1506_last_date' && SortOrder=='desc'}"></span>
                                </th>
                                <th v-on:click="OnTableSorting('inf1507_sal_flag1')">帳銷數可否為負值
                                    <span class="sort-item glyphicon  "
                                        v-bind:class="{'glyphicon-sort':SortColumn!='inf1507_sal_flag1', 
                                        'glyphicon-chevron-up': SortColumn=='inf1507_sal_flag1' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='inf1507_sal_flag1' && SortOrder=='desc'}"></span>
                                </th>
                                <th v-on:click="OnTableSorting('inf1508_inv_flag2')">庫存計算狀態
                                    <span class="sort-item glyphicon  "
                                        v-bind:class="{'glyphicon-sort':SortColumn!='inf1508_inv_flag2', 
                                        'glyphicon-chevron-up': SortColumn=='inf1508_inv_flag2' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='inf1508_inv_flag2' && SortOrder=='desc'}"></span>
                                </th>
                                <th v-on:click="OnTableSorting('inf1509_pas_flag3')">單據是否有異動
                                    <span class="sort-item glyphicon  "
                                        v-bind:class="{'glyphicon-sort':SortColumn!='inf1509_pas_flag3', 
                                        'glyphicon-chevron-up': SortColumn=='inf1509_pas_flag3' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='inf1509_pas_flag3' && SortOrder=='desc'}"></span>
                                </th>
                                <th v-on:click="OnTableSorting('inf1510_clo_flag4')">關帳狀態
                                    <span class="sort-item glyphicon  "
                                        v-bind:class="{'glyphicon-sort':SortColumn!='inf1510_clo_flag4', 
                                        'glyphicon-chevron-up': SortColumn=='inf1510_clo_flag4' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='inf1510_clo_flag4' && SortOrder=='desc'}"></span>
                                </th>
                                <th v-on:click="OnTableSorting('inf1511_trx_flag5')">結轉狀態
                                    <span class="sort-item glyphicon  "
                                        v-bind:class="{'glyphicon-sort':SortColumn!='inf1511_trx_flag5', 
                                        'glyphicon-chevron-up': SortColumn=='inf1511_trx_flag5' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='inf1511_trx_flag5' && SortOrder=='desc'}"></span>
                                </th>
                                <th v-on:click="OnTableSorting('inf1511_rev_flag6')">過帳碼
                                    <span class="sort-item glyphicon  "
                                        v-bind:class="{'glyphicon-sort':SortColumn!='inf1511_rev_flag6', 
                                        'glyphicon-chevron-up': SortColumn=='inf1511_rev_flag6' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='inf1511_rev_flag6' && SortOrder=='desc'}"></span>
                                </th>
                                <th v-on:click="OnTableSorting('inf1512_inv_date')">發票寄出日期
                                    <span class="sort-item glyphicon  "
                                        v-bind:class="{'glyphicon-sort':SortColumn!='inf1512_inv_date', 
                                        'glyphicon-chevron-up': SortColumn=='inf1512_inv_date' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='inf1512_inv_date' && SortOrder=='desc'}"></span>
                                </th>
                                <th v-on:click="OnTableSorting('remark')">備註
                                    <span class="sort-item glyphicon  "
                                        v-bind:class="{'glyphicon-sort':SortColumn!='remark', 
                                        'glyphicon-chevron-up': SortColumn=='remark' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='remark' && SortOrder=='desc'}"></span>
                                </th>
                                <th v-on:click="OnTableSorting('adduser')">新增者
                                    <span class="sort-item glyphicon  "
                                        v-bind:class="{'glyphicon-sort':SortColumn!='adduser', 
                                        'glyphicon-chevron-up': SortColumn=='adduser' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='adduser' && SortOrder=='desc'}"></span>
                                </th>
                                <th v-on:click="OnTableSorting('adddate')">新增日期
                                    <span class="sort-item glyphicon  "
                                        v-bind:class="{'glyphicon-sort':SortColumn!='adddate', 
                                        'glyphicon-chevron-up': SortColumn=='adddate' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='adddate' && SortOrder=='desc'}"></span>
                                </th>
                                <th v-on:click="OnTableSorting('moduser')">修改者
                                    <span class="sort-item glyphicon  "
                                        v-bind:class="{'glyphicon-sort':SortColumn!='moduser', 
                                        'glyphicon-chevron-up': SortColumn=='moduser' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='moduser' && SortOrder=='desc'}"></span>
                                </th>
                                <th v-on:click="OnTableSorting('moddate')">修改日期
                                    <span class="sort-item glyphicon  "
                                        v-bind:class="{'glyphicon-sort':SortColumn!='moddate', 
                                        'glyphicon-chevron-up': SortColumn=='moddate' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='moddate' && SortOrder=='desc'}"></span>
                                </th>
                                <th class="no-sortable">操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="inf15Item in Inf15List">
                                <td>
                                    <input type="checkbox" v-model="inf15Item.checked">
                                </td>
                                <td>{{inf15Item.status==""?"公司":(inf15Item.status=="1"?"客戶":"Unknow")}}</td>
                                <td>{{inf15Item.status==""?GetCompanyName(inf15Item.inf1501_bcode):(inf15Item.status=="1"?GetCustomerName(inf15Item.inf1501_ccode):"Unknow")}}</td>
                                <td>{{GetAppName(inf15Item.inf1502_app)}}</td>
                                <td>{{inf15Item.inf1502_pmonth}}</td>
                                <td>{{inf15Item.inf1502_close_type==1?"月末結帳":(inf15Item.inf1502_close_type==2?"月中結帳":"Unknow")}}</td>
                                <td>{{inf15Item.inf1502_seq}}</td>
                                <td>{{inf15Item.inf1503_beg_date}}</td>
                                <td>{{inf15Item.inf1504_end_date}}</td>
                                <td>{{inf15Item.inf1505_this_date}}</td>
                                <td>{{inf15Item.inf1506_last_date}}</td>
                                <td>{{inf15Item.inf1507_sal_flag1==1?"可":(inf15Item.inf1507_sal_flag1==2?"不可":"Unknow")}}</td>
                                <td>{{inf15Item.inf1508_inv_flag2==1?"電腦盤點":(inf15Item.inf1508_inv_flag2==2?"人工盤點":(inf15Item.inf1508_inv_flag2==2?"人工加電腦盤點":"Unknow"))}}</td>
                                <td>{{inf15Item.inf1509_pas_flag3==""?"否":"是"}}</td>
                                <td>{{inf15Item.inf1510_clo_flag4==1?"未關帳":(inf15Item.inf1510_clo_flag4==2?"關帳":(inf15Item.inf1510_clo_flag4==2?"完全關帳":"Unknow"))}}</td>
                                <td>{{inf15Item.inf1511_trx_flag5==1?"是":(inf15Item.inf1511_trx_flag5==2?"否":"Unknow")}}</td>
                                <td>{{inf15Item.inf1511_rev_flag6}}</td>
                                <td>{{inf15Item.inf1512_inv_date}}</td>
                                <td>{{inf15Item.remark}}</td>
                                <td>{{inf15Item.adduser}}</td>
                                <td>{{inf15Item.adddate}}</td>
                                <td>{{inf15Item.moduser}}</td>
                                <td>{{inf15Item.moddate}}</td>
                                <td>
                                    <button type="button" class="btn btn-default" data-toggle="modal" href='#EditDialog'
                                        v-on:click="OnModify(inf15Item)">
                                        編輯</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <div class="modal fade" id="EditDialog" ref="EditDialog">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title">{{IsEditDialogAddMode?"新增":"編輯"}}
                        </h4>
                    </div>
                    <div class="modal-body">

                        <table class="table table-borderless">
                            <tbody>
                                <tr>
                                    <td>類型</td>
                                    <td>
                                        <input type="radio" name="inf15status" value="" v-model="EditDialog.status">
                                        公司
                                        <input type="radio" name="inf15status" value="1" v-model="EditDialog.status">
                                        客戶
                                    </td>
                                </tr>
                                <tr>
                                    <td>代號</td>
                                    <td>
                                        <div v-show="EditDialog.status == ''">
                                            <multiselect
                                                v-model="EditDialog.inf1501_bcode"
                                                v-bind:options="BcodeList"
                                                v-bind:close-on-select="true"
                                                v-bind:placeholder="''"
                                                v-bind:show-labels="false"
                                                v-bind:custom-label="BcodeSelectLabel"
                                                track-by="cnf0701_bcode"
                                                label="cnf0703_bfname">
                                            </multiselect>
                                        </div>
                                        <div v-show="EditDialog.status == '1'">
                                            <multiselect
                                                v-model="EditDialog.inf1501_ccode"
                                                v-bind:options="CcodeList"
                                                v-bind:close-on-select="true"
                                                v-bind:placeholder="''"
                                                v-bind:show-labels="false"
                                                v-bind:custom-label="CcodeSelectLabel"
                                                track-by="cmf0102_cuscode"
                                                label="cmf0103_bname">
                                            </multiselect>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>系統代號</td>
                                    <td>
                                        <multiselect class="medium-field"
                                            v-model="EditDialog.inf1502_app"
                                            v-bind:options="AppCodeList"
                                            v-bind:close-on-select="true"
                                            v-bind:placeholder="''"
                                            v-bind:show-labels="false"
                                            v-bind:custom-label="AppCodeSelectLabel"
                                            track-by="cnf1002_fileorder"
                                            label="cnf1003_char01">
                                        </multiselect>
                                    </td>
                                </tr>
                                <tr>
                                    <td>結帳年月</td>
                                    <td>
                                        <vue-datetimepicker id="EditMonth" placeholder="" class="medium-field" v-model="EditDialog.inf1502_pmonth"></vue-datetimepicker>
                                    </td>
                                </tr>
                                <tr>
                                    <td title="[舉例說明 : 結帳區間是 1-31、1-15或16-31 ( 1個月結2次也請點選月末結帳 )  單獨於20日(或某一日結一次帳是屬於月中結帳]">結帳別</td>
                                    <td>
                                        <input type="radio" name="inf1502closetype" value="1" v-model="EditDialog.inf1502_close_type">
                                        月末結帳
                                        <input type="radio" name="inf1502closetype" value="2" v-model="EditDialog.inf1502_close_type">
                                        月中結帳
                                    </td>
                                </tr>
                                <tr>
                                    <td>序號</td>
                                    <td>
                                        <input type="number" v-model="EditDialog.inf1502_seq">
                                    </td>
                                </tr>
                                <tr>
                                    <td>結帳開始日期</td>
                                    <td>
                                        <vue-datetimepicker id="inf1503_beg_date" placeholder="" class="medium-field" v-model="EditDialog.inf1503_beg_date" v-on:change="OnEditBegDateChange()"></vue-datetimepicker>
                                    </td>
                                </tr>
                                <tr>
                                    <td>結帳結束日期</td>
                                    <td>
                                        <vue-datetimepicker id="inf1504_end_date" placeholder="" class="medium-field" v-model="EditDialog.inf1504_end_date" v-on:change="OnEditEndDateChange()"></vue-datetimepicker>
                                    </td>
                                </tr>
                                <tr>
                                    <td>本次結轉日期</td>
                                    <td>
                                        <vue-datetimepicker id="inf1505_this_date" placeholder="" class="medium-field" v-model="EditDialog.inf1505_this_date" disabled></vue-datetimepicker>
                                    </td>
                                </tr>
                                <tr>
                                    <td>上次結轉日期</td>
                                    <td>
                                        <vue-datetimepicker id="inf1506_last_date" placeholder="" class="medium-field" v-model="EditDialog.inf1506_last_date" disabled></vue-datetimepicker>
                                    </td>
                                </tr>
                                <tr>
                                    <td>帳銷數可否為負值</td>
                                    <td>
                                        <input type="radio" name="inf1507salflag1" value="1" v-model="EditDialog.inf1507_sal_flag1">
                                        可
                                        <input type="radio" name="inf1507salflag1" value="2" v-model="EditDialog.inf1507_sal_flag1">
                                        不可
                                    </td>
                                </tr>
                                <tr>
                                    <td>庫存計算狀態</td>
                                    <td>
                                        <input type="radio" name="inf1508invflag2" value="3" v-model="EditDialog.inf1508_inv_flag2">
                                        人工加電腦盤點
                                        <input type="radio" name="inf1508invflag2" value="1" v-model="EditDialog.inf1508_inv_flag2">
                                        電腦盤點
                                        <input type="radio" name="inf1508invflag2" value="2" v-model="EditDialog.inf1508_inv_flag2">
                                        人工盤點
                                    </td>
                                </tr>
                                <%--             <tr v-show="EditDialog.isBatchMode == false">
                                    <td>單據是否有異動</td>
                                    <td>
                                        <input type="text"
                                            v-model="EditDialog.inf1509_pas_flag3">
                                    </td>
                                </tr>--%>
                                <tr>
                                    <td>關帳狀態</td>
                                    <td>
                                        <input type="radio" name="inf1510cloflag4" value="0" v-model="EditDialog.inf1510_clo_flag4">
                                        未關帳
                                        <input type="radio" name="inf1510cloflag4" value="1" v-model="EditDialog.inf1510_clo_flag4">
                                        關帳
                                        <input type="radio" name="inf1510cloflag4" value="2" v-model="EditDialog.inf1510_clo_flag4">
                                        完全關帳
                                    </td>
                                </tr>
                                <tr>
                                    <td>結轉狀態</td>
                                    <td>
                                        <input type="radio" name="inf1511trxflag5" value="1" v-model="EditDialog.inf1511_trx_flag5">
                                        是
                                        <input type="radio" name="inf1511trxflag5" value="2" v-model="EditDialog.inf1511_trx_flag5">
                                        否
                                    </td>
                                </tr>
                                <%--                                <tr v-show="EditDialog.isBatchMode == false">
                                    <td>過帳碼</td>
                                    <td>
                                        <input type="text"
                                            v-model="EditDialog.inf1511_rev_flag6">
                                    </td>
                                </tr>--%>
                                <tr>
                                    <td>發票寄出日期</td>
                                    <td>
                                        <vue-datetimepicker id="inf1512_inv_date" placeholder="" class="medium-field" v-model="EditDialog.inf1512_inv_date"></vue-datetimepicker>
                                    </td>
                                </tr>
                                <tr>
                                    <td>備註</td>
                                    <td>
                                        <input type="text" v-model="EditDialog.remark">
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <div class="col-xs-3 no-padding">
                                            <div class="col-xs-5 no-padding">
                                                新增者
                                            </div>
                                            <input class="col-xs-7" type="text" disabled="disabled"
                                                v-model="EditDialog.adduser">
                                        </div>
                                        <div class="col-xs-3 ">
                                            <div class="col-xs-5 no-padding">
                                                新增日期
                                            </div>
                                            <vue-datetimepicker ref="AddDate" class="col-xs-7" placeholder="" disabled="disabled"
                                                v-model="EditDialog.adddate"></vue-datetimepicker>
                                        </div>
                                        <div class="col-xs-3">
                                            <div class="col-xs-5 no-padding">
                                                修改者
                                            </div>
                                            <input class="col-xs-7" type="text" disabled="disabled"
                                                v-model="EditDialog.moduser">
                                        </div>
                                        <div class="col-xs-3">
                                            <div class="col-xs-5 no-padding">
                                                修改日期
                                            </div>
                                            <vue-datetimepicker ref="ModDate" class="col-xs-7" placeholder="" disabled="disabled"
                                                v-model="EditDialog.moddate"></vue-datetimepicker>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <function-button id="SearchBtn"
                            hot-key="f1"
                            v-on:click.native="OnSearch()">
                                    查詢
                                </function-button>
                        <function-button id="AddBtn" v-show="EditDialog.isCopyMode == false"
                            hot-key="f2"
                            v-on:click.native="OnAdd()">
                                    新增
                                </function-button>
                        <function-button class="btn btn-primary"
                            hot-key="f5"
                            v-on:click.native="OnEditDialogSubmit">
                            存檔
                        </function-button>
                        <function-button data-dismiss="modal"
                            hot-key="f12">
                            離開
                        </function-button>
                    </div>
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
                            <div class="col-xs-12">
                                <button type="button" class="btn btn-default" v-on:click="OnExportAllFieldClick(true)">
                                    全選
                                </button>
                                <button type="button" class="btn btn-default" v-on:click="OnExportAllFieldClick(false)">
                                    全不選
                                </button>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" v-model="Export.status">
                                        狀態碼
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" v-model="Export.inf1501_bcode">
                                        代號
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" v-model="Export.inf1502_app">
                                        系統代號
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" v-model="Export.inf1502_pmonth">
                                        結帳年月
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" v-model="Export.inf1502_close_type">
                                        結帳別
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" v-model="Export.inf1502_seq">
                                        序號
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" v-model="Export.inf1503_beg_date">
                                        結帳開始日期
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" v-model="Export.inf1504_end_date">
                                        結帳結束日期
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" v-model="Export.inf1505_this_date">
                                        本次結轉日期
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" v-model="Export.inf1506_last_date">
                                        上次結轉日期
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" v-model="Export.inf1507_sal_flag1">
                                        帳銷數可否為負值
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" v-model="Export.inf1508_inv_flag2">
                                        庫存計算狀態
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" v-model="Export.inf1509_pas_flag3">
                                        單據是否有異動
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" v-model="Export.inf1510_clo_flag4">
                                        關帳狀態
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" v-model="Export.inf1511_trx_flag5">
                                        結轉狀態
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" v-model="Export.inf1511_rev_flag6">
                                        過帳碼
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" v-model="Export.inf1512_inv_date">
                                        發票寄出日期
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" v-model="Export.remark">
                                        備註
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" v-model="Export.adddate">
                                        新增日期
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" v-model="Export.adduser">
                                        新增者
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" v-model="Export.moddate">
                                        修改日期
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" v-model="Export.moduser">
                                        修改者
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

    <script>

        (function () {
            var BcodeList = JSON.parse("<%=HttpUtility.JavaScriptStringEncode(JsonConvert.SerializeObject(BcodeList),false)%>");
            var CcodeList = JSON.parse("<%=HttpUtility.JavaScriptStringEncode(JsonConvert.SerializeObject(CcodeList),false)%>");
            var AppCodeList = JSON.parse("<%=HttpUtility.JavaScriptStringEncode(JsonConvert.SerializeObject(AppCodeList),false)%>");
            requirejs.config({
                paths: {
                    "dinp01501": "Dinp/dinp01501",
                    "jqueryDatetimepicker": "public/scripts/jquery.datetimepicker/jquery.datetimepicker.full",
                    "jqueryDatetimepicker-css": "public/scripts/jquery.datetimepicker/jquery.datetimepicker",
                },
                shim: {
                    "jqueryDatetimepicker": {
                        "deps": ["css!jqueryDatetimepicker-css"]
                    }
                }
            });

            var requiredFiles = ["dinp01501"];

            function onLoaded(dinp01501) {
                window.dinp01501.BcodeList = BcodeList;
                window.dinp01501.CcodeList = CcodeList;
                window.dinp01501.AppCodeList = AppCodeList;
                $('#inf1503BegDate').datetimepicker({
                    timepicker: false,
                    format: 'Y/m'
                });
                $('#inf1504EndDate').datetimepicker({
                    timepicker: false,
                    format: 'Y/m'
                });
                $("#EditMonth").datetimepicker({
                    timepicker: false,
                    format: 'Y/m'
                });
            }

            function onError(error) {
                console.error(error);
            }

            require(requiredFiles, onLoaded, onError);
        })();
    </script>
</asp:Content>
