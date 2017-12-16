<%@ Page Title="" Language="C#" MasterPageFile="~/master/BaseMasterPage.master" AutoEventWireup="true" CodeFile="Dcnp00501.aspx.cs" Inherits="Dcnp_Dcnp00501" %>

<%@ Import Namespace="System.Web.Hosting" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .app-title
        {
            background-color: #3097D1;
            color: #FFF;
        }
        .filter-div{
            margin-top: 5px;
        }
        
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="Dcnp00501">
        <ul class="app-title">
            <li>各檔案欄位說明維護
            </li>
        </ul>
        <div class="common-button-div">
            <function-button id="SearchBtn"
                hot-key="f1"
                v-on:click.native="OnSearch">
                查詢
            </function-button>
            <function-button id="AddBtn"
                hot-key="f2" 
                v-on:click.native="OnAdd">
                新增
            </function-button>
            <function-button id="DeleteBtn"
                hot-key="f3" 
                v-on:click.native="OnDelete">
                刪除
            </function-button>
        </div>
        <div class="filter-div">
            <table class="">
                <tbody>
                    <tr>
                        <td >
                            關鍵字
                        </td>
                        <td>
                            <input type="text">
                        </td>
                    </tr>
                    <tr>
                        <td >
                            檔案代號
                            <span>起~</span>
                        </td>
                        <td>
                            <input type="text">
                            迄~ <input type="text">
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="result-div">
            
            <table class="table table-striped table-bordered table-hover">
                <thead>
                    <tr class="bg-primary text-light">
                        <th>檔案代號</th>
                        <th>欄位名稱</th>
                        <th>中文說明-繁體</th>
                        <th>程式代號</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="i in 5">
                        <td>檔案代號</td>
                        <td>欄位名稱</td>
                        <td>中文說明-繁體</td>
                        <td>程式代號</td>
                    </tr>
                </tbody>
            </table>
            
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
