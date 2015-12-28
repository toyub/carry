$(function(){

  Mis.Vues.PackageItem = new Vue({
    el: ".vue-package-table-items",
    data: {
      packageItems: [],
    },
    methods: {
      removeItem: function(e){
        var id = $(e.target).data("item-id");
        var _this = this;
        $.grep(this.packageItems, function(e){
          if(e.id == id){
            _this.packageItems.pop(e);
          }
        })
      }
    },
    computed: {
      totalPrice: function(){
        var price = 0;
        if(this.packageItems.length > 0){
          $.grep(this.packageItems, function(item){
            price += item.quantity * item.retail_price;
          })
        }
        return price;
      }
    }
  })
})
