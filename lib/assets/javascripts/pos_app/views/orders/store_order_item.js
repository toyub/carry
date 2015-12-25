Mis.Views.StoreOrderItemView = Backbone.View.extend({
  el: ".store-order-item-block",
  template: JST["pos/orders/store_order_item"],
  initialize: function(){
    this.render();
  },
  render: function(){
    this.$el.html(this.template());
  },
  show: function(){
    this.$el.show();
  },
  hide: function(){
    this.$el.hide();
  }
})
