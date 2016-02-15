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
      removeItem: function(evt){
        var _this = this;
        var orderable_id = parseInt(evt.target.dataset.orderableid)
        var orderable_type = evt.target.dataset.orderabletype;
        var idx = this.items.findIndex(function(item){
          return item.orderable_id == orderable_id && item.orderable_type == orderable_type;
        });
        if(idx !== -1){
          this.$emit('remove:item', orderable_id, function(){
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
