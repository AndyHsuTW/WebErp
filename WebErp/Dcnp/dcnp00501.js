'use strict';
(function () {
    requirejs.config({
        paths: {
            "functionButton": "VueComponent/FunctionButton",
        },
        shim: {}
    });

    var requiredFiles = ["functionButton"];

    function onLoaded(functionButton) {
        window.dcnp00501 = new Vue({
            el: "#Dcnp00501",
            data: {

            },
            components: {},
            computed: {

            },
            methods: {
                OnSearch: function () {
                    console.log("OnSearch");
                },
                OnAdd:function(){
                    console.log("OnAdd");
                },
                OnDelete:function(){
                    console.log("OnAdd");
                }
            },
            directives: {

            },
            mounted: function () {}
        });
    }

    function onError(error) {
        console.error(error);
    }

    define(requiredFiles, onLoaded, onError);

})();