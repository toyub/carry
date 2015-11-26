(function(win, doc, Backbone, $$MIS){
  var PositionCollection = Backbone.Collection.extend({
    model: $$MIS.Position
  });
  win.$$MIS = $$MIS || {};
  win.$$MIS.PositionCollection = PositionCollection;
})(window, document, Backbone, window.$$MIS);
