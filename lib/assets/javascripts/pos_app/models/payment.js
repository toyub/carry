(function(win, doc, Backbone, $$MIS){

  var Payment = Backbone.Model.extend({
    defaults: {
      payment_method_id: 0
    },
    as_json: function(){
      return {
        payment_method_id: this.get('payment_method_id'),
        amount: this.get('amount')
      }
    }
  });
  win.$$MIS = $$MIS || {};
  win.$$MIS.Payment = Payment;
})(window, document, Backbone, window.$$MIS);
