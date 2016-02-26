(function(win, $, Mis){
  var opt = {
    el: "#material-items",
    data: {
      items: []
    },
    methods: {
      removeItem: Mis.Components.Order.removeItem,
      makeDiscount: Mis.Components.Order.makeDiscount
    },
    computed: {
      totalPrice: Mis.Components.Order.itemsAmount,
      recommendedTotalPrice: function(){
        var price = 0;
        if(this.items.length > 0){
          $.grep(this.items, function(item){
            price += item.quantity * item.recommended_price;
          })
        }
        return price;
      }
    }
  }

  Mis.Vues.Opts.material = opt;
})(window, jQuery, Mis)
