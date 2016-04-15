(function(win, doc, Backbone, $$MIS){
  var order_tmpl = JST['pos/cashier/checkouts/order'];
  var CashierCheckoutsHandleView = Backbone.View.extend({
    el: 'body',
    events: {
      'click .vehicle_operating .lnr': 'toggle_orders',
      'click .search_nav .query_btn': 'search'
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

    search: function() {
      var _this = this;
      var license_number = $('.query-by-license').val();
      this.orders.fetch({
        data: {
          license_number: license_number,
        },
        success:function(){
          _this.update_counts()
        }
      });
    },

    show_summary: function(model, collection, xhr, undef){
      var _this = this;
      var c = new $$MIS.OrdersController(model, this.urlRoot);
      c.summary();
      c.onchecked = function(){
        _this.update_counts();
      };
    },
    fetch_order: function(){
      var _this = this;
      this.orders.fetch({
        success:function(collection, response, options){
          $("#loading").hide();
          _this.update_counts();
        },
        error: function(collection, response, options){
        }
      });
    },
    update_counts: function(){
      var counts = this.orders.counts();
      $('#queuing_count').html(counts.queuing);
      $('#finished_count').html(counts.finished);
    }

  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.CashierCheckoutsHandleView = CashierCheckoutsHandleView;
})(window, document, Backbone, window.$$MIS);
