(function(win, Mis){
  var tmpl = JST["pos/orders/vehicle_detail_info"];
  Mis.Views.editVehicle = function(vehicle) {
    $('div.right_information').children().hide();
    vehicle.vehicle_brands = $('#vehicle_brands').data('brands');
    $('.completing_vehicle_info').html(tmpl(vehicle));
    $('.completing_vehicle_info').show();
  }

  $(document).on('change', "[name='vehicle[vehicle_brand_id]']", function(){
    console.log(this.value)
  });

})(window, Mis)