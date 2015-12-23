(function(win, doc, Backbone, $$MIS){

  var Payment = Backbone.Model.extend({
    set_excepts: function(excepts){
      this.excepts = excepts || [];
      this.trigger('update');
    },
    as_json: function(){
      return {
        payment_method_type: this.get('payment_method_type'),
        amount: this.get('amount')
      }
    },
    attrs: function(){
        var _attrs = _.clone(this.attributes)
        _attrs.payment_methods = PaymentMethods.available_methods();
        return _attrs;
    }
  });
  win.$$MIS = $$MIS || {};
  win.$$MIS.Payment = Payment;
})(window, document, Backbone, window.$$MIS);
