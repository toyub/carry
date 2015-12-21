(function(win, doc, Backbone, $$MIS){
  var PaymentCollection = Backbone.Collection.extend({
    model: $$MIS.Payment,
    as_json: function(){
      return this.models.map(function(model){
        return model.as_json();
      });
    }
  });
  win.$$MIS.PaymentCollection = PaymentCollection;
})(window, document, Backbone, window.$$MIS);
