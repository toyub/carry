Mis.Views.MaterialItemable = Backbone.View.extend({
  el: ".order_commodity",
  template: JST["pos/subscribe_order/material_itemable"],
  initialize: function(){
    this.render();
  },
  render: function(){
    this.$el.html(this.template());
  }
})
