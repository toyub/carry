(function(win, doc, Backbone, $$MIS){
  var PaymentCollection = Backbone.Collection.extend({
    model: $$MIS.Payment,
    as_json: function(){
      return this.authorized_payments().map(function(model){
        return model.as_json();
      });
    },

    combined_methods: function(){
      return this.models.map(function(model){
        return model.payment_method().name;
      });
    },

    combined_amount: function(){
      return this.map(function(model){ return parseFloat(model.get('amount')) || 0.0;}).reduce(function(x,y){return x+y});
    },

    deposit_pay_amount: function(){
      return this.where({payment_method_type: 'PaymentMethods::Deposit'})
                 .map(function(model){ return parseFloat(model.get('amount')) || 0.0;})
                 .reduce(function(x,y){return x+y});
    },

    combine: function(){
      var available_methods = PaymentMethods.available_methods();
      this.add({payment_method: available_methods[0], payment_methods: available_methods});
    },

    authorized_payments: function(){
      return this.filter(function(model){return parseFloat(model.get('amount')) >= 0;});
    },

    contains_deposit: function(){
      return this.any(function(model){
        return model.payment_method().name == 'PaymentMethods::Deposit';
      });
    }
  });
  win.$$MIS.PaymentCollection = PaymentCollection;
})(window, document, Backbone, window.$$MIS);
