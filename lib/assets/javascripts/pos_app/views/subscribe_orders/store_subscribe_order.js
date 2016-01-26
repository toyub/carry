Mis.Views.SubscribeOrderView = Backbone.View.extend({
  el: ".subscribe-order-view",
  events: {
    "click #new_committed_btn": "newWindow",
    "click .query_btn": "handlerSearching",
    "change select[name='order-state']": "stateSelected",
  },
  initialize: function(){
    this.orderGrid = new Mis.Views.SubscribeOrderGridView();
    new Mis.Views.SubscribeOrderDetail();
    new Mis.Views.SubscribeOrderForm();

    // 暂时取消可移动窗口，问题比较多
    //$(".wrap_order_details").draggable();
  },
  newWindow: function(){
    $(".window_wrap").show();
  },
  stateSelected: function(el){
    var selectedValue = $(el.currentTarget).val();
    if(selectedValue == "all")
      selectedValue = ""
    this.orderGrid.collection.fetch({
      data: {state: selectedValue }
    })
  },
  handlerSearching: function(){
    var numberVal = $(".phone-number-or-license-number").val();
    var subscribeDate = $(".subscribe-date").val();
    if(numberVal == "" && subscribeDate == ""){
      $.alert({
        text: "车牌、电话或预约时间不能为空"
      })
    }else{
      this.orderGrid.collection.fetch({
        data: {number_val: numberVal, subscribe_date: subscribeDate}
      });
    }
  }
})

$(function(){
  if($(".subscribe-order-view").length > 0)
    new Mis.Views.SubscribeOrderView()
})