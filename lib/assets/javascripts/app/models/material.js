(function(win, doc, Backbone, $$MIS){
  var Material = Backbone.Model.extend({
    urlRoot:'/kucun/materials',
    defaults: {

    },
    validate: function(attrs, options){
      if(attrs.barcode && attrs.barcode.length != 13){
        return { attr:'barcode', msg:'Invalid barcode!'};
      }

      if(!attrs.unit_id){
        return {attr: 'unit_id', msg: 'unit must must!'}
      }

      if(!attrs.category_id){
        return {attr: 'cost_price', msg: 'category must must!'}
      }

      if(!attrs.brand_id){
        return {attr: 'brand_id', msg: 'brand must must'}
      }

    },
    //save: function(){console.log(null)},
    invalid_handle: function(model, error){console.log(model, error)}
  });
  win.$$MIS = $$MIS || {};
  win.$$MIS.Material = Material;
})(window, document, Backbone, window.$$MIS);
