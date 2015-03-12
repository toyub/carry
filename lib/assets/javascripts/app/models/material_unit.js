(function(win, doc, Backbone, $$MIS){
  var MaterialUnit = Backbone.Model.extend({
    urlRoot:'/kucun/material_units',
    defaults: {

    }
  });
  win.$$MIS = $$MIS || {};
  win.$$MIS.MaterialUnit = MaterialUnit;
})(window, document, Backbone, window.$$MIS);