<%@ Page Title="" Language="C#" MasterPageFile="~/master/BaseMasterPage.master" AutoEventWireup="true" CodeFile="Dsap92001.aspx.cs" Inherits="Dsap_Dsap92001" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <script>
         (function () {
             requirejs.config({
                 paths: {
                     "Dsap92001": "Dsap/Dsap92001",
                 },
                 shim: {}
             });

             var requiredFiles = ["Dsap92001"];

             function onLoaded(dcnp00501) {
             }

             function onError(error) {
                 console.error(error);
             }

             require(requiredFiles, onLoaded, onError);
         })();
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


</asp:Content>

