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
            width: 95%;
            max-height: 450px;
            overflow-y: auto;
            overflow-y: overlay;
            border: solid 1px #CCC;
        }

        .result-div {
            margin-top: 5px;
        }

        .table-bordered th, .table-bordered td {
            white-space: nowrap;
            padding-right: 18px!important;
        }

        #TotalTable th.orderby {
            font-weight: bold;
            color: #31ff00;
            text-decoration: underline;
        }

        #TotalTable th:hover {
            cursor: pointer;
        }


        .rowclass:hover {
            background-color: #bde7ff;
        }







        /*head*/
        /*.table-fixed {
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
                }*/
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
                            <function-button hot-key="f1" v-on:click.native="Upload()" style="background-color: rgba(255, 169, 169, 0.5098039215686274);">選擇訂單檔案</function-button>
                            <input type="file" id="ImportExcelInput" accept=".csv," multiple style="display: none" v-on:change="onMultipleFileChange">
                        </td>
                        <td style="padding: 3px">步驟3：
                        </td>
                        <td style="padding: 3px">

                            <function-button hot-key="f4" v-on:click.native="MultipleSubmit()" style="background-color: rgba(247, 255, 101, 0.6705882352941176);">檔案送出比對</function-button>
                        </td>
                        <td style="padding: 3px">步驟4：
                        </td>
                        <td style="padding: 3px">
                            <function-button hot-key="f9" v-on:click.native="ImportAll()" style="background-color: rgba(171, 255, 169, 0.51);">檔案匯入資料庫</function-button>
                        </td>
                        <td style="padding: 3px">
                            <function-button data-toggle="modal" href='#HelpDialog' hot-key="f11">求助</function-button>
                        </td>
                        <td style="padding: 3px">
                            <function-button hot-key="f12" v-on:click.native="OnExit()">離開</function-button>
                        </td>

                    </tr>
                </table>

            </div>


            <div class="result-div" style="height: 700px; overflow-y: auto; overflow-y: overlay;">
                <div class="scroll-table">
                    <table class="table table-bordered table-fixed" style="width: 250px; height: 200px">
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
                <div id="TotalTable">
                    <div class="result-div">
                        <%--01. 17P--%>
                        <div class="scroll-table" v-if="one7P.open">

                            <div>
                                <table>
                                    <tr>
                                        <td style="padding: 3px">
                                            <input type="checkbox" v-model="one7P.checked" v-if="one7P.saf25FileInfo.cnf1004_char02!=''" /></td>
                                        <td style="padding: 3px">{{one7P.saf25FileInfo.FileName}}</td>
                                        <td style="padding: 3px">

                                            <label class="btn btn-default" v-if="one7P.saf25FileInfo.cnf1004_char02!=''" style="background-color: rgba(247, 255, 101, 0.67);">
                                                <input style="display: none;" type="file" accept=".csv," v-on:change="onFileChange('01', $event)">
                                                重新送出檔案比對
                                            </label>
                                            <span v-else>此物流公司在此系統未登記，請登記才能匯入資料</span>

                                            <label class="btn btn-default" style="color: red; background-color: rgba(255, 169, 169, 0.51);" v-if="one7P.saf25FileInfo.ErrorMsg.length>0" data-toggle="modal" href='#modalDialog' v-on:click="ModalError=one7P.saf25FileInfo.ErrorMsg">
                                                錯誤訊息   
                                            </label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <table class="table table-bordered" style="width: calc(100% - 18px)" v-if="one7P.saf25FileInfo.cnf1004_char02!=''">
                                <thead>

                                    <tr class="bg-primary text-light">
                                        <th v-on:click="sortBy(one7P,'saf2502_seq',$event)">檔號</th>
                                        <th v-on:click="sortBy(one7P,'saf2503_ord_no',$event)">訂單標號</th>
                                        <th v-on:click="sortBy(one7P,'saf2504_ord_date',$event)">購買日期</th>
                                        <th v-on:click="sortBy(one7P,'saf2513_rec_name',$event)">收件人</th>
                                        <th v-on:click="sortBy(one7P,'saf2515_rec_cell',$event)">收件人電話</th>
                                        <th v-on:click="sortBy(one7P,'saf2519_rec_address',$event)">配送地址</th>
                                        <th v-on:click="sortBy(one7P,'saf2531_psname',$event)">方案名稱</th>
                                        <th v-on:click="sortBy(one7P,'saf2532_pname',$event)">應出貨品項規格</th>
                                        <th v-on:click="sortBy(one7P,'saf2536_Letianode_v',$event)">貨號</th>
                                        <th v-on:click="sortBy(one7P,'saf2541_ord_qty',$event)">數量．應出貨數</th>
                                        <th v-on:click="sortBy(one7P,'saf2547_price',$event)">售價</th>
                                        <th v-on:click="sortBy(one7P,'saf2544_cost',$event)">進貨價</th>
                                        <th v-on:click="sortBy(one7P,'saf2546_mana_fee',$event)">運費</th>
                                        <th v-on:click="sortBy(one7P,'saf2505_ord_remark',$event)">訂單備註</th>
                                        <th v-on:click="sortBy(one7P,'saf2506_ord_status',$event)">訂單狀態</th>
                                        <th v-on:click="sortBy(one7P,'saf2552_return',$event)">退貨管理</th>
                                        <th v-on:click="sortBy(one7P,'saf2523_ship_date',$event)">出貨日期</th>
                                        <th v-on:click="sortBy(one7P,'saf2529_logis_no',$event)">物流代號</th>
                                        <th v-on:click="sortBy(one7P,'saf2530_logis_comp',$event)">物流公司名稱</th>
                                        <th v-on:click="sortBy(one7P,'saf2528_fre_no',$event)">貨運單號</th>
                                        <th v-on:click="sortBy(one7P,'saf2524_ship_remark',$event)">出貨備註</th>
                                        <th v-on:click="sortBy(one7P,'saf2525_ship_condi',$event)">出貨條件</th>

                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="saf25 in one7P.saf25FileInfo.saf25List">
                                        <%--檔號--%><td>{{saf25.saf2502_seq}}</td>
                                        <%--訂單標號--%><td>{{saf25.saf2503_ord_no}}</td>
                                        <%--購買日期--%><td>{{saf25.saf2504_ord_date}}</td>
                                        <%--收件人--%><td>{{saf25.saf2513_rec_name}}</td>
                                        <%--收件人電話--%><td>{{saf25.saf2515_rec_cell}}</td>
                                        <%--配送地址--%><td>{{saf25.saf2519_rec_address}}</td>
                                        <%--方案名稱--%><td>{{saf25.saf2531_psname}}</td>
                                        <%-- 應出貨品項規格 --%><td>{{saf25.saf2532_pname}}</td>
                                        <%--貨號--%><td>{{saf25.saf2536_Letianode_v}}</td>
                                        <%--數量．應出貨數--%><td>{{saf25.saf2541_ord_qty}}</td>
                                        <%--  售價--%><td>{{saf25.saf2547_price}}</td>
                                        <%--  進貨價--%><td>{{saf25.saf2544_cost}}</td>
                                        <%--  運費--%><td>{{saf25.saf2546_mana_fee}}</td>
                                        <%--  訂單備註--%><td>{{saf25.saf2505_ord_remark}}</td>
                                        <%--  訂單狀態--%><td>{{saf25.saf2506_ord_status}}</td>
                                        <%-- 退貨管理 --%><td>{{saf25.saf2552_return}}</td>
                                        <%--  出貨日期--%><td>{{saf25.saf2523_ship_date}}</td>
                                        <%--  物流代號--%><td>{{saf25.saf2529_logis_no}}</td>
                                        <%--  物流公司名稱--%><td>{{saf25.saf2530_logis_comp}}</td>
                                        <%--  貨運單號---%><td>{{saf25.saf2528_fre_no}}</td>
                                        <%--  出貨備註--%><td>{{saf25.saf2524_ship_remark}}</td>
                                        <%--出貨條件  --%><td>{{saf25.saf2525_ship_condi}}</td>
                                    </tr>
                                </tbody>
                            </table>

                        </div>
                        <%--02. MOMO.CSV--%>
                        <div class="scroll-table" v-if="MOMO.open">

                            <div>
                                <table>
                                    <tr>
                                        <td style="padding: 3px">
                                            <input type="checkbox" v-model="MOMO.checked" v-if="MOMO.saf25FileInfo.cnf1004_char02!=''" /></td>
                                        <td style="padding: 3px">{{MOMO.saf25FileInfo.FileName}}</td>
                                        <td style="padding: 3px">

                                            <label class="btn btn-default" v-if="MOMO.saf25FileInfo.cnf1004_char02!=''" style="background-color: rgba(247, 255, 101, 0.67);">
                                                <input style="display: none;" type="file" accept=".csv" v-on:change="onFileChange('02', $event)">
                                                重新送出檔案比對
                                            </label>
                                            <span v-else>此物流公司在此系統未登記，請登記才能匯入資料</span>

                                            <label class="btn btn-default" style="color: red; background-color: rgba(255, 169, 169, 0.51);" v-if="MOMO.saf25FileInfo.ErrorMsg.length>0" data-toggle="modal" href='#modalDialog' v-on:click="ModalError=MOMO.saf25FileInfo.ErrorMsg">
                                                錯誤訊息   
                                            </label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <table class="table table-bordered" style="width: calc(100% - 18px)" v-if="MOMO.saf25FileInfo.cnf1004_char02!=''">
                                <thead>

                                    <tr class="bg-primary text-light">
                                        <th v-on:click="sortBy(MOMO,'saf2502_seq',$event)">項次+燈號</th>
                                        <th v-on:click="sortBy(MOMO,'saf2503_ord_no',$event)">訂單編號</th>
                                        <th v-on:click="sortBy(MOMO,'saf2506_ord_status',$event)">配送狀態</th>
                                        <th v-on:click="sortBy(MOMO,'saf2505_ord_remark',$event)">配送訊息</th>
                                        <th v-on:click="sortBy(MOMO,'saf2520_dis_date',$event)">約定配送日</th>
                                        <th v-on:click="sortBy(MOMO,'saf2529_logis_no',$event)">物流公司</th>
                                        <th v-on:click="sortBy(MOMO,'saf2528_fre_no',$event)">配送單號</th>
                                        <th v-on:click="sortBy(MOMO,'saf2507_ord_class',$event)">訂單類別</th>
                                        <th v-on:click="sortBy(MOMO,'saf2522_dis_demand',$event)">客戶配送需求</th>
                                        <th v-on:click="sortBy(MOMO,'saf2504_ord_date',$event)">轉單日</th>
                                        <th v-on:click="sortBy(MOMO,'saf2523_ship_date',$event)">預計出貨日</th>
                                        <th v-on:click="sortBy(MOMO,'saf2514_rec_name',$event)">收件人姓名</th>
                                        <th v-on:click="sortBy(MOMO,'saf2516_rec_tel01',$event)">收件人行動電話</th>
                                        <th v-on:click="sortBy(MOMO,'saf2515_rec_cell',$event)">收件人地址</th>
                                        <th v-on:click="sortBy(MOMO,'saf2519_rec_address',$event)">商品原廠編號</th>
                                        <th v-on:click="sortBy(MOMO,'saf2536_Letianode_v',$event)">品號</th>
                                        <th v-on:click="sortBy(MOMO,'saf2533_pspec',$event)">品名</th>
                                        <th v-on:click="sortBy(MOMO,'saf2531_psname',$event)">單名編號</th>
                                        <th v-on:click="sortBy(MOMO,'saf2537_Letianode',$event)">單名編號</th>
                                        <th v-on:click="sortBy(MOMO,'saf2532_pname',$event)">單品詳細</th>
                                        <th v-on:click="sortBy(MOMO,'saf2541_ord_qty',$event)">數量</th>
                                        <th v-on:click="sortBy(MOMO,'saf2544_cost',$event)">進價(含稅)</th>
                                        <th v-on:click="sortBy(MOMO,'saf2553_gifts',$event)">贈品</th>
                                        <th v-on:click="sortBy(MOMO,'saf2510_ord_name',$event)">訂購人姓名</th>
                                        <th v-on:click="sortBy(MOMO,'saf2538_inv_no',$event)">發票號碼</th>
                                        <th v-on:click="sortBy(MOMO,'saf2539_inv_date',$event)">發票日期</th>
                                        <th v-on:click="sortBy(MOMO,'saf2554_identifier',$event)">個人識別碼</th>
                                        <th v-on:click="sortBy(MOMO,'saf2555_chg_price',$event)">群組變價商品</th>
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
                                        <td>{{saf25.saf2536_Letianode_v}}</td>
                                        <td>{{saf25.saf2533_pspec}}</td>
                                        <td>{{saf25.saf2531_psname}}</td>
                                        <td>{{saf25.saf2537_Letianode}}</td>
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
                        <%--03. LetianHOME.CSV--%>
                        <div class="scroll-table" v-if="PChome.open">
                            <div>
                                <table>
                                    <tr>
                                        <td style="padding: 3px">
                                            <input type="checkbox" v-model="PChome.checked" v-if="PChome.saf25FileInfo.cnf1004_char02!=''" /></td>
                                        <td style="padding: 3px">{{PChome.saf25FileInfo.FileName}}</td>
                                        <td style="padding: 3px">
                                            <label class="btn btn-default" v-if="PChome.saf25FileInfo.cnf1004_char02!=''" style="background-color: rgba(247, 255, 101, 0.67);">
                                                <input style="display: none;" type="file" accept=".csv" v-on:change="onFileChange('03', $event)">
                                                重新送出檔案比對
                                            </label>
                                            <span v-else>此物流公司在此系統未登記，請登記才能匯入資料</span>
                                            <label class="btn btn-default" style="color: red; background-color: rgba(255, 169, 169, 0.51);" v-if="PChome.saf25FileInfo.ErrorMsg.length>0" data-toggle="modal" href='#modalDialog' v-on:click="ModalError=PChome.saf25FileInfo.ErrorMsg">
                                                錯誤訊息   
                                            </label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <table class="table table-bordered" style="width: calc(100% - 18px)" v-if="PChome.saf25FileInfo.cnf1004_char02!=''">
                                <thead>

                                    <tr class="bg-primary text-light">
                                        <th v-on:click="sortBy(PChome,'saf2503_ord_no',$event)">訂單編號</th>
                                        <th v-on:click="sortBy(PChome,'saf2502_seq',$event)">NO</th>
                                        <th v-on:click="sortBy(PChome,'saf2527_ship_no',$event)">出貨單號</th>
                                        <th v-on:click="sortBy(PChome,'saf2506_ord_status',$event)">確認</th>
                                        <th v-on:click="sortBy(PChome,'saf2523_ship_date',$event)">出貨日期</th>
                                        <th v-on:click="sortBy(PChome,'saf2504_ord_date',$event)">轉單日期</th>
                                        <th v-on:click="sortBy(PChome,'saf2520_dis_date',$event)">預購日/指定配達日</th>
                                        <th v-on:click="sortBy(PChome,'saf2514_rec_name',$event)">收貨人</th>
                                        <th v-on:click="sortBy(PChome,'saf2518_rec_zip',$event)">ZIP</th>
                                        <th v-on:click="sortBy(PChome,'saf2519_rec_address',$event)">收貨地址(訂單編號)</th>
                                        <th v-on:click="sortBy(PChome,'saf2515_rec_cell',$event)">收貨人電話</th>
                                        <th v-on:click="sortBy(PChome,'saf2531_psname',$event)">商品名稱</th>
                                        <th v-on:click="sortBy(PChome,'saf2541_ord_qty',$event)">下定時數量</th>
                                        <th v-on:click="sortBy(PChome,'saf2543_cancel_qty',$event)">取消數量</th>
                                        <th v-on:click="sortBy(PChome,'saf2540_ship_qty',$event)">應出貨數量</th>
                                        <th v-on:click="sortBy(PChome,'saf2544_cost',$event)">單位成本</th>
                                        <th v-on:click="sortBy(PChome,'saf2545_cost_sub',$event)">成本小計</th>
                                        <th v-on:click="sortBy(PChome,'saf2532_pname',$event)">商品規格</th>
                                        <th v-on:click="sortBy(PChome,'saf2536_Letianode_v',$event)">廠商料號</th>
                                        <th v-on:click="sortBy(PChome,'saf2505_ord_remark',$event)">備註</th>
                                        <th v-on:click="sortBy(PChome,'saf2556_leave_msg',$event)">客戶留言</th>
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
                                        <td>{{saf25.saf2536_Letianode_v}}</td>
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
                                            <input type="checkbox" v-model="Formosa_Plastics.checked" v-if="Formosa_Plastics.saf25FileInfo.cnf1004_char02!=''" /></td>
                                        <td style="padding: 3px">{{Formosa_Plastics.saf25FileInfo.FileName}}</td>
                                        <td style="padding: 3px">
                                            <label class="btn btn-default" v-if="Formosa_Plastics.saf25FileInfo.cnf1004_char02!=''" style="background-color: rgba(247, 255, 101, 0.67);">
                                                <input style="display: none;" type="file" accept=".csv" v-on:change="onFileChange('04', $event)">
                                                重新送出檔案比對
                                            </label>
                                            <span v-else>此物流公司在此系統未登記，請登記才能匯入資料</span>
                                            <label class="btn btn-default" style="color: red; background-color: rgba(255, 169, 169, 0.51);" v-if="Formosa_Plastics.saf25FileInfo.ErrorMsg.length>0" data-toggle="modal" href='#modalDialog' v-on:click="ModalError=Formosa_Plastics.saf25FileInfo.ErrorMsg">
                                                錯誤訊息   
                                            </label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <table class="table table-bordered" style="width: calc(100% - 18px)" v-if="Formosa_Plastics.saf25FileInfo.cnf1004_char02!=''">
                                <thead>
                                    <tr class="">
                                        <th colspan="14" style="border: 1px solid white"></th>
                                    </tr>
                                    <tr class="bg-primary text-light">
                                        <th v-on:click="sortBy(Formosa_Plastics,'saf2502_seq',$event)">no</th>
                                        <th v-on:click="sortBy(Formosa_Plastics,'saf2503_ord_no',$event)">訂單編號</th>
                                        <th v-on:click="sortBy(Formosa_Plastics,'saf2557_open_no',$event)">拆單編號</th>
                                        <th v-on:click="sortBy(Formosa_Plastics,'saf2504_ord_date',$event)">訂購日期</th>

                                        <th v-on:click="sortBy(Formosa_Plastics,'saf2507_ord_class',$event)">訂單別</th>
                                        <th v-on:click="sortBy(Formosa_Plastics,'saf2506_ord_status',$event)">訂單狀態</th>

                                        <th v-on:click="sortBy(Formosa_Plastics,'saf2550_paymt_way',$event)">付款方式</th>
                                        <th v-on:click="sortBy(Formosa_Plastics,'saf2551_paymt_status',$event)">付款狀態</th>
                                        <th v-on:click="sortBy(Formosa_Plastics,'saf2522_dis_demand',$event)">配送方式</th>
                                        <th v-on:click="sortBy(Formosa_Plastics,'saf2558_trans_yn',$event)">是否轉檔</th>
                                        <th v-on:click="sortBy(Formosa_Plastics,'saf2526_ship_status',$event)">出貨狀態</th>
                                        <th v-on:click="sortBy(Formosa_Plastics,'saf2520_dis_date',$event)">指交日期</th>
                                        <th v-on:click="sortBy(Formosa_Plastics,'saf2521_dis_time',$event)">配送時段</th>
                                        <th v-on:click="sortBy(Formosa_Plastics,'saf2510_ord_name',$event)">訂購人姓名</th>
                                        <th v-on:click="sortBy(Formosa_Plastics,'saf2512_ord_tel01',$event)">訂購人電話1</th>
                                        <th v-on:click="sortBy(Formosa_Plastics,'saf2513_ord_tel02',$event)">訂購人電話2</th>
                                        <th v-on:click="sortBy(Formosa_Plastics,'saf2511_ord_cell',$event)">訂購人手機</th>
                                        <th v-on:click="sortBy(Formosa_Plastics,'saf2514_rec_name',$event)">收貨人姓名</th>
                                        <th v-on:click="sortBy(Formosa_Plastics,'saf2516_rec_tel01',$event)">收貨人市話1</th>
                                        <th v-on:click="sortBy(Formosa_Plastics,'saf2517_rec_tel02',$event)">收貨人市話2</th>
                                        <th v-on:click="sortBy(Formosa_Plastics,'saf2515_rec_cell',$event)">收貨人手機</th>
                                        <th v-on:click="sortBy(Formosa_Plastics,'saf2519_rec_address',$event)">收貨人地址</th>
                                        <th v-on:click="sortBy(Formosa_Plastics,'saf2505_ord_remark',$event)">備註/卡片內容</th>
                                        <th v-on:click="sortBy(Formosa_Plastics,'saf2559_option_case',$event)">任選案件</th>
                                        <th v-on:click="sortBy(Formosa_Plastics,'saf2542_groups',$event)">商品項次</th>
                                        <th v-on:click="sortBy(Formosa_Plastics,'saf2537_Letianode',$event)">商品編號</th>
                                        <th v-on:click="sortBy(Formosa_Plastics,'saf2531_psname',$event)">商品名稱</th>
                                        <th v-on:click="sortBy(Formosa_Plastics,'saf2532_pname',$event)">商品規格</th>
                                        <th v-on:click="sortBy(Formosa_Plastics,'saf2536_Letianode_v',$event)">廠商料號</th>
                                        <th v-on:click="sortBy(Formosa_Plastics,'saf2533_pspec',$event)">商品型號</th>
                                        <th v-on:click="sortBy(Formosa_Plastics,'saf2560_unit',$event)">單位</th>
                                        <th v-on:click="sortBy(Formosa_Plastics,'saf2547_price',$event)">單價</th>
                                        <th v-on:click="sortBy(Formosa_Plastics,'saf2541_ord_qty',$event)">數量</th>
                                        <th v-on:click="sortBy(Formosa_Plastics,'saf2548_price_sub',$event)">金額</th>
                                        <th v-on:click="sortBy(Formosa_Plastics,'saf2544_cost',$event)">成本價</th>
                                        <th v-on:click="sortBy(Formosa_Plastics,'saf2546_mana_fee',$event)">管理費</th>
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
                                        <td>{{saf25.saf2537_Letianode}}</td>
                                        <td>{{saf25.saf2531_psname}}</td>
                                        <td>{{saf25.saf2532_pname}}</td>
                                        <td>{{saf25.saf2536_Letianode_v}}</td>
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
                                            <input type="checkbox" v-model="Taiwan_Mobile.checked" v-if="Taiwan_Mobile.saf25FileInfo.cnf1004_char02!=''" /></td>
                                        <td style="padding: 3px">{{Taiwan_Mobile.saf25FileInfo.FileName}}</td>
                                        <td style="padding: 3px">
                                            <label class="btn btn-default" v-if="Taiwan_Mobile.saf25FileInfo.cnf1004_char02!=''" style="background-color: rgba(247, 255, 101, 0.67);">
                                                <input style="display: none;" type="file" accept=".csv" v-on:change="onFileChange('05', $event)">
                                                重新送出檔案比對
                                            </label>
                                            <span v-else>此物流公司在此系統未登記，請登記才能匯入資料</span>
                                            <label class="btn btn-default" style="color: red; background-color: rgba(255, 169, 169, 0.51);" v-if="Taiwan_Mobile.saf25FileInfo.ErrorMsg.length>0" data-toggle="modal" href='#modalDialog' v-on:click="ModalError=Taiwan_Mobile.saf25FileInfo.ErrorMsg">
                                                錯誤訊息   
                                            </label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <table class="table table-bordered" style="width: calc(100% - 18px)" v-if="Taiwan_Mobile.saf25FileInfo.cnf1004_char02!=''">
                                <thead>

                                    <tr class="bg-primary text-light">
                                        <th v-on:click="sortBy(Taiwan_Mobile,'saf2504_ord_date',$event)">訂單日期</th>
                                        <th v-on:click="sortBy(Taiwan_Mobile,'saf2527_ship_no',$event)">出貨單編號</th>
                                        <th v-on:click="sortBy(Taiwan_Mobile,'saf2503_ord_no',$event)">訂單編號</th>
                                        <th v-on:click="sortBy(Taiwan_Mobile,'saf2522_dis_demand',$event)">運送方式</th>
                                        <th v-on:click="sortBy(Taiwan_Mobile,'saf2529_logis_no',$event)">物流代碼</th>
                                        <th v-on:click="sortBy(Taiwan_Mobile,'saf2528_fre_no',$event)">配送單號</th>
                                        <th v-on:click="sortBy(Taiwan_Mobile,'saf2537_Letianode',$event)">商品貨號</th>
                                        <th v-on:click="sortBy(Taiwan_Mobile,'saf2536_Letianode_v',$event)">供應商料號</th>
                                        <th v-on:click="sortBy(Taiwan_Mobile,'saf2531_psname',$event)">商品名稱</th>
                                        <th v-on:click="sortBy(Taiwan_Mobile,'saf2532_pname',$event)">樣式/規格</th>
                                        <th v-on:click="sortBy(Taiwan_Mobile,'saf2553_gifts',$event)">贈品資訊</th>
                                        <th v-on:click="sortBy(Taiwan_Mobile,'saf2541_ord_qty',$event)">數量</th>
                                        <th v-on:click="sortBy(Taiwan_Mobile,'saf2544_cost',$event)">單位成本</th>
                                        <th v-on:click="sortBy(Taiwan_Mobile,'saf2545_cost_sub',$event)">成本小計</th>
                                        <th v-on:click="sortBy(Taiwan_Mobile,'saf2514_rec_name',$event)">收件人</th>
                                        <th v-on:click="sortBy(Taiwan_Mobile,'saf2516_rec_tel01',$event)">聯絡電話</th>
                                        <th v-on:click="sortBy(Taiwan_Mobile,'saf2515_rec_cell',$event)">行動電話</th>
                                        <th v-on:click="sortBy(Taiwan_Mobile,'saf2519_rec_address',$event)">送貨地址</th>
                                        <th v-on:click="sortBy(Taiwan_Mobile,'saf2538_inv_no',$event)">發票號碼</th>
                                        <th v-on:click="sortBy(Taiwan_Mobile,'saf2524_ship_remark',$event)">出貨單備註</th>

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
                                        <td>{{saf25.saf2537_Letianode}}</td>
                                        <td>{{saf25.saf2536_Letianode_v}}</td>
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
                        <%--06.生活市集--%>
                        <div class="scroll-table" v-if="Buy123.open">
                            <div>
                                <table>
                                    <tr>
                                        <td style="padding: 3px">
                                            <input type="checkbox" v-model="Buy123.checked" v-if="Buy123.saf25FileInfo.cnf1004_char02!=''" /></td>
                                        <td style="padding: 3px">{{Buy123.saf25FileInfo.FileName}}</td>
                                        <td style="padding: 3px">
                                            <label class="btn btn-default" v-if="Buy123.saf25FileInfo.cnf1004_char02!=''" style="background-color: rgba(247, 255, 101, 0.67);">
                                                <input style="display: none;" type="file" accept=".csv" v-on:change="onFileChange('06', $event)">
                                                重新送出檔案比對
                                            </label>
                                            <span v-else>此物流公司在此系統未登記，請登記才能匯入資料</span>
                                            <label class="btn btn-default" style="color: red; background-color: rgba(255, 169, 169, 0.51);" v-if="Buy123.saf25FileInfo.ErrorMsg.length>0" data-toggle="modal" href='#modalDialog' v-on:click="ModalError=Buy123.saf25FileInfo.ErrorMsg">
                                                錯誤訊息   
                                            </label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <table class="table table-bordered" style="width: calc(100% - 18px)" v-if="Buy123.saf25FileInfo.cnf1004_char02!=''">
                                <thead>

                                    <tr class="bg-primary text-light">
                                        <th v-on:click="sortBy(Buy123,'saf2503_ord_no',$event)">訂單編號</th>
                                        <th v-on:click="sortBy(Buy123,'saf2514_rec_name',$event)">收件人</th>
                                        <th v-on:click="sortBy(Buy123,'saf2519_rec_address',$event)">收件地址</th>
                                        <th v-on:click="sortBy(Buy123,'saf2515_rec_cell',$event)">電話</th>
                                        <th v-on:click="sortBy(Buy123,'saf2521_dis_time',$event)">配送時段</th>
                                        <th v-on:click="sortBy(Buy123,'saf2531_psname',$event)">檔次名稱</th>
                                        <th v-on:click="sortBy(Buy123,'saf2508_ord_plan',$event)">訂購方案</th>
                                        <th v-on:click="sortBy(Buy123,'saf2532_pname',$event)">品項 * 總數</th>
                                        <th v-on:click="sortBy(Buy123,'saf2505_ord_remark',$event)">備註(購買人資料)</th>
                                        <th v-on:click="sortBy(Buy123,'saf2549_paymt_date',$event)">付款時間</th>
                                        <th v-on:click="sortBy(Buy123,'saf2552_return',$event)">退貨狀態</th>

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
                        <%--07.東森 森森--%>
                        <div class="scroll-table" v-if="Eastern.open">
                            <div>
                                <table>
                                    <tr>
                                        <td style="padding: 3px">
                                            <input type="checkbox" v-model="Eastern.checked" v-if="Eastern.saf25FileInfo.cnf1004_char02!=''" /></td>
                                        <td style="padding: 3px">{{Eastern.saf25FileInfo.FileName}}</td>
                                        <td style="padding: 3px">
                                            <label class="btn btn-default" v-if="Eastern.saf25FileInfo.cnf1004_char02!=''" style="background-color: rgba(247, 255, 101, 0.67);">
                                                <input style="display: none;" type="file" accept=".csv," v-on:change="onFileChange('07', $event)">
                                                重新送出檔案比對
                                            </label>
                                            <span v-else>此物流公司在此系統未登記，請登記才能匯入資料</span>
                                            <label class="btn btn-default" style="color: red; background-color: rgba(255, 169, 169, 0.51);" v-if="Eastern.saf25FileInfo.ErrorMsg.length>0" data-toggle="modal" href='#modalDialog' v-on:click="ModalError=Eastern.saf25FileInfo.ErrorMsg">
                                                錯誤訊息   
                                            </label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <table class="table table-bordered" style="width: calc(100% - 18px)" v-if="Eastern.saf25FileInfo.cnf1004_char02!=''">
                                <thead>

                                    <tr class="bg-primary text-light">
                                        <%-- a --%>
                                        <th v-on:click="sortBy(Eastern,'saf2503_ord_no',$event)">訂單號碼</th>
                                        <%-- b --%>
                                        <th v-on:click="sortBy(Eastern,'saf2587_gift_pnt',$event)">併單序號</th>
                                        <%-- c --%>
                                        <th v-on:click="sortBy(Eastern,'saf2527_ship_no',$event)">送貨單號</th>
                                        <%-- d --%>
                                        <th v-on:click="sortBy(Eastern,'saf2578_get_acc',$event)">銷售編號</th>
                                        <%-- e --%>
                                        <th v-on:click="sortBy(Eastern,'saf2537_pcode',$event)">商品編號</th>
                                        <%-- f --%>
                                        <th v-on:click="sortBy(Eastern,'saf2531_psname',$event)">商品名稱</th>
                                        <%-- g --%>
                                        <th v-on:click="sortBy(Eastern,'saf2532_pname',$event)">顏色</th>
                                        <%-- h --%>
                                        <th v-on:click="sortBy(Eastern,'saf2534_ship_pname',$event)">款式</th>
                                        <%-- i --%>
                                        <th v-on:click="sortBy(Eastern,'saf2536_pcode_v',$event)">廠商商品號碼</th>
                                        <%-- j --%>
                                        <th v-on:click="sortBy(Eastern,'saf2507_ord_class',$event)">訂單類別</th>
                                        <%-- k --%>
                                        <th v-on:click="sortBy(Eastern,'saf2541_ord_qty',$event)">數量</th>
                                        <%-- l --%>
                                        <th v-on:click="sortBy(Eastern,'saf2547_price',$event)">售價</th>
                                        <%-- m --%>
                                        <th v-on:click="sortBy(Eastern,'saf2544_cost',$event)">成本</th>
                                        <%-- n --%>
                                        <th v-on:click="sortBy(Eastern,'saf2514_rec_name',$event)">客戶名稱</th>
                                        <%-- o --%>
                                        <th v-on:click="sortBy(Eastern,'saf2515_rec_cell',$event)">客戶電話</th>
                                        <%-- p --%>
                                        <th v-on:click="sortBy(Eastern,'saf2516_rec_tel01',$event)">室內電話</th>
                                        <%-- q --%>
                                        <th v-on:click="sortBy(Eastern,'saf2519_rec_address',$event)">配送地址</th>
                                        <%-- r --%>
                                        <th v-on:click="sortBy(Eastern,'saf2530_logis_comp',$event)">貨運公司</th>
                                        <%-- s --%>
                                        <th v-on:click="sortBy(Eastern,'saf2528_fre_no',$event)">配送單號</th>
                                        <%-- t --%>
                                        <th v-on:click="sortBy(Eastern,'saf2523_ship_date',$event)">出貨指示日</th>
                                        <%-- u --%>
                                        <th v-on:click="sortBy(Eastern,'saf2520_dis_date',$event)">要求配送日</th>
                                        <%-- v --%>
                                        <th v-on:click="sortBy(Eastern,'saf2521_dis_time',$event)">要求配送時間</th>
                                        <%-- w --%>
                                        <th v-on:click="sortBy(Eastern,'saf2505_ord_remark',$event)">備註</th>
                                        <%-- x --%>
                                        <th v-on:click="sortBy(Eastern,'saf2553_gifts',$event)">贈品</th>
                                        <%-- y --%>
                                        <th v-on:click="sortBy(Eastern,'saf2522_dis_demand',$event)">廠商配送訊息</th>
                                        <%-- z --%>
                                        <th v-on:click="sortBy(Eastern,'saf2562_warehs_date',$event)">預計入庫日</th>
                                        <%-- aa --%>
                                        <th v-on:click="sortBy(Eastern,'saf2562_warehs_date',$event)">通路別</th>
                                        <%-- ab --%>
                                        <th v-on:click="sortBy(Eastern,'saf2557_open_no',$event)">併單訂單項次</th>
                                        <%-- ac --%>
                                        <th v-on:click="sortBy(Eastern,'saf2508_ord_plan',$event)">訂單類別代號</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="saf25 in Eastern.saf25FileInfo.saf25List">
                                      
                                         <%-- a --%>
                                        <td>{{saf25.saf2503_ord_no}}</td>
                                        <%-- b --%>
                                        <td>{{saf25.saf2587_gift_pnt}}</td>
                                        <%-- c --%>
                                        <td>{{saf25.saf2527_ship_no}}</td>
                                        <%-- d --%>
                                        <td>{{saf25.saf2578_get_acc}}</td>
                                        <%-- e --%>
                                        <td>{{saf25.saf2537_pcode}}</td>
                                        <%-- f --%>
                                        <td>{{saf25.saf2531_psname}}</td>
                                        <%-- g --%>
                                        <td>{{saf25.saf2532_pname}}</td>
                                        <%-- h --%>
                                        <td>{{saf25.saf2534_ship_pname}}</td>
                                        <%-- i --%>
                                        <td>{{saf25.saf2536_pcode_v}}</td>
                                        <%-- j --%>
                                        <td>{{saf25.saf2507_ord_class}}</td>
                                        <%-- k --%>
                                        <td>{{saf25.saf2541_ord_qty}}</td>
                                        <%-- l --%>
                                        <td>{{saf25.saf2547_price}}</td>
                                        <%-- m --%>
                                        <td>{{saf25.saf2544_cost}}</td>
                                        <%-- n --%>
                                        <td>{{saf25.saf2514_rec_name}}</td>
                                        <%-- o --%>
                                        <td>{{saf25.saf2515_rec_cell}}</td>
                                        <%-- p --%>
                                        <td>{{saf25.saf2516_rec_tel01}}</td>
                                        <%-- q --%>
                                        <td>{{saf25.saf2519_rec_address}}</td>
                                        <%-- r --%>
                                        <td>{{saf25.saf2530_logis_comp}}</td>
                                        <%-- s --%>
                                        <td>{{saf25.saf2528_fre_no}}</td>
                                        <%-- t --%>
                                        <td>{{saf25.saf2523_ship_date}}</td>
                                        <%-- u --%>
                                        <td>{{saf25.saf2520_dis_date}}</td>
                                        <%-- v --%>
                                        <td>{{saf25.saf2521_dis_time}}</td>
                                        <%-- w --%>
                                        <td>{{saf25.saf2505_ord_remark}}</td>
                                        <%-- x --%>
                                        <td>{{saf25.saf2553_gifts}}</td>
                                        <%-- y --%>
                                        <td>{{saf25.saf2522_dis_demand}}</td>
                                        <%-- z --%>
                                        <td>{{saf25.saf2562_warehs_date}}</td>
                                        <%-- aa --%>
                                        <td>{{saf25.saf2562_warehs_date}}</td>
                                        <%-- ab --%>
                                        <td>{{saf25.saf2557_open_no}}</td>
                                        <%-- ac --%>
                                        <td>{{saf25.saf2508_ord_plan}}</td>

                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <%--08.松果--%>
                        <th v-on:click="sortBy(Letianone,'"></th>
                        <div class="scroll-table" v-if="Letianone.open">
                            <div>
                                <table>
                                    <tr>
                                        <td style="padding: 3px">
                                            <input type="checkbox" v-model="Letianone.checked" v-if="Letianone.saf25FileInfo.cnf1004_char02!=''" /></td>
                                        <td style="padding: 3px">{{Letianone.saf25FileInfo.FileName}}</td>
                                        <td style="padding: 3px">
                                            <label class="btn btn-default" v-if="Letianone.saf25FileInfo.cnf1004_char02!=''" style="background-color: rgba(247, 255, 101, 0.67);">
                                                <input style="display: none;" type="file" accept=".csv," v-on:change="onFileChange('08', $event)">
                                                重新送出檔案比對
                                            </label>
                                            <span v-else>此物流公司在此系統未登記，請登記才能匯入資料</span>
                                            <label class="btn btn-default" style="color: red; background-color: rgba(255, 169, 169, 0.51);" v-if="Letianone.saf25FileInfo.ErrorMsg.length>0" data-toggle="modal" href='#modalDialog' v-on:click="ModalError=Letianone.saf25FileInfo.ErrorMsg">
                                                錯誤訊息   
                                            </label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <table class="table table-bordered" style="width: calc(100% - 18px)" v-if="Letianone.saf25FileInfo.cnf1004_char02!=''">
                                <thead>

                                    <tr class="bg-primary text-light">
                                        <%--a--%>
                                        <th v-on:click="sortBy(Letianone,'saf2503_ord_no',$event)">訂單編號</th>
                                        <%--b--%>
                                        <th v-on:click="sortBy(Letianone,'saf2549_paymt_date',$event)">付款時間</th>
                                        <%--c--%>
                                        <th v-on:click="sortBy(Letianone,'saf2510_ord_name',$event)">訂購人</th>
                                        <%--d--%>
                                        <th v-on:click="sortBy(Letianone,'saf2511_ord_cell',$event)">訂購人電話</th>
                                        <%--e--%>
                                        <th v-on:click="sortBy(Letianone,'saf2550_paymt_way',$event)">付款方式</th>
                                        <%--f--%>
                                        <th v-on:click="sortBy(Letianone,'saf2524_ship_remark',$event)">發票</th>
                                        <%--g--%>
                                        <th v-on:click="sortBy(Letianone,'saf2502_seq ',$event)">信用卡後4碼</th>
                                        <%--h--%>
                                        <th v-on:click="sortBy(Letianone,'saf2548_price_sub',$event)">訂單金額</th>
                                        <%--i--%>
                                        <th v-on:click="sortBy(Letianone,'saf2514_rec_name',$event)">收件人</th>
                                        <%--j--%>
                                        <th v-on:click="sortBy(Letianone,'saf2515_rec_cell',$event)">電話</th>
                                        <%--k--%>
                                        <th v-on:click="sortBy(Letianone,'saf2509_ord_shop',$event)">收件地址</th>
                                        <%--l--%>
                                        <th v-on:click="sortBy(Letianone,'saf2531_psname',$event)">商品</th>
                                        <%--m--%>
                                        <th v-on:click="sortBy(Letianone,'saf2537_Letianode',$event)">商品編號</th>
                                        <%--n--%>
                                        <th v-on:click="sortBy(Letianone,'saf2536_Letianode_v',$event)">主料號</th>
                                        <%--o--%>
                                        <th v-on:click="sortBy(Letianone,'saf2542_groups',$event)">方案入數</th>
                                        <%--p--%>
                                        <th v-on:click="sortBy(Letianone,'saf2547_price',$event)">方案價格</th>
                                        <%--q--%>
                                        <th v-on:click="sortBy(Letianone,'',$event)">方案數量</th>
                                        <%--r--%>
                                        <th v-on:click="sortBy(Letianone,'saf2561_option',$event)">選項</th>
                                        <%--s--%>
                                        <th v-on:click="sortBy(Letianone,'saf2533_pspec',$event)">料號</th>
                                        <%--t--%>
                                        <th v-on:click="sortBy(Letianone,'saf2541_ord_qty',$event)">數量</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="saf25 in Letianone.saf25FileInfo.saf25List">
                                        <td>{{saf25.saf2503_ord_no}}</td>
                                        <%--a--%>
                                        <td>{{saf25.saf2503_ord_no}}</td>
                                        <%--b--%>
                                        <td>{{saf25.saf2549_paymt_date}}</td>
                                        <%--c--%>
                                        <td>{{saf25.saf2510_ord_name}}</td>
                                        <%--d--%>
                                        <td>{{saf25.saf2511_ord_cell}}</td>
                                        <%--e--%>
                                        <td>{{saf25.saf2550_paymt_way}}</td>
                                        <%--f--%>
                                        <td>{{saf25.saf2524_ship_remark}}</td>
                                        <%--g--%>
                                        <td>{{saf25.saf2502_seq }}</td>
                                        <%--h--%>
                                        <td>{{saf25.saf2548_price_sub}}</td>
                                        <%--i--%>
                                        <td>{{saf25.saf2514_rec_name}}</td>
                                        <%--j--%>
                                        <td>{{saf25.saf2515_rec_cell}}</td>
                                        <%--k--%>
                                        <td>{{saf25.saf2509_ord_shop}}</td>
                                        <%--l--%>
                                        <td>{{saf25.saf2531_psname}}</td>
                                        <%--m--%>
                                        <td>{{saf25.saf2537_Letianode}}</td>
                                        <%--n--%>
                                        <td>{{saf25.saf2536_Letianode_v}}</td>
                                        <%--o--%>
                                        <td>{{saf25.saf2542_groups}}</td>
                                        <%--p--%>
                                        <td>{{saf25.saf2547_price}}</td>
                                        <%--q--%>
                                        <td></td>
                                        <%--r--%>
                                        <td>{{saf25.saf2561_option}}</td>
                                        <%--s--%>
                                        <td>{{saf25.saf2533_pspec}}</td>
                                        <%--t--%>
                                        <td>{{saf25.saf2541_ord_qty}}</td>

                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <%--09.神坊--%>
                        <div class="scroll-table" v-if="Symphox.open">
                            <div>
                                <table>
                                    <tr>
                                        <td style="padding: 3px">
                                            <input type="checkbox" v-model="Symphox.checked" v-if="Symphox.saf25FileInfo.cnf1004_char02!=''" /></td>
                                        <td style="padding: 3px">{{Symphox.saf25FileInfo.FileName}}</td>
                                        <td style="padding: 3px">
                                            <label class="btn btn-default" v-if="Symphox.saf25FileInfo.cnf1004_char02!=''" style="background-color: rgba(247, 255, 101, 0.67);">
                                                <input style="display: none;" type="file" accept=".csv," v-on:change="onFileChange('09', $event)">
                                                重新送出檔案比對
                                            </label>
                                            <span v-else>此物流公司在此系統未登記，請登記才能匯入資料</span>
                                            <label class="btn btn-default" style="color: red; background-color: rgba(255, 169, 169, 0.51);" v-if="Symphox.saf25FileInfo.ErrorMsg.length>0" data-toggle="modal" href='#modalDialog' v-on:click="ModalError=Symphox.saf25FileInfo.ErrorMsg">
                                                錯誤訊息   
                                            </label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <table class="table table-bordered" style="width: calc(100% - 18px)" v-if="Symphox.saf25FileInfo.cnf1004_char02!=''">
                                <thead>

                                    <tr class="bg-primary text-light">
                                        <th v-on:click="sortBy(Symphox,'saf2510_ord_name',$event)">訂貨人</th>
                                        <th v-on:click="sortBy(Symphox,'saf2503_ord_no',$event)">訂單編號</th>
                                        <th v-on:click="sortBy(Symphox,'saf2504_ord_date',$event)">訂單日</th>
                                        <th v-on:click="sortBy(Symphox,'saf2537_Letianode',$event)">商品流水號</th>
                                        <th v-on:click="sortBy(Symphox,'saf2531_psname',$event)">品項名</th>
                                        <th v-on:click="sortBy(Symphox,'saf2541_ord_qty',$event)">數量</th>
                                        <th v-on:click="sortBy(Symphox,'saf2514_rec_name',$event)">收貨人姓名</th>
                                        <th v-on:click="sortBy(Symphox,'saf2518_rec_zip',$event)">郵遞區號</th>
                                        <th v-on:click="sortBy(Symphox,'saf2519_rec_address',$event)">收貨人地址</th>
                                        <th v-on:click="sortBy(Symphox,'saf2516_rec_tel01',$event)">收貨日間電話</th>
                                        <th v-on:click="sortBy(Symphox,'saf2517_rec_tel02',$event)">收貨夜間電話</th>
                                        <th v-on:click="sortBy(Symphox,'saf2515_rec_cell',$event)">收貨人行動電話</th>
                                        <th v-on:click="sortBy(Symphox,'saf2544_cost',$event)">商品成本</th>
                                        <th v-on:click="sortBy(Symphox,'saf2505_ord_remark',$event)">備註</th>
                                        <th v-on:click="sortBy(Symphox,'saf2556_leave_msg',$event)">要使用的包材</th>
                                        <th v-on:click="sortBy(Symphox,'saf2524_ship_remark',$event)">出貨商品備註 </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="saf25 in Symphox.saf25FileInfo.saf25List">
                                        <td>{{saf25.saf2510_ord_name}}</td>
                                        <td>{{saf25.saf2503_ord_no}}</td>
                                        <td>{{saf25.saf2504_ord_date}}</td>
                                        <td>{{saf25.saf2537_Letianode}}</td>
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
                        <%--10.夠麻吉--%>
                        <div class="scroll-table" v-if="Gomaji.open">
                            <div>
                                <table>
                                    <tr>
                                        <td style="padding: 3px">
                                            <input type="checkbox" v-model="Gomaji.checked" v-if="Gomaji.saf25FileInfo.cnf1004_char02!=''" /></td>
                                        <td style="padding: 3px">{{Gomaji.saf25FileInfo.FileName}}</td>
                                        <td style="padding: 3px">
                                            <label class="btn btn-default" v-if="Gomaji.saf25FileInfo.cnf1004_char02!=''" style="background-color: rgba(247, 255, 101, 0.67);">
                                                <input style="display: none;" type="file" accept=".csv," v-on:change="onFileChange('10', $event)">
                                                重新送出檔案比對
                                            </label>
                                            <span v-else>此物流公司在此系統未登記，請登記才能匯入資料</span>
                                            <label class="btn btn-default" style="color: red; background-color: rgba(255, 169, 169, 0.51);" v-if="Gomaji.saf25FileInfo.ErrorMsg.length>0" data-toggle="modal" href='#modalDialog' v-on:click="ModalError=Gomaji.saf25FileInfo.ErrorMsg">
                                                錯誤訊息   
                                            </label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <table class="table table-bordered" style="width: calc(100% - 18px)" v-if="Gomaji.saf25FileInfo.cnf1004_char02!=''">

                                <thead>

                                    <tr class="bg-primary text-light">
                                        <th v-on:click="sortBy(Gomaji,'saf2502_seq',$event)">store_id</th>
                                        <th v-on:click="sortBy(Gomaji,'saf2537_Letianode',$event)">product_id</th>
                                        <th v-on:click="sortBy(Gomaji,'saf2503_ord_no',$event)">代碼</th>
                                        <th v-on:click="sortBy(Gomaji,'saf2504_ord_date',$event)">購買日期</th>
                                        <th v-on:click="sortBy(Gomaji,'saf2523_ship_date',$event)">最後出貨日</th>
                                        <th v-on:click="sortBy(Gomaji,'saf2510_ord_name',$event)">訂購人</th>
                                        <th v-on:click="sortBy(Gomaji,'saf2514_rec_name',$event)">收件人</th>
                                        <th v-on:click="sortBy(Gomaji,'saf2511_ord_cell',$event)">訂購人電話</th>
                                        <th v-on:click="sortBy(Gomaji,'saf2515_rec_cell',$event)">收件人電話</th>
                                        <th v-on:click="sortBy(Gomaji,'saf2542_groups',$event)">訂單份數</th>
                                        <th v-on:click="sortBy(Gomaji,'saf2531_psname',$event)">方案名稱</th>
                                        <th v-on:click="sortBy(Gomaji,'saf2519_rec_address',$event)">配送地址</th>
                                        <th v-on:click="sortBy(Gomaji,'saf2533_pspec',$event)">品項</th>
                                        <th v-on:click="sortBy(Gomaji,'saf2532_pname',$event)">規格</th>
                                        <th v-on:click="sortBy(Gomaji,'saf2536_Letianode_v',$event)">編號</th>
                                        <th v-on:click="sortBy(Gomaji,'saf2540_ship_qty',$event)">應出貨數量</th>
                                        <th v-on:click="sortBy(Gomaji,'saf2505_ord_remark',$event)">備註</th>
                                        <th v-on:click="sortBy(Gomaji,'saf2528_fre_no',$event)">貨運編號</th>
                                        <th v-on:click="sortBy(Gomaji,'saf2520_dis_date',$event)">出貨日期</th>
                                        <th v-on:click="sortBy(Gomaji,'saf2524_ship_remark',$event)">備註</th>

                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="saf25 in Gomaji.saf25FileInfo.saf25List">
                                        <td>{{saf25.saf2502_seq}}</td>
                                        <td>{{saf25.saf2537_Letianode}}</td>
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
                                        <td>{{saf25.saf2536_Letianode_v}}</td>
                                        <td>{{saf25.saf2540_ship_qty}}</td>
                                        <td>{{saf25.saf2505_ord_remark}}</td>
                                        <td>{{saf25.saf2528_fre_no}}</td>
                                        <td>{{saf25.saf2520_dis_date}}</td>
                                        <td>{{saf25.saf2524_ship_remark}}</td>

                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <%--11.康迅--%>
                        <div class="scroll-table" v-if="PayEasy.open">
                            <div>
                                <table>
                                    <tr>
                                        <td style="padding: 3px">
                                            <input type="checkbox" v-model="PayEasy.checked" v-if="PayEasy.saf25FileInfo.cnf1004_char02!=''" /></td>
                                        <td style="padding: 3px">{{PayEasy.saf25FileInfo.FileName}}</td>
                                        <td style="padding: 3px">
                                            <label class="btn btn-default" v-if="PayEasy.saf25FileInfo.cnf1004_char02!=''" style="background-color: rgba(247, 255, 101, 0.67);">
                                                <input style="display: none;" type="file" accept=".csv," v-on:change="onFileChange('11', $event)">
                                                重新送出檔案比對
                                            </label>
                                            <span v-else>此物流公司在此系統未登記，請登記才能匯入資料</span>
                                            <label class="btn btn-default" style="color: red; background-color: rgba(255, 169, 169, 0.51);" v-if="PayEasy.saf25FileInfo.ErrorMsg.length>0" data-toggle="modal" href='#modalDialog' v-on:click="ModalError=PayEasy.saf25FileInfo.ErrorMsg">
                                                錯誤訊息   
                                            </label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <table class="table table-bordered" style="width: calc(100% - 18px)" v-if="PayEasy.saf25FileInfo.cnf1004_char02!=''">
                                <thead>

                                    <tr class="bg-primary text-light">
                                        <th v-on:click="sortBy(PayEasy,'saf2526_ship_status',$event)">貨物送出</th>
                                        <th v-on:click="sortBy(PayEasy,'saf2523_ship_date',$event)">出貨日</th>
                                        <th v-on:click="sortBy(PayEasy,'saf2529_logis_no',$event)">物流公司</th>
                                        <th v-on:click="sortBy(PayEasy,'saf2528_fre_no',$event)">配送單號</th>
                                        <th v-on:click="sortBy(PayEasy,'saf2502_seq',$event)">項次</th>
                                        <th v-on:click="sortBy(PayEasy,'saf2504_ord_date',$event)">組檔日期</th>
                                        <th v-on:click="sortBy(PayEasy,'saf2503_ord_no',$event)">訂單編號</th>
                                        <th v-on:click="sortBy(PayEasy,'saf2506_ord_status',$event)">活動訂單</th>
                                        <th v-on:click="sortBy(PayEasy,'saf2531_psname',$event)">商品銷售名稱</th>
                                        <th v-on:click="sortBy(PayEasy,'saf2537_Letianode',$event)">商品流水號</th>
                                        <th v-on:click="sortBy(PayEasy,'saf2536_Letianode_v',$event)">廠商商品原始碼</th>
                                        <th v-on:click="sortBy(PayEasy,'saf2541_ord_qty',$event)">商品數量</th>
                                        <th v-on:click="sortBy(PayEasy,'saf2548_price_sub',$event)">帳款金額</th>
                                        <th v-on:click="sortBy(PayEasy,'saf2545_cost_sub',$event)">訂單貨款</th>
                                        <th v-on:click="sortBy(PayEasy,'saf2514_rec_name',$event)">收貨人</th>
                                        <th v-on:click="sortBy(PayEasy,'saf2518_rec_zip',$event)">郵遞區號</th>
                                        <th v-on:click="sortBy(PayEasy,'saf2563_county',$event)">縣市別</th>
                                        <th v-on:click="sortBy(PayEasy,'saf2519_rec_address',$event)">收貨地址</th>
                                        <th v-on:click="sortBy(PayEasy,'saf2516_rec_tel01',$event)">電話(日)</th>
                                        <th v-on:click="sortBy(PayEasy,'saf2517_rec_tel02',$event)">電話(夜)</th>
                                        <th v-on:click="sortBy(PayEasy,'saf2515_rec_cell',$event)">手機</th>
                                        <th v-on:click="sortBy(PayEasy,'saf2505_ord_remark',$event)">備註</th>
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
                                        <td>{{saf25.saf2537_Letianode}}</td>
                                        <td>{{saf25.saf2536_Letianode_v}}</td>
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
                        <%--12.統一--%>
                        <div class="scroll-table" v-if="UniPresiden.open">
                            <div>
                                <table>
                                    <tr>
                                        <td style="padding: 3px">
                                            <input type="checkbox" v-model="UniPresiden.checked" v-if="UniPresiden.saf25FileInfo.cnf1004_char02!=''" /></td>
                                        <td style="padding: 3px">{{UniPresiden.saf25FileInfo.FileName}}</td>
                                        <td style="padding: 3px">
                                            <label class="btn btn-default" v-if="UniPresiden.saf25FileInfo.cnf1004_char02!=''" style="background-color: rgba(247, 255, 101, 0.67);">
                                                <input style="display: none;" type="file" accept=".csv," v-on:change="onFileChange('12', $event)">
                                                重新送出檔案比對
                                            </label>
                                            <span v-else>此物流公司在此系統未登記，請登記才能匯入資料</span>
                                            <label class="btn btn-default" style="color: red; background-color: rgba(255, 169, 169, 0.51);" v-if="UniPresiden.saf25FileInfo.ErrorMsg.length>0" data-toggle="modal" href='#modalDialog' v-on:click="ModalError=UniPresiden.saf25FileInfo.ErrorMsg">
                                                錯誤訊息   
                                            </label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <table class="table table-bordered" style="width: calc(100% - 18px)" v-if="UniPresiden.saf25FileInfo.cnf1004_char02!=''">
                                <thead>

                                    <tr class="bg-primary text-light">
                                        <th v-on:click="sortBy(UniPresiden,'saf2502_seq',$event)">序</th>
                                        <th v-on:click="sortBy(UniPresiden,'saf2568_vendor_no',$event)">廠商廠編</th>
                                        <th v-on:click="sortBy(UniPresiden,'saf2569_vendor_name',$event)">廠商簡稱</th>
                                        <th v-on:click="sortBy(UniPresiden,'saf2504_ord_date',$event)">轉單日</th>
                                        <th v-on:click="sortBy(UniPresiden,'saf2503_ord_no',$event)">訂單編號</th>
                                        <th v-on:click="sortBy(UniPresiden,'saf2527_ship_no',$event)">出貨單編號</th>
                                        <th v-on:click="sortBy(UniPresiden,'saf2510_ord_name',$event)">訂購人姓名</th>
                                        <th v-on:click="sortBy(UniPresiden,'saf2514_rec_name',$event)">收件人姓名</th>
                                        <th v-on:click="sortBy(UniPresiden,'saf2515_rec_cell',$event)">收件人聯絡電話</th>
                                        <th v-on:click="sortBy(UniPresiden,'saf2519_rec_address',$event)">送貨地址</th>
                                        <th v-on:click="sortBy(UniPresiden,'saf2564_post_box',$event)">郵政信箱</th>
                                        <th v-on:click="sortBy(UniPresiden,'saf2518_rec_zip',$event)">收件人郵遞區號</th>
                                        <th v-on:click="sortBy(UniPresiden,'saf2565_chg_notes',$event)">換貨註記</th>
                                        <th v-on:click="sortBy(UniPresiden,'saf2506_ord_status',$event)">訂單型態</th>
                                        <th v-on:click="sortBy(UniPresiden,'saf2566_warm',$event)">溫層</th>
                                        <th v-on:click="sortBy(UniPresiden,'saf2537_Letianode',$event)">商品品號</th>
                                        <th v-on:click="sortBy(UniPresiden,'saf2536_Letianode_v',$event)">廠商貨號</th>
                                        <th v-on:click="sortBy(UniPresiden,'saf2531_psname',$event)">商品名稱</th>
                                        <th v-on:click="sortBy(UniPresiden,'saf2532_pname',$event)">規格</th>
                                        <th v-on:click="sortBy(UniPresiden,'saf2541_ord_qty',$event)">出貨數量</th>
                                        <th v-on:click="sortBy(UniPresiden,'saf2544_cost',$event)">成本價</th>
                                        <th v-on:click="sortBy(UniPresiden,'saf2529_logis_no',$event)">託運公司代碼</th>
                                        <th v-on:click="sortBy(UniPresiden,'saf2530_logis_comp',$event)">託運公司</th>
                                        <th v-on:click="sortBy(UniPresiden,'saf2528_fre_no',$event)">託運單號</th>
                                        <th v-on:click="sortBy(UniPresiden,'saf2567_carton_spec',$event)">外箱規格</th>
                                        <th v-on:click="sortBy(UniPresiden,'saf2526_ship_status',$event)">出貨狀態</th>
                                        <th v-on:click="sortBy(UniPresiden,'saf2505_ord_remark',$event)">訂單備註</th>
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
                                        <td>{{saf25.saf2537_Letianode}}</td>
                                        <td>{{saf25.saf2536_Letianode_v}}</td>
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
                        <%--13.鼎鼎--%>
                        <div class="scroll-table" v-if="Dingding.open">
                            <div>
                                <table>
                                    <tr>
                                        <td style="padding: 3px">
                                            <input type="checkbox" v-model="Dingding.checked" v-if="Dingding.saf25FileInfo.cnf1004_char02!=''" /></td>
                                        <td style="padding: 3px">{{Dingding.saf25FileInfo.FileName}}</td>
                                        <td style="padding: 3px">
                                            <label class="btn btn-default" v-if="Dingding.saf25FileInfo.cnf1004_char02!=''" style="background-color: rgba(247, 255, 101, 0.67);">
                                                <input style="display: none;" type="file" accept=".csv," v-on:change="onFileChange('13', $event)">
                                                重新送出檔案比對
                                            </label>
                                            <span v-else>此物流公司在此系統未登記，請登記才能匯入資料</span>
                                            <label class="btn btn-default" style="color: red; background-color: rgba(255, 169, 169, 0.51);" v-if="Dingding.saf25FileInfo.ErrorMsg.length>0" data-toggle="modal" href='#modalDialog' v-on:click="ModalError=Dingding.saf25FileInfo.ErrorMsg">
                                                錯誤訊息   
                                            </label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <table class="table table-bordered" style="width: calc(100% - 18px)" v-if="Dingding.saf25FileInfo.cnf1004_char02!=''">
                                <thead>

                                    <tr class="bg-primary text-light">
                                        <th v-on:click="sortBy(Dingding,'saf2568_vendor_no',$event)">供應商名稱</th>
                                        <th v-on:click="sortBy(Dingding,'saf2569_vendor_name',$event)">供應商編號</th>
                                        <th v-on:click="sortBy(Dingding,'saf2523_ship_date',$event)">通知出貨時間</th>
                                        <th v-on:click="sortBy(Dingding,'saf2527_ship_no',$event)">出貨單號</th>
                                        <th v-on:click="sortBy(Dingding,'saf2549_paymt_date',$event)">對帳日期</th>
                                        <th v-on:click="sortBy(Dingding,'saf2526_ship_status',$event)">出貨狀態</th>
                                        <th v-on:click="sortBy(Dingding,'saf2503_ord_no',$event)">訂單編號</th>
                                        <th v-on:click="sortBy(Dingding,'saf2506_ord_status',$event)">訂單狀態</th>
                                        <th v-on:click="sortBy(Dingding,'saf2504_ord_date',$event)">訂單時間</th>
                                        <th v-on:click="sortBy(Dingding,'saf2531_psname',$event)">商品名稱</th>
                                        <th v-on:click="sortBy(Dingding,'saf2535_ptpye',$event)">商品類型</th>
                                        <th v-on:click="sortBy(Dingding,'saf2537_Letianode',$event)">商品序號</th>
                                        <th v-on:click="sortBy(Dingding,'saf2532_pname',$event)">規格編號或條碼</th>
                                        <th v-on:click="sortBy(Dingding,'saf2544_cost',$event)">提報成本</th>
                                        <th v-on:click="sortBy(Dingding,'saf2547_price',$event)">單價</th>
                                        <th v-on:click="sortBy(Dingding,'saf2541_ord_qty',$event)">數量</th>
                                        <th v-on:click="sortBy(Dingding,'saf2548_price_sub',$event)">總價</th>
                                        <th v-on:click="sortBy(Dingding,'saf2510_ord_name',$event)">訂購人</th>
                                        <th v-on:click="sortBy(Dingding,'saf2514_rec_name',$event)">收件人</th>
                                        <th v-on:click="sortBy(Dingding,'saf2518_rec_zip',$event)">收件人郵遞區號</th>
                                        <th v-on:click="sortBy(Dingding,'saf2519_rec_address',$event)">收件人地址</th>
                                        <th v-on:click="sortBy(Dingding,'saf2516_rec_tel01',$event)">收件人電話</th>
                                        <th v-on:click="sortBy(Dingding,'saf2515_rec_cell',$event)">收件人手機</th>
                                        <th v-on:click="sortBy(Dingding,'saf2505_ord_remark',$event)">訂單備註</th>
                                        <th v-on:click="sortBy(Dingding,'saf2509_ord_shop',$event)">訂單館別</th>
                                        <th v-on:click="sortBy(Dingding,'saf2570_activity',$event)">搭配活動</th>
                                        <th v-on:click="sortBy(Dingding,'saf2507_ord_class',$event)">訂單類型</th>
                                        <th v-on:click="sortBy(Dingding,'saf2520_dis_date',$event)">應出貨日期</th>
                                        <th v-on:click="sortBy(Dingding,'saf2533_pspec',$event)">規格序號</th>
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
                                        <td>{{saf25.saf2537_Letianode}}</td>
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
                        <%--14.瘋狂賣客--%>
                        <div class="scroll-table" v-if="Crazymike.open">
                            <div>
                                <table>
                                    <tr>
                                        <td style="padding: 3px">
                                            <input type="checkbox" v-model="Crazymike.checked" v-if="Crazymike.saf25FileInfo.cnf1004_char02!=''" /></td>
                                        <td style="padding: 3px">{{Crazymike.saf25FileInfo.FileName}}</td>
                                        <td style="padding: 3px">
                                            <label class="btn btn-default" v-if="Crazymike.saf25FileInfo.cnf1004_char02!=''" style="background-color: rgba(247, 255, 101, 0.67);">
                                                <input style="display: none;" type="file" accept=".csv," v-on:change="onFileChange('14', $event)">
                                                重新送出檔案比對
                                            </label>
                                            <span v-else>此物流公司在此系統未登記，請登記才能匯入資料</span>
                                            <label class="btn btn-default" style="color: red; background-color: rgba(255, 169, 169, 0.51);" v-if="Crazymike.saf25FileInfo.ErrorMsg.length>0" data-toggle="modal" href='#modalDialog' v-on:click="ModalError=Crazymike.saf25FileInfo.ErrorMsg">
                                                錯誤訊息   
                                            </label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <table class="table table-bordered" style="width: calc(100% - 18px)" v-if="Crazymike.saf25FileInfo.cnf1004_char02!=''">
                                <thead>

                                    <tr class="bg-primary text-light">
                                        <th v-on:click="sortBy(Crazymike,'saf2503_ord_no',$event)">訂單編號</th>
                                        <th v-on:click="sortBy(Crazymike,'saf2523_ship_date',$event)">出貨日期</th>
                                        <th v-on:click="sortBy(Crazymike,'saf2527_ship_no',$event)">出貨單號</th>
                                        <th v-on:click="sortBy(Crazymike,'saf2531_psname',$event)">商品名稱</th>
                                        <th v-on:click="sortBy(Crazymike,'saf2541_ord_qty',$event)">訂購數量</th>
                                        <th v-on:click="sortBy(Crazymike,'saf2532_pname',$event)">商品規格</th>
                                        <th v-on:click="sortBy(Crazymike,'saf2544_cost',$event)">含稅成本</th>
                                        <th v-on:click="sortBy(Crazymike,'saf2546_mana_fee',$event)">運費成本</th>
                                        <th v-on:click="sortBy(Crazymike,'saf2514_rec_name',$event)">含稅小計</th>
                                        <th v-on:click="sortBy(Crazymike,'saf2528_fre_no',$event)">收件人姓名</th>
                                        <th v-on:click="sortBy(Crazymike,'saf2519_rec_address',$event)">收件人地址</th>
                                        <th v-on:click="sortBy(Crazymike,'saf2515_rec_cell',$event)">收件人電話</th>
                                        <th v-on:click="sortBy(Crazymike,'saf2553_gifts',$event)">贈品</th>
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
                        <%--15.興奇--%>
                        <div class="scroll-table" v-if="Xingqi.open">
                            <div>
                                <table>
                                    <tr>
                                        <td style="padding: 3px">
                                            <input type="checkbox" v-model="Xingqi.checked" v-if="Xingqi.saf25FileInfo.cnf1004_char02!=''" /></td>
                                        <td style="padding: 3px">{{Xingqi.saf25FileInfo.FileName}}</td>
                                        <td style="padding: 3px">
                                            <label class="btn btn-default" v-if="Xingqi.saf25FileInfo.cnf1004_char02!=''" style="background-color: rgba(247, 255, 101, 0.67);">
                                                <input style="display: none;" type="file" accept=".csv," v-on:change="onFileChange('15', $event)">
                                                重新送出檔案比對
                                            </label>
                                            <span v-else>此物流公司在此系統未登記，請登記才能匯入資料</span>
                                            <label class="btn btn-default" style="color: red; background-color: rgba(255, 169, 169, 0.51);" v-if="Xingqi.saf25FileInfo.ErrorMsg.length>0" data-toggle="modal" href='#modalDialog' v-on:click="ModalError=Xingqi.saf25FileInfo.ErrorMsg">
                                                錯誤訊息   
                                            </label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <table class="table table-bordered" style="width: calc(100% - 18px)" v-if="Xingqi.saf25FileInfo.cnf1004_char02!=''">
                                <thead>

                                    <tr class="bg-primary text-light">
                                        <th v-on:click="sortBy(Xingqi,'saf2502_seq',$event)">序號</th>
                                        <th v-on:click="sortBy(Xingqi,'saf2503_ord_no',$event)">訂單編號</th>
                                        <th v-on:click="sortBy(Xingqi,'saf2514_rec_name',$event)">收件人姓名</th>
                                        <th v-on:click="sortBy(Xingqi,'saf2515_rec_cell',$event)">收件人手機</th>
                                        <th v-on:click="sortBy(Xingqi,'saf2518_rec_zip',$event)">收件人郵遞區號</th>
                                        <th v-on:click="sortBy(Xingqi,'saf2519_rec_address',$event)">收件人地址</th>
                                        <th v-on:click="sortBy(Xingqi,'saf2516_rec_tel01',$event)">收件人電話(日)</th>
                                        <th v-on:click="sortBy(Xingqi,'saf2531_psname',$event)">商品名稱</th>
                                        <th v-on:click="sortBy(Xingqi,'saf2529_logis_no',$event)">貨運方式</th>
                                        <th v-on:click="sortBy(Xingqi,'saf2528_fre_no',$event)">貨運單號</th>
                                        <th v-on:click="sortBy(Xingqi,'saf2541_ord_qty',$event)">數量</th>
                                        <th v-on:click="sortBy(Xingqi,'saf2544_cost',$event)">商品成本</th>
                                        <th v-on:click="sortBy(Xingqi,'saf2523_ship_date',$event)">出貨日期</th>
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
                        <%--16.聯合報--%>
                        <div class="scroll-table" v-if="Lianhebao.open">
                            <div>
                                <table>
                                    <tr>
                                        <td style="padding: 3px">
                                            <input type="checkbox" v-model="Lianhebao.checked" v-if="Lianhebao.saf25FileInfo.cnf1004_char02!=''" /></td>
                                        <td style="padding: 3px">{{Lianhebao.saf25FileInfo.FileName}}</td>
                                        <td style="padding: 3px">
                                            <label class="btn btn-default" v-if="Lianhebao.saf25FileInfo.cnf1004_char02!=''" style="background-color: rgba(247, 255, 101, 0.67);">
                                                <input style="display: none;" type="file" accept=".csv," v-on:change="onFileChange('16', $event)">
                                                重新送出檔案比對
                                            </label>
                                            <span v-else>此物流公司在此系統未登記，請登記才能匯入資料</span>
                                            <label class="btn btn-default" style="color: red; background-color: rgba(255, 169, 169, 0.51);" v-if="Lianhebao.saf25FileInfo.ErrorMsg.length>0" data-toggle="modal" href='#modalDialog' v-on:click="ModalError=Lianhebao.saf25FileInfo.ErrorMsg">
                                                錯誤訊息   
                                            </label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <table class="table table-bordered" style="width: calc(100% - 18px)" v-if="Lianhebao.saf25FileInfo.cnf1004_char02!=''">
                                <thead>
                                    <tr class="bg-primary text-light">
                                        <th v-on:click="sortBy(Lianhebao,'saf2523_ship_date',$event)">最遲出貨日</th>
                                        <th v-on:click="sortBy(Lianhebao,'saf2503_ord_no',$event)">訂單編號</th>
                                        <th v-on:click="sortBy(Lianhebao,'saf2504_ord_date',$event)">訂購日期</th>
                                        <th v-on:click="sortBy(Lianhebao,'saf2510_ord_name',$event)">訂購人姓名</th>
                                        <th v-on:click="sortBy(Lianhebao,'saf2514_rec_name',$event)">收貨人姓名</th>
                                        <th v-on:click="sortBy(Lianhebao,'saf2516_rec_tel01',$event)">收貨人市話</th>
                                        <th v-on:click="sortBy(Lianhebao,'saf2515_rec_cell',$event)">收貨人手機</th>
                                        <th v-on:click="sortBy(Lianhebao,'saf2518_rec_zip',$event)">收件人郵遞區號</th>
                                        <th v-on:click="sortBy(Lianhebao,'saf2519_rec_address',$event)">收貨人地址</th>
                                        <th v-on:click="sortBy(Lianhebao,'saf2522_dis_demand',$event)">配送備註</th>
                                        <th v-on:click="sortBy(Lianhebao,'saf2505_ord_remark',$event)">購買備註</th>
                                        <th v-on:click="sortBy(Lianhebao,'saf2537_Letianode',$event)">商品編號</th>
                                        <th v-on:click="sortBy(Lianhebao,'saf2536_Letianode_v',$event)">廠商料號</th>
                                        <th v-on:click="sortBy(Lianhebao,'saf2532_pname',$event)">商品型號</th>
                                        <th v-on:click="sortBy(Lianhebao,'saf2533_pspec',$event)">國際條碼</th>
                                        <th v-on:click="sortBy(Lianhebao,'saf2531_psname',$event)">商品名稱+規格尺寸</th>
                                        <th v-on:click="sortBy(Lianhebao,'saf2570_activity',$event)">特標語</th>
                                        <th v-on:click="sortBy(Lianhebao,'saf2541_ord_qty',$event)">訂購數量</th>
                                        <th v-on:click="sortBy(Lianhebao,'saf2547_price',$event)">原售價</th>
                                        <th v-on:click="sortBy(Lianhebao,'saf2548_price_sub',$event)">原售價-小計</th>
                                        <th v-on:click="sortBy(Lianhebao,'saf2544_cost',$event)">進貨價</th>
                                        <th v-on:click="sortBy(Lianhebao,'saf2545_cost_sub',$event)">進貨價-小計</th>
                                        <th v-on:click="sortBy(Lianhebao,'saf2520_dis_date',$event)">指交日期</th>
                                        <th v-on:click="sortBy(Lianhebao,'saf2529_logis_no',$event)">合作物流</th>
                                        <th v-on:click="sortBy(Lianhebao,'saf2528_fre_no',$event)">貨運單號</th>
                                        <th v-on:click="sortBy(Lianhebao,'saf2530_logis_comp',$event)">貨運公司</th>
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
                                        <td>{{saf25.saf2537_Letianode}}</td>
                                        <td>{{saf25.saf2536_Letianode_v}}</td>
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
                        <%--17.MOMO指定貨運--%>
                        <div class="scroll-table" v-if="MOMO_Specified.open">
                            <div>
                                <table>
                                    <tr>
                                        <td style="padding: 3px">
                                            <input type="checkbox" v-model="MOMO_Specified.checked" v-if="MOMO_Specified.saf25FileInfo.cnf1004_char02!=''" /></td>
                                        <td style="padding: 3px">{{MOMO_Specified.saf25FileInfo.FileName}}</td>
                                        <td style="padding: 3px">
                                            <label class="btn btn-default" v-if="MOMO_Specified.saf25FileInfo.cnf1004_char02!=''" style="background-color: rgba(247, 255, 101, 0.67);">
                                                <input style="display: none;" type="file" accept=".csv," v-on:change="onFileChange('17', $event)">
                                                重新送出檔案比對
                                            </label>
                                            <span v-else>此物流公司在此系統未登記，請登記才能匯入資料</span>
                                            <label class="btn btn-default" style="color: red; background-color: rgba(255, 169, 169, 0.51);" v-if="MOMO_Specified.saf25FileInfo.ErrorMsg.length>0" data-toggle="modal" href='#modalDialog' v-on:click="ModalError=MOMO_Specified.saf25FileInfo.ErrorMsg">
                                                錯誤訊息   
                                            </label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <table class="table table-bordered" style="width: calc(100% - 18px)" v-if="MOMO_Specified.saf25FileInfo.cnf1004_char02!=''">
                                <thead>
                                    <tr class="bg-primary text-light">
                                        <%--17a	17b	17c	17d	17e	17f	17g	17h	17i	17j	17k	17l	17m	17n	17o	17p	17q	17r	17s	17t	17u	17v	17w	17x	17y	17z	17@	17#--%>
                                        <th v-on:click="sortBy(MOMO_Specified,'saf2502_seq',$event)">項次+燈號</th>
                                        <th v-on:click="sortBy(MOMO_Specified,'saf2506_ord_status',$event)">配送狀態</th>
                                        <th v-on:click="sortBy(MOMO_Specified,'saf2505_ord_remark',$event)">配送訊息</th>
                                        <th v-on:click="sortBy(MOMO_Specified,'saf2520_dis_date',$event)">約定配送日</th>
                                        <%--17e--%>
                                        <th v-on:click="sortBy(MOMO_Specified,'',$event)">宅單備註</th>
                                        <th v-on:click="sortBy(MOMO_Specified,'saf2503_ord_no',$event)">訂單編號</th>
                                        <th v-on:click="sortBy(MOMO_Specified,'saf2550_paymt_way',$event)">付款方式</th>
                                        <th v-on:click="sortBy(MOMO_Specified,'saf2514_rec_name',$event)">收件人姓名</th>
                                        <th v-on:click="sortBy(MOMO_Specified,'saf2519_rec_address',$event)">收件人地址</th>
                                        <th v-on:click="sortBy(MOMO_Specified,'saf2564_post_box',$event)">貨運公司出貨地址</th>
                                        <th v-on:click="sortBy(MOMO_Specified,'saf2565_chg_notes',$event)">貨運公司回收地址</th>
                                        <th v-on:click="sortBy(MOMO_Specified,'saf2507_ord_class',$event)">訂單類別</th>
                                        <th v-on:click="sortBy(MOMO_Specified,'saf2522_dis_demand',$event)">客戶配送需求</th>
                                        <th v-on:click="sortBy(MOMO_Specified,'saf2504_ord_date',$event)">轉單日</th>
                                        <th v-on:click="sortBy(MOMO_Specified,'saf2523_ship_date',$event)">預計出貨日</th>
                                        <th v-on:click="sortBy(MOMO_Specified,'saf2536_Letianode_v',$event)">商品原廠編號</th>
                                        <th v-on:click="sortBy(MOMO_Specified,'saf2533_pspec',$event)">品號</th>
                                        <th v-on:click="sortBy(MOMO_Specified,'saf2531_psname',$event)">品名</th>
                                        <th v-on:click="sortBy(MOMO_Specified,'saf2537_Letianode',$event)">單名編號</th>
                                        <th v-on:click="sortBy(MOMO_Specified,'saf2532_pname',$event)">單品詳細</th>
                                        <th v-on:click="sortBy(MOMO_Specified,'saf2541_ord_qty',$event)">數量</th>
                                        <th v-on:click="sortBy(MOMO_Specified,'saf2544_cost',$event)">進價(含稅)</th>
                                        <th v-on:click="sortBy(MOMO_Specified,'saf2553_gifts',$event)">贈品</th>
                                        <th v-on:click="sortBy(MOMO_Specified,'saf2510_ord_name',$event)">訂購人姓名</th>
                                        <th v-on:click="sortBy(MOMO_Specified,'saf2538_inv_no',$event)">發票號碼</th>
                                        <th v-on:click="sortBy(MOMO_Specified,'saf2539_inv_date',$event)">發票日期</th>
                                        <th v-on:click="sortBy(MOMO_Specified,'saf2554_identifier',$event)">個人識別碼</th>
                                        <th v-on:click="sortBy(MOMO_Specified,'saf2555_chg_price',$event)">群組變價商品</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="saf25 in MOMO_Specified.saf25FileInfo.saf25List">
                                        <td>{{saf25.saf2523_ship_date}}</td>
                                        <td>{{saf25.saf2502_seq}}</td>
                                        <td>{{saf25.saf2506_ord_status}}</td>
                                        <td>{{saf25.saf2505_ord_remark}}</td>
                                        <td>{{saf25.saf2520_dis_date}}</td>
                                        <%--17e--%>
                                        <td></td>
                                        <td>{{saf25.saf2503_ord_no}}</td>
                                        <td>{{saf25.saf2550_paymt_way}}</td>
                                        <td>{{saf25.saf2514_rec_name}}</td>
                                        <td>{{saf25.saf2519_rec_address}}</td>
                                        <td>{{saf25.saf2564_post_box}}</td>
                                        <td>{{saf25.saf2565_chg_notes}}</td>
                                        <td>{{saf25.saf2507_ord_class}}</td>
                                        <td>{{saf25.saf2522_dis_demand}}</td>
                                        <td>{{saf25.saf2504_ord_date}}</td>
                                        <td>{{saf25.saf2504_ord_date}}</td>
                                        <td>{{saf25.saf2536_Letianode_v}}</td>
                                        <td>{{saf25.saf2533_pspec}}</td>
                                        <td>{{saf25.saf2531_psname}}</td>
                                        <td>{{saf25.saf2537_Letianode}}</td>
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
                        <%--18. 奇摩超級商城--%>
                        <div class="scroll-table" v-if="YahooMart.open">
                            <div>
                                <table>
                                    <tr>
                                        <td style="padding: 3px">
                                            <input type="checkbox" v-model="YahooMart.checked" v-if="YahooMart.saf25FileInfo.cnf1004_char02!=''" /></td>
                                        <td style="padding: 3px">{{YahooMart.saf25FileInfo.FileName}}</td>
                                        <td style="padding: 3px">
                                            <label class="btn btn-default" v-if="YahooMart.saf25FileInfo.cnf1004_char02!=''" style="background-color: rgba(247, 255, 101, 0.67);">
                                                <input style="display: none;" type="file" accept=".csv," v-on:change="onFileChange('18', $event)">
                                                重新送出檔案比對
                                            </label>
                                            <span v-else>此物流公司在此系統未登記，請登記才能匯入資料</span>
                                            <label class="btn btn-default" style="color: red; background-color: rgba(255, 169, 169, 0.51);" v-if="YahooMart.saf25FileInfo.ErrorMsg.length>0" data-toggle="modal" href='#modalDialog' v-on:click="ModalError=YahooMart.saf25FileInfo.ErrorMsg">
                                                錯誤訊息   
                                            </label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <table class="table table-bordered" style="width: calc(100% - 18px)" v-if="YahooMart.saf25FileInfo.cnf1004_char02!=''">
                                <thead>
                                    <tr class="bg-primary text-light">
                                        <%--a--%>
                                        <th v-on:click="sortBy(YahooMart,'saf2510_ord_name',$event)">訂購人</th>
                                        <%--b--%>
                                        <th v-on:click="sortBy(YahooMart,'saf2514_rec_name',$event)">收件人姓名</th>
                                        <%--c--%>
                                        <th v-on:click="sortBy(YahooMart,'saf2519_rec_address',$event)">收件人地址</th>
                                        <%--d--%>
                                        <th v-on:click="sortBy(YahooMart,'saf2515_rec_cell',$event)">行動電話</th>
                                        <%--e--%>
                                        <th v-on:click="sortBy(YahooMart,'saf2505_ord_remark',$event)">購物車備註</th>
                                        <%--f--%>
                                        <th v-on:click="sortBy(YahooMart,'saf2582_serial',$event)">交易序號</th>
                                        <%--g--%>
                                        <th v-on:click="sortBy(YahooMart,'saf2531_psname',$event)">商品名稱</th>
                                        <%--h--%>
                                        <th v-on:click="sortBy(YahooMart,'saf2532_pname',$event)">商品規格</th>
                                        <%--i--%>
                                        <th v-on:click="sortBy(YahooMart,'saf2541_ord_qty',$event)">數量</th>
                                        <%--j--%>
                                        <th v-on:click="sortBy(YahooMart,'saf2548_price_sub',$event)">金額小計</th>
                                        <%--k--%>
                                        <th v-on:click="sortBy(YahooMart,'saf2503_ord_no',$event)">訂單編號</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="saf25 in YahooMart.saf25FileInfo.saf25List">
                                        <td>{{saf25.saf2582_serial}}</td>
                                        <%--a--%>
                                        <td>{{saf25.saf2510_ord_name}}</td>
                                        <%--b--%>
                                        <td>{{saf25.saf2514_rec_name}}</td>
                                        <%--c--%>
                                        <td>{{saf25.saf2519_rec_address}}</td>
                                        <%--d--%>
                                        <td>{{saf25.saf2515_rec_cell}}</td>
                                        <%--e--%>
                                        <td>{{saf25.saf2505_ord_remark}}</td>
                                        <%--f--%>
                                        <td>{{saf25.saf2582_serial}}</td>
                                        <%--g--%>
                                        <td>{{saf25.saf2531_psname}}</td>
                                        <%--h--%>
                                        <td>{{saf25.saf2532_pname}}</td>
                                        <%--i--%>
                                        <td>{{saf25.saf2541_ord_qty}}</td>
                                        <%--j--%>
                                        <td>{{saf25.saf2548_price_sub}}</td>
                                        <%--k--%>
                                        <td>{{saf25.saf2503_ord_no}}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <%--19. 摩天--%>
                        <div class="scroll-table" v-if="Motian.open">
                            <div>
                                <table>
                                    <tr>
                                        <td style="padding: 3px">
                                            <input type="checkbox" v-model="Motian.checked" v-if="Motian.saf25FileInfo.cnf1004_char02!=''" /></td>
                                        <td style="padding: 3px">{{Motian.saf25FileInfo.FileName}}</td>
                                        <td style="padding: 3px">
                                            <label class="btn btn-default" v-if="Motian.saf25FileInfo.cnf1004_char02!=''" style="background-color: rgba(247, 255, 101, 0.67);">
                                                <input style="display: none;" type="file" accept=".csv," v-on:change="onFileChange('19', $event)">
                                                重新送出檔案比對
                                            </label>
                                            <span v-else>此物流公司在此系統未登記，請登記才能匯入資料</span>
                                            <label class="btn btn-default" style="color: red; background-color: rgba(255, 169, 169, 0.51);" v-if="Motian.saf25FileInfo.ErrorMsg.length>0" data-toggle="modal" href='#modalDialog' v-on:click="ModalError=Motian.saf25FileInfo.ErrorMsg">
                                                錯誤訊息   
                                            </label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <table class="table table-bordered" style="width: calc(100% - 18px)" v-if="Motian.saf25FileInfo.cnf1004_char02!=''">
                                <thead>
                                    <tr class="bg-primary text-light">
                                        <th v-on:click="sortBy(Motian,'saf2502_seq',$event)">項次</th>
                                        <th v-on:click="sortBy(Motian,'saf2503_ord_no',$event)">訂單編號</th>
                                        <th v-on:click="sortBy(Motian,'saf2506_ord_status',$event)">配送狀態</th>
                                        <th v-on:click="sortBy(Motian,'saf2505_ord_remark',$event)">配送訊息</th>
                                        <th v-on:click="sortBy(Motian,'saf2530_logis_comp',$event)">物流公司</th>
                                        <th v-on:click="sortBy(Motian,'saf2528_fre_no',$event)">配送單號</th>
                                        <th v-on:click="sortBy(Motian,'saf2522_dis_demand',$event)">客戶配送需求</th>
                                        <th v-on:click="sortBy(Motian,'saf2549_paymt_date',$event)">付款日</th>
                                        <th v-on:click="sortBy(Motian,'saf2523_ship_date',$event)">最晚出貨日</th>
                                        <th v-on:click="sortBy(Motian,'saf2514_rec_name',$event)">收件人姓名</th>
                                        <th v-on:click="sortBy(Motian,'saf2516_rec_tel01',$event)">電話</th>
                                        <th v-on:click="sortBy(Motian,'saf2515_rec_cell',$event)">行動電話</th>
                                        <th v-on:click="sortBy(Motian,'saf2519_rec_address',$event)">地址</th>
                                        <th v-on:click="sortBy(Motian,'saf2537_Letianode',$event)">商店品號</th>
                                        <th v-on:click="sortBy(Motian,'saf2536_Letianode_v',$event)">商品編號</th>
                                        <th v-on:click="sortBy(Motian,'saf2531_psname',$event)">商品名稱</th>
                                        <th v-on:click="sortBy(Motian,'saf2532_pname',$event)">單品規格</th>
                                        <th v-on:click="sortBy(Motian,'saf2541_ord_qty',$event)">數量</th>
                                        <th v-on:click="sortBy(Motian,'saf2548_price_sub',$event)">成交價</th>
                                        <th v-on:click="sortBy(Motian,'saf2550_paymt_way',$event)">付款方式</th>
                                        <th v-on:click="sortBy(Motian,'saf2551_paymt_status',$event)">分期</th>
                                        <th v-on:click="sortBy(Motian,'saf2535_ptpye',$event)">商品屬性</th>
                                        <th v-on:click="sortBy(Motian,'saf2510_ord_name',$event)">訂購人姓名</th>
                                        <th v-on:click="sortBy(Motian,'saf2512_ord_tel01',$event)">電話</th>
                                        <th v-on:click="sortBy(Motian,'saf2511_ord_cell',$event)">行動電話</th>

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
                                        <td>{{saf25.saf2537_Letianode}}</td>
                                        <td>{{saf25.saf2536_Letianode_v}}</td>
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

                        <%--20.樂天--%>
                        <div class="scroll-table" v-if="Letian.open">
                            <div>
                                <table>
                                    <tr>
                                        <td style="padding: 3px">
                                            <input type="checkbox" v-model="Letian.checked" v-if="Letian.saf25FileInfo.cnf1004_char02!=''" /></td>
                                        <td style="padding: 3px">{{Letian.saf25FileInfo.FileName}}</td>
                                        <td style="padding: 3px">
                                            <label class="btn btn-default" v-if="Letian.saf25FileInfo.cnf1004_char02!=''" style="background-color: rgba(247, 255, 101, 0.67);">
                                                <input style="display: none;" type="file" accept=".csv," v-on:change="onFileChange('20', $event)">
                                                重新送出檔案比對
                                            </label>
                                            <span v-else>此物流公司在此系統未登記，請登記才能匯入資料</span>
                                            <label class="btn btn-default" style="color: red; background-color: rgba(255, 169, 169, 0.51);" v-if="Letian.saf25FileInfo.ErrorMsg.length>0" data-toggle="modal" href='#modalDialog' v-on:click="ModalError=Letian.saf25FileInfo.ErrorMsg">
                                                錯誤訊息   
                                            </label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <table class="table table-bordered" style="width: calc(100% - 18px)" v-if="Letian.saf25FileInfo.cnf1004_char02!=''">
                                <thead>
                                    <tr class="bg-primary text-light">
                                        <%--a--%>
                                        <th v-on:click="sortBy(Letian,'saf2504_ord_date',$event)">order_date</th>
                                        <%--b--%>
                                        <th v-on:click="sortBy(Letian,'saf2503_ord_no',$event)">order_id</th>
                                        <%--c--%>
                                        <th v-on:click="sortBy(Letian,'saf2506_ord_status',$event)">order_status</th>
                                        <%--f--%>
                                        <th v-on:click="sortBy(Letian,'saf2537_pcode',$event)">product_base_sku</th>
                                        <%--g--%>
                                        <th v-on:click="sortBy(Letian,'saf2536_pcode_v',$event)">product_sku</th>
                                        <%--i--%>
                                        <th v-on:click="sortBy(Letian,'saf2535_ptpye',$event)">rakuten_category</th>
                                        <%--j--%>
                                        <th v-on:click="sortBy(Letian,'saf2531_psname',$event)">product_name</th>
                                        <%--k--%>
                                        <th v-on:click="sortBy(Letian,'saf2541_ord_qty',$event)">products_quantity</th>
                                        <%--l--%>
                                        <th v-on:click="sortBy(Letian,'saf2547_price',$event)">product_price</th>
                                        <%--p--%>
                                        <th v-on:click="sortBy(Letian,'saf2548_price_sub',$event)">order_total</th>
                                        <%--q--%>
                                        <th v-on:click="sortBy(Letian,'saf2587_gift_pnt',$event)">shop_coupon</th>
                                        <%--r--%>
                                        <th v-on:click="sortBy(Letian,'saf2588_gift_amt',$event)">rakuten_coupon</th>
                                        <%--s--%>
                                        <th v-on:click="sortBy(Letian,'saf2573_discount',$event)">payment_discount</th>
                                        <%--v--%>
                                        <th v-on:click="sortBy(Letian,'saf2532_pname',$event)">attribute_1</th>
                                        <%--AD--%>
                                        <th v-on:click="sortBy(Letian,'saf2551_paymt_status',$event)">payment_status</th>
                                        <%--AF--%>
                                        <th v-on:click="sortBy(Letian,'saf2550_paymt_way',$event)">payment_method</th>
                                        <%--AL--%>
                                        <th v-on:click="sortBy(Letian,'saf2549_paymt_date',$event)">payment_date</th>
                                        <%--AO--%>
                                        <th v-on:click="sortBy(Letian,'saf2576_cancel_d',$event)">cancel_due_date</th>
                                        <%--AR--%>
                                        <th v-on:click="sortBy(Letian,'saf2526_ship_status',$event)">shipping_status</th>
                                        <%--AT--%>
                                        <th v-on:click="sortBy(Letian,'saf2523_ship_date',$event)">shipping_date</th>
                                        <%--AU--%>
                                        <th v-on:click="sortBy(Letian,'saf2546_mana_fee',$event)">shipping_fee_total</th>
                                        <%--AX--%>
                                        <th v-on:click="sortBy(Letian,'saf2522_dis_demand',$event)">shipping_method</th>
                                        <%--BC--%>
                                        <th v-on:click="sortBy(Letian,'saf2510_ord_name',$event)">customer_name</th>
                                        <%--BE--%>
                                        <th v-on:click="sortBy(Letian,'saf2511_ord_cell',$event)">customer_phone</th>
                                        <%--BF--%>
                                        <th v-on:click="sortBy(Letian,'saf2538_inv_no',$event)">e_invoice_number</th>
                                        <%--BI--%>
                                        <th v-on:click="sortBy(Letian,'saf2539_inv_date',$event)">e_invoice_issued_date</th>
                                        <%--BO--%>
                                        <th v-on:click="sortBy(Letian,'saf2514_rec_name',$event)">recipient_name</th>
                                        <%--BP--%>
                                        <th v-on:click="sortBy(Letian,'saf2515_rec_cell',$event)">recipient_phone</th>
                                        <%--BQ--%>
                                        <th v-on:click="sortBy(Letian,'saf2518_rec_zip',$event)">address_code</th>
                                        <%--BR--%>
                                        <th v-on:click="sortBy(Letian,'saf2519_rec_address',$event)">shipping_address</th>

                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="saf25 in Letian.saf25FileInfo.saf25List">



                                        <%--a--%>
                                        <td>{{saf25.saf2504_ord_date}}</td>
                                        <%--b--%>
                                        <td>{{saf25.saf2503_ord_no}}</td>
                                        <%--c--%>
                                        <td>{{saf25.saf2506_ord_status}}</td>
                                        <%--f--%>
                                        <td>{{saf25.saf2537_pcode}}</td>
                                        <%--g--%>
                                        <td>{{saf25.saf2536_pcode_v}}</td>
                                        <%--i--%>
                                        <td>{{saf25.saf2535_ptpye}}</td>
                                        <%--j--%>
                                        <td>{{saf25.saf2531_psname}}</td>
                                        <%--k--%>
                                        <td>{{saf25.saf2541_ord_qty}}</td>
                                        <%--l--%>
                                        <td>{{saf25.saf2547_price}}</td>
                                        <%--p--%>
                                        <td>{{saf25.saf2548_price_sub}}</td>
                                        <%--q--%>
                                        <td>{{saf25.saf2587_gift_pnt}}</td>
                                        <%--r--%>
                                        <td>{{saf25.saf2588_gift_amt}}</td>
                                        <%--s--%>
                                        <td>{{saf25.saf2573_discount}}</td>
                                        <%--v--%>
                                        <td>{{saf25.saf2532_pname}}</td>
                                        <%--AD--%>
                                        <td>{{saf25.saf2551_paymt_status}}</td>
                                        <%--AF--%>
                                        <td>{{saf25.saf2550_paymt_way}}</td>
                                        <%--AL--%>
                                        <td>{{saf25.saf2549_paymt_date}}</td>
                                        <%--AO--%>
                                        <td>{{saf25.saf2576_cancel_d}}</td>
                                        <%--AR--%>
                                        <td>{{saf25.saf2526_ship_status}}</td>
                                        <%--AT--%>
                                        <td>{{saf25.saf2523_ship_date}}</td>
                                        <%--AU--%>
                                        <td>{{saf25.saf2546_mana_fee}}</td>
                                        <%--AX--%>
                                        <td>{{saf25.saf2522_dis_demand}}</td>
                                        <%--BC--%>
                                        <td>{{saf25.saf2510_ord_name}}</td>
                                        <%--BE--%>
                                        <td>{{saf25.saf2511_ord_cell}}</td>
                                        <%--BF--%>
                                        <td>{{saf25.saf2538_inv_no}}</td>
                                        <%--BI--%>
                                        <td>{{saf25.saf2539_inv_date}}</td>
                                        <%--BO--%>
                                        <td>{{saf25.saf2514_rec_name}}</td>
                                        <%--BP--%>
                                        <td>{{saf25.saf2515_rec_cell}}</td>
                                        <%--BQ--%>
                                        <td>{{saf25.saf2518_rec_zip}}</td>
                                        <%--BR--%>
                                        <td>{{saf25.saf2519_rec_address}}</td>

                                    </tr>
                                </tbody>
                            </table>
                        </div>





                        <%--21. Letian--%>
                        <div class="scroll-table" v-if="Letian.open">
                            <div>
                                <table>
                                    <tr>
                                        <td style="padding: 3px">
                                            <input type="checkbox" v-model="Letian.checked" v-if="Letian.saf25FileInfo.cnf1004_char02!=''" /></td>
                                        <td style="padding: 3px">{{Letian.saf25FileInfo.FileName}}</td>
                                        <td style="padding: 3px">
                                            <label class="btn btn-default" v-if="Letian.saf25FileInfo.cnf1004_char02!=''" style="background-color: rgba(247, 255, 101, 0.67);">
                                                <input style="display: none;" type="file" accept=".csv," v-on:change="onFileChange('21', $event)">
                                                重新送出檔案比對
                                            </label>
                                            <span v-else>此物流公司在此系統未登記，請登記才能匯入資料</span>
                                            <label class="btn btn-default" style="color: red; background-color: rgba(255, 169, 169, 0.51);" v-if="Letian.saf25FileInfo.ErrorMsg.length>0" data-toggle="modal" href='#modalDialog' v-on:click="ModalError=Letian.saf25FileInfo.ErrorMsg">
                                                錯誤訊息   
                                            </label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <table class="table table-bordered" style="width: calc(100% - 18px)" v-if="Letian.saf25FileInfo.cnf1004_char02!=''">
                                <thead>
                                    <tr class="bg-primary text-light">
                                        <th v-on:click="sortBy(Letian,'saf2503_ord_no',$event)">訂單編號</th>
                                        <th v-on:click="sortBy(Letian,'saf2504_ord_date',$event)">訂購日期
                                        </th>
                                        <th v-on:click="sortBy(Letian,'saf2510_ord_name',$event)">訂購人
                                        </th>
                                        <th v-on:click="sortBy(Letian,'saf2514_rec_name',$event)">收貨人
                                        </th>
                                        <th v-on:click="sortBy(Letian,'saf2515_rec_cell',$event)">收貨人電話
                                        </th>
                                        <th v-on:click="sortBy(Letian,'saf2531_psname',$event)">商品名稱
                                        </th>
                                        <th v-on:click="sortBy(Letian,'saf2541_ord_qty',$event)">數量
                                        </th>
                                        <th v-on:click="sortBy(Letian,'saf2548_price_sub',$event)">金額
                                        </th>
                                        <th v-on:click="sortBy(Letian,'saf2532_pname',$event)">商品規格
                                        </th>
                                        <th v-on:click="sortBy(Letian,'saf2505_ord_remark',$event)">顧客特殊需求／統編
                                        </th>
                                        <th v-on:click="sortBy(Letian,'saf2538_inv_no',$event)">店家料號
                                        </th>

                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="saf25 in Letian.saf25FileInfo.saf25List">
                                        <td>{{saf25.saf2503_ord_no}}</td>
                                        <td>{{saf25.saf2504_ord_date}}</td>
                                        <td>{{saf25.saf2510_ord_name}}</td>
                                        <td>{{saf25.saf2514_rec_name}}</td>
                                        <td>{{saf25.saf2515_rec_cell}}</td>
                                        <td>{{saf25.saf2531_psname}}</td>
                                        <td>{{saf25.saf2541_ord_qty}}</td>
                                        <td>{{saf25.saf2548_price_sub}}</td>
                                        <td>{{saf25.saf2532_pname}}</td>
                                        <td>{{saf25.saf2505_ord_remark}}</td>
                                        <td>{{saf25.saf2538_inv_no}}</td>


                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <%--22.露天--%>
                        <div class="scroll-table" v-if="Lutian.open">
                            <div>
                                <table>
                                    <tr>
                                        <td style="padding: 3px">
                                            <input type="checkbox" v-model="Lutian.checked" v-if="Lutian.saf25FileInfo.cnf1004_char02!=''" /></td>
                                        <td style="padding: 3px">{{Lutian.saf25FileInfo.FileName}}</td>
                                        <td style="padding: 3px">
                                            <label class="btn btn-default" v-if="Lutian.saf25FileInfo.cnf1004_char02!=''" style="background-color: rgba(247, 255, 101, 0.67);">
                                                <input style="display: none;" type="file" accept=".csv," v-on:change="onFileChange('22', $event)">
                                                重新送出檔案比對
                                            </label>
                                            <span v-else>此物流公司在此系統未登記，請登記才能匯入資料</span>
                                            <label class="btn btn-default" style="color: red; background-color: rgba(255, 169, 169, 0.51);" v-if="Lutian.saf25FileInfo.ErrorMsg.length>0" data-toggle="modal" href='#modalDialog' v-on:click="ModalError=Lutian.saf25FileInfo.ErrorMsg">
                                                錯誤訊息   
                                            </label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <table class="table table-bordered" style="width: calc(100% - 18px)" v-if="Lutian.saf25FileInfo.cnf1004_char02!=''">
                                <thead>

                                    <tr class="bg-primary text-light">
                                        <%--22a	22b	22c	22d	22e	22f	22g	22h	22i	22j	22k	22l	22m	22n	22o	22p	22q	22r	22s	22t	22u	22v--%>
                                        <th v-on:click="sortBy(Lutian,'saf2504_ord_date',$event)">結帳時間</th>
                                        <th v-on:click="sortBy(Lutian,'saf2503_ord_no',$event)">訂單編號</th>
                                        <th v-on:click="sortBy(Lutian,'saf2549_paymt_date',$event)">付款時間</th>
                                        <th v-on:click="sortBy(Lutian,'saf2578_get_acc',$event)">買家帳號</th>
                                        <th v-on:click="sortBy(Lutian,'saf2537_Letianode',$event)">商品編號</th>
                                        <th v-on:click="sortBy(Lutian,'saf2531_psname',$event)">商品名稱</th>
                                        <th v-on:click="sortBy(Lutian,'saf2532_pname',$event)">規格</th>
                                        <th v-on:click="sortBy(Lutian,'saf2561_option',$event)">項目</th>
                                        <th v-on:click="sortBy(Lutian,'saf2536_Letianode_v',$event)">賣家自用料號</th>
                                        <th v-on:click="sortBy(Lutian,'saf2541_ord_qty',$event)">數量</th>
                                        <th v-on:click="sortBy(Lutian,'saf2547_price',$event)">單價</th>
                                        <th v-on:click="sortBy(Lutian,'saf2523_ship_date',$event)">運送方式</th>
                                        <th v-on:click="sortBy(Lutian,'saf2588_gift_amt',$event)">折扣金額</th>
                                        <th v-on:click="sortBy(Lutian,'saf2546_mana_fee',$event)">運費</th>
                                        <th v-on:click="sortBy(Lutian,'saf2548_price_sub',$event)">結帳總金額</th>
                                        <th v-on:click="sortBy(Lutian,'saf2505_ord_remark',$event)">給賣家的話</th>
                                        <th v-on:click="sortBy(Lutian,'saf2506_ord_status',$event)">交易狀況</th>
                                        <th v-on:click="sortBy(Lutian,'saf2564_post_box',$event)">物流追蹤碼/交貨便代碼/寄件代碼/郵局配送單號</th>
                                        <th v-on:click="sortBy(Lutian,'saf2514_rec_name',$event)">收件人姓名</th>
                                        <th v-on:click="sortBy(Lutian,'saf2516_rec_tel01',$event)">電話</th>
                                        <th v-on:click="sortBy(Lutian,'saf2515_rec_cell',$event)">手機</th>
                                        <th v-on:click="sortBy(Lutian,'saf2519_rec_address',$event)">收件地址</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="saf25 in Lutian.saf25FileInfo.saf25List">
                                        <td>{{saf25.saf2504_ord_date}}</td>
                                        <td>{{saf25.saf2504_ord_date}}</td>
                                        <td>{{saf25.saf2503_ord_no}}</td>
                                        <td>{{saf25.saf2549_paymt_date}}</td>
                                        <td>{{saf25.saf2578_get_acc}}</td>
                                        <td>{{saf25.saf2537_Letianode}}</td>
                                        <td>{{saf25.saf2531_psname}}</td>
                                        <td>{{saf25.saf2532_pname}}</td>
                                        <td>{{saf25.saf2561_option}}</td>
                                        <td>{{saf25.saf2536_Letianode_v}}</td>
                                        <td>{{saf25.saf2541_ord_qty}}</td>
                                        <td>{{saf25.saf2547_price}}</td>
                                        <td>{{saf25.saf2523_ship_date}}</td>
                                        <td>{{saf25.saf2588_gift_amt}}</td>
                                        <td>{{saf25.saf2546_mana_fee}}</td>
                                        <td>{{saf25.saf2548_price_sub}}</td>
                                        <td>{{saf25.saf2505_ord_remark}}</td>
                                        <td>{{saf25.saf2506_ord_status}}</td>
                                        <td>{{saf25.saf2564_post_box}}</td>
                                        <td>{{saf25.saf2514_rec_name}}</td>
                                        <td>{{saf25.saf2516_rec_tel01}}</td>
                                        <td>{{saf25.saf2515_rec_cell}}</td>
                                        <td>{{saf25.saf2519_rec_address}}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <%--23.Yahoo--%>
                        <div class="scroll-table" v-if="Yahoo.open">
                            <div>
                                <table>
                                    <tr>
                                        <td style="padding: 3px">
                                            <input type="checkbox" v-model="Yahoo.checked" v-if="Yahoo.saf25FileInfo.cnf1004_char02!=''" /></td>
                                        <td style="padding: 3px">{{Yahoo.saf25FileInfo.FileName}}</td>
                                        <td style="padding: 3px">
                                            <label class="btn btn-default" v-if="Yahoo.saf25FileInfo.cnf1004_char02!=''" style="background-color: rgba(247, 255, 101, 0.67);">
                                                <input style="display: none;" type="file" accept=".csv," v-on:change="onFileChange('23', $event)">
                                                重新送出檔案比對
                                            </label>
                                            <span v-else>此物流公司在此系統未登記，請登記才能匯入資料</span>
                                            <label class="btn btn-default" style="color: red; background-color: rgba(255, 169, 169, 0.51);" v-if="Yahoo.saf25FileInfo.ErrorMsg.length>0" data-toggle="modal" href='#modalDialog' v-on:click="ModalError=Yahoo.saf25FileInfo.ErrorMsg">
                                                錯誤訊息   
                                            </label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <table class="table table-bordered" style="width: calc(100% - 18px)" v-if="Yahoo.saf25FileInfo.cnf1004_char02!=''">
                                <thead>

                                    <tr class="bg-primary text-light">
                                        <th v-on:click="sortBy(Yahoo,'saf2504_ord_date',$event)">訂單成立時間</th>
                                        <th v-on:click="sortBy(Yahoo,'saf2503_ord_no',$event)">訂單編號</th>
                                        <th v-on:click="sortBy(Yahoo,'saf2527_ship_no',$event)">帳單編號</th>
                                        <th v-on:click="sortBy(Yahoo,'saf2536_Letianode_v',$event)">商品編號</th>
                                        <th v-on:click="sortBy(Yahoo,'saf2531_psname',$event)">商品名稱</th>
                                        <th v-on:click="sortBy(Yahoo,'saf2537_Letianode',$event)">第一組貨號</th>
                                        <th v-on:click="sortBy(Yahoo,'saf2532_pname',$event)">規格1</th>
                                        <th v-on:click="sortBy(Yahoo,'saf2571_auction',$event)">買家拍賣代號 </th>
                                        <th v-on:click="sortBy(Yahoo,'saf2547_price',$event)">購買金額</th>
                                        <th v-on:click="sortBy(Yahoo,'saf2541_ord_qty',$event)">購買數量 </th>
                                        <th v-on:click="sortBy(Yahoo,'saf2548_price_sub',$event)">購買總額</th>
                                        <th v-on:click="sortBy(Yahoo,'saf2546_mana_fee',$event)">原運費 </th>
                                        <th v-on:click="sortBy(Yahoo,'saf2589_order_amt',$event)">訂單金額 </th>
                                        <th v-on:click="sortBy(Yahoo,'saf2587_gift_pnt',$event)">超贈點</th>
                                        <th v-on:click="sortBy(Yahoo,'saf2514_rec_name',$event)">取件人姓名 </th>
                                        <th v-on:click="sortBy(Yahoo,'saf2516_rec_tel01',$event)">電話 </th>
                                        <th v-on:click="sortBy(Yahoo,'saf2515_rec_cell',$event)">手機</th>
                                        <th v-on:click="sortBy(Yahoo,'saf2518_rec_zip',$event)">郵遞區號</th>
                                        <th v-on:click="sortBy(Yahoo,'saf2519_rec_address',$event)">收件人住址</th>
                                        <th v-on:click="sortBy(Yahoo,'saf2550_paymt_way',$event)">付款方式</th>
                                        <th v-on:click="sortBy(Yahoo,'saf2530_logis_comp',$event)">運送方式</th>
                                        <th v-on:click="sortBy(Yahoo,'saf2530_logis_comp',$event)">出貨日期</th>
                                        <th v-on:click="sortBy(Yahoo,'saf2506_ord_status',$event)">訂單狀態</th>
                                        <th v-on:click="sortBy(Yahoo,'saf2551_paymt_status',$event)">付款狀態</th>
                                        <th v-on:click="sortBy(Yahoo,'saf2526_ship_status',$event)">出貨狀態</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="saf25 in Yahoo.saf25FileInfo.saf25List">
                                        <td>{{saf25.saf2504_ord_date}}</td>
                                        <td>{{saf25.saf2503_ord_no}}</td>
                                        <td>{{saf25.saf2527_ship_no}}</td>
                                        <td>{{saf25.saf2536_Letianode_v}}</td>
                                        <td>{{saf25.saf2531_psname}}</td>
                                        <td>{{saf25.saf2537_Letianode}}</td>
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
                        <%--24.松果超取--%>
                        <div class="scroll-table" v-if="LetianoneMart.open">
                            <div>
                                <table>
                                    <tr>
                                        <td style="padding: 3px">
                                            <input type="checkbox" v-model="LetianoneMart.checked" v-if="LetianoneMart.saf25FileInfo.cnf1004_char02!=''" /></td>
                                        <td style="padding: 3px">{{LetianoneMart.saf25FileInfo.FileName}}</td>
                                        <td style="padding: 3px">
                                            <label class="btn btn-default" v-if="LetianoneMart.saf25FileInfo.cnf1004_char02!=''" style="background-color: rgba(247, 255, 101, 0.67);">
                                                <input style="display: none;" type="file" accept=".csv," v-on:change="onFileChange('24', $event)">
                                                重新送出檔案比對
                                            </label>
                                            <span v-else>此物流公司在此系統未登記，請登記才能匯入資料</span>
                                            <label class="btn btn-default" style="color: red; background-color: rgba(255, 169, 169, 0.51);" v-if="LetianoneMart.saf25FileInfo.ErrorMsg.length>0" data-toggle="modal" href='#modalDialog' v-on:click="ModalError=LetianoneMart.saf25FileInfo.ErrorMsg">
                                                錯誤訊息   
                                            </label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <table class="table table-bordered" style="width: calc(100% - 18px)" v-if="LetianoneMart.saf25FileInfo.cnf1004_char02!=''">
                                <thead>

                                    <tr class="bg-primary text-light">
                                        <%--a--%>
                                        <th v-on:click="sortBy(LetianoneMart,'saf2502_seq',$event)">訂單編號</th>
                                        <%--b--%>
                                        <th v-on:click="sortBy(LetianoneMart,'saf2549_paymt_date',$event)">付款時間</th>
                                        <%--c--%>
                                        <th v-on:click="sortBy(LetianoneMart,'saf2510_ord_name',$event)">訂購人</th>
                                        <%--d--%>
                                        <th v-on:click="sortBy(LetianoneMart,'saf2511_ord_cell',$event)">訂購人電話</th>
                                        <%--e--%>
                                        <th v-on:click="sortBy(LetianoneMart,'saf2550_paymt_way',$event)">付款方式</th>
                                        <%--f--%>
                                        <th v-on:click="sortBy(LetianoneMart,'saf2538_inv_no',$event)">發票</th>
                                        <%--g--%>
                                        <th v-on:click="sortBy(LetianoneMart,'saf2502_seq',$event)">信用卡後四碼</th>
                                        <%--h--%>
                                        <th v-on:click="sortBy(LetianoneMart,'saf2548_price_sub',$event)">訂單金額</th>
                                        <%--i--%>
                                        <th v-on:click="sortBy(LetianoneMart,'saf2514_rec_name',$event)">收件人</th>
                                        <%--j--%>
                                        <th v-on:click="sortBy(LetianoneMart,'saf2515_rec_cell',$event)">電話</th>
                                        <%--k--%>
                                        <th v-on:click="sortBy(LetianoneMart,'saf2509_ord_shop',$event)">取貨門市</th>
                                        <%--l--%>
                                        <th v-on:click="sortBy(LetianoneMart,'saf2531_psname',$event)">商品</th>
                                        <%--m--%>
                                        <th v-on:click="sortBy(LetianoneMart,'saf2537_Letianode',$event)">商品編號</th>
                                        <%--n--%>
                                        <th v-on:click="sortBy(LetianoneMart,'saf2536_Letianode_v',$event)">主料號</th>
                                        <%--o--%>
                                        <th v-on:click="sortBy(LetianoneMart,'saf2542_groups',$event)">方案入數</th>
                                        <%--p--%>
                                        <th v-on:click="sortBy(LetianoneMart,'saf2547_price',$event)">方案價格</th>
                                        <%--q--%>
                                        <th v-on:click="sortBy(LetianoneMart,'saf2540_ship_qty',$event)">方案數量</th>
                                        <%--r--%>
                                        <th v-on:click="sortBy(LetianoneMart,'saf2561_option',$event)">選項</th>
                                        <%--s--%>
                                        <th v-on:click="sortBy(LetianoneMart,'saf2533_pspec',$event)">料號</th>
                                        <%--t--%>
                                        <th v-on:click="sortBy(LetianoneMart,'saf2541_ord_qty',$event)">數量</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="saf25 in LetianoneMart.saf25FileInfo.saf25List">

                                        <td>{{saf25.saf2502_seq}}</td>
                                        <td>{{saf25.saf2549_paymt_date}}</td>
                                        <td>{{saf25.saf2510_ord_name}}</td>

                                        <td>{{saf25.saf2511_ord_cell}}</td>
                                        <td>{{saf25.saf2550_paymt_way}}</td>
                                        <td>{{saf25.saf2538_inv_no}}</td>
                                        <td>{{saf25.saf2502_seq}}</td>
                                        <td>{{saf25.saf2548_price_sub}}</td>
                                        <td>{{saf25.saf2514_rec_name}}</td>
                                        <td>{{saf25.saf2515_rec_cell}}</td>
                                        <td>{{saf25.saf2509_ord_shop}}</td>
                                        <td>{{saf25.saf2531_psname}}</td>
                                        <td>{{saf25.saf2537_Letianode}}</td>
                                        <td>{{saf25.saf2536_Letianode_v}}</td>
                                        <td>{{saf25.saf2542_groups}}</td>
                                        <td>{{saf25.saf2547_price}}</td>
                                        <td>{{saf25.saf2540_ship_qty}}</td>
                                        <td>{{saf25.saf2561_option}}</td>
                                        <td>{{saf25.saf2533_pspec}}</td>
                                        <td>{{saf25.saf2541_ord_qty}}</td>


                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <%--25. 奇摩超級商城-超取--%>
                        <div class="scroll-table" v-if="YahooMart_MartDelivery.open">
                            <div>
                                <table>
                                    <tr>
                                        <td style="padding: 3px">
                                            <input type="checkbox" v-model="YahooMart_MartDelivery.checked" v-if="YahooMart_MartDelivery.saf25FileInfo.cnf1004_char02!=''" /></td>
                                        <td style="padding: 3px">{{YahooMart_MartDelivery.saf25FileInfo.FileName}}</td>
                                        <td style="padding: 3px">
                                            <label class="btn btn-default" v-if="YahooMart_MartDelivery.saf25FileInfo.cnf1004_char02!=''" style="background-color: rgba(247, 255, 101, 0.67);">
                                                <input style="display: none;" type="file" accept=".csv," v-on:change="onFileChange('25', $event)">
                                                重新送出檔案比對
                                            </label>
                                            <span v-else>此物流公司在此系統未登記，請登記才能匯入資料</span>
                                            <label class="btn btn-default" style="color: red; background-color: rgba(255, 169, 169, 0.51);" v-if="YahooMart_MartDelivery.saf25FileInfo.ErrorMsg.length>0" data-toggle="modal" href='#modalDialog' v-on:click="ModalError=YahooMart_MartDelivery.saf25FileInfo.ErrorMsg">
                                                錯誤訊息   
                                            </label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <table class="table table-bordered" style="width: calc(100% - 18px)" v-if="YahooMart_MartDelivery.saf25FileInfo.cnf1004_char02!=''">
                                <thead>

                                    <tr class="bg-primary text-light">
                                        <%--a--%>
                                        <th v-on:click="sortBy(YahooMart_MartDelivery,'saf2582_serial',$event)">交易序號</th>
                                        <%--b--%>
                                        <th v-on:click="sortBy(YahooMart_MartDelivery,'saf2514_rec_name',$event)">收件人姓名</th>
                                        <%--c--%>
                                        <th v-on:click="sortBy(YahooMart_MartDelivery,'saf2515_rec_cell',$event)">行動電話</th>
                                        <%--d--%>
                                        <th v-on:click="sortBy(YahooMart_MartDelivery,'saf2531_psname',$event)">商品名稱</th>
                                        <%--e--%>
                                        <th v-on:click="sortBy(YahooMart_MartDelivery,'saf2532_pname',$event)">商品規格</th>
                                        <%--f--%>
                                        <th v-on:click="sortBy(YahooMart_MartDelivery,'saf2541_ord_qty',$event)">數量</th>
                                        <%--g--%>
                                        <th v-on:click="sortBy(YahooMart_MartDelivery,'saf2548_price_sub',$event)">金額小計</th>
                                        <%--h--%>
                                        <th v-on:click="sortBy(YahooMart_MartDelivery,'saf2505_ord_remark',$event)">購物車備註</th>
                                        <%--i--%>
                                        <th v-on:click="sortBy(YahooMart_MartDelivery,'saf2519_rec_address',$event)">收件人地址</th>
                                        <%--j--%>
                                        <th v-on:click="sortBy(YahooMart_MartDelivery,'saf2516_rec_tel01',$event)">收件人電話</th>
                                        <%--k--%>
                                        <th v-on:click="sortBy(YahooMart_MartDelivery,'saf2506_ord_status',$event)">訂單狀態</th>
                                        <%--l--%>
                                        <th v-on:click="sortBy(YahooMart_MartDelivery,'saf2503_ord_no',$event)">訂單編號</th>

                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="saf25 in YahooMart_MartDelivery.saf25FileInfo.saf25List">



                                        <%--a--%>
                                        <td>{{saf25.saf2582_serial}}</td>
                                        <%--b--%>
                                        <td>{{saf25.saf2514_rec_name}}</td>
                                        <%--c--%>
                                        <td>{{saf25.saf2515_rec_cell}}</td>
                                        <%--d--%>
                                        <td>{{saf25.saf2531_psname}}</td>
                                        <%--e--%>
                                        <td>{{saf25.saf2532_pname}}</td>
                                        <%--f--%>
                                        <td>{{saf25.saf2541_ord_qty}}</td>
                                        <%--g--%>
                                        <td>{{saf25.saf2548_price_sub}}</td>
                                        <%--h--%>
                                        <td>{{saf25.saf2505_ord_remark}}</td>
                                        <%--i--%>
                                        <td>{{saf25.saf2519_rec_address}}</td>
                                        <%--j--%>
                                        <td>{{saf25.saf2516_rec_tel01}}</td>
                                        <%--k--%>
                                        <td>{{saf25.saf2506_ord_status}}</td>
                                        <%--l--%>
                                        <td>{{saf25.saf2503_ord_no}}</td>

                                    </tr>
                                </tbody>
                            </table>
                        </div>



                        <%--26.Letianhome宅配--%>
                        <div class="scroll-table" v-if="PcHome_Delivery.open">
                            <div>
                                <table>
                                    <tr>
                                        <td style="padding: 3px">
                                            <input type="checkbox" v-model="PcHome_Delivery.checked" v-if="PcHome_Delivery.saf25FileInfo.cnf1004_char02!=''" /></td>
                                        <td style="padding: 3px">{{PcHome_Delivery.saf25FileInfo.FileName}}</td>
                                        <td style="padding: 3px">
                                            <label class="btn btn-default" v-if="PcHome_Delivery.saf25FileInfo.cnf1004_char02!=''" style="background-color: rgba(247, 255, 101, 0.67);">
                                                <input style="display: none;" type="file" accept=".csv," v-on:change="onFileChange('26', $event)">
                                                重新送出檔案比對
                                            </label>
                                            <span v-else>此物流公司在此系統未登記，請登記才能匯入資料</span>
                                            <label class="btn btn-default" style="color: red; background-color: rgba(255, 169, 169, 0.51);" v-if="PcHome_Delivery.saf25FileInfo.ErrorMsg.length>0" data-toggle="modal" href='#modalDialog' v-on:click="ModalError=PcHome_Delivery.saf25FileInfo.ErrorMsg">
                                                錯誤訊息   
                                            </label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <table class="table table-bordered" style="width: calc(100% - 18px)" v-if="PcHome_Delivery.saf25FileInfo.cnf1004_char02!=''">
                                <thead>

                                    <tr class="bg-primary text-light">
                                        <%--a--%>
                                        <th v-on:click="sortBy(PcHome_Delivery,'saf2503_ord_no',$event)">訂單編號</th>
                                        <%--b--%>
                                        <th v-on:click="sortBy(PcHome_Delivery,'saf2504_ord_date',$event)">訂購日期</th>
                                        <%--c--%>
                                        <th v-on:click="sortBy(PcHome_Delivery,'saf2510_ord_name',$event)">訂購人</th>
                                        <%--d--%>
                                        <th v-on:click="sortBy(PcHome_Delivery,'saf2514_rec_name',$event)">收貨人</th>
                                        <%--e--%>
                                        <th v-on:click="sortBy(PcHome_Delivery,'saf2524_ship_remark',$event)">出貨方式</th>
                                        <%--f--%>
                                        <th v-on:click="sortBy(PcHome_Delivery,'saf2518_rec_zip',$event)">郵遞區號</th>
                                        <%--g--%>
                                        <th v-on:click="sortBy(PcHome_Delivery,'saf2519_rec_address',$event)">收貨地址</th>
                                        <%--h--%>
                                        <th v-on:click="sortBy(PcHome_Delivery,'saf2515_rec_cell',$event)">收貨人電話</th>
                                        <%--i--%>
                                        <th v-on:click="sortBy(PcHome_Delivery,'saf2531_psname',$event)">商品名稱</th>
                                        <%--j--%>
                                        <th v-on:click="sortBy(PcHome_Delivery,'saf2541_ord_qty',$event)">數量</th>
                                        <%--k--%>
                                        <th v-on:click="sortBy(PcHome_Delivery,'saf2548_price_sub',$event)">金額</th>
                                        <%--l--%>
                                        <th v-on:click="sortBy(PcHome_Delivery,'saf2532_pname',$event)">商品規格</th>
                                        <%--m--%>
                                        <th v-on:click="sortBy(PcHome_Delivery,'saf2505_ord_remark',$event)">顧客特殊需求／統編</th>
                                        <%--n--%>
                                        <th v-on:click="sortBy(PcHome_Delivery,'saf2537_Letianode',$event)">店家料號</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="saf25 in PcHome_Delivery.saf25FileInfo.saf25List">


                                        <td>{{saf25.saf2503_ord_no}}</td>
                                        <td>{{saf25.saf2504_ord_date}}</td>
                                        <td>{{saf25.saf2510_ord_name}}</td>
                                        <td>{{saf25.saf2514_rec_name}}</td>
                                        <td>{{saf25.saf2524_ship_remark}}</td>
                                        <td>{{saf25.saf2518_rec_zip}}</td>
                                        <td>{{saf25.saf2519_rec_address}}</td>
                                        <td>{{saf25.saf2515_rec_cell}}</td>
                                        <td>{{saf25.saf2531_psname}}</td>
                                        <td>{{saf25.saf2541_ord_qty}}</td>
                                        <td>{{saf25.saf2548_price_sub}}</td>
                                        <td>{{saf25.saf2532_pname}}</td>
                                        <td>{{saf25.saf2505_ord_remark}}</td>
                                        <td>{{saf25.saf2537_Letianode}}</td>

                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <%--27.蝦皮拍賣--%>
                        <div class="scroll-table" v-if="Shopee.open">
                            <div>
                                <table>
                                    <tr>
                                        <td style="padding: 3px">
                                            <input type="checkbox" v-model="Shopee.checked" v-if="Shopee.saf25FileInfo.cnf1004_char02!=''" /></td>
                                        <td style="padding: 3px">{{Shopee.saf25FileInfo.FileName}}</td>
                                        <td style="padding: 3px">
                                            <label class="btn btn-default" v-if="Shopee.saf25FileInfo.cnf1004_char02!=''" style="background-color: rgba(247, 255, 101, 0.67);">
                                                <input style="display: none;" type="file" accept=".csv," v-on:change="onFileChange('27', $event)">
                                                重新送出檔案比對
                                            </label>
                                            <span v-else>此物流公司在此系統未登記，請登記才能匯入資料</span>
                                            <label class="btn btn-default" style="color: red; background-color: rgba(255, 169, 169, 0.51);" v-if="Shopee.saf25FileInfo.ErrorMsg.length>0" data-toggle="modal" href='#modalDialog' v-on:click="ModalError=Shopee.saf25FileInfo.ErrorMsg">
                                                錯誤訊息   
                                            </label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <table class="table table-bordered" style="width: calc(100% - 18px)" v-if="Shopee.saf25FileInfo.cnf1004_char02!=''">
                                <thead>

                                    <tr class="bg-primary text-light">
                                        <%--27a	27b	27c	27d	27e	27f	27g	27h	27i	27j	27k	27l	27m	27n	27o	27p	27q	27r	27s	27t	27u	27v	27w	27x	27y	27z	27aa	27ab--%>
                                        <th v-on:click="sortBy(Shopee,'saf2503_ord_no',$event)">訂單編號</th>
                                        <th v-on:click="sortBy(Shopee,'saf2506_ord_status',$event)">訂單狀態</th>
                                        <th v-on:click="sortBy(Shopee,'saf2552_return',$event)">退貨 / 退款狀態</th>
                                        <th v-on:click="sortBy(Shopee,'saf2578_get_acc',$event)">買家帳號</th>
                                        <th v-on:click="sortBy(Shopee,'saf2504_ord_date',$event)">訂單成立時間</th>
                                        <th v-on:click="sortBy(Shopee,'saf2549_paymt_date',$event)">買家完成付款時間</th>
                                        <th v-on:click="sortBy(Shopee,'saf2548_price_sub',$event)">訂單小計</th>
                                        <th v-on:click="sortBy(Shopee,'saf2546_mana_fee',$event)">買家支付的運費</th>
                                        <th v-on:click="sortBy(Shopee,'saf2589_order_amt',$event)">訂單總金額</th>
                                        <th v-on:click="sortBy(Shopee,'saf2531_psname',$event)">商品資訊</th>
                                        <th v-on:click="sortBy(Shopee,'saf2519_rec_address',$event)">收件地址</th>
                                        <th v-on:click="sortBy(Shopee,'saf2561_option',$event)">國家</th>
                                        <th v-on:click="sortBy(Shopee,'saf2566_warm',$event)">城市</th>
                                        <th v-on:click="sortBy(Shopee,'saf2563_county',$event)">行政區</th>
                                        <th v-on:click="sortBy(Shopee,'saf2518_rec_zip',$event)">郵遞區號</th>
                                        <th v-on:click="sortBy(Shopee,'saf2514_rec_name',$event)">收件者姓名</th>
                                        <th v-on:click="sortBy(Shopee,'saf2515_rec_cell',$event)">電話號碼</th>
                                        <th v-on:click="sortBy(Shopee,'saf2522_dis_demand',$event)">寄送方式</th>
                                        <th v-on:click="sortBy(Shopee,'saf2525_ship_condi',$event)">出貨方式</th>
                                        <th v-on:click="sortBy(Shopee,'saf2502_seq',$event)">信用卡後四碼</th>
                                        <th v-on:click="sortBy(Shopee,'saf2507_ord_class',$event)">訂單類型</th>
                                        <th v-on:click="sortBy(Shopee,'saf2550_paymt_way',$event)">付款方式</th>
                                        <th v-on:click="sortBy(Shopee,'saf2523_ship_date',$event)">最晚出貨日期</th>
                                        <th v-on:click="sortBy(Shopee,'saf2579_auction_y',$event)">包裹查詢號碼</th>
                                        <th v-on:click="sortBy(Shopee,'saf2584_deli_date',$event)">實際出貨時間</th>
                                        <th v-on:click="sortBy(Shopee,'saf2575_check_d',$event)">訂單完成時間</th>
                                        <th v-on:click="sortBy(Shopee,'saf2505_ord_remark',$event)">買家備註</th>



                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="saf25 in Shopee.saf25FileInfo.saf25List">

                                        <td>{{saf25.saf2503_ord_no}}</td>
                                        <td>{{saf25.saf2506_ord_status}}</td>
                                        <td>{{saf25.saf2552_return}}</td>
                                        <td>{{saf25.saf2578_get_acc}}</td>
                                        <td>{{saf25.saf2504_ord_date}}</td>
                                        <td>{{saf25.saf2549_paymt_date}}</td>
                                        <td>{{saf25.saf2548_price_sub}}</td>
                                        <td>{{saf25.saf2546_mana_fee}}</td>
                                        <td>{{saf25.saf2589_order_amt}}</td>
                                        <td>{{saf25.saf2531_psname}}</td>
                                        <td>{{saf25.saf2519_rec_address}}</td>
                                        <td>{{saf25.saf2561_option}}</td>
                                        <td>{{saf25.saf2566_warm}}</td>
                                        <td>{{saf25.saf2563_county}}</td>
                                        <td>{{saf25.saf2518_rec_zip}}</td>
                                        <td>{{saf25.saf2514_rec_name}}</td>
                                        <td>{{saf25.saf2515_rec_cell}}</td>
                                        <td>{{saf25.saf2522_dis_demand}}</td>
                                        <td>{{saf25.saf2525_ship_condi}}</td>
                                        <td>{{saf25.saf2502_seq}}</td>
                                        <td>{{saf25.saf2507_ord_class}}</td>
                                        <td>{{saf25.saf2550_paymt_way}}</td>
                                        <td>{{saf25.saf2523_ship_date}}</td>
                                        <td>{{saf25.saf2579_auction_y}}</td>
                                        <td>{{saf25.saf2584_deli_date}}</td>
                                        <td>{{saf25.saf2575_check_d}}</td>
                                        <td>{{saf25.saf2505_ord_remark}}</td>


                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <%--28.Yahoo拍賣-超取--%>
                        <div class="scroll-table" v-if="Yahoo_MartDelivery.open">
                            <div>
                                <table>
                                    <tr>
                                        <td style="padding: 3px">
                                            <input type="checkbox" v-model="Yahoo_MartDelivery.checked" v-if="Yahoo_MartDelivery.saf25FileInfo.cnf1004_char02!=''" /></td>
                                        <td style="padding: 3px">{{Yahoo_MartDelivery.saf25FileInfo.FileName}}</td>
                                        <td style="padding: 3px">
                                            <label class="btn btn-default" v-if="Yahoo_MartDelivery.saf25FileInfo.cnf1004_char02!=''" style="background-color: rgba(247, 255, 101, 0.67);">
                                                <input style="display: none;" type="file" accept=".csv," v-on:change="onFileChange('28', $event)">
                                                重新送出檔案比對
                                            </label>
                                            <span v-else>此物流公司在此系統未登記，請登記才能匯入資料</span>
                                            <label class="btn btn-default" style="color: red; background-color: rgba(255, 169, 169, 0.51);" v-if="Yahoo_MartDelivery.saf25FileInfo.ErrorMsg.length>0" data-toggle="modal" href='#modalDialog' v-on:click="ModalError=Yahoo_MartDelivery.saf25FileInfo.ErrorMsg">
                                                錯誤訊息   
                                            </label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <table class="table table-bordered" style="width: calc(100% - 18px)" v-if="Yahoo_MartDelivery.saf25FileInfo.cnf1004_char02!=''">
                                <thead>

                                    <tr class="bg-primary text-light">
                                        <th v-on:click="sortBy(Yahoo_MartDelivery,'saf2504_ord_date',$event)">訂單成立時間</th>
                                        <th v-on:click="sortBy(Yahoo_MartDelivery,'saf2503_ord_no',$event)">訂單編號</th>
                                        <th v-on:click="sortBy(Yahoo_MartDelivery,'saf2527_ship_no',$event)">帳單編號</th>
                                        <th v-on:click="sortBy(Yahoo_MartDelivery,'saf2536_Letianode_v',$event)">商品編號</th>
                                        <th v-on:click="sortBy(Yahoo_MartDelivery,'saf2531_psname',$event)">商品名稱</th>
                                        <th v-on:click="sortBy(Yahoo_MartDelivery,'saf2537_Letianode',$event)">第一組貨號</th>
                                        <th v-on:click="sortBy(Yahoo_MartDelivery,'saf2532_pname',$event)">規格1</th>
                                        <th v-on:click="sortBy(Yahoo_MartDelivery,'saf2571_auction',$event)">買家拍賣代號 </th>
                                        <th v-on:click="sortBy(Yahoo_MartDelivery,'saf2547_price',$event)">購買金額</th>
                                        <th v-on:click="sortBy(Yahoo_MartDelivery,'saf2541_ord_qty',$event)">購買數量 </th>
                                        <th v-on:click="sortBy(Yahoo_MartDelivery,'saf2548_price_sub',$event)">購買總額</th>
                                        <th v-on:click="sortBy(Yahoo_MartDelivery,'saf2546_mana_fee',$event)">原運費 </th>
                                        <th v-on:click="sortBy(Yahoo_MartDelivery,'saf2589_order_amt',$event)">訂單金額 </th>
                                        <th v-on:click="sortBy(Yahoo_MartDelivery,'saf2587_gift_pnt',$event)">超贈點</th>
                                        <th v-on:click="sortBy(Yahoo_MartDelivery,'saf2514_rec_name',$event)">取件人姓名 </th>
                                        <th v-on:click="sortBy(Yahoo_MartDelivery,'saf2516_rec_tel01',$event)">電話 </th>
                                        <th v-on:click="sortBy(Yahoo_MartDelivery,'saf2515_rec_cell',$event)">手機</th>
                                        <th v-on:click="sortBy(Yahoo_MartDelivery,'saf2518_rec_zip',$event)">郵遞區號</th>
                                        <th v-on:click="sortBy(Yahoo_MartDelivery,'saf2519_rec_address',$event)">收件人住址</th>
                                        <th v-on:click="sortBy(Yahoo_MartDelivery,'saf2550_paymt_way',$event)">付款方式</th>
                                        <th v-on:click="sortBy(Yahoo_MartDelivery,'saf2530_logis_comp',$event)">運送方式</th>
                                        <th v-on:click="sortBy(Yahoo_MartDelivery,'saf2530_logis_comp',$event)">出貨日期</th>
                                        <th v-on:click="sortBy(Yahoo_MartDelivery,'saf2506_ord_status',$event)">訂單狀態</th>
                                        <th v-on:click="sortBy(Yahoo_MartDelivery,'saf2551_paymt_status',$event)">付款狀態</th>
                                        <th v-on:click="sortBy(Yahoo_MartDelivery,'saf2526_ship_status',$event)">出貨狀態</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="saf25 in Yahoo_MartDelivery.saf25FileInfo.saf25List">
                                        <td>{{saf25.saf2504_ord_date}}</td>
                                        <td>{{saf25.saf2503_ord_no}}</td>
                                        <td>{{saf25.saf2527_ship_no}}</td>
                                        <td>{{saf25.saf2536_Letianode_v}}</td>
                                        <td>{{saf25.saf2531_psname}}</td>
                                        <td>{{saf25.saf2537_Letianode}}</td>
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

        <div class="modal fade" id="HelpDialog" ref="HelpDialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title">求助</h4>
                    </div>
                    <div class="modal-body">
                        <div style="padding: 30px;">
                            <a href="../operation/dsap92501.pdf" target="_blank" style="font-size: 30px">各平台訂單轉入操作手冊.pdf</a>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <function-button data-dismiss="modal" hot-key="f12">
                                離開
                            </function-button>
                    </div>
                </div>
            </div>
        </div>


        <div class="modal fade" id="modalDialog" ref="modalDialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title">錯誤訊息</h4>
                    </div>
                    <div class="modal-body">
                        <div class="scroll-table">
                            <table class="table table-bordered" style="width: 250px; height: 200px">
                                <thead>
                                    <tr class="bg-primary text-light">
                                        <th>錯誤欄位</th>
                                        <th>檔案訊息</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr class="rowclass" v-for="Error in ModalError">
                                        <td>{{Error.column}}</td>
                                        <td>{{Error.messenge}}
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
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

