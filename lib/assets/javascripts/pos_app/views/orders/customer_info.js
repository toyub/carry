(function(win, Mis){
  var tmpl = JST["pos/orders/customer_info"];
  var url = '/api/store_customer_entities/';
  Mis.Views.editCustomer = function(vehicle) {
    if(vehicle.license_number){
      if(vehicle.store_customer){
        $.get(url + vehicle.store_customer.store_customer_entity_id, function(response){
          console.log(response)
          var customer = response;
          $('div.right_information').children().hide();
          $('.improve_crm_wrap').html(tmpl(customer));
          $('.improve_crm_wrap').show();
        });
        
      }else{
        var customer =  {
          store_customer:{},
          store_customer_settlement: {},
          regions: {}
        };
        $('div.right_information').children().hide();
        $('.improve_crm_wrap').html(tmpl(customer));
        $('.improve_crm_wrap').show();
      }
    }
  }

  $(document).on('submit', '.improve_crm_wrap form', function(evt){
    console.log($(this).serializeJSON({checkboxUncheckedValue: 'false', parseBooleans: true}))
    return false;
  });
})(window, Mis)