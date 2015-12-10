(function(win, doc, $, $$MIS){
  function OrdersController(model){
    this.model = model;
    this.summary_view = new $$MIS.CashierOrderSummaryView({model: this.model});
    this.summary_view.on('show', this.show_detail)
  }

  OrdersController.prototype={
    constructor: OrdersController,
    summary: function(){
      return this.summary_view.render();
    },
    show_detail: function(){
      console.log(this)
    }
  };
  win.$$MIS.OrdersController = OrdersController;
})(window, document, $, window.$$MIS);
