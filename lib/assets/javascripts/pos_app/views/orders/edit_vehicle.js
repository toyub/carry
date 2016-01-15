(function(win, Mis){
  var tmpl = JST["pos/orders/vehicle_detail_info"];
  Mis.Views.editVehicle = function(vehicle) {
    $('div.right_information').children().hide();

    vehicle.vehicle_brands = $('#vehicle_brands').data('brands');

    $('.completing_vehicle_info').html(tmpl(vehicle));
    $('.completing_vehicle_info').show();
    initVueSelect();
  }

  $(document).on('change', "[name='vehicle[vehicle_brand_id]']", function(){
    var url = "/api/vehicle_brands/" + this.value + "/search_series";

    $.ajax({
      method: "GET",
      url: url,
    }).done(function(e){
      Mis.Vues.SelectVehicleInfo.vehicleSeries = e;
      Mis.Vues.SelectVehicleInfo.vehicleModels = [];
    }).fail(function(e){
    })
  });

  $(document).on('change', "[name='vehicle[vehicle_series_id]']", function(){
    var url = "/api/vehicle_series/" + this.value + "/vehicle_models";

    $.ajax({
      method: "GET",
      url: url,
    }).done(function(e){
      Mis.Vues.SelectVehicleInfo.vehicleModels = e;
    }).fail(function(e){
    })
  })

  var initVueSelect = function(){
    Mis.Vues.SelectVehicleInfo = new Vue({
      el: ".completing_vehicle_info",
      data: {
        vehicleSeries: [],
        vehicleModels: []
      }
    })
  }
})(window, Mis)
