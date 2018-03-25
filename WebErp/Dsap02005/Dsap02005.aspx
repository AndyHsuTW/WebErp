<%@ Page Title="" Language="C#" MasterPageFile="~/master/BaseMasterPage.master" AutoEventWireup="true" CodeFile="Dsap02005.aspx.cs" Inherits="Dsap02005_Dsap02005" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .app-title {
            background-color: #3097D1;
            color: #FFF;
        }

        .app-body {
            padding-left: 5px;
        }

        .padding-table td {
            padding: 4px;
        }

        .sort-item {
            cursor: pointer;
        }

        .scroll-table {
            height: 450px;
            overflow-y: auto;
            border: solid 1px #CCC;
        }
    </style>


    <script>
        (function () {
            requirejs.config({
                paths: {
                    "Dsap02005": "Dsap02005/Dsap02005",
                },
                shim: {}
            });
            var requiredFiles = ["Dsap02005"];


            function onLoaded(Dsap02005) {
                window.Dsap02005.Init();
            }

            function onError(error) {
                console.error(error);
            }

            require(requiredFiles, onLoaded, onError);
        })();
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div id="content" v-cloak>
        <ul class="app-title">
            <li>銷項發票開立及列印<%=AppVersion %></li>
        </ul>
        <div class="app-body">
            <div class="common-button-div">
                <function-button hot-key="f1" v-on:click.native="OnSearch()">出貨查詢</function-button>
                <function-button hot-key="f2" v-on:click.native="">發票開立</function-button>
                <function-button hot-key="f3" v-on:click.native="">發票列印</function-button>
                <function-button hot-key="f4" v-on:click.native="">檢貨明細及簡表列印</function-button>
                <function-button hot-key="f5" v-on:click.native="">發票明細查詢</function-button>
            </div>
            <div class="filter-div">
                <table class="padding-table">
                    <tr>
                        <td>訂單來源</td>
                        <td>起
                            <input type="text" />
                            迄
                           <input type="text" />
                        </td>

                        <td>出貨日期</td>
                        <td>起
                            <vue-datetimepicker placeholder=""></vue-datetimepicker>
                            迄
                            <vue-datetimepicker placeholder=""></vue-datetimepicker>
                        </td>

                        <td>交易序號</td>
                        <td>起
                            <input type="text" />
                            迄
                           <input type="text" />
                        </td>
                    </tr>
                    <tr>
                        <td>發票日期</td>
                        <td>起
                            <vue-datetimepicker placeholder=""></vue-datetimepicker>
                            迄
                            <vue-datetimepicker placeholder=""></vue-datetimepicker>
                        </td>
                        </td>

                        <td>發票號碼</td>
                        <td>起
                            <input type="text" />
                            迄
                           <input type="text" />
                        </td>

                        <td>發票開立</td>
                        <td>
                            <label class="checkbox-inline">
                                <input type="checkbox" value="" />尚未開立</label>
                            <label class="checkbox-inline">
                                <input type="checkbox" value="" />已經開立</label>
                        </td>
                    </tr>

                </table>
            </div>
            <div class="result-div">
                <div class="scroll-table" style="font-size: 14px;">
                    <table class="table table-bordered sortable" style="width: 100%">
                        <thead>
                            <tr class="bg-primary text-light">
                                <th style="text-align: center"></th>

                                <th class="sort-item" v-on:click="OnTableSorting('Email',$event)">訂單來源<i class="fa fa-fw fa-sort"></i></th>
                                <th class="sort-item" v-on:click="OnTableSorting('Email',$event)">發票號碼<i class="fa fa-fw fa-sort"></i></th>
                                <th class="sort-item" v-on:click="OnTableSorting('UpdateTime',$event)">發票日期<i class="fa fa-fw fa-sort"></i></th>
                                <th class="sort-item" v-on:click="OnTableSorting('UpdateTime',$event)">銷售額<i class="fa fa-fw fa-sort"></i></th>
                                <th class="sort-item" v-on:click="OnTableSorting('UpdateTime',$event)">稅額<i class="fa fa-fw fa-sort"></i></th>
                                <th class="sort-item" v-on:click="OnTableSorting('UpdateTime',$event)">總計<i class="fa fa-fw fa-sort"></i></th>
                                <th class="sort-item" v-on:click="OnTableSorting('UpdateTime',$event)">運費<i class="fa fa-fw fa-sort"></i></th>
                                <th class="sort-item" v-on:click="OnTableSorting('UpdateTime',$event)">統一編號<i class="fa fa-fw fa-sort"></i></th>
                                <th class="sort-item" v-on:click="OnTableSorting('UpdateTime',$event)">商品編號<i class="fa fa-fw fa-sort"></i></th>
                                <th class="sort-item" v-on:click="OnTableSorting('UpdateTime',$event)">商品名稱<i class="fa fa-fw fa-sort"></i></th>
                                <th class="sort-item" v-on:click="OnTableSorting('UpdateTime',$event)">規格<i class="fa fa-fw fa-sort"></i></th>
                                <th class="sort-item" v-on:click="OnTableSorting('UpdateTime',$event)">顏色<i class="fa fa-fw fa-sort"></i></th>
                                <th class="sort-item" v-on:click="OnTableSorting('UpdateTime',$event)">交易序號<i class="fa fa-fw fa-sort"></i></th>
                                <th class="sort-item" v-on:click="OnTableSorting('UpdateTime',$event)">訂單編號  <i class="fa fa-fw fa-sort"></i></th>
                                <th class="sort-item" v-on:click="OnTableSorting('UpdateTime',$event)">收件人<i class="fa fa-fw fa-sort"></i></th>
                                <th class="sort-item" v-on:click="OnTableSorting('UpdateTime',$event)">手機<i class="fa fa-fw fa-sort"></i></th>
                                <th class="sort-item" v-on:click="OnTableSorting('UpdateTime',$event)">印<i class="fa fa-fw fa-sort"></i></th>
                            </tr>

                        </thead>
                        <tbody>
                            <tr v-for="User in UserInfoList">
                                <td  style="text-align: center">
                                    <input type="checkbox" v-model="User.checked">
                                </td>

                            </tr>
                        </tbody>

                    </table>
                </div>
                <div>
                    <button type="button"  class="btn btn-default">全選
                </button> <button type="button"  class="btn btn-default">全不選
                </button>

                </div>

            </div>
           



        </div>


    </div>

</asp:Content>

