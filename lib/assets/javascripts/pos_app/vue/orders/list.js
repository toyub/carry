(function(win, $, Mis){
  var opt = {
    el: ".vue-store-order-index",
    data: {
      storeOrders: []
    },
    methods: {
      searchStoreOrder: function(){
        $('#loading').show();
        var storeVehicle = $(".js-store-vehicle-license-number").val();
        var storeOrderDate = $(".js-store-order-date").val();
        var stateSelect = $(".state-select").val();
        var payStatus = $(".pay-status").val();
        var taskStatus = $('.task-status').val();
        var data = {license_number: storeVehicle, created_at: storeOrderDate};
        if(payStatus){
          data.pay_status = payStatus;
        }

        if(taskStatus){
          if(taskStatus == 0){
            data.state = 0;
          }else{
            data.task_status = taskStatus;
          }
        }
        this.storeOrdersCollection.fetch({
          data: data,
          success: function(){
            $('#loading').hide();
          }
        });
      }
    }
  };

  Mis.Vues.Opts.list = opt;
})(window, jQuery, Mis);
