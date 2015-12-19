(function(win, doc, Backbone, $$MIS){
  var PaymentCollection = Backbone.Collection.extend({
    model:$$MIS.Payment
  });
  win.$$MIS.PaymentCollection = PaymentCollection;
})(window, document, Backbone, window.$$MIS);
