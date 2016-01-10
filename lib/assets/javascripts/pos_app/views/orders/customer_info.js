(function(win, Mis){
  var tmpl = JST["pos/orders/customer_info"];
  var url = '/api/store_checkouts';
  Mis.Views.editCustomer = function(vehicle) {
    if(vehicle.license_number){
      var customer = vehicle.store_customer || {};
      $('div.right_information').children().hide();
      $('.improve_crm_wrap').html(tmpl(customer));
      $('.improve_crm_wrap').show();
    }
  }

  $(document).on('submit', '.improve_crm_wrap form', function(evt){
    console.log($(this).serializeJSON({checkboxUncheckedValue: 'false', parseBooleans: true}))
    return false;
  });
})(window, Mis)