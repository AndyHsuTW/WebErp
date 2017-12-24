
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
    
    template: `
    <input type='text' v-bind:placeholder="placeholderText" />
        `,
    props: {
        changecallback: null,
        timepicker:{
            type:Boolean
        },
        placeholder:{
            type:String
        }
    },
    data: function() { // use function to make reset function work
        return {
            value: '',
            placeholderText:"",
            format:"",
        }
    },
    methods: {
        onClose: function(date) {
            this.$emit('input', date); 
        },
        setValue:function(date){
            $(this.$el).val(date);
        }
    },
    created: function() {

    },
    mounted: function() {
        var vm = this;
        if(this.timepicker){
            this.placeholderText = this.placeholder==null? "YYYY/MM/DD HH:MM":this.placeholder;
            this.format="Y/m/d H:i";
        } else {
            this.placeholderText = this.placeholder==null? "YYYY/MM/DD HH:MM":this.placeholder;
            this.format="Y/m/d";
        }
        var mycomp = $(this.$el).datetimepicker({
            format:this.format,
            onChangeDateTime:function(dp,$input) {
                vm.value = $input.val();
                vm.$emit('input', vm.value);
                vm.$emit('change', vm.value);
                if (typeof(vm.changecallback) == 'function') {
                    vm.changecallback();
                }
            },
            timepicker: this.timepicker
        });
    }
});