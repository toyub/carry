(function(win, doc, Backbone, $$MIS){
  var order_summary_tmpl = JST["pos/cashier/checkouts/order_summary"];
  var CashierOrderSummaryView = Backbone.View.extend({
    tagName: 'li',
    events: {
      'click ': 'show'
    },
    initialize: function(){
      this.listenTo(this.model, 'change', this.refresh);
    },
    render: function(){
      this.$el.html(order_summary_tmpl(this.model.attributes));
      if(this.model.queuing()){
        $("#queuing").append(this.$el);
      }else if(this.model.processing()){
        $("#processing").append(this.$el);
      }else if(this.model.paying()){
        $("#paying").append(this.$el);
      }else if(this.model.finished()){
        $("#finished").append(this.$el);
      }
    },
    show: function(){
      this.trigger('show')
    },
    refresh: function(){
      if(this.model.finished()){
        this.$el.remove();
        this.render();
      }
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.CashierOrderSummaryView = CashierOrderSummaryView;
})(window, document, Backbone, window.$$MIS);
