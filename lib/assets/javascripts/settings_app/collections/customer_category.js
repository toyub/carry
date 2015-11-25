(function(win, doc, Backbone, $$MIS){
  var CustomerCategoryCollection = Backbone.Collection.extend({
    model: $$MIS.CustomerCategory
  });
  win.$$MIS = $$MIS || {};
  win.$$MIS.CustomerCategoryCollection = CustomerCategoryCollection;
})(window, document, Backbone, window.$$MIS);
