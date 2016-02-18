(function(win, Backbone, $, Mis){
  var tmpl = JST["pos/orders/vehicle/form"];
  Mis.Views.NewCustomerView = function(){
    var dialog = form_dialog(tmpl());
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
          console.log(response)
        },
        error: function(){
          ZhanchuangAlert('保存失败请重试');
        }
      })
    });
  }
})(window, Backbone, jQuery, Mis);
