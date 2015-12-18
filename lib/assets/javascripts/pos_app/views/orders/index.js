Mis.Views.PosOrderIndexView = Backbone.View.extend({
  el: ".pos-orders-index",
  events: {
    "click .do_show": "showCustomerInfoView",
    "click .query_btn": "handlerQueryOrder",
  },
  initialize: function(){
    this.customerInfoView = new Mis.Views.CustomerInfoView();
    this.storeOrderItemView = new Mis.Views.StoreOrderItemView();
  },
  showCustomerInfoView: function(el){
    var target = $($(el.currentTarget));
    this.hideOtherRightInfomationDiv();
    if(target.data("target") == "completing_customer"){
      this.customerInfoView.show();
    }
  },
  hideOtherRightInfomationDiv: function(){
    this.storeOrderItemView.hide();
    this.customerInfoView.hide();
  },
  handlerQueryOrder: function(){
    console.log("click the query order btn");
  }
})

$(function(){
  if($(".pos-orders-index").length > 0){
    new Mis.Views.PosOrderIndexView();
  }
})
