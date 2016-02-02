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
        var idx = this.items.findIndex(function(item){
          return item.orderable_id == orderable_id;
        });
        if(idx !== -1){
          this.$emit('remove:item', orderable_id, function(){
            _this.items.splice(idx, 1);
          });
        }
      }
    }
  }
}