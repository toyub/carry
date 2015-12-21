(function(win, doc, Backbone, $$MIS){
  var tmpl = JST["pos/cashier/checkouts/payment"];
  var PaymentView = Backbone.View.extend({
    tagName: 'dl',
    events: {
      'change input': 'set_pay',
      'change select': 'set_method'
    },
    initialize: function(){
      this.listenTo(this.model, 'update', this.rerender)
    },
    render: function(){
      var _attrs = this.model.attributes;
      _attrs.payment_methods = $$MIS.PaymentMethods.excepts(this.model.get('excepts'));
      this.$el.html(tmpl(_attrs))
      return this.$el;
    },
    rerender: function(){
      var _attrs = this.model.attributes;
      _attrs.payment_methods = $$MIS.PaymentMethods;
      this.$el.html(tmpl(_attrs));
    },
    set_pay: function(evt){
      var target = evt.target;
      this.model.set('value', target.value);
    },
    set_method: function(evt){
      this.model.set('payment_method_id', evt.target.value);
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.PaymentView = PaymentView;
})(window, document, Backbone, window.$$MIS);
