(function(win, doc, Backbone, $$MIS){
  var OrderCollection = Backbone.Collection.extend({
    model: $$MIS.Order,
    counts: function(){
      var _counts = this.countBy('pay_status');
      return {
        queuing: this.numeric(_counts.pay_queuing),
        finished: this.numeric(_counts.pay_finished) + this.numeric(_counts.pay_hanging)
      }
    },
    numeric: function(number) {
      return number === undefined ? 0 : number
    }
  });
  win.$$MIS.OrderCollection = OrderCollection;
})(window, document, Backbone, window.$$MIS);
