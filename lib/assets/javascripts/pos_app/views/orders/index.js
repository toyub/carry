Mis.Views.PosOrderIndexView = Backbone.View.extend({
  el: ".pos-orders-index",
  events: {
    "click .do_show": "showCustomerInfoView",
    "click .query_btn": "handlerQueryOrder",
  },
  initialize: function(){
    this.customerInfoView = new Mis.Views.CustomerInfoView();
    this.storeOrderItemView = new Mis.Views.StoreOrderItemView();

    this.initSelectInput()
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
  },
  initSelectInput: function(){
    $(".js-store-vehicle-license-number-input").select2({
      ajax: {
        url: "/api/store_vehicles/search",
        dataType: "json",
        minimumInputLength: 3,
        data: function(params){
          return {
            q: params.term
          }
        },
        processResults: function(data, params){
          params.page = params.page || 1;

          return {
            results: data.items,
            pagination: {
              more: (params.page * 30) < data.total_count
            }
          };
        },
      }
    });
  }
})

$(function(){
  if($(".pos-orders-index").length > 0){
    new Mis.Views.PosOrderIndexView();
  }
})
