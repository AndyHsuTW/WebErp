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
                    <function-button hot-key="f2" v-on:click.native="InvoiceOpening()">發票開立</function-button>
                    <function-button hot-key="f3" v-on:click.native="InvoicePrint()">發票列印</function-button>
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
                                <vue-datetimepicker placeholder="" v-model="Filters.deli_date_start" v-bind:value="Filters.deli_date_start"></vue-datetimepicker>
                                迄
                                <vue-datetimepicker placeholder="" v-model="Filters.deli_date_end" v-bind:value="Filters.deli_date_end"></vue-datetimepicker>
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
                                <vue-datetimepicker placeholder="" v-model="Filters.inv_date_start" v-bind:value="Filters.inv_date_start"></vue-datetimepicker>
                                迄
                                <vue-datetimepicker placeholder="" v-model="Filters.inv_date_end" v-bind:value="Filters.inv_date_end"></vue-datetimepicker>
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
                                    <th class="sort-item" v-on:click="OnTableSorting('saf2002_serial',$event)">交易序號
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
                                    <th class="sort-item" v-on:click="OnTableSorting('saf2014_rec_name',$event)">收件人
                                        <i class="fa fa-fw fa-sort"></i>
                                    </th>
                                    <th class="sort-item" v-on:click="OnTableSorting('saf2015_rec_cell',$event)">手機
                                        <i class="fa fa-fw fa-sort"></i>
                                    </th>
                                    <th class="sort-item" v-on:click="OnTableSorting('saf20110_printmark',$event)">印
                                        <i class="fa fa-fw fa-sort"></i>
                                    </th>
                                    <th>發票號碼
                                        
                                    </th>
                                    <th >發票日期
                                        
                                    </th>


                                    <th>商品編號
                                      
                                    </th>
                                    <th>商品名稱
                                        
                                    </th>
                                    <th >規格
                                       
                                    </th>
                                    <th >顏色
                                       
                                    </th>

                                    <th >訂單編號
                                      
                                    </th>

                                </tr>

                            </thead>
                            <tbody>
                                <template v-for="Order in OrderList">
                                    <tr>
                                        <td v-bind:rowspan="Order.OrderbodyDataList.length">
                                            <input type="checkbox" v-model="Order.checked">
                                        </td>
                                        <td v-bind:rowspan="Order.OrderbodyDataList.length">{{Order.saf2001_cuscode}}</td>
                                        <td v-bind:rowspan="Order.OrderbodyDataList.length">{{Order.saf2002_serial}}</td>
                                        <td v-bind:rowspan="Order.OrderbodyDataList.length">{{Order. saf20103_sales_amt}}</td>
                                        <td v-bind:rowspan="Order.OrderbodyDataList.length">{{Order.saf20105_tax}}</td>
                                        <td v-bind:rowspan="Order.OrderbodyDataList.length">{{Order.af20106_total_amt}}</td>
                                        <td v-bind:rowspan="Order.OrderbodyDataList.length">{{Order.saf2046_mana_fee}}</td>
                                        <td v-bind:rowspan="Order.OrderbodyDataList.length">{{Order.saf20107_tax_id}}</td>
                                        <td v-bind:rowspan="Order.OrderbodyDataList.length">{{Order.saf2014_rec_name}}</td>
                                        <td v-bind:rowspan="Order.OrderbodyDataList.length">{{Order.saf2015_rec_cell}}</td>
                                        <td v-bind:rowspan="Order.OrderbodyDataList.length">{{Order.saf20110_printmark}}</td>
                                    </tr>
                                    <tr v-for="Orderbody in Order.OrderbodyDataList">
                                        <td>{{Orderbody.saf20a38_inv_no}}</td>
                                        <td>{{Orderbody.saf20a39_inv_date}}</td>
                                        <td>{{Orderbody.saf20a37_pcode}}</td>
                                        <td>{{Orderbody.saf20a31_psname}}</td>
                                        <td>{{Orderbody.saf20a32_pname}}</td>
                                        <td>{{Orderbody.saf20a34_ship_pname}}</td>
                                        <td>{{Orderbody.saf20a03_ord_no}}</td>

                                    </tr>
                                </template>

                            </tbody>

                        </table>
                    </div>
                    <div>
                        <button type="button" class="btn btn-default" v-on:click="OnCheckAll(true)" >
                            全選
                        </button>
                        <button type="button" class="btn btn-default" v-on:click="OnCheckAll(false)">
                            全不選
                        </button>

                    </div>

                </div>




            </div>



        </div>

    </asp:Content>