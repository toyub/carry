Mis.Views.SubscribeOrderView = Backbone.View.extend({
  el: ".subscribe-order-view",
  events: {
    "click #new_committed_btn": "newWindow",
  },
  render: function(){
  },
  initialize: function(){
    new Mis.Views.SubscribeOrderGridView();
    new Mis.Views.SubscribeOrderDetail();
  },
  newWindow: function(){
    $(".window_wrap").show();
  }
})

$(function(){
  if($(".subscribe-order-view").length > 0)
    new Mis.Views.SubscribeOrderView()
})
