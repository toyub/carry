Mis.Views.SubscribeOrderView = Backbone.View.extend({
  el: ".subscribe-order-view",
  render: function(){
    console.log("mouseshi")
  },
  initialize: function(){
    new Mis.Views.SubscribeOrderGridView();
    new Mis.Views.SubscribeOrderDetail();
  }
})

$(function(){
  if($(".subscribe-order-view").length > 0)
    new Mis.Views.SubscribeOrderView()
})
