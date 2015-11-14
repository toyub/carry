Mis.Views.SubscribeOrderForm = Backbone.View.extend({
  el: ".window_wrap",
  template: JST["xianchang/subscribe_order/form"],
  initialize: function(){
    this.render()
  },
  render: function(){
    this.$el.html(this.template());
    return this.$el;
  }
})
