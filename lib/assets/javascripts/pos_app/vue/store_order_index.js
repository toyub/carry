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
        var stateSelect = $(".state-select").val();

        storeOrders.fetch({
          data: {license_number: storeVehicle, created_at: storeOrderDate, state: stateSelect}
        });
      }
    }
  });

  if($(".vue-store-order-index").length > 0){
    var storeOrders = new Mis.Collections.StoreOrders;
    storeOrders.fetch({success: function(){
      Mis.Vues.StoreOrderIndexView.storeOrders = storeOrders.models;
    }})
  }
})
