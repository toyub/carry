(function(win, doc, Backbone, $$MIS){
  var tmpl = JST["pos/cashier/checkouts/payment"];
  var PaymentView = Backbone.View.extend({
    tagName: 'dl',
    events: {
      'change input': 'set_pay',
      'change select': 'set_method'
    },

    initialize: function(){
      this.listenTo(this.model, 'update', this.rerender);
      this.listenTo(this.model, 'destroy', this.remove);
      this.listenTo(this.model, 'hang!', this.hanging);
      this.listenTo(this.model, 'not:hang!', this.nothang);
    },

    render: function(){
      var _attrs = this.model.attrs();
      this.$el.html(tmpl(_attrs))
      return this.$el;
    },
    rerender: function(){
      this.render();
    },
    set_pay: function(evt){
      var target = evt.target;
      this.model.set('amount', parseFloat(target.value));
    },
    set_method: function(evt){
      this.model.set_method(evt.target.value);
    },
    hanging: function(){
      this.trigger('hang!');
    },
    nothang: function(){
      this.trigger('not:hang!');
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.PaymentView = PaymentView;
})(window, document, Backbone, window.$$MIS);
