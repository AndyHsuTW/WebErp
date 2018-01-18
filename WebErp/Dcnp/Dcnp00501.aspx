<%@ Page Language="C#" MasterPageFile="~/master/BaseMasterPage.master" AutoEventWireup="true" CodeFile="Dcnp00501.aspx.cs" Inherits="Dcnp_Dcnp00501" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.3500.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .app-title
        {
            background-color: #3097D1;
            color: #FFF;
        }

        .app-body
        {
            padding-left: 5px;
        }

        .filter-div
        {
            margin-top: 5px;
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

        .vuetable >thead>tr>th,
        .table-borderless > tbody > tr > td,
        .table-borderless > tbody > tr > th,
        .table-borderless > tfoot > tr > td,
        .table-borderless > tfoot > tr > th,
        .table-borderless > thead > tr > td,
        .table-borderless > thead > tr > th
        {
            border: none;
        }
        .table.sortable>thead>tr>th{
            cursor: pointer;
            white-space: nowrap;
        }
        .table.sortable .no-sortable{
            cursor: default;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="Dcnp00501" v-cloak>
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
                <button type="button" class="btn btn-default" role='button'
                    id="BatchProgramBtn" href='#EditDialog'
                    v-on:click="OnBatchModify()">
                    批次輸入程式代號
                </button>
            </div>
            <div class="filter-div">
                <table class="">
                    <tbody>
                        <tr>
                            <td>關鍵字
                            </td>
                            <td>
                                <input type="text" v-model="Filter.Keyword">
                            </td>
                        </tr>
                        <tr>
                            <td>檔案代號
                                        <span>起~</span>
                            </td>
                            <td>
                                <input type="text" v-model="Filter.Cnf0501FileStart"
                                    v-on:change="OnFileStartChange()">
                                迄~
                                        <input type="text" v-model="Filter.Cnf0501FileEnd">
                            </td>
                        </tr>
                        <tr>
                            <td>程式代號
                                        <span>起~</span>
                            </td>
                            <td>
                                <input type="text" v-model="Filter.Cnf0506ProgramStart"
                                    v-on:change="OnProgramStartChange()">
                                迄~
                                        <input type="text" v-model="Filter.Cnf0506ProgramEnd">
                            </td>
                        </tr>
                        <tr>
                            <td>欄位名稱
                                <span>起~</span>
                            </td>
                            <td>
                                <input type="text" v-model="Filter.Cnf0502FieldStart"
                                    v-on:change="OnFieldStartChange()">
                                迄~
                                <input type="text" v-model="Filter.Cnf0502FieldEnd">
                            </td>
                        </tr>
                        <tr>
                            <td>新增日期
                                        <span>起~</span>
                            </td>
                            <td>
                                <vue-datetimepicker v-model="Filter.AddDateStart" placeholder=""
                                v-on:change="OnAddDateStartChange()"></vue-datetimepicker>
                                迄~
                                <vue-datetimepicker id="FilterAddDateEnd" ref="FilterAddDateEnd" v-model="Filter.AddDateEnd" placeholder=""></vue-datetimepicker>
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
                                <th v-on:click="OnTableSorting('cnf0501_file')" >
                                    檔案代號<br>
                                    <span class="pull-right glyphicon  " 
                                        v-bind:class="{'glyphicon-sort':SortColumn!='cnf0501_file', 
                                        'glyphicon-chevron-up': SortColumn=='cnf0501_file' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='cnf0501_file' && SortOrder=='desc'}"></span>
                                </th>
                                <th v-on:click="OnTableSorting('cnf0502_field')">
                                    欄位名稱<br>
                                    <span class="pull-right glyphicon  " 
                                        v-bind:class="{'glyphicon-sort':SortColumn!='cnf0502_field', 
                                        'glyphicon-chevron-up': SortColumn=='cnf0502_field' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='cnf0502_field' && SortOrder=='desc'}"></span>
                                </th>
                                <th v-on:click="OnTableSorting('cnf0503_fieldname_tw')">
                                    中文說明-繁體<br>
                                    <span class="pull-right glyphicon  " 
                                        v-bind:class="{'glyphicon-sort':SortColumn!='cnf0503_fieldname_tw', 
                                        'glyphicon-chevron-up': SortColumn=='cnf0503_fieldname_tw' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='cnf0503_fieldname_tw' && SortOrder=='desc'}"></span>
                                </th>
                                <th v-on:click="OnTableSorting('cnf0506_program')">
                                    程式代號<br>
                                    <span class="pull-right glyphicon  " 
                                        v-bind:class="{'glyphicon-sort':SortColumn!='cnf0506_program', 
                                        'glyphicon-chevron-up': SortColumn=='cnf0506_program' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='cnf0506_program' && SortOrder=='desc'}"></span>
                                </th>
                                <th v-on:click="OnTableSorting('adddate')">
                                    新增日期<br>
                                    <span class="pull-right glyphicon  " 
                                        v-bind:class="{'glyphicon-sort':SortColumn!='adddate', 
                                        'glyphicon-chevron-up': SortColumn=='adddate' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='adddate' && SortOrder=='desc'}"></span>
                                </th>
                                <th v-on:click="OnTableSorting('adduser')">
                                    新增者<br>
                                    <span class="pull-right glyphicon  " 
                                        v-bind:class="{'glyphicon-sort':SortColumn!='adduser', 
                                        'glyphicon-chevron-up': SortColumn=='adduser' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='adduser' && SortOrder=='desc'}"></span>
                                </th>
                                <th v-on:click="OnTableSorting('moddate')">
                                    修改日期<br>
                                    <span class="pull-right glyphicon  " 
                                        v-bind:class="{'glyphicon-sort':SortColumn!='moddate', 
                                        'glyphicon-chevron-up': SortColumn=='moddate' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='moddate' && SortOrder=='desc'}"></span>
                                </th>
                                <th v-on:click="OnTableSorting('moduser')">
                                    修改者<br>
                                    <span class="pull-right glyphicon  " 
                                        v-bind:class="{'glyphicon-sort':SortColumn!='moduser', 
                                        'glyphicon-chevron-up': SortColumn=='moduser' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='moduser' && SortOrder=='desc'}"></span>
                                </th>
                                <th v-on:click="OnTableSorting('cnf0504_fieldname_cn')">
                                    中文說明-簡體<br>
                                    <span class="pull-right glyphicon  " 
                                        v-bind:class="{'glyphicon-sort':SortColumn!='cnf0504_fieldname_cn', 
                                        'glyphicon-chevron-up': SortColumn=='cnf0504_fieldname_cn' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='cnf0504_fieldname_cn' && SortOrder=='desc'}"></span>
                                </th>
                                <th v-on:click="OnTableSorting('cnf0505_fieldname_en')">
                                    英文說明<br>
                                    <span class="pull-right glyphicon  " 
                                        v-bind:class="{'glyphicon-sort':SortColumn!='cnf0505_fieldname_en', 
                                        'glyphicon-chevron-up': SortColumn=='cnf0505_fieldname_en' && SortOrder=='asc',
                                        'glyphicon-chevron-down': SortColumn=='cnf0505_fieldname_en' && SortOrder=='desc'}"></span>
                                </th>
                                <th class="no-sortable">操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="cnf05Item in Cnf05List">
                                <td>
                                    <input type="checkbox" v-model="cnf05Item.checked">
                                </td>
                                <td>{{cnf05Item.cnf0501_file}}</td>
                                <td>{{cnf05Item.cnf0502_field}}</td>
                                <td>{{cnf05Item.cnf0503_fieldname_tw}}</td>
                                <td>{{cnf05Item.cnf0506_program}}</td>
                                <td>{{new Date(cnf05Item.adddate).dateFormat('Y/m/d')}}</td>
                                <td>{{cnf05Item.adduser}}</td>
                                <td>
                                    {{cnf05Item.moddate==null?"":new Date(cnf05Item.moddate).dateFormat('Y/m/d')}}
                                </td>
                                <td>{{cnf05Item.moduser}}</td>
                                <td>{{cnf05Item.cnf0504_fieldname_cn}}</td>
                                <td>{{cnf05Item.cnf0505_fieldname_en}}</td>
                                <td>
                                    <button type="button" class="btn btn-default"
                                        v-on:click="OnDelete(cnf05Item)">
                                        刪除</button>
                                    <button type="button" class="btn btn-default" data-toggle="modal" href='#EditDialog'
                                        v-on:click="OnModify(cnf05Item)">
                                        編輯</button>
                                    <button type="button" class="btn btn-default" data-toggle="modal" href='#EditDialog'
                                        v-on:click="OnCopy(cnf05Item)">
                                        複製</button>
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
                        <h4 class="modal-title">
                            {{IsEditDialogAddMode?"新增":"編輯"}}
                        </h4>
                    </div>
                    <div class="modal-body">

                        <table class="table table-borderless">
                            <tbody>
                                <tr v-show="EditDialog.isBatchMode == false">
                                    <td>檔案代號</td>
                                    <td>
                                        <input type="text"
                                            v-model="EditDialog.cnf0501_file">
                                    </td>
                                </tr>
                                <tr v-show="EditDialog.isBatchMode == false">
                                    <td>欄位名稱</td>
                                    <td>
                                        <input type="text"
                                            v-model="EditDialog.cnf0502_field">
                                    </td>
                                </tr>
                                <tr v-show="EditDialog.isBatchMode == false">
                                    <td>中文說明-繁體</td>
                                    <td>
                                        <input type="text"
                                            v-model="EditDialog.cnf0503_fieldname_tw">
                                    </td>
                                </tr>
                                <tr v-show="EditDialog.isBatchMode == false">
                                    <td>中文說明-簡體</td>
                                    <td>
                                        <input type="text"
                                            v-model="EditDialog.cnf0504_fieldname_cn">
                                    </td>
                                </tr>
                                <tr v-show="EditDialog.isBatchMode == false">
                                    <td>英文說明</td>
                                    <td>
                                        <input type="text"
                                            v-model="EditDialog.cnf0505_fieldname_en">
                                    </td>
                                </tr>
                                <tr>
                                    <td>程式代號</td>
                                    <td>
                                        <input type="text"
                                            v-model="EditDialog.cnf0506_program">
                                    </td>
                                </tr>
                                <tr v-show="EditDialog.isBatchMode == false">
                                    <td>備註</td>
                                    <td>
                                        <input type="text"
                                            v-model="EditDialog.remark">
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <div class="col-xs-3 no-padding" v-show="EditDialog.isBatchMode == false">
                                            <div class="col-xs-5 no-padding">
                                                新增者
                                            </div>
                                            <input class="col-xs-7" type="text" disabled="disabled"
                                                v-model="EditDialog.adduser">
                                        </div>
                                        <div class="col-xs-3 " v-show="EditDialog.isBatchMode == false">
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
                        <function-button id="AddBtn" v-show="EditDialog.isBatchMode == false"
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
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" v-model="Export.cnf0501_file">
                                檔案代號
                            </label>
                        </div>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" v-model="Export.cnf0502_field">
                                欄位名稱
                            </label>
                        </div>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" v-model="Export.cnf0503_fieldname_tw">
                                中文說明-繁體
                            </label>
                        </div>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" v-model="Export.cnf0506_program">
                                程式代號
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
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" v-model="Export.cnf0504_fieldname_cn">
                                中文說明-簡體
                            </label>
                        </div>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" v-model="Export.cnf0505_fieldname_en">
                                英文說明
                            </label>
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
                            <input type="file" id="ImportExcelInput" ref="ImportExcelInput" accept=".xlsx">
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
    <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="true" />
    <script>
        (function () {
            requirejs.config({
                paths: {
                    "dcnp00501": "Dcnp/dcnp00501",
                },
                shim: {}
            });

            var requiredFiles = ["dcnp00501"];

            function onLoaded(dcnp00501) {
            }

            function onError(error) {
                console.error(error);
            }

            require(requiredFiles, onLoaded, onError);
        })();
    </script>

</asp:Content>
