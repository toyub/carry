Mis.Views.CustomerInfoView = Backbone.View.extend({
  el: ".completing_customer_info",
  template: JST["pos/orders/customer_info"],
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
