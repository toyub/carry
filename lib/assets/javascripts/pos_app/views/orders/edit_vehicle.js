(function(win, Mis){
  var tmpl = JST["pos/orders/vehicle_detail_info"];
  Mis.Views.editVehicle = function(vehicle) {
    $('div.right_information').children().hide();
    $('.completing_vehicle_info').html(tmpl(vehicle));
    $('.completing_vehicle_info').show();
  }

})(window, Mis)