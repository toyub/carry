(function(win, doc, Backbone, $$MIS){
  var order_tmpl = JST["pos/cashier/checkouts/order"];
  var CashierOrderDetailView = Backbone.View.extend({
    tagName: 'div',
    className: 'float-left',
    events: {
      'click .js-checkout': 'checkout'
    },
    initialize: function(){
      this.listenTo(this.model, 'change', this.rerender)
    },
    render: function(){
      this.$el.html(order_tmpl(this.model.attributes));
    },
    rerender: function(){
      console.log(this)
    },
    show: function(){
      this.render();
      $('.cashiering').append(this.$el)
    },
    checkout: function(evt){
      this.model.fetch()
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.CashierOrderDetailView = CashierOrderDetailView;
})(window, document, Backbone, window.$$MIS);
