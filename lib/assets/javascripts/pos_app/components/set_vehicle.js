(function(){

  var check_phone_number = function(phone_number){
    $.get('/api/crm/customers/check', {phone_number: phone_number}, function(response, status_str, xhr, undef){
          if(response.success){
            $('.vehicle_info .add_new_customer').hide();
            $('.vehicle_info .add_new_vehicle').show();
          }else{
            $('.vehicle_info .add_new_vehicle').hide();
            $('.vehicle_info .add_new_customer').show();
          }
        });
  }

  Mis.SetVehicle = function(){
    $(".vehicle_info .js-license-number").on('change', function(){
      if(!!this.value){
        var license_number = this.value;
        var phone_number = $(".vehicle_info .js-phone-number").val();
        $.get('/api/store_vehicles/search', {license_number: license_number}, function(response, status_str, xhr, undef){
          if(response.vehicle_id){
            Mis.current_vehicle.id = response.vehicle_id;
            Mis.current_vehicle.fetch();
            $('.vehicle_info .add_new_customer').hide();
            $('.vehicle_info .add_new_vehicle').hide();
          }else{
            if(!!phone_number){
              check_phone_number(phone_number);
            }else{
              $('.vehicle_info .add_new_vehicle').hide();
              $('.vehicle_info .add_new_customer').show();
            }
          }
        })
      }
    });

    $(".vehicle_info .js-phone-number").on('blur', function(){
      if(!!this.value){
        var phone_number = this.value;
        check_phone_number(phone_number);
      }
    });


  };
})();
