(function(win, doc, Backbone, $$MIS){

  var Payment = Backbone.Model.extend({
    
    payment_method: function(){
      return this.get('payment_method');
    },

    as_json: function(){
      var _attrs = this.attributes;
      return {
        payment_method_type: _attrs.payment_method.name,
        amount: this.get('amount')
      }
    },

    attrs: function(){
      var _attrs = _.clone(this.attributes);
      return _attrs;
    },

    set_method: function(method_name){
      this.set('payment_method', PaymentMethods.get_by_name(method_name));
    }
  });
  win.$$MIS = $$MIS || {};
  win.$$MIS.Payment = Payment;
})(window, document, Backbone, window.$$MIS);
