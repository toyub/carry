(function(win, doc, Backbone, $$MIS){
  var OrderCollection = Backbone.Collection.extend({
    model: $$MIS.Order,
    counts: function(){
      var _counts = this.countBy('state');
      return {
        queuing: _counts.queuing,
        finished: _counts.finished
      }
    }
  });
  win.$$MIS.OrderCollection = OrderCollection;
})(window, document, Backbone, window.$$MIS);
