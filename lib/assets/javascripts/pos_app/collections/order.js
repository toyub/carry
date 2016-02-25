(function(win, doc, Backbone, $$MIS){
  var OrderCollection = Backbone.Collection.extend({
    model: $$MIS.Order,
    counts: function(){
      var _counts = this.countBy('pay_status');
      return {
        queuing: _counts.pay_queuing === undefined ? 0 : _counts.pay_queuing,
        finished: _counts.pay_finished + _counts.pay_hanging
      }
    }
  });
  win.$$MIS.OrderCollection = OrderCollection;
})(window, document, Backbone, window.$$MIS);
