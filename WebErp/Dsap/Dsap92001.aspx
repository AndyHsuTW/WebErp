<%@ Page Title="" Language="C#" MasterPageFile="~/master/BaseMasterPage.master" AutoEventWireup="true" CodeFile="Dsap92001.aspx.cs" Inherits="Dsap_Dsap92001" %>

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

        .table-borderless > tbody > tr > td,
        .table-borderless > tbody > tr > th,
        .table-borderless > tfoot > tr > td,
        .table-borderless > tfoot > tr > th,
        .table-borderless > thead > tr > td,
        .table-borderless > thead > tr > th {
            border: none;
        }
        .rowclass:hover {
          background-color:#bde7ff;
        
        }
    </style>
    <script>
        (function () {
            requirejs.config({
                urlArgs: "NoCach=" + (new Date()).getTime(),
                paths: {
                    "Dsap92001": "Dsap/Dsap92001",
                },
                shim: {}
            });

            var requiredFiles = ["Dsap92001"];

            function onLoaded(dsap92001) {
            }

            function onError(error) {
                console.error(error);
            }

            require(requiredFiles, onLoaded, onError);
        })();
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="Dsap92001" v-cloak>
        <ul class="app-title">
            <li>出貨資料匯出各物流公司</li>
        </ul>
        <div class="app-body">
            <div class="common-button-div">
                <function-button id="SearchBtn" hot-key="f1" v-on:click.native="OnSearch()">查詢</function-button>
                <function-button id="ExportBtn" hot-key="f7" v-on:click.native="OnExport()">匯出</function-button>
            </div>
            <div class="filter-div">
                <table class="">
                    <tr>
                        <td>日期 
                        <span>起~</span>
                        </td>
                        <td>
                            <vue-datetimepicker placeholder="" v-model="Filter.StartDate"></vue-datetimepicker>
                            迄~<vue-datetimepicker placeholder="" v-model="Filter.EndDate"></vue-datetimepicker>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="result-div" style="max-width:1024px">
                <div class="scroll-table">
                    <table class="table table-bordered ">
                         <thead>
                            <tr class="bg-primary text-light">
                                <th class="col-xs-1" style="text-align:center">
                                    <input type="checkbox" value="" v-on:click="OnCheckAll" v-model="IsCheckAll">
                                </th>
                                <th class="col-xs-5">公司名稱</th>
                                <th class="col-xs-5">公司代碼</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr class="rowclass" v-for="CompanyItem in CompanyList" >
                                <td class="col-xs-1" style="text-align:center">
                                    <input type="checkbox" v-model="CompanyItem.checked">
                                </td>
                                <td class="col-xs-5">{{CompanyItem.Name}}</td>
                                <td class="col-xs-5">{{CompanyItem.Code}}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </div>


</asp:Content>

