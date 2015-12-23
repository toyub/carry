(function(win, doc, Backbone, $$MIS){

  var Payment = Backbone.Model.extend({
    defaults: {
      payment_method_type: 0
    },
    as_json: function(){
      return {
        payment_method_type: this.get('payment_method_type'),
        amount: this.get('amount')
      }
    }
  });
  win.$$MIS = $$MIS || {};
  win.$$MIS.Payment = Payment;
})(window, document, Backbone, window.$$MIS);
