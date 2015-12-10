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
      this.listenTo(this.orders,'add', this.load)
      this.orders.fetch();
      this.show_the_1st_order();

      this.orders = new $$MIS.OrderCollection([
            {plate_number: '浙A2232323', amount: 232232.32, status: 0},
            {plate_number: '浙A2232323', amount: 232232.32, status: 0},
            {plate_number: '浙A2232323', amount: 232232.32, status: 0},
            {plate_number: '浙A2232323', amount: 232232.32, status: 1},
            {plate_number: '浙A2232323', amount: 232232.32, status: 1},
            {plate_number: '浙A2232323', amount: 232232.32, status: 1},
            {plate_number: '浙A2232323', amount: 232232.32, status: 2},
            {plate_number: '浙A2232323', amount: 232232.32, status: 2}, 
            {plate_number: '浙A2232323', amount: 232232.32, status: 2},
            {plate_number: '浙A2232323', amount: 232232.32, status: 3},
            {plate_number: '浙A2232323', amount: 232232.32, status: 3},
            {plate_number: '浙A2232323', amount: 232232.32, status: 3}
            ]);
      
      this.initpage();
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

    load: function(model, collection, xhr, undef){
      
    },

    show_the_1st_order: function(){
      var html = order_tmpl();
      $('.cashiering_vehicle_order').html(html);
    },
    initpage: function(){
      this.orders.each(function(model, idx, arr){
        var c = new $$MIS.OrdersController(model)
         c.summary();
      });
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.CashierCheckoutsHandleView = CashierCheckoutsHandleView;
})(window, document, Backbone, window.$$MIS);
