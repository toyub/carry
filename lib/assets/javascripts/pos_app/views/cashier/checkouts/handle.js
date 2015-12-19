(function(win, doc, Backbone, $$MIS){
  var order_tmpl = JST['pos/cashier/checkouts/order'];
  var CashierCheckoutsHandleView = Backbone.View.extend({
    el: 'body',
    events: {
      'click .vehicle_operating .lnr': 'toggle_orders'
    },
    initialize: function(opt){
      this.urlRoot = opt.urlRoot;
      this.orders = new $$MIS.OrderCollection();
      this.orders.url = this.urlRoot;
      this.fetch_order();
      this.listenTo(this.orders, 'add', this.show_summary);
    },
    toggle_orders: function(evt){
      var $target = $(evt.target);
      if($target.hasClass('lnr-chevron-up')){
        $target.removeClass('lnr-chevron-up');
        $target.addClass('lnr-chevron-down');
        $target.parents('div.vehicle_operating').next('ul').slideUp();
      }else{
        $target.removeClass('lnr-chevron-down');
        $target.addClass('lnr-chevron-up');
        $target.parents('div.vehicle_operating').next('ul').slideDown();
      }
    },

    show_summary: function(model, collection, xhr, undef){
      var c = new $$MIS.OrdersController(model, this.urlRoot);
      c.summary();
    },
    fetch_order: function(){
      $('#queuing').html('');
      $('#progressing').html('');
      $('#paying').html('');
      $('#finished').html('');
      var _this = this;
      this.orders.fetch({
        success:function(collection, response, options){
          var counts = _this.orders.counts();
          $('#queuing_count').html(counts.queuing);
          $("#progressing_count").html(counts.progressing);
          $('#paying_count').html(counts.paying);
          $('#finished_count').html(counts.finished);
        },
        error: function(collection, response, options){

        }
      });
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.CashierCheckoutsHandleView = CashierCheckoutsHandleView;
})(window, document, Backbone, window.$$MIS);
