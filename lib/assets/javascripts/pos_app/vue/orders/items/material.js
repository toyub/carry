(function(win, $, Mis){
  var opt = {
    el: "#material-items",
    data: {
      materialSaleinfoItems: []
    },
    methods: {
      removeItem: function(e){
        var orderable_id = $(e.target).data("item-id");
        var _this = this;
        $.grep(this.materialSaleinfoItems, function(e){
          if(e.orderable_id == orderable_id){
            _this.materialSaleinfoItems.pop(e);
          }
        })
      }
    },
    computed: {
      totalPrice: function(){
        var price = 0;
        if(this.materialSaleinfoItems.length > 0){
          $.grep(this.materialSaleinfoItems, function(item){
            price += item.quantity * item.retail_price;
          })
        }
        return price;
      },
      recommendedTotalPrice: function(){
        var price = 0;
        if(this.materialSaleinfoItems.length > 0){
          $.grep(this.materialSaleinfoItems, function(item){
            price += item.quantity * item.recommended_price;
          })
        }
        return price;
      }
    }
  }

  Mis.Vues.Opts.material = opt;
})(window, jQuery, Mis)
