'use strict';
(function () {
    requirejs.config({
        paths: {
            "jqueryHotkeys": "public/scripts/jquery.hotkeys",
        },
        shim: {}
    });
    var requiredFiles = ["jqueryHotkeys"];

    function onLoaded(jqueryHotkeys) {

        Vue.component('function-button', {
            template: `
                <button type="button" class="btn btn-default" role='button'>
                    <slot>
                        Button
                    </slot>
                    ({{hotKey.toUpperCase()}})
                </button>
            `,
            props: {
                "hot-key": {
                    type: String,
                    validator: function (hotKey) {
                        // F1~F12 only
                        var hotKey = hotKey.toLowerCase();
                        if (hotKey.startsWith("f")) {
                            return true;
                        } else {
                            console.warn("hotKey must start with 'F'");
                            return false;
                        }
                    }
                },
            },
            data: function () {
                return {

                };
            },
            methods: {
                OnHotKey: function(){
                    $(this.$el).trigger('click');
                    return false;
                }
            },
            mounted: function () {
                $(document).on('keydown',null, this.hotKey,this.OnHotKey);
            },
            beforeDestroy:function(){
                $(document).off('keydown',null, this.OnHotKey);
            }
        });
    }

    function onError(error) {
        console.error(error);
    }

    define(requiredFiles, onLoaded, onError);

})();