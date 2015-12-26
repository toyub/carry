Mis.Views.StoreOrderItemView = Backbone.View.extend({
  el: ".store-order-item-block",
  template: JST["pos/orders/store_order_item"],
  initialize: function(){
    this.materialCollection = new Mis.Collections.StoreMaterialSaleinfos;
    var _this = this;

    this.listenTo(this.materialCollection, 'add', this.render);

    this.materialCollection.fetch()
  },
  render: function(){
    var materials = []
    this.materialCollection.each(function(item){
      materials.push(item.attributes);
    })
    this.$el.html(this.template({materials:  materials}));
  },
  show: function(){
    this.$el.show();
  },
  hide: function(){
    this.$el.hide();
  }
})
