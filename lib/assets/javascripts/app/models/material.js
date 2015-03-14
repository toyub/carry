(function(win, doc, Backbone, $$MIS){
  var Material = Backbone.Model.extend({
    urlRoot:'/kucun/materials',
    defaults: {

    },
    validate: function(attrs, options){
      if(attrs.barcode && attrs.barcode.length != 13){
        return { attr:'barcode', msg:'Invalid barcode!'};
      }
      console.log(attrs)
      if(!attrs.store_material_unit_id){
        return {attr: 'store_material_unit_id', msg: 'unit must must!'}
      }

      if(!attrs.store_material_brand_id){
        return {attr: 'store_material_brand_id', msg: 'brand must must'}
      }

      if(!attrs.store_material_manufacturer_id){
        return {attr: 'store_material_manufacturer_id', msg: 'manufacturer must must'} 
      }

      if(!attrs.store_material_category_id){
        return {attr: 'store_material_category_id', msg: 'category must must'}
      }

    },
    //save: function(){console.log(null)},
    invalid_handle: function(model, error){console.log([model.attributes, error.attr, error.msg])}
  });
  win.$$MIS = $$MIS || {};
  win.$$MIS.Material = Material;
})(window, document, Backbone, window.$$MIS);
