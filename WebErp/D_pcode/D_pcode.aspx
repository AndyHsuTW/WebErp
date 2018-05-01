<%@ Page Title="" Language="C#" MasterPageFile="~/master/BaseMasterPage.master" AutoEventWireup="true" CodeFile="D_pcode.aspx.cs" Inherits="D_pcode_D_pcode" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    
    <script>
        (function () {
            requirejs.config({
                //urlArgs: "NoCach=" + (new Date()).getTime(),
                paths: {
                    "d_pcode": "D_pcode/D_pcode",
                    "d_pcode-css": "D_pcode/D_pcodeCss",
                },
                shim: {
                    "d_pcode": {
                        "deps": ["css!d_pcode-css"]
                    },
                }
            });

            var requiredFiles = ["d_pcode"];

            function onLoaded(d_pcode) {


                window.Dpcode = new Vue({
                    el: '#d_pcode',
                    data: {
                        Dpcode_pcode: ""

                    }, methods: {
                        getDpcode: function (data) {
                            this.Dpcode_pcode = data.pcode;


                        }, leaveDpcode: function () {

                        }

                    }

                })

            }

            function onError(error) {
                console.error(error);
            }

            require(requiredFiles, onLoaded, onError);

           

        })();
        
    </script>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    

    <div id="d_pcode" v-cloak>

        <%--<input type="text" v-model="Dpcode_pcode"/>--%>
       <d_pcode_component :callback="getDpcode" :leavefunction="leaveDpcode"></d_pcode_component>
        <%--<d_pcode_component ></d_pcode_component>--%>
    </div>




</asp:Content>

