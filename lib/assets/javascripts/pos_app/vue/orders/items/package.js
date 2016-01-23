(function(win, $, Mis){
  var opt = {
    el: "#package-items",
    data: {
      packageItems: [],
    },
    methods: {
      removeItem: function(e){
        var orderable_id = $(e.target).data("item-id");
        var _this = this;
        $.grep(this.packageItems, function(e){
          if(e.orderable_id == orderable_id){
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
      },
      recommendedTotalPrice: function(){
        var price = 0;
        if(this.packageItems.length > 0){
          $.grep(this.packageItems, function(item){
            price += item.quantity * item.recommended_price;
          })
        }
        return price;
      }
    }
  };

  Mis.Vues.Opts.package = opt;

})(window, jQuery, Mis);