Mis.Views.PosOrderIndexView = Backbone.View.extend({
  el: ".pos-orders-index",
  events: {
    "click .do_show": "mouseshi",
  },
  initialize: function(){
    this.customerInfoView = new Mis.Views.CustomerInfoView();
  },
  showCustomerInfoView: function(el){
    console.log(el);
    console.log("show the customer info view");
  }
})

$(function(){
  if($(".pos-orders-index").length > 0)
    new Mis.Views.PosOrderIndexView()
})
