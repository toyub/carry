(function(win, $, Mis){
  var opt = {
    el: "#package-items",
    data: {
      items: [],
    },
    methods: {
      removeItem: Mis.Components.Order.removeItem
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
  };

  Mis.Vues.Opts.package = opt;

})(window, jQuery, Mis);