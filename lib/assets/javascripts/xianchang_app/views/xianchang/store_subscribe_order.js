Mis.Views.SubscribeOrderView = Backbone.View.extend({
  el: ".subscribe-order-view",
  events: {
    "click #new_committed_btn": "newWindow",
    "change select[name='order-state']": "stateSelected"
  },
  render: function(){
  },
  initialize: function(){
    this.orderGrid = new Mis.Views.SubscribeOrderGridView();
    new Mis.Views.SubscribeOrderDetail();
  },
  newWindow: function(){
    $(".window_wrap").show();
  },
  stateSelected: function(el){
    var selectedValue = $(el.currentTarget).val();
    this.orderGrid.collection.fetch({
      data: {state: selectedValue }
    })
  }
})

$(function(){
  if($(".subscribe-order-view").length > 0)
    new Mis.Views.SubscribeOrderView()
})
