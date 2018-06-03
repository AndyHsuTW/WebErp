<%@ Page Title="" Language="C#" MasterPageFile="~/master/BaseMasterPage.master" AutoEventWireup="true" CodeFile="D_EmpId.aspx.cs" Inherits="CommonObjFunc_D_EmpId_D_EmpId" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <script>
        (function () {
            requirejs.config({
                //urlArgs: "NoCach=" + (new Date()).getTime(),
                paths: {
                    "D_EmpId": "CommonObjFunc/D_EmpId/D_EmpId",
                    "d_empId-css": "CommonObjFunc/D_EmpId/D_EmpIdCss",
                },
                shim: {
                    "D_EmpId": {
                        "deps": ["css!d_empId-css"]
                    },
                }
            });

            var requiredFiles = ["D_EmpId"];

            function onLoaded(d_EmpId) {


                window.DEmpId = new Vue({
                    el: '#d_EmpId',
                    data: {
                        DEmpId_EmpId: ""

                    }, methods: {
                        getDEmpId: function (data) {
                            this.DEmpId_EmpId = data.EmpId;


                        }, leaveDEmpId: function () {

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
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <div id="d_EmpId" v-cloak>
       <d_empId_component :callback="getDEmpId" :leavefunction="leaveDEmpId"></d_empId_component>
    </div>

</asp:Content>

