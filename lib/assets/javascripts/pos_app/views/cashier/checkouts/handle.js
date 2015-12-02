(function(win, doc, Backbone, $$MIS){
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
      
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.CashierCheckoutsHandleView = CashierCheckoutsHandleView;
})(window, document, Backbone, window.$$MIS);
