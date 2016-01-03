$(function(){
  Mis.Vues.StoreOrderIndexView = new Vue({
    el: ".vue-store-order-index",
    data: {
      storeOrders: []
    },
    methods: {
      searchStoreOrder: function(){
        var storeVehicle = $(".js-store-vehicle-license-number").val();
        var storeOrderDate = $(".js-store-order-date").val();

        if(storeVehicle == "" &&  storeOrderDate == ""){
          $.alert({text: "车牌或时间不能为空"})
        }else{
          storeOrders.fetch({
            data: {license_number: storeVehicle, created_at: storeOrderDate}
          });
        }
      }
    }
  });

  var storeOrders = new Mis.Collections.StoreOrders;
  storeOrders.fetch({success: function(){
    Mis.Vues.StoreOrderIndexView.storeOrders = storeOrders.models;
  }})

})
