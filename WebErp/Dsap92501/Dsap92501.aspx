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
                        <td style="padding: 3px">Step1
                        </td>
                        <td style="padding: 3px">
                            <vue-datetimepicker placeholder="選擇日期" v-bind:value="DateTime" v-model="DateTime"></vue-datetimepicker>
                        </td>
                        <td style="padding: 3px">Step2
                        </td>
                        <td style="padding: 3px">
                            <function-button hot-key="f1" v-on:click.native="Upload()">選擇檔案</function-button>
                        </td>
                        <td style="padding: 3px">Step3
                        </td>
                        <td style="padding: 3px">
                            <input type="file" id="ImportExcelInput" ref="ImportExcelInput" accept=".csv,.xls,.xlsx" multiple style="display: none" v-on:change="onMultipleFileChange">
                            <function-button hot-key="f4" v-on:click.native="Submit()">送出比對</function-button>
                        </td>
                        <td style="padding: 3px">Step4
                        </td>
                        <td style="padding: 3px">
                            <function-button hot-key="f9" v-on:click.native="ImportAll()">匯入資料庫</function-button>
                        </td>
                    </tr>
                </table>

            </div>


            <div class="result-div" style=" height: 800px;overflow-y: auto; overflow-y: overlay;">
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
                <div v-if="StepOpen">

                    <div class="result-div">
                        <div class="scroll-table">
                            <table class="table table-bordered">
                                <thead>
                                    <tr class="">
                                        <th colspan="14" style="border: 1px solid white">
                                            <div>
                                                <table>
                                                    <tr>
                                                        <td style="padding: 3px">
                                                            <input type="checkbox" checked="checked" /></td>
                                                        <td style="padding: 3px">100.csv 17P團購</td>
                                                        <td style="padding: 3px">
                                                            <button type="button" role="button" class="btn btn-default">重新上傳</button></td>
                                                    </tr>


                                                </table>

                                            </div>



                                        </th>
                                    </tr>
                                    <tr class="bg-primary text-light">
                                        <th>序號</th>
                                        <th>客戶簡稱</th>
                                        <th>訂單編號</th>
                                        <th>訂單日期</th>
                                        <th>收件人姓名</th>
                                        <th>收件人手機</th>
                                        <th>收件人地址</th>
                                        <th>約定配送日</th>
                                        <th>商品名稱</th>
                                        <th>數量</th>
                                        <th>售價</th>
                                        <th>金額</th>
                                        <th>訂購人姓名</th>
                                        <th>手機</th>
                                    </tr>
                                </thead>
                                <tbody style="width: calc(100% - 18px)">
                                    <tr>
                                        <td>01</td>
                                        <td>MOMO</td>
                                        <td>001</td>
                                        <td>2018/01/24</td>
                                        <td>康XX</td>
                                        <td>09XXXXXXXX</td>
                                        <td>XXXXXXXXXXXXXX</td>
                                        <td>2018/01/30</td>
                                        <td>XXXXXXXXX</td>
                                        <td>2</td>
                                        <td>120</td>
                                        <td>240</td>
                                        <td>康XX</td>
                                        <td>09XXXXXXXX</td>
                                    </tr>
                                    <tr>
                                        <td>01</td>
                                        <td>MOMO</td>
                                        <td>001</td>
                                        <td>2018/01/24</td>
                                        <td>康XX</td>
                                        <td>09XXXXXXXX</td>
                                        <td>XXXXXXXXXXXXXX</td>
                                        <td>2018/01/30</td>
                                        <td>XXXXXXXXX</td>
                                        <td>2</td>
                                        <td>120</td>
                                        <td>240</td>
                                        <td>康XX</td>
                                        <td>09XXXXXXXX</td>
                                    </tr>
                                    <tr>
                                        <td>01</td>
                                        <td>MOMO</td>
                                        <td>001</td>
                                        <td>2018/01/24</td>
                                        <td>康XX</td>
                                        <td>09XXXXXXXX</td>
                                        <td>XXXXXXXXXXXXXX</td>
                                        <td>2018/01/30</td>
                                        <td>XXXXXXXXX</td>
                                        <td>2</td>
                                        <td>120</td>
                                        <td>240</td>
                                        <td>康XX</td>
                                        <td>09XXXXXXXX</td>
                                    </tr>
                                    <tr>
                                        <td>01</td>
                                        <td>MOMO</td>
                                        <td>001</td>
                                        <td>2018/01/24</td>
                                        <td>康XX</td>
                                        <td>09XXXXXXXX</td>
                                        <td>XXXXXXXXXXXXXX</td>
                                        <td>2018/01/30</td>
                                        <td>XXXXXXXXX</td>
                                        <td>2</td>
                                        <td>120</td>
                                        <td>240</td>
                                        <td>康XX</td>
                                        <td>09XXXXXXXX</td>
                                    </tr>
                                    <tr>
                                        <td>01</td>
                                        <td>MOMO</td>
                                        <td>001</td>
                                        <td>2018/01/24</td>
                                        <td>康XX</td>
                                        <td>09XXXXXXXX</td>
                                        <td>XXXXXXXXXXXXXX</td>
                                        <td>2018/01/30</td>
                                        <td>XXXXXXXXX</td>
                                        <td>2</td>
                                        <td>120</td>
                                        <td>240</td>
                                        <td>康XX</td>
                                        <td>09XXXXXXXX</td>
                                    </tr>
                                    <tr>
                                        <td>01</td>
                                        <td>MOMO</td>
                                        <td>001</td>
                                        <td>2018/01/24</td>
                                        <td>康XX</td>
                                        <td>09XXXXXXXX</td>
                                        <td>XXXXXXXXXXXXXX</td>
                                        <td>2018/01/30</td>
                                        <td>XXXXXXXXX</td>
                                        <td>2</td>
                                        <td>120</td>
                                        <td>240</td>
                                        <td>康XX</td>
                                        <td>09XXXXXXXX</td>
                                    </tr>
                                    <tr>
                                        <td>01</td>
                                        <td>MOMO</td>
                                        <td>001</td>
                                        <td>2018/01/24</td>
                                        <td>康XX</td>
                                        <td>09XXXXXXXX</td>
                                        <td>XXXXXXXXXXXXXX</td>
                                        <td>2018/01/30</td>
                                        <td>XXXXXXXXX</td>
                                        <td>2</td>
                                        <td>120</td>
                                        <td>240</td>
                                        <td>康XX</td>
                                        <td>09XXXXXXXX</td>
                                    </tr>
                                    <tr>
                                        <td>01</td>
                                        <td>MOMO</td>
                                        <td>001</td>
                                        <td>2018/01/24</td>
                                        <td>康XX</td>
                                        <td>09XXXXXXXX</td>
                                        <td>XXXXXXXXXXXXXX</td>
                                        <td>2018/01/30</td>
                                        <td>XXXXXXXXX</td>
                                        <td>2</td>
                                        <td>120</td>
                                        <td>240</td>
                                        <td>康XX</td>
                                        <td>09XXXXXXXX</td>
                                    </tr>
                                </tbody>

                            </table>
                        </div>
                        <div class="scroll-table">
                            <table class="table table-bordered">
                                <thead>
                                    <tr class="">
                                        <th colspan="14" style="border: 1px solid white">
                                            <div>
                                                <table>
                                                    <tr>
                                                        <td style="padding: 3px">
                                                            <input type="checkbox" checked="checked" /></td>
                                                        <td style="padding: 3px">102.csv MOMO</td>
                                                        <td style="padding: 3px">
                                                            <button type="button" role="button" class="btn btn-default">重新上傳</button></td>
                                                    </tr>


                                                </table>

                                            </div>



                                        </th>
                                    </tr>
                                    <tr class="bg-primary text-light">
                                        <th>序號</th>
                                        <th>客戶簡稱</th>
                                        <th>訂單編號</th>
                                        <th>訂單日期</th>
                                        <th>收件人姓名</th>
                                        <th>收件人手機</th>
                                        <th>收件人地址</th>
                                        <th>約定配送日</th>
                                        <th>商品名稱</th>
                                        <th>數量</th>
                                        <th>售價</th>
                                        <th>金額</th>
                                        <th>訂購人姓名</th>
                                        <th>手機</th>
                                    </tr>
                                </thead>
                                <tbody style="width: calc(100% - 18px)">
                                    <tr>
                                        <td>01</td>
                                        <td>MOMO</td>
                                        <td>001</td>
                                        <td>2018/01/24</td>
                                        <td>康XX</td>
                                        <td>09XXXXXXXX</td>
                                        <td>XXXXXXXXXXXXXX</td>
                                        <td>2018/01/30</td>
                                        <td>XXXXXXXXX</td>
                                        <td>2</td>
                                        <td>120</td>
                                        <td>240</td>
                                        <td>康XX</td>
                                        <td>09XXXXXXXX</td>
                                    </tr>
                                    <tr>
                                        <td>01</td>
                                        <td>MOMO</td>
                                        <td>001</td>
                                        <td>2018/01/24</td>
                                        <td>康XX</td>
                                        <td>09XXXXXXXX</td>
                                        <td>XXXXXXXXXXXXXX</td>
                                        <td>2018/01/30</td>
                                        <td>XXXXXXXXX</td>
                                        <td>2</td>
                                        <td>120</td>
                                        <td>240</td>
                                        <td>康XX</td>
                                        <td>09XXXXXXXX</td>
                                    </tr>
                                    <tr>
                                        <td>01</td>
                                        <td>MOMO</td>
                                        <td>001</td>
                                        <td>2018/01/24</td>
                                        <td>康XX</td>
                                        <td>09XXXXXXXX</td>
                                        <td>XXXXXXXXXXXXXX</td>
                                        <td>2018/01/30</td>
                                        <td>XXXXXXXXX</td>
                                        <td>2</td>
                                        <td>120</td>
                                        <td>240</td>
                                        <td>康XX</td>
                                        <td>09XXXXXXXX</td>
                                    </tr>
                                    <tr>
                                        <td>01</td>
                                        <td>MOMO</td>
                                        <td>001</td>
                                        <td>2018/01/24</td>
                                        <td>康XX</td>
                                        <td>09XXXXXXXX</td>
                                        <td>XXXXXXXXXXXXXX</td>
                                        <td>2018/01/30</td>
                                        <td>XXXXXXXXX</td>
                                        <td>2</td>
                                        <td>120</td>
                                        <td>240</td>
                                        <td>康XX</td>
                                        <td>09XXXXXXXX</td>
                                    </tr>
                                    <tr>
                                        <td>01</td>
                                        <td>MOMO</td>
                                        <td>001</td>
                                        <td>2018/01/24</td>
                                        <td>康XX</td>
                                        <td>09XXXXXXXX</td>
                                        <td>XXXXXXXXXXXXXX</td>
                                        <td>2018/01/30</td>
                                        <td>XXXXXXXXX</td>
                                        <td>2</td>
                                        <td>120</td>
                                        <td>240</td>
                                        <td>康XX</td>
                                        <td>09XXXXXXXX</td>
                                    </tr>
                                    <tr>
                                        <td>01</td>
                                        <td>MOMO</td>
                                        <td>001</td>
                                        <td>2018/01/24</td>
                                        <td>康XX</td>
                                        <td>09XXXXXXXX</td>
                                        <td>XXXXXXXXXXXXXX</td>
                                        <td>2018/01/30</td>
                                        <td>XXXXXXXXX</td>
                                        <td>2</td>
                                        <td>120</td>
                                        <td>240</td>
                                        <td>康XX</td>
                                        <td>09XXXXXXXX</td>
                                    </tr>
                                    <tr>
                                        <td>01</td>
                                        <td>MOMO</td>
                                        <td>001</td>
                                        <td>2018/01/24</td>
                                        <td>康XX</td>
                                        <td>09XXXXXXXX</td>
                                        <td>XXXXXXXXXXXXXX</td>
                                        <td>2018/01/30</td>
                                        <td>XXXXXXXXX</td>
                                        <td>2</td>
                                        <td>120</td>
                                        <td>240</td>
                                        <td>康XX</td>
                                        <td>09XXXXXXXX</td>
                                    </tr>
                                    <tr>
                                        <td>01</td>
                                        <td>MOMO</td>
                                        <td>001</td>
                                        <td>2018/01/24</td>
                                        <td>康XX</td>
                                        <td>09XXXXXXXX</td>
                                        <td>XXXXXXXXXXXXXX</td>
                                        <td>2018/01/30</td>
                                        <td>XXXXXXXXX</td>
                                        <td>2</td>
                                        <td>120</td>
                                        <td>240</td>
                                        <td>康XX</td>
                                        <td>09XXXXXXXX</td>
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

