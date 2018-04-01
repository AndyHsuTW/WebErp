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
                <li>銷項發票開立及列印
                    <%=AppVersion %>
                </li>
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
                                <input type="text" v-model="Filters.cuscode_start" /> 迄
                                <input type="text" v-model="Filters.cuscode_end" />
                            </td>

                            <td>出貨日期</td>
                            <td>起
                                <vue-datetimepicker placeholder="" v-model="Filters.deli_date_start" :value="Filters.deli_date_start"></vue-datetimepicker>
                                迄
                                <vue-datetimepicker placeholder="" v-model="Filters.deli_date_end" :value="Filters.deli_date_end"></vue-datetimepicker>
                            </td>

                            <td>交易序號</td>
                            <td>起
                                <input type="text" v-model="Filters.serial_start" /> 迄
                                <input type="text" v-model="Filters.serial_end" />
                            </td>
                        </tr>
                        <tr>
                            <td>發票日期</td>
                            <td>起
                                <vue-datetimepicker placeholder="" v-model="Filters.inv_date_start" :value="Filters.inv_date_start"></vue-datetimepicker>
                                迄
                                <vue-datetimepicker placeholder="" v-model="Filters.inv_date_end" :value="Filters.inv_date_end"></vue-datetimepicker>
                            </td>
                            </td>

                            <td>發票號碼</td>
                            <td>起
                                <input type="text" v-model="Filters.inv_no_start" /> 迄
                                <input type="text" v-model="Filters.inv_no_end" />
                            </td>

                            <td>發票開立</td>
                            <td>
                                <label class="checkbox-inline">
                                    <input type="checkbox" v-model="Filters.inv_no_n" />尚未開立</label>
                                <label class="checkbox-inline">
                                    <input type="checkbox" v-model="Filters.inv_no_y" />已經開立</label>
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

                                    <th class="sort-item" v-on:click="OnTableSorting('saf2001_cuscode',$event)">訂單來源
                                        <i class="fa fa-fw fa-sort"></i>
                                    </th>
                                    <th class="sort-item" v-on:click="OnTableSorting('saf2038a_inv_no',$event)">發票號碼
                                        <i class="fa fa-fw fa-sort"></i>
                                    </th>
                                    <th class="sort-item" v-on:click="OnTableSorting('saf2039a_inv_date',$event)">發票日期
                                        <i class="fa fa-fw fa-sort"></i>
                                    </th>
                                    <th class="sort-item" v-on:click="OnTableSorting('saf20103_sales_amt',$event)">銷售額
                                        <i class="fa fa-fw fa-sort"></i>
                                    </th>
                                    <th class="sort-item" v-on:click="OnTableSorting('saf20105_tax',$event)">稅額
                                        <i class="fa fa-fw fa-sort"></i>
                                    </th>
                                    <th class="sort-item" v-on:click="OnTableSorting('af20106_total_amt',$event)">總計
                                        <i class="fa fa-fw fa-sort"></i>
                                    </th>
                                    <th class="sort-item" v-on:click="OnTableSorting('saf2046_mana_fee',$event)">運費
                                        <i class="fa fa-fw fa-sort"></i>
                                    </th>
                                    <th class="sort-item" v-on:click="OnTableSorting('saf20107_tax_id',$event)">統一編號
                                        <i class="fa fa-fw fa-sort"></i>
                                    </th>
                                    <th class="sort-item" v-on:click="OnTableSorting('saf20a37_pcode',$event)">商品編號
                                        <i class="fa fa-fw fa-sort"></i>
                                    </th>
                                    <th class="sort-item" v-on:click="OnTableSorting('saf20a31_psname',$event)">商品名稱
                                        <i class="fa fa-fw fa-sort"></i>
                                    </th>
                                    <th class="sort-item" v-on:click="OnTableSorting('saf20a34_ship_pname',$event)">規格
                                        <i class="fa fa-fw fa-sort"></i>
                                    </th>
                                    <th class="sort-item" v-on:click="OnTableSorting('saf20a34_ship_pname',$event)">顏色
                                        <i class="fa fa-fw fa-sort"></i>
                                    </th>
                                    <th class="sort-item" v-on:click="OnTableSorting('saf2002_serial',$event)">交易序號
                                        <i class="fa fa-fw fa-sort"></i>
                                    </th>
                                    <th class="sort-item" v-on:click="OnTableSorting('saf20a03_ord_no',$event)">訂單編號
                                        <i class="fa fa-fw fa-sort"></i>
                                    </th>
                                    <th class="sort-item" v-on:click="OnTableSorting('saf2014_rec_name',$event)">收件人
                                        <i class="fa fa-fw fa-sort"></i>
                                    </th>
                                    <th class="sort-item" v-on:click="OnTableSorting('saf2015_rec_cell',$event)">手機
                                        <i class="fa fa-fw fa-sort"></i>
                                    </th>
                                    <th class="sort-item" v-on:click="OnTableSorting('saf20110_printmark',$event)">印
                                        <i class="fa fa-fw fa-sort"></i>
                                    </th>
                                </tr>

                            </thead>
                            <tbody>
                                <tr v-for="Order in OrderList">
                                    <td>
                                        <input type="checkbox" v-model="Order.checked">
                                    </td>
                                    <td>{{Order.saf2001_cuscode}}</td>
                                    <td>{{Order.saf2038a_inv_no}}</td>
                                    <td>{{Order.saf2039a_inv_date}}</td>
                                    <td>{{Order. saf20103_sales_amt}}</td>
                                    <td>{{Order.saf20105_tax}}</td>
                                    <td>{{Order.af20106_total_amt}}</td>
                                    <td>{{Order.saf2046_mana_fee}}</td>
                                    <td>{{Order.saf20107_tax_id}}</td>
                                    <td>{{Order.saf20a37_pcode}}</td>
                                    <td>{{Order.saf20a31_psname}}</td>
                                    <td>{{Order.saf20a32_pname}}</td>
                                    <td>{{Order.saf20a34_ship_pname}}</td>
                                    <td>{{Order. saf2002_serial}}</td>
                                    <td>{{Order.saf20a03_ord_no}}</td>
                                    <td>{{Order.saf2014_rec_name}}</td>
                                    <td>{{Order.saf2015_rec_cell}}</td>
                                    <td>{{Order.saf20110_printmark}}</td>

                                </tr>
                            </tbody>

                        </table>
                    </div>
                    <div>
                        <button type="button" class="btn btn-default">
                            全選
                        </button>
                        <button type="button" class="btn btn-default">
                            全不選
                        </button>

                    </div>

                </div>




            </div>



        </div>

    </asp:Content>