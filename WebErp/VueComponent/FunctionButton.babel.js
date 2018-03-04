'use strict';

(function () {
    requirejs.config({
        paths: {
            "jqueryHotkeys": "public/scripts/jquery.hotkeys"
        },
        shim: {}
    });
    var requiredFiles = ["jqueryHotkeys"];

    function onLoaded(jqueryHotkeys) {

        Vue.component('function-button', {
            template: "\n                <button type=\"button\" class=\"btn btn-default\" role='button'>\n                    <slot>\n                        Button\n                    </slot>\n                    ({{hotKey.toUpperCase()}})\n                </button>\n            ",
            props: {
                "hot-key": {
                    type: String,
                    validator: function validator(hotKey) {
                        // F1~F12 only
                        var hotKey = hotKey.toLowerCase();
                        if (hotKey.startsWith("f")) {
                            return true;
                        } else {
                            console.warn("hotKey must start with 'F'");
                            return false;
                        }
                    }
                }
            },
            data: function data() {
                return {};
            },
            methods: {
                OnHotKey: function OnHotKey() {
                    $(this.$el).trigger('click');
                    return false;
                }
            },
            mounted: function mounted() {
                $(document).on('keydown', null, this.hotKey, this.OnHotKey);
            },
            beforeDestroy: function beforeDestroy() {
                $(document).off('keydown', null, this.OnHotKey);
            }
        });
    }

    function onError(error) {
        console.error(error);
    }

    define(requiredFiles, onLoaded, onError);
})();