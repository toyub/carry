(function(win, doc, Backbone, $$MIS){
  var OrderCollection = Backbone.Collection.extend({
    model: $$MIS.Order,
    counts: function(){
      var _counts = handle.orders.countBy('status');
      return {
        queuing: _counts[0],
        progressing: _counts[1],
        paying: _counts[2],
        finished: _counts[3]
      }
    }
  });
  win.$$MIS.OrderCollection = OrderCollection;
})(window, document, Backbone, window.$$MIS);
