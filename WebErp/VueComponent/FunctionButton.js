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
                <button type="button" class="btn btn-outline-primary">
                    <slot>
                        Button
                    </slot>
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

            },
            mounted: function () {
                var that = this;
                $(document).on('keydown',null, this.hotKey, function(){
                    $(that.$el).trigger('click');
                    return false;
                });
            }
        });
    }

    function onError(error) {
        console.error(error);
    }

    define(requiredFiles, onLoaded, onError);

})();