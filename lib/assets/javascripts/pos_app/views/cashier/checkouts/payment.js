(function(win, doc, Backbone, $$MIS){
  var tmpl = JST["pos/cashier/checkouts/payment"];
  var PaymentView = Backbone.View.extend({
    tagName: 'dl',
    events: {
      'change input': 'set_pay'
    },
    render: function(){
      this.$el.html(tmpl(this.model.attributes))
      return this.$el;
    },
    set_pay: function(evt){
      var target = evt.target;
      this.model.set('value', target.value);
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.PaymentView = PaymentView;
})(window, document, Backbone, window.$$MIS);
