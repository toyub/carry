(function(win, doc, Backbone, $$MIS){
  var Position = Backbone.Model.extend({
    defaults: {
      store_staff: []
    }
  });
  win.$$MIS = $$MIS || {};
  win.$$MIS.Position = Position;
})(window, document, Backbone, window.$$MIS);
