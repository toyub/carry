Mis.Views.SubscribeOrderDetail = Backbone.View.extend({
  el: ".subscribe-order-top-detail",
  template: JST["xianchang/subscribe_order/top_details"],
  initialize: function(){
    this.render()
  },
  render: function(){
    this.$el.html(this.template());
    return this.$el;
  }
})
