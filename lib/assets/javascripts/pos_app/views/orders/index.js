Mis.Views.PosOrderIndexView = Backbone.View.extend({
  el: ".pos-orders-index",
  events: {
    "click .do_show": "showCustomerInfoView",
  },
  initialize: function(){
    this.customerInfoView = new Mis.Views.CustomerInfoView();
  },
  showCustomerInfoView: function(el){
    var target = $($(el.currentTarget));
    if(target.data("target") == "completing_customer"){
      this.customerInfoView.show();
    }
  }
})

$(function(){
  if($(".pos-orders-index").length > 0){
    new Mis.Views.PosOrderIndexView();
  }
})
