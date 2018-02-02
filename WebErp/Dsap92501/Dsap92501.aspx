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
                        <%--02. MOMO.CSV--%>
                        <div class="scroll-table" v-if="MOMO.open">
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
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <table class="table table-bordered" style="width: calc(100% - 18px)">
                                <thead>

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
                        <%--03. PCHOME.CSV--%>
                        <div class="scroll-table" v-if="PChome.open">
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
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <table class="table table-bordered">
                                <thead>

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
                        <%--04. 台塑.csv--%>
                        <div class="scroll-table" v-if="Formosa_Plastics.open">
                            <div>
                                <table>
                                    <tr>
                                        <td style="padding: 3px">
                                            <input type="checkbox" v-model="Formosa_Plastics.checked" /></td>
                                        <td style="padding: 3px">{{Formosa_Plastics.saf25FileInfo.FileName}}</td>
                                        <td style="padding: 3px">
                                            <label class="btn btn-default">
                                                <input style="display: none;" type="file" accept=".csv,.xls,.xlsx" v-on:change="onFileChange('04. 台塑.CSV', $event)">
                                                重新送出檔案比對
                                            </label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <table class="table table-bordered">
                                <thead>
                                    <tr class="">
                                        <th colspan="14" style="border: 1px solid white"></th>
                                    </tr>
                                    <tr class="bg-primary text-light">
                                        <th>no</th>
                                        <th>訂單編號</th>
                                        <th>拆單編號</th>
                                        <th>訂購日期</th>
                                        <th>付款方式</th>
                                        <th>付款狀態</th>
                                        <th>配送方式</th>
                                        <th>是否轉檔</th>
                                        <th>出貨狀態</th>
                                        <th>指交日期</th>
                                        <th>配送時段</th>
                                        <th>訂購人姓名</th>
                                        <th>訂購人電話1</th>
                                        <th>訂購人電話2</th>
                                        <th>訂購人手機</th>
                                        <th>收貨人姓名</th>
                                        <th>收貨人市話1</th>
                                        <th>收貨人市話2</th>
                                        <th>收貨人手機</th>
                                        <th>收貨人地址</th>
                                        <th>備註/卡片內容</th>
                                        <th>任選案件</th>
                                        <th>商品項次</th>
                                        <th>商品編號</th>
                                        <th>商品名稱</th>
                                        <th>商品規格</th>
                                        <th>廠商料號</th>
                                        <th>商品型號</th>
                                        <th>單位</th>
                                        <th>單價</th>
                                        <th>數量</th>
                                        <th>金額</th>
                                        <th>成本價</th>
                                        <th>管理費</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="saf25 in Formosa_Plastics.saf25FileInfo.saf25List">
                                        <td>{{saf25.saf2502_seq}}</td>
                                        <td>{{saf25.saf2503_ord_no}}</td>
                                        <td>{{saf25.saf2557_open_no}}</td>
                                        <td>{{saf25.saf2504_ord_date}}</td>
                                        <td>{{saf25.saf2507_ord_class}}</td>
                                        <td>{{saf25.saf2506_ord_status}}</td>
                                        <td>{{saf25.saf2550_paymt_way}}</td>
                                        <td>{{saf25.saf2551_paymt_status}}</td>
                                        <td>{{saf25.saf2522_dis_demand}}</td>
                                        <td>{{saf25.saf2558_trans_yn}}</td>
                                        <td>{{saf25.saf2526_ship_status}}</td>
                                        <td>{{saf25.saf2520_dis_date}}</td>
                                        <td>{{saf25.saf2521_dis_time}}</td>
                                        <td>{{saf25.saf2510_ord_name}}</td>
                                        <td>{{saf25.saf2512_ord_tel01}}</td>
                                        <td>{{saf25.saf2513_ord_tel02}}</td>
                                        <td>{{saf25.saf2511_ord_cell}}</td>
                                        <td>{{saf25.saf2514_rec_name}}</td>
                                        <td>{{saf25.saf2516_rec_tel01}}</td>
                                        <td>{{saf25.saf2517_rec_tel02}}</td>
                                        <td>{{saf25.saf2515_rec_cell}}</td>
                                        <td>{{saf25.saf2519_rec_address}}</td>
                                        <td>{{saf25.saf2505_ord_remark}}</td>
                                        <td>{{saf25.saf2559_option_case}}</td>
                                        <td>{{saf25.saf2542_groups}}</td>
                                        <td>{{saf25.saf2537_pcode}}</td>
                                        <td>{{saf25.saf2531_psname}}</td>
                                        <td>{{saf25.saf2532_pname}}</td>
                                        <td>{{saf25.saf2536_pcode_v}}</td>
                                        <td>{{saf25.saf2533_pspec}}</td>
                                        <td>{{saf25.saf2560_unit}}</td>
                                        <td>{{saf25.saf2547_price}}</td>
                                        <td>{{saf25.saf2541_ord_qty}}</td>
                                        <td>{{saf25.saf2548_price_sub}}</td>
                                        <td>{{saf25.saf2544_cost}}</td>
                                        <td>{{saf25.saf2546_mana_fee}}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <%--05. 台灣大哥大.csv--%>
                        <div class="scroll-table" v-if="Taiwan_Mobile.open">
                            <div>
                                <table>
                                    <tr>
                                        <td style="padding: 3px">
                                            <input type="checkbox" v-model="Taiwan_Mobile.checked" /></td>
                                        <td style="padding: 3px">{{Taiwan_Mobile.saf25FileInfo.FileName}}</td>
                                        <td style="padding: 3px">
                                            <label class="btn btn-default">
                                                <input style="display: none;" type="file" accept=".csv,.xls,.xlsx" v-on:change="onFileChange('05. 台灣大哥大.CSV', $event)">
                                                重新送出檔案比對
                                            </label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <table class="table table-bordered">
                                <thead>

                                    <tr class="bg-primary text-light">
                                        <th>訂單日期</th>
                                        <th>出貨單編號</th>
                                        <th>訂單編號</th>
                                        <th>運送方式</th>
                                        <th>物流代碼</th>
                                        <th>配送單號</th>
                                        <th>商品貨號</th>
                                        <th>供應商料號</th>
                                        <th>商品名稱</th>
                                        <th>樣式/規格</th>
                                        <th>贈品資訊</th>
                                        <th>數量</th>
                                        <th>單位成本</th>
                                        <th>成本小計</th>
                                        <th>收件人</th>
                                        <th>聯絡電話</th>
                                        <th>行動電話</th>
                                        <th>送貨地址</th>
                                        <th>發票號碼</th>
                                        <th>出貨單備註</th>

                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="saf25 in Taiwan_Mobile.saf25FileInfo.saf25List">
                                        <td>{{saf25.saf2504_ord_date}}</td>
                                        <td>{{saf25.saf2527_ship_no}}</td>
                                        <td>{{saf25.saf2503_ord_no}}</td>
                                        <td>{{saf25.saf2522_dis_demand}}</td>
                                        <td>{{saf25.saf2529_logis_no}}</td>
                                        <td>{{saf25.saf2528_fre_no}}</td>
                                        <td>{{saf25.saf2537_pcode}}</td>
                                        <td>{{saf25.saf2536_pcode_v}}</td>
                                        <td>{{saf25.saf2531_psname}}</td>
                                        <td>{{saf25.saf2532_pname}}</td>
                                        <td>{{saf25.saf2553_gifts}}</td>
                                        <td>{{saf25.saf2541_ord_qty}}</td>
                                        <td>{{saf25.saf2544_cost}}</td>
                                        <td>{{saf25.saf2545_cost_sub}}</td>
                                        <td>{{saf25.saf2514_rec_name}}</td>
                                        <td>{{saf25.saf2516_rec_tel01}}</td>
                                        <td>{{saf25.saf2515_rec_cell}}</td>
                                        <td>{{saf25.saf2519_rec_address}}</td>
                                        <td>{{saf25.saf2538_inv_no}}</td>
                                        <td>{{saf25.saf2540_ship_qty}}</td>

                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <%--生活市集--%>
                        <div class="scroll-table" v-if="Buy123.open">
                            <div>
                                <table>
                                    <tr>
                                        <td style="padding: 3px">
                                            <input type="checkbox" v-model="Buy123.checked" /></td>
                                        <td style="padding: 3px">{{Buy123.saf25FileInfo.FileName}}</td>
                                        <td style="padding: 3px">
                                            <label class="btn btn-default">
                                                <input style="display: none;" type="file" accept=".csv,.xls,.xlsx" v-on:change="onFileChange('06. 生活市集.CSV', $event)">
                                                重新送出檔案比對
                                            </label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <table class="table table-bordered">
                                <thead>

                                    <tr class="bg-primary text-light">
                                        <th>訂單編號</th>
                                        <th>收件人</th>
                                        <th>收件地址</th>
                                        <th>電話</th>
                                        <th>配送時段</th>
                                        <th>檔次名稱</th>
                                        <th>訂購方案</th>
                                        <th>品項 * 總數</th>
                                        <th>備註(購買人資料)</th>
                                        <th>付款時間</th>
                                        <th>退貨狀態</th>

                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="saf25 in Buy123.saf25FileInfo.saf25List">
                                        <td>{{saf25.saf2503_ord_no}}</td>
                                        <td>{{saf25.saf2514_rec_name}}</td>
                                        <td>{{saf25.saf2519_rec_address}}</td>
                                        <td>{{saf25.saf2515_rec_cell}}</td>
                                        <td>{{saf25.saf2521_dis_time}}</td>
                                        <td>{{saf25.saf2531_psname}}</td>
                                        <td>{{saf25.saf2508_ord_plan}}</td>
                                        <td>{{saf25.saf2532_pname}}</td>
                                        <td>{{saf25.saf2505_ord_remark}}</td>
                                        <td>{{saf25.saf2549_paymt_date}}</td>
                                        <td>{{saf25.saf2552_return}}</td>

                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <%--東森 森森--%>
                        <div class="scroll-table" v-if="Eastern.open">
                            <div>
                                <table>
                                    <tr>
                                        <td style="padding: 3px">
                                            <input type="checkbox" v-model="Eastern.checked" /></td>
                                        <td style="padding: 3px">{{Eastern.saf25FileInfo.FileName}}</td>
                                        <td style="padding: 3px">
                                            <label class="btn btn-default">
                                                <input style="display: none;" type="file" accept=".csv,.xls,.xlsx" v-on:change="onFileChange('07. 東森 森森.CSV', $event)">
                                                重新送出檔案比對
                                            </label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <table class="table table-bordered">
                                <thead>

                                    <tr class="bg-primary text-light">
                                        <th></th>
                                        <th>訂單號碼</th>
                                        <th>通路別</th>
                                        <th>銷售編號</th>
                                        <th>商品編號</th>
                                        <th>商品名稱</th>
                                        <th>顏色</th>
                                        <th>款式</th>
                                        <th>廠商料號</th>
                                        <th>訂單類別</th>
                                        <th>數量</th>
                                        <th>售價</th>
                                        <th>成本</th>
                                        <th>客戶名稱</th>
                                        <th>客戶電話</th>
                                        <th>室內電話</th>
                                        <th>配送地址</th>
                                        <th>貨運公司</th>
                                        <th>配送單號</th>
                                        <th>出貨指示日</th>
                                        <th>要求配送日</th>
                                        <th>要求配送時間</th>
                                        <th>備註</th>
                                        <th>電子發票號碼</th>
                                        <th>識別碼</th>
                                        <th>電子發票日期</th>
                                        <th>贈品</th>
                                        <th>廠商配送訊息</th>
                                        <th>預計入庫日期</th>
                                       
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="saf25 in Eastern.saf25FileInfo.saf25List">
                                        <td>{{saf25.saf2502_seq}}</td>
                                        <td>{{saf25.saf2503_ord_no}}</td>
                                        <td>{{saf25.saf2506_ord_status}}</td>
                                        <td>{{saf25.saf2527_ship_no}}</td>
                                        <td>{{saf25.saf2537_pcode}}</td>
                                        <td>{{saf25.saf2531_psname}}</td>
                                        <td>{{saf25.saf2534_ship_pname}}</td>
                                        <td>{{saf25.saf2533_pspec}}</td>
                                        <td>{{saf25.saf2536_pcode_v}}</td>
                                        <td>{{saf25.saf2507_ord_class}}</td>
                                        <td>{{saf25.saf2541_ord_qty}}</td>
                                        <td>{{saf25.saf2547_price}}</td>
                                        <td>{{saf25.saf2544_cost}}</td>
                                        <td>{{saf25.saf2514_rec_name}}</td>
                                        <td>{{saf25.saf2515_rec_cell}}</td>
                                        <td>{{saf25.saf2516_rec_tel01}}</td>
                                        <td>{{saf25.saf2519_rec_address}}</td>
                                        <td>{{saf25.saf2530_logis_comp}}</td>
                                        <td>{{saf25.saf2528_fre_no}}</td>
                                        <td>{{saf25.saf2523_ship_date}}</td>
                                        <td>{{saf25.saf2520_dis_date}}</td>
                                        <td>{{saf25.saf2521_dis_time}}</td>
                                        <td>{{saf25.saf2505_ord_remark}}</td>
                                        <td>{{saf25.saf2538_inv_no}}</td>
                                        <td>{{saf25.saf2554_identifier}}</td>
                                        <td>{{saf25.saf2539_inv_date}}</td>
                                        <td>{{saf25.saf2553_gifts}}</td>
                                        <td>{{saf25.saf2522_dis_demand}}</td>
                                        <td>{{saf25.saf2562_warehs_date}}</td>

                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <%--松果--%>
                        <div class="scroll-table" v-if="Pcone.open">
                            <div>
                                <table>
                                    <tr>
                                        <td style="padding: 3px">
                                            <input type="checkbox" v-model="Pcone.checked" /></td>
                                        <td style="padding: 3px">{{Pcone.saf25FileInfo.FileName}}</td>
                                        <td style="padding: 3px">
                                            <label class="btn btn-default">
                                                <input style="display: none;" type="file" accept=".csv,.xls,.xlsx" v-on:change="onFileChange('08. 松果.CSV', $event)">
                                                重新送出檔案比對
                                            </label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <table class="table table-bordered">
                                <thead>

                                    <tr class="bg-primary text-light">
                                        <th>訂單編號</th>
                                        <th>付款時間</th>
                                        <th>訂購人</th>
                                        <th>付款方式</th>
                                        <th>收件人</th>
                                        <th>電話</th>
                                        <th>收件地址</th>
                                        <th>商品</th>
                                        <th>商品編號</th>
                                        <th>方案入數</th>
                                        <th>方案價格</th>
                                        <th>方案數量</th>
                                        <th>選項</th>
                                        <th>數量</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="saf25 in Pcone.saf25FileInfo.saf25List">
                                        <td>{{saf25.saf2503_ord_no}}</td>
                                        <td>{{saf25.saf2549_paymt_date}}</td>
                                        <td>{{saf25.saf2510_ord_name}}</td>
                                        <td>{{saf25.saf2550_paymt_way}}</td>
                                        <td>{{saf25.saf2514_rec_name}}</td>
                                        <td>{{saf25.saf2515_rec_cell}}</td>
                                        <td>{{saf25.saf2519_rec_address}}</td>
                                        <td>{{saf25.saf2531_psname}}</td>
                                        <td>{{saf25.saf2537_pcode}}</td>
                                        <td>{{saf25.saf2542_groups}}</td>
                                        <td>{{saf25.saf2547_price}}</td>
                                        <td>{{saf25.saf2540_ship_qty}}</td>
                                        <td>{{saf25.saf2561_option}}</td>
                                        <td>{{saf25.saf2541_ord_qty}}</td>

                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <%--神坊--%>
                        <div class="scroll-table" v-if="Symphox.open">
                            <div>
                                <table>
                                    <tr>
                                        <td style="padding: 3px">
                                            <input type="checkbox" v-model="Symphox.checked" /></td>
                                        <td style="padding: 3px">{{Symphox.saf25FileInfo.FileName}}</td>
                                        <td style="padding: 3px">
                                            <label class="btn btn-default">
                                                <input style="display: none;" type="file" accept=".csv,.xls,.xlsx" v-on:change="onFileChange('09. 神坊.CSV', $event)">
                                                重新送出檔案比對
                                            </label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <table class="table table-bordered">
                                <thead>

                                    <tr class="bg-primary text-light">
                                        <th>訂貨人</th>
                                        <th>訂單編號</th>
                                        <th>訂單日</th>
                                        <th>商品流水號</th>
                                        <th>品項名</th>
                                        <th>數量</th>
                                        <th>收貨人姓名</th>
                                        <th>郵遞區號</th>
                                        <th>收貨人地址</th>
                                        <th>收貨日間電話</th>
                                        <th>收貨夜間電話</th>
                                        <th>收貨人行動電話</th>
                                        <th>商品成本</th>
                                        <th>備註</th>
                                        <th>要使用的包材</th>
                                        <th>出貨商品備註 </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="saf25 in Symphox.saf25FileInfo.saf25List">
                                        <td>{{saf25.saf2510_ord_name}}</td>
                                        <td>{{saf25.saf2503_ord_no}}</td>
                                        <td>{{saf25.saf2504_ord_date}}</td>
                                        <td>{{saf25.saf2537_pcode}}</td>
                                        <td>{{saf25.saf2531_psname}}</td>
                                        <td>{{saf25.saf2541_ord_qty}}</td>
                                        <td>{{saf25.saf2514_rec_name}}</td>
                                        <td>{{saf25.saf2518_rec_zip}}</td>
                                        <td>{{saf25.saf2519_rec_address}}</td>
                                        <td>{{saf25.saf2516_rec_tel01}}</td>
                                        <td>{{saf25.saf2517_rec_tel02}}</td>
                                        <td>{{saf25.saf2515_rec_cell}}</td>
                                        <td>{{saf25.saf2544_cost}}</td>
                                        <td>{{saf25.saf2505_ord_remark}}</td>
                                        <td>{{saf25.saf2556_leave_msg}}</td>
                                        <td>{{saf25.saf2524_ship_remark}}</td>

                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <%--夠麻吉--%>
                        <div class="scroll-table" v-if="Gomaji.open">
                            <div>
                                <table>
                                    <tr>
                                        <td style="padding: 3px">
                                            <input type="checkbox" v-model="Gomaji.checked" /></td>
                                        <td style="padding: 3px">{{Gomaji.saf25FileInfo.FileName}}</td>
                                        <td style="padding: 3px">
                                            <label class="btn btn-default">
                                                <input style="display: none;" type="file" accept=".csv,.xls,.xlsx" v-on:change="onFileChange('10. 夠麻吉.CSV', $event)">
                                                重新送出檔案比對
                                            </label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <table class="table table-bordered">

                                <thead>

                                    <tr class="bg-primary text-light">
                                        <th>store_id</th>
                                        <th>product_id</th>
                                        <th>代碼</th>
                                        <th>購買日期</th>
                                        <th>最後出貨日</th>
                                        <th>訂購人</th>
                                        <th>收件人</th>
                                        <th>訂購人電話</th>
                                        <th>收件人電話</th>
                                        <th>訂單份數</th>
                                        <th>方案名稱</th>
                                        <th>配送地址</th>
                                        <th>品項</th>
                                        <th>規格</th>
                                        <th>編號</th>
                                        <th>應出貨數量</th>
                                        <th>備註</th>
                                        <th>貨運編號</th>
                                        <th>出貨日期</th>
                                        <th>備註</th>

                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="saf25 in Gomaji.saf25FileInfo.saf25List">
                                        <td>{{saf25.saf2502_seq}}</td>
                                        <td>{{saf25.saf2537_pcode}}</td>
                                        <td>{{saf25.saf2503_ord_no}}</td>
                                        <td>{{saf25.saf2504_ord_date}}</td>
                                        <td>{{saf25.saf2523_ship_date}}</td>
                                        <td>{{saf25.saf2510_ord_name}}</td>
                                        <td>{{saf25.saf2514_rec_name}}</td>
                                        <td>{{saf25.saf2511_ord_cell}}</td>
                                        <td>{{saf25.saf2515_rec_cell}}</td>
                                        <td>{{saf25.saf2542_groups}}</td>
                                        <td>{{saf25.saf2531_psname}}</td>
                                        <td>{{saf25.saf2519_rec_address}}</td>
                                        <td>{{saf25.saf2533_pspec}}</td>
                                        <td>{{saf25.saf2532_pname}}</td>
                                        <td>{{saf25.saf2536_pcode_v}}</td>
                                        <td>{{saf25.saf2540_ship_qty}}</td>
                                        <td>{{saf25.saf2505_ord_remark}}</td>
                                        <td>{{saf25.saf2528_fre_no}}</td>
                                        <td>{{saf25.saf2520_dis_date}}</td>
                                        <td>{{saf25.saf2524_ship_remark}}</td>

                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <%--康迅--%>
                        <div class="scroll-table" v-if="PayEasy.open">
                            <div>
                                <table>
                                    <tr>
                                        <td style="padding: 3px">
                                            <input type="checkbox" v-model="PayEasy.checked" /></td>
                                        <td style="padding: 3px">{{PayEasy.saf25FileInfo.FileName}}</td>
                                        <td style="padding: 3px">
                                            <label class="btn btn-default">
                                                <input style="display: none;" type="file" accept=".csv,.xls,.xlsx" v-on:change="onFileChange('11. 康迅.CSV', $event)">
                                                重新送出檔案比對
                                            </label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <table class="table table-bordered">
                                <thead>

                                    <tr class="bg-primary text-light">
                                        <th>貨物送出</th>
                                        <th>出貨日</th>
                                        <th>物流公司</th>
                                        <th>配送單號</th>
                                        <th>項次</th>
                                        <th>組檔日期</th>
                                        <th>訂單編號</th>
                                        <th>活動訂單</th>
                                        <th>商品銷售名稱</th>
                                        <th>商品流水號</th>
                                        <th>廠商商品原始碼</th>
                                        <th>商品數量</th>
                                        <th>帳款金額</th>
                                        <th>訂單貨款</th>
                                        <th>收貨人</th>
                                        <th>郵遞區號</th>
                                        <th>縣市別</th>
                                        <th>收貨地址</th>
                                        <th>電話(日)</th>
                                        <th>電話(夜)</th>
                                        <th>手機</th>
                                        <th>備註</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="saf25 in PayEasy.saf25FileInfo.saf25List">
                                        <td>{{saf25.saf2526_ship_status}}</td>
                                        <td>{{saf25.saf2523_ship_date}}</td>
                                        <td>{{saf25.saf2529_logis_no}}</td>
                                        <td>{{saf25.saf2528_fre_no}}</td>
                                        <td>{{saf25.saf2502_seq}}</td>
                                        <td>{{saf25.saf2504_ord_date}}</td>
                                        <td>{{saf25.saf2503_ord_no}}</td>
                                        <td>{{saf25.saf2506_ord_status}}</td>
                                        <td>{{saf25.saf2531_psname}}</td>
                                        <td>{{saf25.saf2537_pcode}}</td>
                                        <td>{{saf25.saf2536_pcode_v}}</td>
                                        <td>{{saf25.saf2541_ord_qty}}</td>
                                        <td>{{saf25.saf2548_price_sub}}</td>
                                        <td>{{saf25.saf2545_cost_sub}}</td>
                                        <td>{{saf25.saf2514_rec_name}}</td>
                                        <td>{{saf25.saf2518_rec_zip}}</td>
                                        <td>{{saf25.saf2563_county}}</td>
                                        <td>{{saf25.saf2519_rec_address}}</td>
                                        <td>{{saf25.saf2516_rec_tel01}}</td>
                                        <td>{{saf25.saf2517_rec_tel02}}</td>
                                        <td>{{saf25.saf2515_rec_cell}}</td>
                                        <td>{{saf25.saf2505_ord_remark}}</td>

                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <%--統一--%>
                        <div class="scroll-table" v-if="UniPresiden.open">
                            <div>
                                <table>
                                    <tr>
                                        <td style="padding: 3px">
                                            <input type="checkbox" v-model="UniPresiden.checked" /></td>
                                        <td style="padding: 3px">{{UniPresiden.saf25FileInfo.FileName}}</td>
                                        <td style="padding: 3px">
                                            <label class="btn btn-default">
                                                <input style="display: none;" type="file" accept=".csv,.xls,.xlsx" v-on:change="onFileChange('12. 統一.CSV', $event)">
                                                重新送出檔案比對
                                            </label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <table class="table table-bordered">
                                <thead>

                                    <tr class="bg-primary text-light">
                                        <th>序</th>
                                        <th>廠商廠編</th>
                                        <th>廠商簡稱</th>
                                        <th>轉單日</th>
                                        <th>訂單編號</th>
                                        <th>出貨單編號</th>
                                        <th>訂購人姓名</th>
                                        <th>收件人姓名</th>
                                        <th>收件人聯絡電話</th>
                                        <th>送貨地址</th>
                                        <th>郵政信箱</th>
                                        <th>收件人郵遞區號</th>
                                        <th>換貨註記</th>
                                        <th>訂單型態</th>
                                        <th>溫層</th>
                                        <th>商品品號</th>
                                        <th>廠商貨號</th>
                                        <th>商品名稱</th>
                                        <th>規格</th>
                                        <th>出貨數量</th>
                                        <th>成本價</th>
                                        <th>託運公司代碼</th>
                                        <th>託運公司</th>
                                        <th>託運單號</th>
                                        <th>外箱規格</th>
                                        <th>出貨狀態</th>
                                        <th>訂單備註</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="saf25 in UniPresiden.saf25FileInfo.saf25List">
                                        <td>{{saf25.saf2502_seq}}</td>
                                        <td>{{saf25.saf2568_vendor_no}}</td>
                                        <td>{{saf25.saf2569_vendor_name}}</td>
                                        <td>{{saf25.saf2504_ord_date}}</td>
                                        <td>{{saf25.saf2503_ord_no}}</td>
                                        <td>{{saf25.saf2527_ship_no}}</td>
                                        <td>{{saf25.saf2510_ord_name}}</td>
                                        <td>{{saf25.saf2514_rec_name}}</td>
                                        <td>{{saf25.saf2515_rec_cell}}</td>
                                        <td>{{saf25.saf2519_rec_address}}</td>
                                        <td>{{saf25.saf2564_post_box}}</td>
                                        <td>{{saf25.saf2518_rec_zip}}</td>
                                        <td>{{saf25.saf2565_chg_notes}}</td>
                                        <td>{{saf25.saf2506_ord_status}}</td>
                                        <td>{{saf25.saf2566_warm}}</td>
                                        <td>{{saf25.saf2537_pcode}}</td>
                                        <td>{{saf25.saf2536_pcode_v}}</td>
                                        <td>{{saf25.saf2531_psname}}</td>
                                        <td>{{saf25.saf2532_pname}}</td>
                                        <td>{{saf25.saf2541_ord_qty}}</td>
                                        <td>{{saf25.saf2544_cost}}</td>
                                        <td>{{saf25.saf2529_logis_no}}</td>
                                        <td>{{saf25.saf2530_logis_comp}}</td>
                                        <td>{{saf25.saf2528_fre_no}}</td>
                                        <td>{{saf25.saf2567_carton_spec}}</td>
                                        <td>{{saf25.saf2526_ship_status}}</td>
                                        <td>{{saf25.saf2505_ord_remark}}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <%--鼎鼎--%>
                        <div class="scroll-table" v-if="Dingding.open">
                            <div>
                                <table>
                                    <tr>
                                        <td style="padding: 3px">
                                            <input type="checkbox" v-model="Dingding.checked" /></td>
                                        <td style="padding: 3px">{{Dingding.saf25FileInfo.FileName}}</td>
                                        <td style="padding: 3px">
                                            <label class="btn btn-default">
                                                <input style="display: none;" type="file" accept=".csv,.xls,.xlsx" v-on:change="onFileChange('13. 鼎鼎.CSV', $event)">
                                                重新送出檔案比對
                                            </label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <table class="table table-bordered">
                                <thead>

                                    <tr class="bg-primary text-light">
                                        <th>供應商名稱</th>
                                        <th>供應商編號</th>
                                        <th>通知出貨時間</th>
                                        <th>出貨單號</th>
                                        <th>對帳日期</th>
                                        <th>出貨狀態</th>
                                        <th>訂單編號</th>
                                        <th>訂單狀態</th>
                                        <th>訂單時間</th>
                                        <th>商品名稱</th>
                                        <th>商品類型</th>
                                        <th>商品序號</th>
                                        <th>規格編號或條碼</th>
                                        <th>提報成本</th>
                                        <th>單價</th>
                                        <th>數量</th>
                                        <th>總價</th>
                                        <th>訂購人</th>
                                        <th>收件人</th>
                                        <th>收件人郵遞區號</th>
                                        <th>收件人地址</th>
                                        <th>收件人電話</th>
                                        <th>收件人手機</th>
                                        <th>訂單備註</th>
                                        <th>訂單館別</th>
                                        <th>搭配活動</th>
                                        <th>訂單類型</th>
                                        <th>應出貨日期</th>
                                        <th>規格序號</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="saf25 in Dingding.saf25FileInfo.saf25List">
                                        <td>{{saf25.saf2568_vendor_no}}</td>
                                        <td>{{saf25.saf2569_vendor_name}}</td>
                                        <td>{{saf25.saf2523_ship_date}}</td>
                                        <td>{{saf25.saf2527_ship_no}}</td>
                                        <td>{{saf25.saf2549_paymt_date}}</td>
                                        <td>{{saf25.saf2526_ship_status}}</td>
                                        <td>{{saf25.saf2503_ord_no}}</td>
                                        <td>{{saf25.saf2506_ord_status}}</td>
                                        <td>{{saf25.saf2504_ord_date}}</td>
                                        <td>{{saf25.saf2531_psname}}</td>
                                        <td>{{saf25.saf2535_ptpye}}</td>
                                        <td>{{saf25.saf2537_pcode}}</td>
                                        <td>{{saf25.saf2532_pname}}</td>
                                        <td>{{saf25.saf2544_cost}}</td>
                                        <td>{{saf25.saf2547_price}}</td>
                                        <td>{{saf25.saf2541_ord_qty}}</td>
                                        <td>{{saf25.saf2548_price_sub}}</td>
                                        <td>{{saf25.saf2510_ord_name}}</td>
                                        <td>{{saf25.saf2514_rec_name}}</td>
                                        <td>{{saf25.saf2518_rec_zip}}</td>
                                        <td>{{saf25.saf2519_rec_address}}</td>
                                        <td>{{saf25.saf2516_rec_tel01}}</td>
                                        <td>{{saf25.saf2515_rec_cell}}</td>
                                        <td>{{saf25.saf2505_ord_remark}}</td>
                                        <td>{{saf25.saf2509_ord_shop}}</td>
                                        <td>{{saf25.saf2570_activity}}</td>
                                        <td>{{saf25.saf2507_ord_class}}</td>
                                        <td>{{saf25.saf2520_dis_date}}</td>
                                        <td>{{saf25.saf2533_pspec}}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <%--瘋狂賣客--%>
                        <div class="scroll-table" v-if="Crazymike.open">
                            <div>
                                <table>
                                    <tr>
                                        <td style="padding: 3px">
                                            <input type="checkbox" v-model="Crazymike.checked" /></td>
                                        <td style="padding: 3px">{{Crazymike.saf25FileInfo.FileName}}</td>
                                        <td style="padding: 3px">
                                            <label class="btn btn-default">
                                                <input style="display: none;" type="file" accept=".csv,.xls,.xlsx" v-on:change="onFileChange('14. 瘋狂賣客.CSV', $event)">
                                                重新送出檔案比對
                                            </label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <table class="table table-bordered">
                                <thead>

                                    <tr class="bg-primary text-light">
                                        <th>訂單編號</th>
                                        <th>出貨日期</th>
                                        <th>出貨單號</th>
                                        <th>商品名稱</th>
                                        <th>訂購數量</th>
                                        <th>商品規格</th>
                                        <th>含稅成本</th>
                                        <th>運費成本</th>
                                        <th>含稅小計</th>
                                        <th>收件人姓名</th>
                                        <th>收件人地址</th>
                                        <th>收件人電話</th>
                                        <th>贈品</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="saf25 in Crazymike.saf25FileInfo.saf25List">
                                        <td>{{saf25.saf2503_ord_no}}</td>
                                        <td>{{saf25.saf2523_ship_date}}</td>
                                        <td>{{saf25.saf2527_ship_no}}</td>
                                        <td>{{saf25.saf2531_psname}}</td>
                                        <td>{{saf25.saf2541_ord_qty}}</td>
                                        <td>{{saf25.saf2532_pname}}</td>
                                        <td>{{saf25.saf2544_cost}}</td>
                                        <td>{{saf25.saf2546_mana_fee}}</td>
                                        <td>{{saf25.saf2514_rec_name}}</td>
                                        <td>{{saf25.saf2528_fre_no}}</td>
                                        <td>{{saf25.saf2519_rec_address}}</td>
                                        <td>{{saf25.saf2515_rec_cell}}</td>
                                        <td>{{saf25.saf2553_gifts}}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <%--興奇--%>
                        <div class="scroll-table" v-if="Xingqi.open">
                            <div>
                                <table>
                                    <tr>
                                        <td style="padding: 3px">
                                            <input type="checkbox" v-model="Xingqi.checked" /></td>
                                        <td style="padding: 3px">{{Xingqi.saf25FileInfo.FileName}}</td>
                                        <td style="padding: 3px">
                                            <label class="btn btn-default">
                                                <input style="display: none;" type="file" accept=".csv,.xls,.xlsx" v-on:change="onFileChange('15. 興奇.CSV', $event)">
                                                重新送出檔案比對
                                            </label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <table class="table table-bordered">
                                <thead>

                                    <tr class="bg-primary text-light">
                                        <th>序號</th>
                                        <th>訂單編號</th>
                                        <th>收件人姓名</th>
                                        <th>收件人手機</th>
                                        <th>收件人郵遞區號</th>
                                        <th>收件人地址</th>
                                        <th>收件人電話(日)</th>
                                        <th>商品名稱</th>
                                        <th>貨運方式</th>
                                        <th>貨運單號</th>
                                        <th>數量</th>
                                        <th>商品成本</th>
                                        <th>出貨日期</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="saf25 in Xingqi.saf25FileInfo.saf25List">
                                        <td>{{saf25.saf2502_seq}}</td>
                                        <td>{{saf25.saf2503_ord_no}}</td>
                                        <td>{{saf25.saf2514_rec_name}}</td>
                                        <td>{{saf25.saf2515_rec_cell}}</td>
                                        <td>{{saf25.saf2518_rec_zip}}</td>
                                        <td>{{saf25.saf2519_rec_address}}</td>
                                        <td>{{saf25.saf2516_rec_tel01}}</td>
                                        <td>{{saf25.saf2531_psname}}</td>
                                        <td>{{saf25.saf2529_logis_no}}</td>
                                        <td>{{saf25.saf2528_fre_no}}</td>
                                        <td>{{saf25.saf2541_ord_qty}}</td>
                                        <td>{{saf25.saf2544_cost}}</td>
                                        <td>{{saf25.saf2523_ship_date}}</td>


                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <%--聯合報--%>
                        <div class="scroll-table" v-if="Lianhebao.open">
                            <div>
                                <table>
                                    <tr>
                                        <td style="padding: 3px">
                                            <input type="checkbox" v-model="Lianhebao.checked" /></td>
                                        <td style="padding: 3px">{{Lianhebao.saf25FileInfo.FileName}}</td>
                                        <td style="padding: 3px">
                                            <label class="btn btn-default">
                                                <input style="display: none;" type="file" accept=".csv,.xls,.xlsx" v-on:change="onFileChange('16. 聯合報.CSV', $event)">
                                                重新送出檔案比對
                                            </label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <table class="table table-bordered">
                                <thead>
                                    <tr class="bg-primary text-light">
                                        <th>最遲出貨日</th>
                                        <th>訂單編號</th>
                                        <th>訂購日期</th>
                                        <th>訂購人姓名</th>
                                        <th>收貨人姓名</th>
                                        <th>收貨人市話</th>
                                        <th>收貨人手機</th>
                                        <th>收件人郵遞區號</th>
                                        <th>收貨人地址</th>
                                        <th>配送備註</th>
                                        <th>購買備註</th>
                                        <th>商品編號</th>
                                        <th>廠商料號</th>
                                        <th>商品型號</th>
                                        <th>國際條碼</th>
                                        <th>商品名稱+規格尺寸</th>
                                        <th>特標語</th>
                                        <th>訂購數量</th>
                                        <th>原售價</th>
                                        <th>原售價-小計</th>
                                        <th>進貨價</th>
                                        <th>進貨價-小計</th>
                                        <th>指交日期</th>
                                        <th>合作物流</th>
                                        <th>貨運單號</th>
                                        <th>貨運公司</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="saf25 in Lianhebao.saf25FileInfo.saf25List">
                                        <td>{{saf25.saf2523_ship_date}}</td>
                                        <td>{{saf25.saf2503_ord_no}}</td>
                                        <td>{{saf25.saf2504_ord_date}}</td>
                                        <td>{{saf25.saf2510_ord_name}}</td>
                                        <td>{{saf25.saf2514_rec_name}}</td>
                                        <td>{{saf25.saf2516_rec_tel01}}</td>
                                        <td>{{saf25.saf2515_rec_cell}}</td>
                                        <td>{{saf25.saf2518_rec_zip}}</td>
                                        <td>{{saf25.saf2519_rec_address}}</td>
                                        <td>{{saf25.saf2522_dis_demand}}</td>
                                        <td>{{saf25.saf2505_ord_remark}}</td>
                                        <td>{{saf25.saf2537_pcode}}</td>
                                        <td>{{saf25.saf2536_pcode_v}}</td>
                                        <td>{{saf25.saf2532_pname}}</td>
                                        <td>{{saf25.saf2533_pspec}}</td>
                                        <td>{{saf25.saf2531_psname}}</td>
                                        <td>{{saf25.saf2570_activity}}</td>
                                        <td>{{saf25.saf2541_ord_qty}}</td>
                                        <td>{{saf25.saf2547_price}}</td>
                                        <td>{{saf25.saf2548_price_sub}}</td>
                                        <td>{{saf25.saf2544_cost}}</td>
                                        <td>{{saf25.saf2545_cost_sub}}</td>
                                        <td>{{saf25.saf2520_dis_date}}</td>
                                        <td>{{saf25.saf2529_logis_no}}</td>
                                        <td>{{saf25.saf2528_fre_no}}</td>
                                        <td>{{saf25.saf2530_logis_comp}}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <%--18  奇摩超級商城--%>
                        <div class="scroll-table" v-if="YahooMart.open">
                            <div>
                                <table>
                                    <tr>
                                        <td style="padding: 3px">
                                            <input type="checkbox" v-model="YahooMart.checked" /></td>
                                        <td style="padding: 3px">{{YahooMart.saf25FileInfo.FileName}}</td>
                                        <td style="padding: 3px">
                                            <label class="btn btn-default">
                                                <input style="display: none;" type="file" accept=".csv,.xls,.xlsx" v-on:change="onFileChange('16. 聯合報.CSV', $event)">
                                                重新送出檔案比對
                                            </label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <table class="table table-bordered">
                                <thead>
                                    <tr class="bg-primary text-light">
                                        <th>交易序號</th>
                                        <th>付款別</th>
                                        <th>訂購人</th>
                                        <th>訂單編號</th>
                                        <th>收件人姓名</th>
                                        <th>收件人郵遞區號</th>
                                        <th>收件人地址</th>
                                        <th>轉單日期</th>
                                        <th>最晚出貨日</th>
                                        <th>店家出貨日</th>
                                        <th>商品類型</th>
                                        <th>物流設定</th>
                                        <th>商品編號</th>
                                        <th>店家商品料號</th>
                                        <th>商品名稱</th>
                                        <th>購物車備註</th>
                                        <th>商品規格</th>
                                        <th>數量</th>
                                        <th>金額小計</th>
                                        <th>訂單狀態</th>
                                        <th>收件人電話(日)</th>
                                        <th>收件人電話(夜)</th>
                                        <th>收件人行動電話</th>
                                        <th>發票寄送地址</th>
                                        <th>商品稅別</th>
                                        <th>超贈點點數</th>
                                         <th>超贈點折抵金額</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="saf25 in YahooMart.saf25FileInfo.saf25List">
                                        <td>{{saf25.saf2582_serial}}</td>
                                        <td>{{saf25.saf2550_paymt_way}}</td>
                                        <td>{{saf25.saf2510_ord_name}}</td>
                                        <td>{{saf25.saf2503_ord_no}}</td>
                                        <td>{{saf25.saf2514_rec_name}}</td>
                                        <td>{{saf25.saf2518_rec_zip}}</td>
                                        <td>{{saf25.saf2519_rec_address}}</td>
                                        <td>{{saf25.saf2504_ord_date}}</td>
                                        <td>{{saf25.saf2523_ship_date}}</td>
                                        <td>{{saf25.saf2584_deli_date}}</td>
                                        <td>{{saf25.saf2535_ptpye}}</td>
                                        <td>{{saf25.saf2530_logis_comp}}</td>
                                        <td>{{saf25.saf2536_pcode_v}}</td>
                                        <td>{{saf25.saf2537_pcode}}</td>
                                        <td>{{saf25.saf2531_psname}}</td>
                                        <td>{{saf25.saf2505_ord_remark}}</td>
                                        <td>{{saf25.saf2532_pname}}</td>
                                        <td>{{saf25.saf2548_price_sub}}</td>
                                        <td>{{saf25.saf2541_ord_qty}}</td>
                                        <td>{{saf25.saf2506_ord_status}}</td>
                                        <td>{{saf25.saf2516_rec_tel01}}</td>
                                        <td>{{saf25.saf2517_rec_tel02}}</td>
                                        <td>{{saf25.saf2515_rec_cell}}</td>
                                        <td>{{saf25.saf2564_post_box}}</td>
                                        <td>{{saf25.saf2586_tax_class}}</td>
                                        <td>{{saf25.saf2587_gift_pnt}}</td>
                                        <td>{{saf25.saf2588_gift_amt}}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                         <%--19  摩天--%>
                        <div class="scroll-table" v-if="Motian.open">
                            <div>
                                <table>
                                    <tr>
                                        <td style="padding: 3px">
                                            <input type="checkbox" v-model="Motian.checked" /></td>
                                        <td style="padding: 3px">{{Motian.saf25FileInfo.FileName}}</td>
                                        <td style="padding: 3px">
                                            <label class="btn btn-default">
                                                <input style="display: none;" type="file" accept=".csv,.xls,.xlsx" v-on:change="onFileChange('19. 摩天.XLS', $event)">
                                                重新送出檔案比對
                                            </label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <table class="table table-bordered">
                                <thead>
                                    <tr class="bg-primary text-light">
                                        <th>訂單編號</th>
                                        <th>配送狀態</th>
                                        <th>配送訊息</th>
                                        <th>配送單號</th>
                                        <th>客戶配送需求</th>
                                        <th>付款日</th>
                                        <th>最晚出貨日</th>
                                        <th>收件人姓名</th>
                                        <th>電話</th>
                                        <th>行動電話</th>
                                        <th>地址</th>
                                        <th>商店品號</th>
                                        <th>商品編號</th>
                                        <th>商品名稱</th>
                                        <th>單品規格</th>
                                        <th>數量</th>
                                        <th>成交價</th>
                                        <th>付款方式</th>
                                        <th>分期</th>
                                        <th>商品屬性</th>
                                        <th>訂購人姓名</th>
                                        <th>電話</th>
                                        <th>行動電話</th>
                                       
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="saf25 in Motian.saf25FileInfo.saf25List">
                                        <td>{{saf25.saf2502_seq}}</td>
                                        <td>{{saf25.saf2503_ord_no}}</td>
                                        <td>{{saf25.saf2506_ord_status}}</td>
                                        <td>{{saf25.saf2505_ord_remark}}</td>
                                        <td>{{saf25.saf2530_logis_comp}}</td>
                                        <td>{{saf25.saf2528_fre_no}}</td>
                                        <td>{{saf25.saf2522_dis_demand}}</td>
                                        <td>{{saf25.saf2549_paymt_date}}</td>
                                        <td>{{saf25.saf2523_ship_date}}</td>
                                        <td>{{saf25.saf2514_rec_name}}</td>
                                        <td>{{saf25.saf2516_rec_tel01}}</td>
                                        <td>{{saf25.saf2515_rec_cell}}</td>
                                        <td>{{saf25.saf2519_rec_address}}</td>
                                        <td>{{saf25.saf2537_pcode}}</td>
                                        <td>{{saf25.saf2536_pcode_v}}</td>
                                        <td>{{saf25.saf2531_psname}}</td>
                                        <td>{{saf25.saf2532_pname}}</td>
                                        <td>{{saf25.saf2541_ord_qty}}</td>
                                        <td>{{saf25.saf2548_price_sub}}</td>
                                        <td>{{saf25.saf2550_paymt_way}}</td>
                                        <td>{{saf25.saf2551_paymt_status}}</td>
                                        <td>{{saf25.saf2535_ptpye}}</td>
                                        <td>{{saf25.saf2510_ord_name}}</td>
                                        <td>{{saf25.saf2512_ord_tel01}}</td>
                                        <td>{{saf25.saf2511_ord_cell}}</td>
                                        
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <%--露天--%>
                        <div class="scroll-table" v-if="Lutian.open">
                            <div>
                                <table>
                                    <tr>
                                        <td style="padding: 3px">
                                            <input type="checkbox" v-model="Lutian.checked" /></td>
                                        <td style="padding: 3px">{{Lutian.saf25FileInfo.FileName}}</td>
                                        <td style="padding: 3px">
                                            <label class="btn btn-default">
                                                <input style="display: none;" type="file" accept=".csv,.xls,.xlsx" v-on:change="onFileChange('22. 露天.CSV', $event)">
                                                重新送出檔案比對
                                            </label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <table class="table table-bordered">
                                <thead>

                                    <tr class="bg-primary text-light">
                                        <th>賣出時間</th>
                                        <th>商品編號</th>
                                        <th>商品名稱</th>
                                        <th>規格</th>
                                        <th>賣家自用料號</th>
                                        <th>得標金額</th>
                                        <th>數量</th>
                                        <th>商品總價</th>
                                        <th>買家帳號</th>
                                        <th>交易狀態</th>
                                        <th>收件人姓名</th>
                                        <th>電話</th>
                                        <th>手機</th>
                                        <th>收件地址</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="saf25 in Lutian.saf25FileInfo.saf25List">
                                        <td>{{saf25.saf2504_ord_date}}</td>
                                        <td>{{saf25.saf2536_pcode_v}}</td>
                                        <td>{{saf25.saf2531_psname}}</td>
                                        <td>{{saf25.saf2532_pname}}</td>
                                        <td>{{saf25.saf2537_pcode}}</td>
                                        <td>{{saf25.saf2547_price}}</td>
                                        <td>{{saf25.saf2541_ord_qty}}</td>
                                        <td>{{saf25.saf2548_price_sub}}</td>
                                        <td>{{saf25.saf2578_get_acc}}</td>
                                        <td>{{saf25.saf2506_ord_status}}</td>
                                        <td>{{saf25.saf2514_rec_name}}</td>
                                        <td>{{saf25.saf2516_rec_tel01}}</td>
                                        <td>{{saf25.saf2515_rec_cell}}</td>
                                        <td>{{saf25.saf2519_rec_address}}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <%--Yahoo--%>
                        <div class="scroll-table" v-if="Yahoo.open">
                            <div>
                                <table>
                                    <tr>
                                        <td style="padding: 3px">
                                            <input type="checkbox" v-model="Yahoo.checked" /></td>
                                        <td style="padding: 3px">{{Yahoo.saf25FileInfo.FileName}}</td>
                                        <td style="padding: 3px">
                                            <label class="btn btn-default">
                                                <input style="display: none;" type="file" accept=".csv,.xls,.xlsx" v-on:change="onFileChange('23. YAHOO拍賣.CSV', $event)">
                                                重新送出檔案比對
                                            </label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <table class="table table-bordered">
                                <thead>

                                    <tr class="bg-primary text-light">
                                        <th>訂單成立時間</th>
                                        <th>訂單編號</th>
                                        <th>帳單編號</th>
                                        <th>商品編號</th>
                                        <th>商品名稱</th>
                                        <th>第一組貨號</th>
                                        <th>規格1</th>
                                        <th>買家拍賣代號</th>
                                        <th>購買金額</th>
                                        <th>購買數量</th>
                                        <th>購買總額</th>
                                        <th>原運費</th>
                                        <th>訂單金額</th>
                                        <th>超贈點</th>
                                        <th>取件人姓名</th>
                                        <th>電話</th>
                                        <th>手機</th>
                                        <th>郵遞區號</th>
                                        <th>收件人住址</th>
                                        <th>付款方式</th>
                                        <th>運送方式</th>
                                        <th>出貨日期</th>
                                        <th>訂單狀態</th>
                                        <th>付款狀態</th>
                                        <th>出貨狀態</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="saf25 in Yahoo.saf25FileInfo.saf25List">
                                        <td>{{saf25.saf2504_ord_date}}</td>
                                        <td>{{saf25.saf2503_ord_no}}</td>
                                        <td>{{saf25.saf2527_ship_no}}</td>
                                        <td>{{saf25.saf2536_pcode_v}}</td>
                                        <td>{{saf25.saf2531_psname}}</td>
                                        <td>{{saf25.saf2537_pcode}}</td>
                                        <td>{{saf25.saf2532_pname}}</td>
                                        <td>{{saf25.saf2571_auction}}</td>
                                        <td>{{saf25.saf2547_price}}</td>
                                        <td>{{saf25.saf2541_ord_qty}}</td>
                                        <td>{{saf25.saf2548_price_sub}}</td>
                                        <td>{{saf25.saf2546_mana_fee}}</td>
                                        <td>{{saf25.saf2589_order_amt}}</td>
                                        <td>{{saf25.saf2587_gift_pnt}}</td>
                                        <td>{{saf25.saf2514_rec_name}}</td>
                                        <td>{{saf25.saf2516_rec_tel01}}</td>
                                        <td>{{saf25.saf2515_rec_cell}}</td>
                                        <td>{{saf25.saf2518_rec_zip}}</td>
                                        <td>{{saf25.saf2519_rec_address}}</td>
                                        <td>{{saf25.saf2550_paymt_way}}</td>
                                        <td>{{saf25.saf2530_logis_comp}}</td>
                                        <td>{{saf25.saf2523_ship_date}}</td>
                                        <td>{{saf25.saf2506_ord_status}}</td>
                                        <td>{{saf25.saf2551_paymt_status}}</td>
                                        <td>{{saf25.saf2526_ship_status}}</td>

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

