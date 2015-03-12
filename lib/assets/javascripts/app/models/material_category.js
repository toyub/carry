(function(win, doc, Backbone, $$MIS){
  var MaterialCategory = Backbone.Model.extend({
    urlRoot:'/kucun/material_categories',
    defaults: {

    }
  });
  win.$$MIS = $$MIS || {};
  win.$$MIS.MaterialCategory = MaterialCategory;
})(window, document, Backbone, window.$$MIS);