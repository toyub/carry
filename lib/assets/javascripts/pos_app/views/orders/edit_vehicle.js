(function(win, Mis){
  var tmpl = JST["pos/orders/vehicle_detail_info"];
  Mis.Views.editVehicle = function(vehicle) {
    $('div.right_information').children().hide();

    vehicle.vehicle_brands = $('#vehicle_brands').data('brands');

    $('.completing_vehicle_info').html(tmpl(vehicle));
    $('.completing_vehicle_info').show();
    initiSelect();
  }

  $(document).on('change', "[name='vehicle[vehicle_brand_id]']", function(){
    console.log(this.value)
  });

  var initiSelect = function(){
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

})(window, Mis)
