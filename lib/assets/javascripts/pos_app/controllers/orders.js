(function(win, doc, $, $$MIS){
  var checked = function(){}
  function OrdersController(model, urlRoot){
    this.model = model;
    this.model.urlRoot = urlRoot;
    this.summary_view = new $$MIS.CashierOrderSummaryView({model: this.model});
    var _this = this;
    this.summary_view.on('show', function(){
      _this.show_detail();
    });
  }

  OrdersController.prototype={
    constructor: OrdersController,
    summary: function(){
      return this.summary_view.render();
    },
    show_detail: function(){
      $('.order-detail').hide();
      var _this = this;
      if(!this.detail_view){
        this.detail_view = new $$MIS.CashierOrderDetailView({model: this.model});
        this.detail_view.render();
        this.detail_view.on('checked', function(response){
          _this.after_check(response);
        })
      }
      this.detail_view.$el.show();
    },
    after_check: function(result){
      if(result.checked){
        this.model.fetch();
        checked.call();
      }else{

      }
    },
    on: function(callback){
      checked = callback;
    }
  };
  win.$$MIS.OrdersController = OrdersController;
})(window, document, $, window.$$MIS);
