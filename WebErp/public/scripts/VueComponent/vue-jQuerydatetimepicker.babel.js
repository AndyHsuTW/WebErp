"use strict";

/*!
 * 
 * 20170608 Andy Hsu
 * jQuery-datetimepicker
 * Global constant:
 * js file:
 *  jQuery
 *  ...
 * style:
 *  ...
 */
Vue.component("vue-datetimepicker", {

    template: "\n    <input type='text' v-bind:placeholder=\"placeholderText\" />\n        ",
    props: {
        changecallback: null,
        timepicker: {
            type: Boolean
        },
        placeholder: {
            type: String
        }
    },
    data: function data() {
        // use function to make reset function work
        return {
            value: '',
            placeholderText: "",
            format: ""
        };
    },
    methods: {
        onClose: function onClose(date) {
            this.$emit('input', date);
        },
        setValue: function setValue(date) {
            $(this.$el).val(date);
        }
    },
    created: function created() {},
    mounted: function mounted() {
        var vm = this;
        if (this.timepicker) {
            this.placeholderText = this.placeholder == null ? "YYYY/MM/DD HH:MM" : this.placeholder;
            this.format = "Y/m/d H:i";
        } else {
            this.placeholderText = this.placeholder == null ? "YYYY/MM/DD HH:MM" : this.placeholder;
            this.format = "Y/m/d";
        }
        var mycomp = $(this.$el).datetimepicker({
            format: this.format,
            onChangeDateTime: function onChangeDateTime(dp, $input) {
                vm.value = $input.val();
                vm.$emit('input', vm.value);
                if (typeof vm.changecallback == 'function') {
                    vm.changecallback();
                }
            },
            timepicker: this.timepicker
        });
    }
});