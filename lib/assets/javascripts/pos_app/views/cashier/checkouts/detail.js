(function(win, doc, Backbone, $$MIS){
  var order_tmpl = JST["pos/cashier/checkouts/order"];
  var payment_methods_tmpl = JST["pos/cashier/checkouts/payment_methods"];
  var CashierOrderDetailView = Backbone.View.extend({
    tagName: 'div',
    className: 'float-left order-detail',
    events: {
      'click .js-checkout': 'checkout',
      'click .add_method': 'add_payment_method'
    },
    initialize: function(){
      this.listenTo(this.model, 'change', this.rerender)
    },
    render: function(){
      this.$el.html(order_tmpl(this.model.attributes));
      $('.cashiering').append(this.$el)
    },
    rerender: function(){
      this.$el.html(order_tmpl(this.model.attributes));
    },
    checkout: function(evt){
      this.model.fetch()
    },
    add_payment_method: function(){
      this.$el.find('.payment_method').append(payment_methods_tmpl());
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.CashierOrderDetailView = CashierOrderDetailView;
})(window, document, Backbone, window.$$MIS);
