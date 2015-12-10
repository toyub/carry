(function(win, doc, Backbone, $$MIS){
  var order_summary_tmpl = JST["pos/cashier/checkouts/order_summary"];
  var CashierOrderSummaryView = Backbone.View.extend({
    tagName: 'li',
    events: {
      'click ': 'show'
    },
    render: function(){
      this.$el.html(order_summary_tmpl(this.model.attributes));
      if(this.model.attributes.status  == 0){
        $("#queuing").append(this.$el);
      }else if(this.model.attributes.status == 1){
        $("#progressing").append(this.$el);
      }else if(this.model.attributes.status == 2){
        $("#paying").append(this.$el);
      }else if(this.model.attributes.status == 3){
        $("#finished").append(this.$el);
      }
    },
    show: function(){
      this.trigger('show')
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.CashierOrderSummaryView = CashierOrderSummaryView;
})(window, document, Backbone, window.$$MIS);
