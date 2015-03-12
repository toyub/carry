(function(win, doc, Backbone, $$MIS){
  var MaterialCategoryView = Backbone.View.extend({
    events: {
      
    },
    template: _.template('<div>{%=name%}</div>')
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.MaterialCategoryView = MaterialCategoryView;
})(window, document, Backbone, window.$$MIS);