<%@ Page Title="" Language="C#" MasterPageFile="~/master/BaseMasterPage.master" AutoEventWireup="true" CodeFile="D_pcode.aspx.cs" Inherits="D_pcode_D_pcode" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
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
                    "d_pcode": "D_pcode/D_pcode",
                },
                shim: {}
            });

            var requiredFiles = ["d_pcode"];

            function onLoaded(d_pcode) {
            }

            function onError(error) {
                console.error(error);
            }

            require(requiredFiles, onLoaded, onError);
        })();

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     


    <div id="example"  v-cloak>
      <d_pcode_component></d_pcode_component>
</div>




</asp:Content>

