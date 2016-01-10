Mis.Views.editCustomer = function(vehicle) {
  if(vehicle.license_number){
    if(vehicle.customer){
      $('div.right_information').children().hide();
      $('.improve_crm_wrap').show();
    }else{
      console.log('No customer');
    }
  }else{
    console.log('No vehicle');
  }
}