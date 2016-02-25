(function(win, Backbone, $, Mis){
  var tmpl = JST['pos/orders/discount/form'];
  Mis.Views.EditDiscount = function(item){
    var attrs = {name: item.name, discount: item.discount, discount_reason: item.discount_reason, cached_price: item.cached_price};
    var dialog = form_dialog(tmpl(attrs));
    
    dialog.dialog.on('click', '.cancel_btn', function(){
      dialog.hide();
    })

    dialog.dialog.on('submit', 'form', function(evt){
      evt.preventDefault();

      if(!item.cached_price){
        item.cached_price = parseFloat(item.price || 0.0) + parseFloat(item.discount||0);
      }
      
      var form = evt.target;
      var $form = $(form);
      var discount = $form.serializeJSON();

      item.discount = parseFloat(discount.discount) || 0.0;
      item.discount_reason = discount.discount_reason;
      item.price = item.cached_price - discount.discount;
      dialog.hide();
      console.log(item)
    });
  }
})(window, Backbone, jQuery, Mis);
