Mis.Views.PosOrderIndexView = Backbone.View.extend({
  el: ".pos-orders-index",
  events: {
    "click .do_show": "showCustomerInfoView",
  },
  initialize: function(){
    this.customerInfoView = new Mis.Views.CustomerInfoView();
    this.storeOrderItemView = new Mis.Views.StoreOrderItemView();
  },
  showCustomerInfoView: function(el){
    var target = $($(el.currentTarget));
    hideOtherRightInfomationDiv()
    if(target.data("target") == "completing_customer"){
      this.customerInfoView.show();
    }
  },
  hideOtherRightInfomationDiv: function(){
    this.storeOrderItemView.hide();
    this.customerInfoView.hide();
  }
})

$(function(){
  if($(".pos-orders-index").length > 0){
    new Mis.Views.PosOrderIndexView();
  }
})
