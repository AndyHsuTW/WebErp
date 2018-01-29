<%@ Page Title="" Language="C#" MasterPageFile="~/master/BaseMasterPage.master" AutoEventWireup="true" CodeFile="Dsap92501.aspx.cs" Inherits="Dsap92501_Dsap92501" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .app-title {
            background-color: #3097D1;
            color: #FFF;
        }

        .app-body {
            padding-left: 5px;
        }

        .filter-div {
            margin-top: 5px;
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

        .result-div {
            margin-top: 5px;
        }

        .table-borderless > tbody > tr > td,
        .table-borderless > tbody > tr > th,
        .table-borderless > tfoot > tr > td,
        .table-borderless > tfoot > tr > th,
        .table-borderless > thead > tr > td,
        .table-borderless > thead > tr > th {
            border: none;
        }

        .rowclass:hover {
            background-color: #bde7ff;
        }

        /*head*/
        .table-fixed {
            table-layout: fixed;
            margin: auto;
        }

            .table-fixed > thead > th, .table-fixed > tbody > td {
                padding: 5px 10px;
                border: 1px solid #000;
            }

            .table-fixed > thead, .table-fixed > tfoot {
                display: table;
                width: 100%;
                width: calc(100% - 18px);
            }

            .table-fixed > tbody {
                height: 400px;
                overflow: auto;
                overflow-x: hidden;
                display: block;
                width: 100%;
            }

                .table-fixed > tbody > tr {
                    display: table;
                    width: 100%;
                    table-layout: fixed;
                }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="Dspa92501" v-cloak>

        <ul class="app-title">
            <li><%=Page.Title %></li>
        </ul>
        <div class="app-body">

            <div class="filter-div">
                <table>


                    <tr>
                        <td style="padding: 3px">步驟1：選擇訂單日期
                        </td>
                        <td style="padding: 3px">
                            <vue-datetimepicker placeholder="選擇訂單日期" v-bind:value="DateTime" v-model="DateTime" style="width: 90px"></vue-datetimepicker>
                        </td>
                        <td style="padding: 3px">步驟2：
                        </td>
                        <td style="padding: 3px">
                            <function-button hot-key="f1" v-on:click.native="Upload()">選擇訂單檔案</function-button>
                            <input type="file" id="ImportExcelInput" accept=".csv,.xls,.xlsx" multiple style="display: none" v-on:change="onMultipleFileChange">
                        </td>
                        <td style="padding: 3px">步驟3：
                        </td>
                        <td style="padding: 3px">

                            <function-button hot-key="f4" v-on:click.native="MultipleSubmit()">檔案送出比對</function-button>
                        </td>
                        <td style="padding: 3px">步驟4：
                        </td>
                        <td style="padding: 3px">
                            <function-button hot-key="f9" v-on:click.native="ImportAll()">檔案匯入資料庫</function-button>
                        </td>
                    </tr>
                </table>

            </div>


            <div class="result-div" style="height: 800px; overflow-y: auto; overflow-y: overlay;">
                <div>
                    <table class="table table-bordered" style="width: 250px;">
                        <thead>
                            <tr class="bg-primary text-light">
                                <th>檔案</th>
                                <th>檔案大小</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr class="rowclass" v-for="file in MultipleFile">
                                <td>{{file.name}}</td>
                                <td>
                                    <div v-text="bytesToSize(file.size)"></div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div>
                    <div class="result-div">
                        <div class="scroll-table" v-if="MOMO.open">
                            <table class="table table-bordered">
                                <thead>
                                    <tr class="">
                                        <th colspan="14" style="border: 1px solid white">
                                            <div>
                                                <table>
                                                    <tr>
                                                        <td style="padding: 3px">
                                                            <input type="checkbox" v-model="MOMO.checked" /></td>
                                                        <td style="padding: 3px">{{MOMO.saf25FileInfo.FileName}}</td>
                                                        <td style="padding: 3px">

                                                            <label class="btn btn-default">
                                                                <input style="display: none;" type="file" accept=".csv,.xls,.xlsx" v-on:change="onFileChange('MOMO', $event)">
                                                                重新送出檔案比對
                                                            </label>
                                                    </tr>
                                                </table>
                                            </div>
                                        </th>
                                    </tr>
                                    <tr class="bg-primary text-light">
                                        <th>項次+燈號</th>
                                        <th>訂單編號</th>
                                        <th>配送狀態</th>
                                        <th>配送訊息</th>
                                        <th>約定配送日</th>
                                        <th>物流公司</th>
                                        <th>配送單號</th>
                                        <th>訂單類別</th>
                                        <th>客戶配送需求</th>
                                        <th>轉單日</th>
                                        <th>預計出貨日</th>
                                        <th>收件人姓名</th>
                                        <th>收件人行動電話</th>
                                        <th>收件人地址</th>
                                        <th>商品原廠編號</th>
                                        <th>品號</th>
                                        <th>品名</th>
                                        <th>單名編號</th>
                                        <th>單名編號</th>
                                        <th>單品詳細</th>
                                        <th>數量</th>
                                        <th>進價(含稅)</th>
                                        <th>贈品</th>
                                        <th>訂購人姓名</th>
                                        <th>發票號碼</th>
                                        <th>發票日期</th>
                                        <th>個人識別碼</th>
                                        <th>群組變價商品</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="saf25 in MOMO.saf25FileInfo.saf25List">
                                        <td>{{saf25.saf2502_seq}}</td>
                                        <td>{{saf25.saf2503_ord_no}}</td>
                                        <td>{{saf25.saf2506_ord_status}}</td>
                                        <td>{{saf25.saf2505_ord_remark}}</td>
                                        <td>{{saf25.saf2520_dis_date}}</td>
                                        <td>{{saf25.saf2529_logis_no}}</td>
                                        <td>{{saf25.saf2528_fre_no}}</td>
                                        <td>{{saf25.saf2507_ord_class}}</td>
                                        <td>{{saf25.saf2522_dis_demand}}</td>
                                        <td>{{saf25.saf2504_ord_date}}</td>
                                        <td>{{saf25.saf2523_ship_date}}</td>
                                        <td>{{saf25.saf2514_rec_name}}</td>
                                        <td>{{saf25.saf2516_rec_tel01}}</td>
                                        <td>{{saf25.saf2515_rec_cell}}</td>
                                        <td>{{saf25.saf2519_rec_address}}</td>
                                        <td>{{saf25.saf2536_pcode_v}}</td>
                                        <td>{{saf25.saf2533_pspec}}</td>
                                        <td>{{saf25.saf2531_psname}}</td>
                                        <td>{{saf25.saf2537_pcode}}</td>
                                        <td>{{saf25.saf2532_pname}}</td>
                                        <td>{{saf25.saf2541_ord_qty}}</td>
                                        <td>{{saf25.saf2544_cost}}</td>
                                        <td>{{saf25.saf2553_gifts}}</td>
                                        <td>{{saf25.saf2510_ord_name}}</td>
                                        <td>{{saf25.saf2538_inv_no}}</td>
                                        <td>{{saf25.saf2539_inv_date}}</td>
                                        <td>{{saf25.saf2554_identifier}}</td>
                                        <td>{{saf25.saf2555_chg_price}}</td>

                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <div class="scroll-table" v-if="PChome.open">
                            <table class="table table-bordered">
                                <thead>
                                    <tr class="">
                                        <th colspan="14" style="border: 1px solid white">
                                            <div>
                                                <table>
                                                    <tr>
                                                        <td style="padding: 3px">
                                                            <input type="checkbox" v-model="PChome.checked" /></td>
                                                        <td style="padding: 3px">{{PChome.saf25FileInfo.FileName}}</td>
                                                        <td style="padding: 3px">
                                                            <label class="btn btn-default">
                                                                <input style="display: none;" type="file" accept=".csv,.xls,.xlsx" v-on:change="onFileChange('PChome', $event)">
                                                                重新送出檔案比對
                                                            </label>
                                                    </tr>
                                                </table>
                                            </div>
                                        </th>
                                    </tr>
                                    <tr class="bg-primary text-light">
                                        <th>訂單編號</th>
                                        <th>NO</th>
                                        <th>出貨單號</th>
                                        <th>確認</th>
                                        <th>出貨日期</th>
                                        <th>轉單日期</th>
                                        <th>預購日/指定配達日</th>
                                        <th>收貨人</th>
                                        <th>ZIP</th>
                                        <th>收貨地址(訂單編號)</th>
                                        <th>收貨人電話</th>
                                        <th>商品名稱</th>
                                        <th>下定時數量</th>
                                        <th>取消數量</th>
                                        <th>應出貨數量</th>
                                        <th>單位成本</th>
                                        <th>成本小計</th>
                                        <th>商品規格</th>
                                        <th>廠商料號</th>
                                        <th>備註</th>
                                        <th>客戶留言</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="saf25 in PChome.saf25FileInfo.saf25List">
                                        <td>{{saf25.saf2503_ord_no}}</td>
                                        <td>{{saf25.saf2502_seq}}</td>
                                        <td>{{saf25.saf2527_ship_no}}</td>
                                        <td>{{saf25.saf2506_ord_status}}</td>
                                        <td>{{saf25.saf2523_ship_date}}</td>
                                        <td>{{saf25.saf2504_ord_date}}</td>
                                        <td>{{saf25.saf2520_dis_date}}</td>
                                        <td>{{saf25.saf2514_rec_name}}</td>
                                        <td>{{saf25.saf2522_dis_demand}}</td>
                                        <td>{{saf25.saf2519_rec_address}}</td>
                                        <td>{{saf25.saf2515_rec_cell}}</td>
                                        <td>{{saf25.saf2531_psname}}</td>
                                        <td>{{saf25.saf2541_ord_qty}}</td>
                                        <td>{{saf25.saf2543_cancel_qty}}</td>
                                        <td>{{saf25.saf2540_ship_qty}}</td>
                                        <td>{{saf25.saf2544_cost}}</td>
                                        <td>{{saf25.saf2545_cost_sub}}</td>
                                        <td>{{saf25.saf2532_pname}}</td>
                                        <td>{{saf25.saf2536_pcode_v}}</td>
                                        <td>{{saf25.saf2505_ord_remark}}</td>
                                        <td>{{saf25.saf2556_leave_msg}}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <div class="scroll-table" v-if="Formosa_Plastics.open">
                            <table class="table table-bordered">
                                <thead>
                                    <tr class="">
                                        <th colspan="14" style="border: 1px solid white">
                                            <div>
                                                <table>
                                                    <tr>
                                                        <td style="padding: 3px">
                                                            <input type="checkbox" v-model="Formosa_Plastics.checked" /></td>
                                                        <td style="padding: 3px">{{Formosa_Plastics.saf25FileInfo.FileName}}</td>
                                                        <td style="padding: 3px">
                                                            <label class="btn btn-default">
                                                                <input style="display: none;" type="file" accept=".csv,.xls,.xlsx" v-on:change="onFileChange('Formosa_Plastics', $event)">
                                                                重新送出檔案比對
                                                            </label>
                                                    </tr>
                                                </table>
                                            </div>
                                        </th>
                                    </tr>
                                    <tr class="bg-primary text-light">
                                        <th>訂單編號</th>
                                        <th>NO</th>
                                        <th>出貨單號</th>
                                        <th>確認</th>
                                        <th>出貨日期</th>
                                        <th>轉單日期</th>
                                        <th>預購日/指定配達日</th>
                                        <th>收貨人</th>
                                        <th>ZIP</th>
                                        <th>收貨地址(訂單編號)</th>
                                        <th>收貨人電話</th>
                                        <th>商品名稱</th>
                                        <th>下定時數量</th>
                                        <th>取消數量</th>
                                        <th>應出貨數量</th>
                                        <th>單位成本</th>
                                        <th>成本小計</th>
                                        <th>商品規格</th>
                                        <th>廠商料號</th>
                                        <th>備註</th>
                                        <th>客戶留言</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="saf25 in Formosa_Plastics.saf25FileInfo.saf25List">
                                        <td>{{saf25.saf2503_ord_no}}</td>
                                        <td>{{saf25.saf2502_seq}}</td>
                                        <td>{{saf25.saf2527_ship_no}}</td>
                                        <td>{{saf25.saf2506_ord_status}}</td>
                                        <td>{{saf25.saf2523_ship_date}}</td>
                                        <td>{{saf25.saf2504_ord_date}}</td>
                                        <td>{{saf25.saf2520_dis_date}}</td>
                                        <td>{{saf25.saf2514_rec_name}}</td>
                                        <td>{{saf25.saf2522_dis_demand}}</td>
                                        <td>{{saf25.saf2519_rec_address}}</td>
                                        <td>{{saf25.saf2515_rec_cell}}</td>
                                        <td>{{saf25.saf2531_psname}}</td>
                                        <td>{{saf25.saf2541_ord_qty}}</td>
                                        <td>{{saf25.saf2543_cancel_qty}}</td>
                                        <td>{{saf25.saf2540_ship_qty}}</td>
                                        <td>{{saf25.saf2544_cost}}</td>
                                        <td>{{saf25.saf2545_cost_sub}}</td>
                                        <td>{{saf25.saf2532_pname}}</td>
                                        <td>{{saf25.saf2536_pcode_v}}</td>
                                        <td>{{saf25.saf2505_ord_remark}}</td>
                                        <td>{{saf25.saf2556_leave_msg}}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="scroll-table" v-if="Taiwan_Mobile.open">
                            <table class="table table-bordered">
                                <thead>
                                    <tr class="">
                                        <th colspan="14" style="border: 1px solid white">
                                            <div>
                                                <table>
                                                    <tr>
                                                        <td style="padding: 3px">
                                                            <input type="checkbox" v-model="Taiwan_Mobile.checked" /></td>
                                                        <td style="padding: 3px">{{Taiwan_Mobile.saf25FileInfo.FileName}}</td>
                                                        <td style="padding: 3px">
                                                            <label class="btn btn-default">
                                                                <input style="display: none;" type="file" accept=".csv,.xls,.xlsx" v-on:change="onFileChange('Taiwan_Mobile', $event)">
                                                                重新送出檔案比對
                                                            </label>
                                                    </tr>
                                                </table>
                                            </div>
                                        </th>
                                    </tr>
                                    <tr class="bg-primary text-light">
                                        <th>訂單編號</th>
                                        <th>NO</th>
                                        <th>出貨單號</th>
                                        <th>確認</th>
                                        <th>出貨日期</th>
                                        <th>轉單日期</th>
                                        <th>預購日/指定配達日</th>
                                        <th>收貨人</th>
                                        <th>ZIP</th>
                                        <th>收貨地址(訂單編號)</th>
                                        <th>收貨人電話</th>
                                        <th>商品名稱</th>
                                        <th>下定時數量</th>
                                        <th>取消數量</th>
                                        <th>應出貨數量</th>
                                        <th>單位成本</th>
                                        <th>成本小計</th>
                                        <th>商品規格</th>
                                        <th>廠商料號</th>
                                        <th>備註</th>
                                        <th>客戶留言</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="saf25 in Taiwan_Mobile.saf25FileInfo.saf25List">
                                        <td>{{saf25.saf2503_ord_no}}</td>
                                        <td>{{saf25.saf2502_seq}}</td>
                                        <td>{{saf25.saf2527_ship_no}}</td>
                                        <td>{{saf25.saf2506_ord_status}}</td>
                                        <td>{{saf25.saf2523_ship_date}}</td>
                                        <td>{{saf25.saf2504_ord_date}}</td>
                                        <td>{{saf25.saf2520_dis_date}}</td>
                                        <td>{{saf25.saf2514_rec_name}}</td>
                                        <td>{{saf25.saf2522_dis_demand}}</td>
                                        <td>{{saf25.saf2519_rec_address}}</td>
                                        <td>{{saf25.saf2515_rec_cell}}</td>
                                        <td>{{saf25.saf2531_psname}}</td>
                                        <td>{{saf25.saf2541_ord_qty}}</td>
                                        <td>{{saf25.saf2543_cancel_qty}}</td>
                                        <td>{{saf25.saf2540_ship_qty}}</td>
                                        <td>{{saf25.saf2544_cost}}</td>
                                        <td>{{saf25.saf2545_cost_sub}}</td>
                                        <td>{{saf25.saf2532_pname}}</td>
                                        <td>{{saf25.saf2536_pcode_v}}</td>
                                        <td>{{saf25.saf2505_ord_remark}}</td>
                                        <td>{{saf25.saf2556_leave_msg}}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="scroll-table" v-if="Buy123.open">
                            <table class="table table-bordered">
                                <thead>
                                    <tr class="">
                                        <th colspan="14" style="border: 1px solid white">
                                            <div>
                                                <table>
                                                    <tr>
                                                        <td style="padding: 3px">
                                                            <input type="checkbox" v-model="Buy123.checked" /></td>
                                                        <td style="padding: 3px">{{Buy123.saf25FileInfo.FileName}}</td>
                                                        <td style="padding: 3px">
                                                            <label class="btn btn-default">
                                                                <input style="display: none;" type="file" accept=".csv,.xls,.xlsx" v-on:change="onFileChange('Buy123', $event)">
                                                                重新送出檔案比對
                                                            </label>
                                                    </tr>
                                                </table>
                                            </div>
                                        </th>
                                    </tr>
                                    <tr class="bg-primary text-light">
                                        <th>訂單編號</th>
                                        <th>NO</th>
                                        <th>出貨單號</th>
                                        <th>確認</th>
                                        <th>出貨日期</th>
                                        <th>轉單日期</th>
                                        <th>預購日/指定配達日</th>
                                        <th>收貨人</th>
                                        <th>ZIP</th>
                                        <th>收貨地址(訂單編號)</th>
                                        <th>收貨人電話</th>
                                        <th>商品名稱</th>
                                        <th>下定時數量</th>
                                        <th>取消數量</th>
                                        <th>應出貨數量</th>
                                        <th>單位成本</th>
                                        <th>成本小計</th>
                                        <th>商品規格</th>
                                        <th>廠商料號</th>
                                        <th>備註</th>
                                        <th>客戶留言</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="saf25 in Buy123.saf25FileInfo.saf25List">
                                        <td>{{saf25.saf2503_ord_no}}</td>
                                        <td>{{saf25.saf2502_seq}}</td>
                                        <td>{{saf25.saf2527_ship_no}}</td>
                                        <td>{{saf25.saf2506_ord_status}}</td>
                                        <td>{{saf25.saf2523_ship_date}}</td>
                                        <td>{{saf25.saf2504_ord_date}}</td>
                                        <td>{{saf25.saf2520_dis_date}}</td>
                                        <td>{{saf25.saf2514_rec_name}}</td>
                                        <td>{{saf25.saf2522_dis_demand}}</td>
                                        <td>{{saf25.saf2519_rec_address}}</td>
                                        <td>{{saf25.saf2515_rec_cell}}</td>
                                        <td>{{saf25.saf2531_psname}}</td>
                                        <td>{{saf25.saf2541_ord_qty}}</td>
                                        <td>{{saf25.saf2543_cancel_qty}}</td>
                                        <td>{{saf25.saf2540_ship_qty}}</td>
                                        <td>{{saf25.saf2544_cost}}</td>
                                        <td>{{saf25.saf2545_cost_sub}}</td>
                                        <td>{{saf25.saf2532_pname}}</td>
                                        <td>{{saf25.saf2536_pcode_v}}</td>
                                        <td>{{saf25.saf2505_ord_remark}}</td>
                                        <td>{{saf25.saf2556_leave_msg}}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="scroll-table" v-if="Eastern.open">
                            <table class="table table-bordered">
                                <thead>
                                    <tr class="">
                                        <th colspan="14" style="border: 1px solid white">
                                            <div>
                                                <table>
                                                    <tr>
                                                        <td style="padding: 3px">
                                                            <input type="checkbox" v-model="Eastern.checked" /></td>
                                                        <td style="padding: 3px">{{Eastern.saf25FileInfo.FileName}}</td>
                                                        <td style="padding: 3px">
                                                            <label class="btn btn-default">
                                                                <input style="display: none;" type="file" accept=".csv,.xls,.xlsx" v-on:change="onFileChange('Eastern', $event)">
                                                                重新送出檔案比對
                                                            </label>
                                                    </tr>
                                                </table>
                                            </div>
                                        </th>
                                    </tr>
                                    <tr class="bg-primary text-light">
                                        <th>訂單編號</th>
                                        <th>NO</th>
                                        <th>出貨單號</th>
                                        <th>確認</th>
                                        <th>出貨日期</th>
                                        <th>轉單日期</th>
                                        <th>預購日/指定配達日</th>
                                        <th>收貨人</th>
                                        <th>ZIP</th>
                                        <th>收貨地址(訂單編號)</th>
                                        <th>收貨人電話</th>
                                        <th>商品名稱</th>
                                        <th>下定時數量</th>
                                        <th>取消數量</th>
                                        <th>應出貨數量</th>
                                        <th>單位成本</th>
                                        <th>成本小計</th>
                                        <th>商品規格</th>
                                        <th>廠商料號</th>
                                        <th>備註</th>
                                        <th>客戶留言</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="saf25 in Eastern.saf25FileInfo.saf25List">
                                        <td>{{saf25.saf2503_ord_no}}</td>
                                        <td>{{saf25.saf2502_seq}}</td>
                                        <td>{{saf25.saf2527_ship_no}}</td>
                                        <td>{{saf25.saf2506_ord_status}}</td>
                                        <td>{{saf25.saf2523_ship_date}}</td>
                                        <td>{{saf25.saf2504_ord_date}}</td>
                                        <td>{{saf25.saf2520_dis_date}}</td>
                                        <td>{{saf25.saf2514_rec_name}}</td>
                                        <td>{{saf25.saf2522_dis_demand}}</td>
                                        <td>{{saf25.saf2519_rec_address}}</td>
                                        <td>{{saf25.saf2515_rec_cell}}</td>
                                        <td>{{saf25.saf2531_psname}}</td>
                                        <td>{{saf25.saf2541_ord_qty}}</td>
                                        <td>{{saf25.saf2543_cancel_qty}}</td>
                                        <td>{{saf25.saf2540_ship_qty}}</td>
                                        <td>{{saf25.saf2544_cost}}</td>
                                        <td>{{saf25.saf2545_cost_sub}}</td>
                                        <td>{{saf25.saf2532_pname}}</td>
                                        <td>{{saf25.saf2536_pcode_v}}</td>
                                        <td>{{saf25.saf2505_ord_remark}}</td>
                                        <td>{{saf25.saf2556_leave_msg}}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="scroll-table" v-if="Pcone.open">
                            <table class="table table-bordered">
                                <thead>
                                    <tr class="">
                                        <th colspan="14" style="border: 1px solid white">
                                            <div>
                                                <table>
                                                    <tr>
                                                        <td style="padding: 3px">
                                                            <input type="checkbox" v-model="Pcone.checked" /></td>
                                                        <td style="padding: 3px">{{Pcone.saf25FileInfo.FileName}}</td>
                                                        <td style="padding: 3px">
                                                            <label class="btn btn-default">
                                                                <input style="display: none;" type="file" accept=".csv,.xls,.xlsx" v-on:change="onFileChange('Pcone', $event)">
                                                                重新送出檔案比對
                                                            </label>
                                                    </tr>
                                                </table>
                                            </div>
                                        </th>
                                    </tr>
                                    <tr class="bg-primary text-light">
                                        <th>訂單編號</th>
                                        <th>NO</th>
                                        <th>出貨單號</th>
                                        <th>確認</th>
                                        <th>出貨日期</th>
                                        <th>轉單日期</th>
                                        <th>預購日/指定配達日</th>
                                        <th>收貨人</th>
                                        <th>ZIP</th>
                                        <th>收貨地址(訂單編號)</th>
                                        <th>收貨人電話</th>
                                        <th>商品名稱</th>
                                        <th>下定時數量</th>
                                        <th>取消數量</th>
                                        <th>應出貨數量</th>
                                        <th>單位成本</th>
                                        <th>成本小計</th>
                                        <th>商品規格</th>
                                        <th>廠商料號</th>
                                        <th>備註</th>
                                        <th>客戶留言</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="saf25 in Pcone.saf25FileInfo.saf25List">
                                        <td>{{saf25.saf2503_ord_no}}</td>
                                        <td>{{saf25.saf2502_seq}}</td>
                                        <td>{{saf25.saf2527_ship_no}}</td>
                                        <td>{{saf25.saf2506_ord_status}}</td>
                                        <td>{{saf25.saf2523_ship_date}}</td>
                                        <td>{{saf25.saf2504_ord_date}}</td>
                                        <td>{{saf25.saf2520_dis_date}}</td>
                                        <td>{{saf25.saf2514_rec_name}}</td>
                                        <td>{{saf25.saf2522_dis_demand}}</td>
                                        <td>{{saf25.saf2519_rec_address}}</td>
                                        <td>{{saf25.saf2515_rec_cell}}</td>
                                        <td>{{saf25.saf2531_psname}}</td>
                                        <td>{{saf25.saf2541_ord_qty}}</td>
                                        <td>{{saf25.saf2543_cancel_qty}}</td>
                                        <td>{{saf25.saf2540_ship_qty}}</td>
                                        <td>{{saf25.saf2544_cost}}</td>
                                        <td>{{saf25.saf2545_cost_sub}}</td>
                                        <td>{{saf25.saf2532_pname}}</td>
                                        <td>{{saf25.saf2536_pcode_v}}</td>
                                        <td>{{saf25.saf2505_ord_remark}}</td>
                                        <td>{{saf25.saf2556_leave_msg}}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="scroll-table" v-if="Symphox.open">
                            <table class="table table-bordered">
                                <thead>
                                    <tr class="">
                                        <th colspan="14" style="border: 1px solid white">
                                            <div>
                                                <table>
                                                    <tr>
                                                        <td style="padding: 3px">
                                                            <input type="checkbox" v-model="Symphox.checked" /></td>
                                                        <td style="padding: 3px">{{Symphox.saf25FileInfo.FileName}}</td>
                                                        <td style="padding: 3px">
                                                            <label class="btn btn-default">
                                                                <input style="display: none;" type="file" accept=".csv,.xls,.xlsx" v-on:change="onFileChange('Symphox', $event)">
                                                                重新送出檔案比對
                                                            </label>
                                                    </tr>
                                                </table>
                                            </div>
                                        </th>
                                    </tr>
                                    <tr class="bg-primary text-light">
                                        <th>訂單編號</th>
                                        <th>NO</th>
                                        <th>出貨單號</th>
                                        <th>確認</th>
                                        <th>出貨日期</th>
                                        <th>轉單日期</th>
                                        <th>預購日/指定配達日</th>
                                        <th>收貨人</th>
                                        <th>ZIP</th>
                                        <th>收貨地址(訂單編號)</th>
                                        <th>收貨人電話</th>
                                        <th>商品名稱</th>
                                        <th>下定時數量</th>
                                        <th>取消數量</th>
                                        <th>應出貨數量</th>
                                        <th>單位成本</th>
                                        <th>成本小計</th>
                                        <th>商品規格</th>
                                        <th>廠商料號</th>
                                        <th>備註</th>
                                        <th>客戶留言</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="saf25 in Symphox.saf25FileInfo.saf25List">
                                        <td>{{saf25.saf2503_ord_no}}</td>
                                        <td>{{saf25.saf2502_seq}}</td>
                                        <td>{{saf25.saf2527_ship_no}}</td>
                                        <td>{{saf25.saf2506_ord_status}}</td>
                                        <td>{{saf25.saf2523_ship_date}}</td>
                                        <td>{{saf25.saf2504_ord_date}}</td>
                                        <td>{{saf25.saf2520_dis_date}}</td>
                                        <td>{{saf25.saf2514_rec_name}}</td>
                                        <td>{{saf25.saf2522_dis_demand}}</td>
                                        <td>{{saf25.saf2519_rec_address}}</td>
                                        <td>{{saf25.saf2515_rec_cell}}</td>
                                        <td>{{saf25.saf2531_psname}}</td>
                                        <td>{{saf25.saf2541_ord_qty}}</td>
                                        <td>{{saf25.saf2543_cancel_qty}}</td>
                                        <td>{{saf25.saf2540_ship_qty}}</td>
                                        <td>{{saf25.saf2544_cost}}</td>
                                        <td>{{saf25.saf2545_cost_sub}}</td>
                                        <td>{{saf25.saf2532_pname}}</td>
                                        <td>{{saf25.saf2536_pcode_v}}</td>
                                        <td>{{saf25.saf2505_ord_remark}}</td>
                                        <td>{{saf25.saf2556_leave_msg}}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="scroll-table" v-if="Gomaji.open">
                            <table class="table table-bordered">
                                <thead>
                                    <tr class="">
                                        <th colspan="14" style="border: 1px solid white">
                                            <div>
                                                <table>
                                                    <tr>
                                                        <td style="padding: 3px">
                                                            <input type="checkbox" v-model="Gomaji.checked" /></td>
                                                        <td style="padding: 3px">{{Gomaji.saf25FileInfo.FileName}}</td>
                                                        <td style="padding: 3px">
                                                            <label class="btn btn-default">
                                                                <input style="display: none;" type="file" accept=".csv,.xls,.xlsx" v-on:change="onFileChange('Gomaji', $event)">
                                                                重新送出檔案比對
                                                            </label>
                                                    </tr>
                                                </table>
                                            </div>
                                        </th>
                                    </tr>
                                    <tr class="bg-primary text-light">
                                        <th>訂單編號</th>
                                        <th>NO</th>
                                        <th>出貨單號</th>
                                        <th>確認</th>
                                        <th>出貨日期</th>
                                        <th>轉單日期</th>
                                        <th>預購日/指定配達日</th>
                                        <th>收貨人</th>
                                        <th>ZIP</th>
                                        <th>收貨地址(訂單編號)</th>
                                        <th>收貨人電話</th>
                                        <th>商品名稱</th>
                                        <th>下定時數量</th>
                                        <th>取消數量</th>
                                        <th>應出貨數量</th>
                                        <th>單位成本</th>
                                        <th>成本小計</th>
                                        <th>商品規格</th>
                                        <th>廠商料號</th>
                                        <th>備註</th>
                                        <th>客戶留言</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="saf25 in Gomaji.saf25FileInfo.saf25List">
                                        <td>{{saf25.saf2503_ord_no}}</td>
                                        <td>{{saf25.saf2502_seq}}</td>
                                        <td>{{saf25.saf2527_ship_no}}</td>
                                        <td>{{saf25.saf2506_ord_status}}</td>
                                        <td>{{saf25.saf2523_ship_date}}</td>
                                        <td>{{saf25.saf2504_ord_date}}</td>
                                        <td>{{saf25.saf2520_dis_date}}</td>
                                        <td>{{saf25.saf2514_rec_name}}</td>
                                        <td>{{saf25.saf2522_dis_demand}}</td>
                                        <td>{{saf25.saf2519_rec_address}}</td>
                                        <td>{{saf25.saf2515_rec_cell}}</td>
                                        <td>{{saf25.saf2531_psname}}</td>
                                        <td>{{saf25.saf2541_ord_qty}}</td>
                                        <td>{{saf25.saf2543_cancel_qty}}</td>
                                        <td>{{saf25.saf2540_ship_qty}}</td>
                                        <td>{{saf25.saf2544_cost}}</td>
                                        <td>{{saf25.saf2545_cost_sub}}</td>
                                        <td>{{saf25.saf2532_pname}}</td>
                                        <td>{{saf25.saf2536_pcode_v}}</td>
                                        <td>{{saf25.saf2505_ord_remark}}</td>
                                        <td>{{saf25.saf2556_leave_msg}}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="scroll-table" v-if="PayEasy.open">
                            <table class="table table-bordered">
                                <thead>
                                    <tr class="">
                                        <th colspan="14" style="border: 1px solid white">
                                            <div>
                                                <table>
                                                    <tr>
                                                        <td style="padding: 3px">
                                                            <input type="checkbox" v-model="PayEasy.checked" /></td>
                                                        <td style="padding: 3px">{{PayEasy.saf25FileInfo.FileName}}</td>
                                                        <td style="padding: 3px">
                                                            <label class="btn btn-default">
                                                                <input style="display: none;" type="file" accept=".csv,.xls,.xlsx" v-on:change="onFileChange('PayEasy', $event)">
                                                                重新送出檔案比對
                                                            </label>
                                                    </tr>
                                                </table>
                                            </div>
                                        </th>
                                    </tr>
                                    <tr class="bg-primary text-light">
                                        <th>訂單編號</th>
                                        <th>NO</th>
                                        <th>出貨單號</th>
                                        <th>確認</th>
                                        <th>出貨日期</th>
                                        <th>轉單日期</th>
                                        <th>預購日/指定配達日</th>
                                        <th>收貨人</th>
                                        <th>ZIP</th>
                                        <th>收貨地址(訂單編號)</th>
                                        <th>收貨人電話</th>
                                        <th>商品名稱</th>
                                        <th>下定時數量</th>
                                        <th>取消數量</th>
                                        <th>應出貨數量</th>
                                        <th>單位成本</th>
                                        <th>成本小計</th>
                                        <th>商品規格</th>
                                        <th>廠商料號</th>
                                        <th>備註</th>
                                        <th>客戶留言</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="saf25 in PayEasy.saf25FileInfo.saf25List">
                                        <td>{{saf25.saf2503_ord_no}}</td>
                                        <td>{{saf25.saf2502_seq}}</td>
                                        <td>{{saf25.saf2527_ship_no}}</td>
                                        <td>{{saf25.saf2506_ord_status}}</td>
                                        <td>{{saf25.saf2523_ship_date}}</td>
                                        <td>{{saf25.saf2504_ord_date}}</td>
                                        <td>{{saf25.saf2520_dis_date}}</td>
                                        <td>{{saf25.saf2514_rec_name}}</td>
                                        <td>{{saf25.saf2522_dis_demand}}</td>
                                        <td>{{saf25.saf2519_rec_address}}</td>
                                        <td>{{saf25.saf2515_rec_cell}}</td>
                                        <td>{{saf25.saf2531_psname}}</td>
                                        <td>{{saf25.saf2541_ord_qty}}</td>
                                        <td>{{saf25.saf2543_cancel_qty}}</td>
                                        <td>{{saf25.saf2540_ship_qty}}</td>
                                        <td>{{saf25.saf2544_cost}}</td>
                                        <td>{{saf25.saf2545_cost_sub}}</td>
                                        <td>{{saf25.saf2532_pname}}</td>
                                        <td>{{saf25.saf2536_pcode_v}}</td>
                                        <td>{{saf25.saf2505_ord_remark}}</td>
                                        <td>{{saf25.saf2556_leave_msg}}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="scroll-table" v-if="UniPresiden.open">
                            <table class="table table-bordered">
                                <thead>
                                    <tr class="">
                                        <th colspan="14" style="border: 1px solid white">
                                            <div>
                                                <table>
                                                    <tr>
                                                        <td style="padding: 3px">
                                                            <input type="checkbox" v-model="UniPresiden.checked" /></td>
                                                        <td style="padding: 3px">{{UniPresiden.saf25FileInfo.FileName}}</td>
                                                        <td style="padding: 3px">
                                                            <label class="btn btn-default">
                                                                <input style="display: none;" type="file" accept=".csv,.xls,.xlsx" v-on:change="onFileChange('UniPresiden', $event)">
                                                                重新送出檔案比對
                                                            </label>
                                                    </tr>
                                                </table>
                                            </div>
                                        </th>
                                    </tr>
                                    <tr class="bg-primary text-light">
                                        <th>訂單編號</th>
                                        <th>NO</th>
                                        <th>出貨單號</th>
                                        <th>確認</th>
                                        <th>出貨日期</th>
                                        <th>轉單日期</th>
                                        <th>預購日/指定配達日</th>
                                        <th>收貨人</th>
                                        <th>ZIP</th>
                                        <th>收貨地址(訂單編號)</th>
                                        <th>收貨人電話</th>
                                        <th>商品名稱</th>
                                        <th>下定時數量</th>
                                        <th>取消數量</th>
                                        <th>應出貨數量</th>
                                        <th>單位成本</th>
                                        <th>成本小計</th>
                                        <th>商品規格</th>
                                        <th>廠商料號</th>
                                        <th>備註</th>
                                        <th>客戶留言</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="saf25 in UniPresiden.saf25FileInfo.saf25List">
                                        <td>{{saf25.saf2503_ord_no}}</td>
                                        <td>{{saf25.saf2502_seq}}</td>
                                        <td>{{saf25.saf2527_ship_no}}</td>
                                        <td>{{saf25.saf2506_ord_status}}</td>
                                        <td>{{saf25.saf2523_ship_date}}</td>
                                        <td>{{saf25.saf2504_ord_date}}</td>
                                        <td>{{saf25.saf2520_dis_date}}</td>
                                        <td>{{saf25.saf2514_rec_name}}</td>
                                        <td>{{saf25.saf2522_dis_demand}}</td>
                                        <td>{{saf25.saf2519_rec_address}}</td>
                                        <td>{{saf25.saf2515_rec_cell}}</td>
                                        <td>{{saf25.saf2531_psname}}</td>
                                        <td>{{saf25.saf2541_ord_qty}}</td>
                                        <td>{{saf25.saf2543_cancel_qty}}</td>
                                        <td>{{saf25.saf2540_ship_qty}}</td>
                                        <td>{{saf25.saf2544_cost}}</td>
                                        <td>{{saf25.saf2545_cost_sub}}</td>
                                        <td>{{saf25.saf2532_pname}}</td>
                                        <td>{{saf25.saf2536_pcode_v}}</td>
                                        <td>{{saf25.saf2505_ord_remark}}</td>
                                        <td>{{saf25.saf2556_leave_msg}}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="scroll-table" v-if="Dingding.open">
                            <table class="table table-bordered">
                                <thead>
                                    <tr class="">
                                        <th colspan="14" style="border: 1px solid white">
                                            <div>
                                                <table>
                                                    <tr>
                                                        <td style="padding: 3px">
                                                            <input type="checkbox" v-model="Dingding.checked" /></td>
                                                        <td style="padding: 3px">{{Dingding.saf25FileInfo.FileName}}</td>
                                                        <td style="padding: 3px">
                                                            <label class="btn btn-default">
                                                                <input style="display: none;" type="file" accept=".csv,.xls,.xlsx" v-on:change="onFileChange('Dingding', $event)">
                                                                重新送出檔案比對
                                                            </label>
                                                    </tr>
                                                </table>
                                            </div>
                                        </th>
                                    </tr>
                                    <tr class="bg-primary text-light">
                                        <th>訂單編號</th>
                                        <th>NO</th>
                                        <th>出貨單號</th>
                                        <th>確認</th>
                                        <th>出貨日期</th>
                                        <th>轉單日期</th>
                                        <th>預購日/指定配達日</th>
                                        <th>收貨人</th>
                                        <th>ZIP</th>
                                        <th>收貨地址(訂單編號)</th>
                                        <th>收貨人電話</th>
                                        <th>商品名稱</th>
                                        <th>下定時數量</th>
                                        <th>取消數量</th>
                                        <th>應出貨數量</th>
                                        <th>單位成本</th>
                                        <th>成本小計</th>
                                        <th>商品規格</th>
                                        <th>廠商料號</th>
                                        <th>備註</th>
                                        <th>客戶留言</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="saf25 in Dingding.saf25FileInfo.saf25List">
                                        <td>{{saf25.saf2503_ord_no}}</td>
                                        <td>{{saf25.saf2502_seq}}</td>
                                        <td>{{saf25.saf2527_ship_no}}</td>
                                        <td>{{saf25.saf2506_ord_status}}</td>
                                        <td>{{saf25.saf2523_ship_date}}</td>
                                        <td>{{saf25.saf2504_ord_date}}</td>
                                        <td>{{saf25.saf2520_dis_date}}</td>
                                        <td>{{saf25.saf2514_rec_name}}</td>
                                        <td>{{saf25.saf2522_dis_demand}}</td>
                                        <td>{{saf25.saf2519_rec_address}}</td>
                                        <td>{{saf25.saf2515_rec_cell}}</td>
                                        <td>{{saf25.saf2531_psname}}</td>
                                        <td>{{saf25.saf2541_ord_qty}}</td>
                                        <td>{{saf25.saf2543_cancel_qty}}</td>
                                        <td>{{saf25.saf2540_ship_qty}}</td>
                                        <td>{{saf25.saf2544_cost}}</td>
                                        <td>{{saf25.saf2545_cost_sub}}</td>
                                        <td>{{saf25.saf2532_pname}}</td>
                                        <td>{{saf25.saf2536_pcode_v}}</td>
                                        <td>{{saf25.saf2505_ord_remark}}</td>
                                        <td>{{saf25.saf2556_leave_msg}}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="scroll-table" v-if="Crazymike.open">
                            <table class="table table-bordered">
                                <thead>
                                    <tr class="">
                                        <th colspan="14" style="border: 1px solid white">
                                            <div>
                                                <table>
                                                    <tr>
                                                        <td style="padding: 3px">
                                                            <input type="checkbox" v-model="Crazymike.checked" /></td>
                                                        <td style="padding: 3px">{{Crazymike.saf25FileInfo.FileName}}</td>
                                                        <td style="padding: 3px">
                                                            <label class="btn btn-default">
                                                                <input style="display: none;" type="file" accept=".csv,.xls,.xlsx" v-on:change="onFileChange('Crazymike', $event)">
                                                                重新送出檔案比對
                                                            </label>
                                                    </tr>
                                                </table>
                                            </div>
                                        </th>
                                    </tr>
                                    <tr class="bg-primary text-light">
                                        <th>訂單編號</th>
                                        <th>NO</th>
                                        <th>出貨單號</th>
                                        <th>確認</th>
                                        <th>出貨日期</th>
                                        <th>轉單日期</th>
                                        <th>預購日/指定配達日</th>
                                        <th>收貨人</th>
                                        <th>ZIP</th>
                                        <th>收貨地址(訂單編號)</th>
                                        <th>收貨人電話</th>
                                        <th>商品名稱</th>
                                        <th>下定時數量</th>
                                        <th>取消數量</th>
                                        <th>應出貨數量</th>
                                        <th>單位成本</th>
                                        <th>成本小計</th>
                                        <th>商品規格</th>
                                        <th>廠商料號</th>
                                        <th>備註</th>
                                        <th>客戶留言</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="saf25 in Crazymike.saf25FileInfo.saf25List">
                                        <td>{{saf25.saf2503_ord_no}}</td>
                                        <td>{{saf25.saf2502_seq}}</td>
                                        <td>{{saf25.saf2527_ship_no}}</td>
                                        <td>{{saf25.saf2506_ord_status}}</td>
                                        <td>{{saf25.saf2523_ship_date}}</td>
                                        <td>{{saf25.saf2504_ord_date}}</td>
                                        <td>{{saf25.saf2520_dis_date}}</td>
                                        <td>{{saf25.saf2514_rec_name}}</td>
                                        <td>{{saf25.saf2522_dis_demand}}</td>
                                        <td>{{saf25.saf2519_rec_address}}</td>
                                        <td>{{saf25.saf2515_rec_cell}}</td>
                                        <td>{{saf25.saf2531_psname}}</td>
                                        <td>{{saf25.saf2541_ord_qty}}</td>
                                        <td>{{saf25.saf2543_cancel_qty}}</td>
                                        <td>{{saf25.saf2540_ship_qty}}</td>
                                        <td>{{saf25.saf2544_cost}}</td>
                                        <td>{{saf25.saf2545_cost_sub}}</td>
                                        <td>{{saf25.saf2532_pname}}</td>
                                        <td>{{saf25.saf2536_pcode_v}}</td>
                                        <td>{{saf25.saf2505_ord_remark}}</td>
                                        <td>{{saf25.saf2556_leave_msg}}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="scroll-table" v-if="Xingqi.open">
                            <table class="table table-bordered">
                                <thead>
                                    <tr class="">
                                        <th colspan="14" style="border: 1px solid white">
                                            <div>
                                                <table>
                                                    <tr>
                                                        <td style="padding: 3px">
                                                            <input type="checkbox" v-model="Xingqi.checked" /></td>
                                                        <td style="padding: 3px">{{Xingqi.saf25FileInfo.FileName}}</td>
                                                        <td style="padding: 3px">
                                                            <label class="btn btn-default">
                                                                <input style="display: none;" type="file" accept=".csv,.xls,.xlsx" v-on:change="onFileChange('Xingqi', $event)">
                                                                重新送出檔案比對
                                                            </label>
                                                    </tr>
                                                </table>
                                            </div>
                                        </th>
                                    </tr>
                                    <tr class="bg-primary text-light">
                                        <th>訂單編號</th>
                                        <th>NO</th>
                                        <th>出貨單號</th>
                                        <th>確認</th>
                                        <th>出貨日期</th>
                                        <th>轉單日期</th>
                                        <th>預購日/指定配達日</th>
                                        <th>收貨人</th>
                                        <th>ZIP</th>
                                        <th>收貨地址(訂單編號)</th>
                                        <th>收貨人電話</th>
                                        <th>商品名稱</th>
                                        <th>下定時數量</th>
                                        <th>取消數量</th>
                                        <th>應出貨數量</th>
                                        <th>單位成本</th>
                                        <th>成本小計</th>
                                        <th>商品規格</th>
                                        <th>廠商料號</th>
                                        <th>備註</th>
                                        <th>客戶留言</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="saf25 in Xingqi.saf25FileInfo.saf25List">
                                        <td>{{saf25.saf2503_ord_no}}</td>
                                        <td>{{saf25.saf2502_seq}}</td>
                                        <td>{{saf25.saf2527_ship_no}}</td>
                                        <td>{{saf25.saf2506_ord_status}}</td>
                                        <td>{{saf25.saf2523_ship_date}}</td>
                                        <td>{{saf25.saf2504_ord_date}}</td>
                                        <td>{{saf25.saf2520_dis_date}}</td>
                                        <td>{{saf25.saf2514_rec_name}}</td>
                                        <td>{{saf25.saf2522_dis_demand}}</td>
                                        <td>{{saf25.saf2519_rec_address}}</td>
                                        <td>{{saf25.saf2515_rec_cell}}</td>
                                        <td>{{saf25.saf2531_psname}}</td>
                                        <td>{{saf25.saf2541_ord_qty}}</td>
                                        <td>{{saf25.saf2543_cancel_qty}}</td>
                                        <td>{{saf25.saf2540_ship_qty}}</td>
                                        <td>{{saf25.saf2544_cost}}</td>
                                        <td>{{saf25.saf2545_cost_sub}}</td>
                                        <td>{{saf25.saf2532_pname}}</td>
                                        <td>{{saf25.saf2536_pcode_v}}</td>
                                        <td>{{saf25.saf2505_ord_remark}}</td>
                                        <td>{{saf25.saf2556_leave_msg}}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="scroll-table" v-if="Xingqi.open">
                            <table class="table table-bordered">
                                <thead>
                                    <tr class="">
                                        <th colspan="14" style="border: 1px solid white">
                                            <div>
                                                <table>
                                                    <tr>
                                                        <td style="padding: 3px">
                                                            <input type="checkbox" v-model="Xingqi.checked" /></td>
                                                        <td style="padding: 3px">{{Xingqi.saf25FileInfo.FileName}}</td>
                                                        <td style="padding: 3px">
                                                            <label class="btn btn-default">
                                                                <input style="display: none;" type="file" accept=".csv,.xls,.xlsx" v-on:change="onFileChange('Xingqi', $event)">
                                                                重新送出檔案比對
                                                            </label>
                                                    </tr>
                                                </table>
                                            </div>
                                        </th>
                                    </tr>
                                    <tr class="bg-primary text-light">
                                        <th>訂單編號</th>
                                        <th>NO</th>
                                        <th>出貨單號</th>
                                        <th>確認</th>
                                        <th>出貨日期</th>
                                        <th>轉單日期</th>
                                        <th>預購日/指定配達日</th>
                                        <th>收貨人</th>
                                        <th>ZIP</th>
                                        <th>收貨地址(訂單編號)</th>
                                        <th>收貨人電話</th>
                                        <th>商品名稱</th>
                                        <th>下定時數量</th>
                                        <th>取消數量</th>
                                        <th>應出貨數量</th>
                                        <th>單位成本</th>
                                        <th>成本小計</th>
                                        <th>商品規格</th>
                                        <th>廠商料號</th>
                                        <th>備註</th>
                                        <th>客戶留言</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="saf25 in Xingqi.saf25FileInfo.saf25List">
                                        <td>{{saf25.saf2503_ord_no}}</td>
                                        <td>{{saf25.saf2502_seq}}</td>
                                        <td>{{saf25.saf2527_ship_no}}</td>
                                        <td>{{saf25.saf2506_ord_status}}</td>
                                        <td>{{saf25.saf2523_ship_date}}</td>
                                        <td>{{saf25.saf2504_ord_date}}</td>
                                        <td>{{saf25.saf2520_dis_date}}</td>
                                        <td>{{saf25.saf2514_rec_name}}</td>
                                        <td>{{saf25.saf2522_dis_demand}}</td>
                                        <td>{{saf25.saf2519_rec_address}}</td>
                                        <td>{{saf25.saf2515_rec_cell}}</td>
                                        <td>{{saf25.saf2531_psname}}</td>
                                        <td>{{saf25.saf2541_ord_qty}}</td>
                                        <td>{{saf25.saf2543_cancel_qty}}</td>
                                        <td>{{saf25.saf2540_ship_qty}}</td>
                                        <td>{{saf25.saf2544_cost}}</td>
                                        <td>{{saf25.saf2545_cost_sub}}</td>
                                        <td>{{saf25.saf2532_pname}}</td>
                                        <td>{{saf25.saf2536_pcode_v}}</td>
                                        <td>{{saf25.saf2505_ord_remark}}</td>
                                        <td>{{saf25.saf2556_leave_msg}}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="scroll-table" v-if="Lianhebao.open">
                            <table class="table table-bordered">
                                <thead>
                                    <tr class="">
                                        <th colspan="14" style="border: 1px solid white">
                                            <div>
                                                <table>
                                                    <tr>
                                                        <td style="padding: 3px">
                                                            <input type="checkbox" v-model="Xingqi.checked" /></td>
                                                        <td style="padding: 3px">{{Xingqi.saf25FileInfo.FileName}}</td>
                                                        <td style="padding: 3px">
                                                            <label class="btn btn-default">
                                                                <input style="display: none;" type="file" accept=".csv,.xls,.xlsx" v-on:change="onFileChange('Xingqi', $event)">
                                                                重新送出檔案比對
                                                            </label>
                                                    </tr>
                                                </table>
                                            </div>
                                        </th>
                                    </tr>
                                    <tr class="bg-primary text-light">
                                        <th>訂單編號</th>
                                        <th>NO</th>
                                        <th>出貨單號</th>
                                        <th>確認</th>
                                        <th>出貨日期</th>
                                        <th>轉單日期</th>
                                        <th>預購日/指定配達日</th>
                                        <th>收貨人</th>
                                        <th>ZIP</th>
                                        <th>收貨地址(訂單編號)</th>
                                        <th>收貨人電話</th>
                                        <th>商品名稱</th>
                                        <th>下定時數量</th>
                                        <th>取消數量</th>
                                        <th>應出貨數量</th>
                                        <th>單位成本</th>
                                        <th>成本小計</th>
                                        <th>商品規格</th>
                                        <th>廠商料號</th>
                                        <th>備註</th>
                                        <th>客戶留言</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="saf25 in Xingqi.saf25FileInfo.saf25List">
                                        <td>{{saf25.saf2503_ord_no}}</td>
                                        <td>{{saf25.saf2502_seq}}</td>
                                        <td>{{saf25.saf2527_ship_no}}</td>
                                        <td>{{saf25.saf2506_ord_status}}</td>
                                        <td>{{saf25.saf2523_ship_date}}</td>
                                        <td>{{saf25.saf2504_ord_date}}</td>
                                        <td>{{saf25.saf2520_dis_date}}</td>
                                        <td>{{saf25.saf2514_rec_name}}</td>
                                        <td>{{saf25.saf2522_dis_demand}}</td>
                                        <td>{{saf25.saf2519_rec_address}}</td>
                                        <td>{{saf25.saf2515_rec_cell}}</td>
                                        <td>{{saf25.saf2531_psname}}</td>
                                        <td>{{saf25.saf2541_ord_qty}}</td>
                                        <td>{{saf25.saf2543_cancel_qty}}</td>
                                        <td>{{saf25.saf2540_ship_qty}}</td>
                                        <td>{{saf25.saf2544_cost}}</td>
                                        <td>{{saf25.saf2545_cost_sub}}</td>
                                        <td>{{saf25.saf2532_pname}}</td>
                                        <td>{{saf25.saf2536_pcode_v}}</td>
                                        <td>{{saf25.saf2505_ord_remark}}</td>
                                        <td>{{saf25.saf2556_leave_msg}}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>  <div class="scroll-table" v-if="Lutian.open">
                            <table class="table table-bordered">
                                <thead>
                                    <tr class="">
                                        <th colspan="14" style="border: 1px solid white">
                                            <div>
                                                <table>
                                                    <tr>
                                                        <td style="padding: 3px">
                                                            <input type="checkbox" v-model="Xingqi.checked" /></td>
                                                        <td style="padding: 3px">{{Xingqi.saf25FileInfo.FileName}}</td>
                                                        <td style="padding: 3px">
                                                            <label class="btn btn-default">
                                                                <input style="display: none;" type="file" accept=".csv,.xls,.xlsx" v-on:change="onFileChange('Xingqi', $event)">
                                                                重新送出檔案比對
                                                            </label>
                                                    </tr>
                                                </table>
                                            </div>
                                        </th>
                                    </tr>
                                    <tr class="bg-primary text-light">
                                        <th>訂單編號</th>
                                        <th>NO</th>
                                        <th>出貨單號</th>
                                        <th>確認</th>
                                        <th>出貨日期</th>
                                        <th>轉單日期</th>
                                        <th>預購日/指定配達日</th>
                                        <th>收貨人</th>
                                        <th>ZIP</th>
                                        <th>收貨地址(訂單編號)</th>
                                        <th>收貨人電話</th>
                                        <th>商品名稱</th>
                                        <th>下定時數量</th>
                                        <th>取消數量</th>
                                        <th>應出貨數量</th>
                                        <th>單位成本</th>
                                        <th>成本小計</th>
                                        <th>商品規格</th>
                                        <th>廠商料號</th>
                                        <th>備註</th>
                                        <th>客戶留言</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="saf25 in Xingqi.saf25FileInfo.saf25List">
                                        <td>{{saf25.saf2503_ord_no}}</td>
                                        <td>{{saf25.saf2502_seq}}</td>
                                        <td>{{saf25.saf2527_ship_no}}</td>
                                        <td>{{saf25.saf2506_ord_status}}</td>
                                        <td>{{saf25.saf2523_ship_date}}</td>
                                        <td>{{saf25.saf2504_ord_date}}</td>
                                        <td>{{saf25.saf2520_dis_date}}</td>
                                        <td>{{saf25.saf2514_rec_name}}</td>
                                        <td>{{saf25.saf2522_dis_demand}}</td>
                                        <td>{{saf25.saf2519_rec_address}}</td>
                                        <td>{{saf25.saf2515_rec_cell}}</td>
                                        <td>{{saf25.saf2531_psname}}</td>
                                        <td>{{saf25.saf2541_ord_qty}}</td>
                                        <td>{{saf25.saf2543_cancel_qty}}</td>
                                        <td>{{saf25.saf2540_ship_qty}}</td>
                                        <td>{{saf25.saf2544_cost}}</td>
                                        <td>{{saf25.saf2545_cost_sub}}</td>
                                        <td>{{saf25.saf2532_pname}}</td>
                                        <td>{{saf25.saf2536_pcode_v}}</td>
                                        <td>{{saf25.saf2505_ord_remark}}</td>
                                        <td>{{saf25.saf2556_leave_msg}}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        </div>  <div class="scroll-table" v-if="Yahoo.open">
                            <table class="table table-bordered">
                                <thead>
                                    <tr class="">
                                        <th colspan="14" style="border: 1px solid white">
                                            <div>
                                                <table>
                                                    <tr>
                                                        <td style="padding: 3px">
                                                            <input type="checkbox" v-model="Yahoo.checked" /></td>
                                                        <td style="padding: 3px">{{Yahoo.saf25FileInfo.FileName}}</td>
                                                        <td style="padding: 3px">
                                                            <label class="btn btn-default">
                                                                <input style="display: none;" type="file" accept=".csv,.xls,.xlsx" v-on:change="onFileChange('23. YAHOO拍賣.csv', $event)">
                                                                重新送出檔案比對
                                                            </label>
                                                    </tr>
                                                </table>
                                            </div>
                                        </th>
                                    </tr>
                                    <tr class="bg-primary text-light">
                                        <th>訂單編號</th>
                                        <th>NO</th>
                                        <th>出貨單號</th>
                                        <th>確認</th>
                                        <th>出貨日期</th>
                                        <th>轉單日期</th>
                                        <th>預購日/指定配達日</th>
                                        <th>收貨人</th>
                                        <th>ZIP</th>
                                        <th>收貨地址(訂單編號)</th>
                                        <th>收貨人電話</th>
                                        <th>商品名稱</th>
                                        <th>下定時數量</th>
                                        <th>取消數量</th>
                                        <th>應出貨數量</th>
                                        <th>單位成本</th>
                                        <th>成本小計</th>
                                        <th>商品規格</th>
                                        <th>廠商料號</th>
                                        <th>備註</th>
                                        <th>客戶留言</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="saf25 in Yahoo.saf25FileInfo.saf25List">
                                        <td>{{saf25.saf2503_ord_no}}</td>
                                        <td>{{saf25.saf2502_seq}}</td>
                                        <td>{{saf25.saf2527_ship_no}}</td>
                                        <td>{{saf25.saf2506_ord_status}}</td>
                                        <td>{{saf25.saf2523_ship_date}}</td>
                                        <td>{{saf25.saf2504_ord_date}}</td>
                                        <td>{{saf25.saf2520_dis_date}}</td>
                                        <td>{{saf25.saf2514_rec_name}}</td>
                                        <td>{{saf25.saf2522_dis_demand}}</td>
                                        <td>{{saf25.saf2519_rec_address}}</td>
                                        <td>{{saf25.saf2515_rec_cell}}</td>
                                        <td>{{saf25.saf2531_psname}}</td>
                                        <td>{{saf25.saf2541_ord_qty}}</td>
                                        <td>{{saf25.saf2543_cancel_qty}}</td>
                                        <td>{{saf25.saf2540_ship_qty}}</td>
                                        <td>{{saf25.saf2544_cost}}</td>
                                        <td>{{saf25.saf2545_cost_sub}}</td>
                                        <td>{{saf25.saf2532_pname}}</td>
                                        <td>{{saf25.saf2536_pcode_v}}</td>
                                        <td>{{saf25.saf2505_ord_remark}}</td>
                                        <td>{{saf25.saf2556_leave_msg}}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>





    </div>


    <script>
        (function () {
            requirejs.config({
                paths: {
                    "Dsap92501": "Dsap92501/Dsap92501",
                },
                shim: {}
            });

            var requiredFiles = ["Dsap92501"];

            function onLoaded(Dsap92501) {



            }

            function onError(error) {
                console.error(error);
            }

            require(requiredFiles, onLoaded, onError);
        })();
    </script>
</asp:Content>

