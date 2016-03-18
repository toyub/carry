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
        var data = {license_number: storeVehicle, created_at: storeOrderDate};
        this.storeOrdersCollection.fetch({
          data: data
        });
      }
    }
  };

  Mis.Vues.Opts.list = opt;
})(window, jQuery, Mis);
