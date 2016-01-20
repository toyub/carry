$(function(){

  Mis.Vues.ServiceItem = new Vue({
    el: ".vue-service-table-items",
    data: {
      serviceItems: [],
    },
    methods: {
      removeItem: function(e){
        var id = $(e.target).data("item-id");
        var _this = this;
        $.grep(this.serviceItems, function(e){
          if(e.id == id){
            _this.serviceItems.pop(e);
          }
        })
      }
    },
    computed: {
      totalPrice: function(){
        var price = 0;
        if(this.serviceItems.length > 0){
          $.grep(this.serviceItems, function(item){
            price += item.quantity * item.retail_price;
          })
        }
        return price;
      },
      recommendedTotalPrice: function(){
        var price = 0;
        if(this.serviceItems.length > 0){
          $.grep(this.serviceItems, function(item){
            price += item.quantity * item.recommended_price;
          })
        }
        return price;
      }
    }
  })
})
