(function(win, Backbone, $, Mis){
  var tmpl = JST["pos/orders/vehicle/form"];
  Mis.Views.NewCustomerView = function(customer, handle){
    var dialog = form_dialog(tmpl(customer));
    var provisional = customer.provisional;
    $(".cancel_btn").on('click', function(){
      dialog.hide();
    })
    dialog.dialog.on('submit', function(evt){
      evt.preventDefault();
      var $form = $(evt.target);
      var vehicle_attr = $form.serializeJSON();
      vehicle_attr.vehicle.provisional = provisional;
      $.ajax({
        type: 'POST',
        url: '/api/crm/customers',
        contentType: 'application/json',
        data: JSON.stringify(vehicle_attr),
        success: function(response, status_str, xhr, undef){
          handle.createVehicleSuccess(response);
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
