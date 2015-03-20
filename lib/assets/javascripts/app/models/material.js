(function(win, doc, Backbone, $$MIS){
  var Material = Backbone.Model.extend({
    urlRoot:'/kucun/materials',
    defaults: {

    },
    validate: function(attrs, options){
      var errors = [];
      
      if(!attrs.store_material_unit_id){
        errors.push({attr: 'store_material_unit_id', msg: 'unit must must!'});
      }

      if(!attrs.store_material_brand_id){
        errors.push({attr: 'store_material_brand_id', msg: 'brand must must'});
      }

      if(!attrs.store_material_manufacturer_id){
        errors.push({attr: 'store_material_manufacturer_id', msg: 'manufacturer must must'});
      }

      if(!attrs.store_material_category_id){
        errors.push({attr: 'store_material_category_id', msg: 'category must must'});
      }
      if(errors.length > 0){
        return errors;
      }
    }
  });
  win.$$MIS = $$MIS || {};
  win.$$MIS.Material = Material;
})(window, document, Backbone, window.$$MIS);
