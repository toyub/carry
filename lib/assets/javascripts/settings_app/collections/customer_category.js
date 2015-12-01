(function(win, doc, Backbone, $$MIS){
  var CustomerCategoryCollection = Backbone.Collection.extend({
    model: $$MIS.CustomerCategory,
    saved_categories: function(except_id){
      return this.filter(function(model){return !model.isNew() && model.get('id') != except_id;})
    }
  });
  win.$$MIS = $$MIS || {};
  win.$$MIS.CustomerCategoryCollection = CustomerCategoryCollection;
})(window, document, Backbone, window.$$MIS);
