(function(win, doc, Backbone, $$MIS){
  var Position = Backbone.Model.extend({
    defaults: {}
  });
  win.$$MIS = $$MIS || {};
  win.$$MIS.Position = Position;
})(window, document, Backbone, window.$$MIS);
