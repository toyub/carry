(function(win, doc, Backbone, $$MIS){
  var Material = Backbone.Model.extend({
    defaults: {

    },
    validate: function(attrs, options){
      if(!attrs.barcode || attrs.barcode.length == 13){
        return 'Invalid barcode!';
      }
    },
    save: function(){console.log(null)},
    invalid_handle: function(model, error){console.log(model, error)}
  });
  win.$$MIS = $$MIS || {};
  win.$$MIS.Material = Material;
})(window, document, Backbone, window.$$MIS);