
(function(win, doc, Backbone, $$MIS){
  var MaterialCollection = Backbone.Collection.extend({
    model: $$MIS.Material
  });
  win.$$MIS.MaterialCollection = MaterialCollection;
})(window, document, Backbone, window.$$MIS);
