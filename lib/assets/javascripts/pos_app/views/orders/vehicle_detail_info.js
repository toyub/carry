Mis.Views.VehicleDetailInfoView = Backbone.View.extend({
  el: ".vehicle_details_info",
  template: JST["pos/orders/vehicle_detail_info"],
  initialize: function(){
    this.render();

    this.initSelectInput();
  },
  render: function(){
    this.$el.html(this.template());
  },
  initSelectInput: function(){
    var vehicleSeriesId = $(".js-select-vehicle-series").val();
    if(vehicleSeriesId == ""){
      vehicleSeriesId = 0
    }
    var url = "api/vehicle_series/" + vehicleSeriesId + "/vehicle_models";
    $(".js-select-vehicle-model").select2({
      language: "zh-CN",
      ajax: {
        url: url,
        dataType: "json",
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
    })
  }
})
