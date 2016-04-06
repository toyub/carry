(function(win, Backbone, $, Mis){
  var tmpl = JST["pos/orders/vehicle/form"];
  Mis.Views.NewCustomerView = function(options, handle){
    var dialog = form_dialog(tmpl(options));
    $(".cancel_btn").on('click', function(){
      dialog.hide();
    })
    dialog.dialog.on('submit', function(evt){
      evt.preventDefault();
      var $form = $(evt.target);
      var vehicle_attr = $form.serializeJSON();
      $.ajax({
        type: 'POST',
        url: '/api/crm/customers',
        contentType: 'application/json',
        data: JSON.stringify(vehicle_attr),
        success: function(response, status_str, xhr, undef){
          handle.storeVehicle.id = response.store_vehicle_id;
          handle.fetchVehicle();
          $("input[name='license_number']").val(response.license_number);
          $("input[name='phone_number']").val(response.customer.phone_number);
          $('.add_new_vehicle').hide();
          $('.add_new_customer').hide();
          dialog.hide();
          ZhanchuangAlert(response.notice);
        },
        error: function(){
          ZhanchuangAlert('保存失败请重试');
        }
      })
    });
  }
})(window, Backbone, jQuery, Mis);
