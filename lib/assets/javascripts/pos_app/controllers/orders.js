(function(win, doc, $, $$MIS){
  function OrdersController(model, urlRoot){
    this.model = model;
    this.model.urlRoot = urlRoot;
    this.summary_view = new $$MIS.CashierOrderSummaryView({model: this.model});
    this.summary_view.on('show', this.show_detail)
  }

  OrdersController.prototype={
    constructor: OrdersController,
    summary: function(){
      return this.summary_view.render();
    },
    show_detail: function(){
      $('.order-detail').hide();
      if(!this.detail_view){
        this.detail_view = new $$MIS.CashierOrderDetailView({model: this.model});
        this.detail_view.render();
        this.detail_view.on('checked', function(){
          console.log(this, arguments)
        })
      }
      this.detail_view.$el.show();
    }
  };
  win.$$MIS.OrdersController = OrdersController;
})(window, document, $, window.$$MIS);
