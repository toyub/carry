(function(win, doc, Backbone, $$MIS){

  var Payment = Backbone.Model.extend({
    defaults: {
      payment_method_id: 0
    }
  });
  win.$$MIS = $$MIS || {};
  win.$$MIS.Payment = Payment;
})(window, document, Backbone, window.$$MIS);
