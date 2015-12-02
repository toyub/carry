(function(win, doc, Backbone, $$MIS){
  var OrderCollection = Backbone.Collection.extend({
    model: $$MIS.Order
  });
  win.$$MIS.OrderCollection = OrderCollection;
})(window, document, Backbone, window.$$MIS);
