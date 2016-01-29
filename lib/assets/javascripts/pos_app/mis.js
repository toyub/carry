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
        var orderable_id = parseInt(evt.target.dataset.orderableid)
        var idx = this.items.findIndex(function(item){
          return item.orderable_id == orderable_id;
        });
        console.log(idx)
        if(idx !== -1){
          this.items.$remove(idx)
        }
      }
    }
  }
}
