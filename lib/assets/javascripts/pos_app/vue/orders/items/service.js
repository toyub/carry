(function(win, $, Mis){
  var opt = {
    el: ".vue-service-table-items",
    data: {
      serviceItems: [],
    },
    methods: {
      removeItem: function(e){
        var orderable_id = $(e.target).data("item-id");
        var _this = this;
        $.grep(this.serviceItems, function(e){
          if(e.orderable_id == orderable_id){
            _this.serviceItems.pop(e);
          }
        })
      },

      items: function(){
        console.log(this.serviceItems)
        return [];
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
  }

  Mis.Vues.Opts.service = opt;
})(window, jQuery, Mis)