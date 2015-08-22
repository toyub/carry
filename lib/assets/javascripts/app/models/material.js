(function(win, doc, Backbone, $$MIS){
  var Material = Backbone.Model.extend({
    urlRoot:'/kucun/materials',
    defaults: {

    },
    validate: function(attrs, options){
      var errors = [];

      if(!attrs.store_material_unit_id){
        errors.push({attr: 'store_material_unit_id', msg: '请选择商品单位!'});
      }

      if(!attrs.store_material_brand_id){
        errors.push({attr: 'store_material_brand_id', msg: '请选择商品品牌'});
      }

      if(!attrs.store_material_manufacturer_id){
        errors.push({attr: 'store_material_manufacturer_id', msg: '请选择商品生产单位'});
      }
      if(!attrs.store_material_root_category_id){
        errors.push({attr: 'store_material_root_category_id', msg: '请选择商品一级类别'});
      }
      if(!attrs.store_material_category_id){
        errors.push({attr: 'store_material_category_id', msg: '请选择商品二级类别'});
      }
      if(errors.length > 0){
        return errors;
      }
    }
  });
  win.$$MIS = $$MIS || {};
  win.$$MIS.Material = Material;
})(window, document, Backbone, window.$$MIS);
