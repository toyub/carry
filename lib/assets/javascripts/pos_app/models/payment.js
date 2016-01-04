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
      if(!this.attributes.paid){
        if(!this.attributes.credit_able){
          _attrs.payment_methods = this.attributes.payment_methods.filter(function(method){return method.name != 'PaymentMethods::Internalcredit'})
        }
      }

      return _attrs;
    },

    set_method: function(method_name){
      var payment_method = PaymentMethods.get_by_name(method_name);
      this.set('payment_method_type', payment_method.name);
      this.set('payment_method', payment_method);
      if(this.get('payment_method').name == 'PaymentMethods::Internalcredit'){
        this.trigger('hang!');
      }

      if(this._previousAttributes.payment_method && this._previousAttributes.payment_method.name == 'PaymentMethods::Internalcredit'){
        this.trigger('not:hang!');
      }
    }
  });
  win.$$MIS = $$MIS || {};
  win.$$MIS.Payment = Payment;
})(window, document, Backbone, window.$$MIS);
