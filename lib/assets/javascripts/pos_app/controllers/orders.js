(function(win, doc, $, $$MIS){

  function OrdersController(model, urlRoot){
    this.model = model;
    this.model.urlRoot = urlRoot;
    this.summary_view = new $$MIS.CashierOrderSummaryView({model: this.model});
    var _this = this;
    this.summary_view.on('show', function(){
      _this.show_detail();
    });
    this.onchecked = function(){}
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
        this.model.fetch({
          success:function() {
            _this.detail_view = new $$MIS.CashierOrderDetailView({model: _this.model});
            _this.detail_view.render();
            _this.detail_view.on('checked', function(response){
              _this.after_check(response);
            });
            _this.detail_view.$el.show();
          }
        })
      }else{
        this.detail_view.$el.show();
      }
      
    },
    after_check: function(result){
      if(result.checked){
        this.model.fetch();
        this.onchecked.call();
      }else{

      }
    }
  };
  win.$$MIS.OrdersController = OrdersController;
})(window, document, $, window.$$MIS);
