(function(win, Backbone, $, Mis){
  Mis.Views.WasteOrder = function(item){
    var dialog = form_dialog($('#waste-form').html());

    dialog.dialog.on('click', '.cancel_btn', function(){
      dialog.hide();
    })

    dialog.dialog.on('submit', 'form', function(evt){
      evt.preventDefault();
      var form = evt.target;
      var $form = $(form);
      var waste_args = $form.serializeJSON();
      var user = {login_name: waste_args.login_name, password: waste_args.password}
      $.ajax({
        url: '/api/pos/auth/waste_order_authorities',
        type: 'POST',
        data: user,
        success: function(data){
          $form.find('[name="deleted_authorizer_id"]').val(data.staff.id)
          form.submit();
          dialog.hide();
        },
        error: function(xhr){
          alert(xhr.responseJSON.message);
        }
      });
    });
  }
})(window, Backbone, jQuery, Mis);
