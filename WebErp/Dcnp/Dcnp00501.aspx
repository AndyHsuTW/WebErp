<%@ Page Title="" Language="C#" MasterPageFile="~/master/BaseMasterPage.master" AutoEventWireup="true" CodeFile="Dcnp00501.aspx.cs" Inherits="Dcnp_Dcnp00501" %>

<%@ Import Namespace="System.Web.Hosting" %>

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

        .table-borderless > tbody > tr > td,
        .table-borderless > tbody > tr > th,
        .table-borderless > tfoot > tr > td,
        .table-borderless > tfoot > tr > th,
        .table-borderless > thead > tr > td,
        .table-borderless > thead > tr > th
        {
            border: none;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="Dcnp00501" v-cloak>
        <ul class="app-title">
            <li>各檔案欄位說明維護
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
                <function-button id="ExportBtn" data-toggle="modal" href='#ImportExcelDialog'
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
                                <input type="text" v-model="Filter.Cnf0501FileStart">
                                迄~
                                        <input type="text" v-model="Filter.Cnf0501FileEnd">
                            </td>
                        </tr>
                        <tr>
                            <td>程式代號
                                        <span>起~</span>
                            </td>
                            <td>
                                <input type="text" v-model="Filter.Cnf0506ProgramStart">
                                迄~
                                        <input type="text" v-model="Filter.Cnf0506ProgramEnd">
                            </td>
                        </tr>
                        <tr>
                            <td>新增日期
                                        <span>起~</span>
                            </td>
                            <td>
                                <vue-datetimepicker v-model="Filter.AddDateStart" placeholder=""></vue-datetimepicker>
                                迄~
                                        <vue-datetimepicker v-model="Filter.AddDateEnd" placeholder=""></vue-datetimepicker>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="result-div">
                <table v-if="false" class="table table-bordered no-margin">
                </table>
                <div class="scroll-table">
                    <table class="table table-bordered ">
                        <thead>
                            <tr class="bg-primary text-light">
                                <th class="col-xs-1">
                                    <input type="checkbox" value="" v-on:click="OnCheckAll" v-model="IsCheckAll">
                                </th>
                                <th class="col-xs-1">檔案代號</th>
                                <th class="col-xs-1">欄位名稱</th>
                                <th class="col-xs-2">中文說明-繁體</th>
                                <th class="col-xs-1">程式代號</th>
                                <th class="col-xs-1">新增日期</th>
                                <th class="col-xs-2">中文說明-簡體</th>
                                <th class="col-xs-1">英文說明</th>
                                <th class="col-xs-2">操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="cnf05Item in Cnf05List">
                                <td class="col-xs-1">
                                    <input type="checkbox" v-model="cnf05Item.checked">
                                </td>
                                <td class="col-xs-1">{{cnf05Item.cnf0501_file}}</td>
                                <td class="col-xs-1">{{cnf05Item.cnf0502_field}}</td>
                                <td class="col-xs-2">{{cnf05Item.cnf0503_fieldname_tw}}</td>
                                <td class="col-xs-1">{{cnf05Item.cnf0506_program}}</td>
                                <td class="col-xs-1">{{new Date(cnf05Item.adddate).dateFormat('Y/m/d')}}</td>
                                <td class="col-xs-2">{{cnf05Item.cnf0504_fieldname_cn}}</td>
                                <td class="col-xs-1">{{cnf05Item.cnf0505_fieldname_en}}</td>
                                <td class="col-xs-2">
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

                <div v-if="false" class="card card-block bg-faded">
                    <uib-pagination v-model="Pagination" v-bind:total-items="22"></uib-pagination>
                </div>
            </div>
        </div>


        <div class="modal fade" id="EditDialog" ref="EditDialog">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title"></h4>
                    </div>
                    <div class="modal-body">

                        <table class="table table-borderless">
                            <tbody>
                                <tr>
                                    <td>檔案代號</td>
                                    <td>
                                        <input type="text"
                                            v-model="EditDialog.cnf0501_file">
                                    </td>
                                </tr>
                                <tr>
                                    <td>欄位名稱</td>
                                    <td>
                                        <input type="text"
                                            v-model="EditDialog.cnf0502_field">
                                    </td>
                                </tr>
                                <tr>
                                    <td>中文說明-繁體</td>
                                    <td>
                                        <input type="text"
                                            v-model="EditDialog.cnf0503_fieldname_tw">
                                    </td>
                                </tr>
                                <tr>
                                    <td>中文說明-簡體</td>
                                    <td>
                                        <input type="text"
                                            v-model="EditDialog.cnf0504_fieldname_cn">
                                    </td>
                                </tr>
                                <tr>
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
                                <tr>
                                    <td>備註</td>
                                    <td>
                                        <input type="text"
                                            v-model="EditDialog.remark">
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <div class="col-xs-3 no-padding">
                                            <div class="col-xs-5 no-padding">
                                                新增者
                                            </div>
                                            <input class="col-xs-7" type="text"
                                                v-model="EditDialog.adduser">
                                        </div>
                                        <div class="col-xs-3 ">
                                            <div class="col-xs-5 no-padding">
                                                新增日期
                                            </div>
                                            <vue-datetimepicker ref="AddDate" class="col-xs-7" placeholder=""
                                                v-model="EditDialog.adddate"></vue-datetimepicker>
                                        </div>
                                        <div class="col-xs-3">
                                            <div class="col-xs-5 no-padding">
                                                修改者
                                            </div>
                                            <input class="col-xs-7" type="text"
                                                v-model="EditDialog.moduser">
                                        </div>
                                        <div class="col-xs-3">
                                            <div class="col-xs-5 no-padding">
                                                修改日期
                                            </div>
                                            <vue-datetimepicker ref="ModDate" class="col-xs-7" placeholder=""
                                                v-model="EditDialog.moddate"></vue-datetimepicker>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <function-button data-dismiss="modal"
                            hot-key="f12">
                            離開
                        </function-button>
                        <function-button class="btn btn-primary"
                            hot-key="f5"
                            v-on:click.native="OnEditDialogSubmit">
                            存檔
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
