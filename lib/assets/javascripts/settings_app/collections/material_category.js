(function(win, doc, Backbone, $$MIS){
  var MaterialCategoryCollection = Backbone.Collection.extend({
    model: $$MIS.MaterialCategory
  });
  win.$$MIS = $$MIS || {};
  win.$$MIS.MaterialCategoryCollection = MaterialCategoryCollection;
})(window, document, Backbone, window.$$MIS);
