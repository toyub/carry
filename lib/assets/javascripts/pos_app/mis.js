window.Mis ={
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  Helpers: {},
  Vues: {
    Orders:{
      Items:{}
    },
    Opts: {}
  },
  Components:{
    Order: {
      removeItem: function(item_idx, evt){
        var _this = this;
        var idx = item_idx;
        if(idx !== -1){
          var item = this.items[item_idx]
          this.$emit('remove:item', item, function(){
            _this.items.splice(idx, 1); /*TODO: orderable type id */
          });
        }
      },

      itemsAmount: function(){
        var amount = 0;
        this.items.forEach(function(item){
           amount += item.price*item.quantity
        });
        return amount;
      }
    }
  }
}
