(function(win, doc, Backbone, $$MIS){
  var order_tmpl = JST["pos/cashier/checkouts/order"];
  var CashierOrderDetailView = Backbone.View.extend({
    tagName: 'div',
    events: {
      
    },
    render: function(){
      this.$el.html(order_tmpl(this.model.attributes));
    },
    show: function(){
      this.render();
      $('.cashiering_vehicle_order').append(this.$el)
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.CashierOrderDetailView = CashierOrderDetailView;
})(window, document, Backbone, window.$$MIS);
