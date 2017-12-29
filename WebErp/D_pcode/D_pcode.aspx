<%@ Page Title="" Language="C#" MasterPageFile="~/master/BaseMasterPage.master" AutoEventWireup="true" CodeFile="D_pcode.aspx.cs" Inherits="D_pcode_D_pcode" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
       <style>
        #toolbox {
            top: 25px;
            right: 5px;
            z-index: 2147483000;
            position: fixed;
        }


            #toolbox .tooltiptext {
                visibility: hidden;
                position: absolute;
                width: 120px;
                background-color: #555;
                color: #fff;
                text-align: center;
                padding: 5px 0;
                border-radius: 6px;
                z-index: 1;
                opacity: 0;
                transition: opacity .6s;
            }

            #toolbox:hover .tooltiptext {
                visibility: visible;
                opacity: 1;
            }



        .tooltip-right {
            top: -5px;
            left: 125%;
        }



            .tooltip-right::after {
                content: "";
                position: absolute;
                top: 50%;
                right: 100%;
                margin-top: -5px;
                border-width: 5px;
                border-style: solid;
                border-color: transparent #555 transparent transparent;
            }

        .tooltip-bottom {
            top: 135%;
            left: 50%;
            margin-left: -60px;
        }



            .tooltip-bottom::after {
                content: "";
                position: absolute;
                bottom: 100%;
                left: 50%;
                margin-left: -5px;
                border-width: 5px;
                border-style: solid;
                border-color: transparent transparent #555 transparent;
            }

        .tooltip-top {
            bottom: 125%;
            left: 50%;
            margin-left: -60px;
        }



            .tooltip-top::after {
                content: "";
                position: absolute;
                top: 100%;
                left: 50%;
                margin-left: -5px;
                border-width: 5px;
                border-style: solid;
                border-color: #555 transparent transparent transparent;
            }

        .tooltip-left {
            top: -5px;
            bottom: auto;
            right: 128%;
        }



            .tooltip-left::after {
                content: "";
                position: absolute;
                top: 50%;
                left: 100%;
                margin-top: -5px;
                border-width: 5px;
                border-style: solid;
                border-color: transparent transparent transparent #555;
            }

        .tooltip .tooltiptext-bottomarrow {
            visibility: hidden;
            width: 120px;
            background-color: #111;
            color: #fff;
            text-align: center;
            border-radius: 6px;
            padding: 5px 0;
            position: absolute;
            z-index: 1;
            bottom: 130%;
            left: 50%;
            margin-left: -60px;
        }

            .tooltip .tooltiptext-bottomarrow::after {
                content: "";
                position: absolute;
                top: 100%;
                left: 50%;
                margin-left: -5px;
                border-width: 5px;
                border-style: solid;
                border-color: black transparent transparent transparent;
            }

        .tooltip:hover .tooltiptext-bottomarrow {
            visibility: visible;
        }

        .tooltip .tooltiptext-toparrow {
            visibility: hidden;
            width: 120px;
            background-color: #111;
            color: #fff;
            text-align: center;
            border-radius: 6px;
            padding: 5px 0;
            position: absolute;
            z-index: 1;
            top: 150%;
            left: 50%;
            margin-left: -60px;
        }

            .tooltip .tooltiptext-toparrow::after {
                content: "";
                position: absolute;
                bottom: 100%;
                left: 50%;
                margin-left: -5px;
                border-width: 5px;
                border-style: solid;
                border-color: transparent transparent black transparent;
            }

        .tooltip:hover .tooltiptext-toparrow {
            visibility: visible;
        }

        .tooltip .tooltiptext-leftarrow {
            visibility: hidden;
            width: 120px;
            background-color: #111;
            color: #fff;
            text-align: center;
            border-radius: 6px;
            padding: 5px 0;
            position: absolute;
            z-index: 1;
            top: -5px;
            left: 110%;
        }

            .tooltip .tooltiptext-leftarrow::after {
                content: "";
                position: absolute;
                top: 50%;
                right: 100%;
                margin-top: -5px;
                border-width: 5px;
                border-style: solid;
                border-color: transparent black transparent transparent;
            }

        .tooltip:hover .tooltiptext-leftarrow {
            visibility: visible;
        }

        .tooltip .tooltiptext-rightarrow {
            visibility: hidden;
            width: 120px;
            background-color: #111;
            color: #fff;
            text-align: center;
            border-radius: 6px;
            padding: 5px 0;
            position: absolute;
            z-index: 1;
            top: -5px;
            right: 110%;
        }

            .tooltip .tooltiptext-rightarrow::after {
                content: "";
                position: absolute;
                top: 50%;
                left: 100%;
                margin-top: -5px;
                border-width: 5px;
                border-style: solid;
                border-color: transparent transparent transparent black;
            }

        .tooltip:hover .tooltiptext-rightarrow {
            visibility: visible;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <div id="toolbox">

            <img src="../public/images/if_folder_search_48770.png" style="width: 35px;" />
            <span class="tooltiptext tooltip-left" style="top: 3px; font-size: 16px">商品資料查詢</span>
        </div>


</asp:Content>

