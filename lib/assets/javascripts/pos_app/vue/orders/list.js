(function(win, $, Mis){
  var opt = {
    el: ".vue-store-order-index",
    data: {
      storeOrders: []
    },
    methods: {
      searchStoreOrder: function(){
        var storeVehicle = $(".js-store-vehicle-license-number").val();
        var storeOrderDate = $(".js-store-order-date").val();
        var stateSelect = $(".state-select").val();
        this.storeOrdersCollection.fetch({
          data: {license_number: storeVehicle, created_at: storeOrderDate, state: stateSelect}
        });
      }
    }
  };

  Mis.Vues.Opts.list = opt;
})(window, jQuery, Mis);
