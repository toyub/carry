(function(win, doc, Backbone, $$MIS){
  var CustomerCategory = Backbone.Model.extend({
    defaults: {
      color: '#000000'
    },
    attrs: function(){
      var _attrs = _.clone(this.attributes);
      _attrs.material_categories = this.material_categories;
      _attrs.service_categories = this.service_categories;
      return _attrs;
    },
    set_attrs: function(attrs){
      var _this_attrs = _.clone(this.attributes);
      this.set($.extend(true, {}, _this_attrs, attrs));
      console.log(this.attributes)
    },
    get_material_categories_discount: function(id){
      return this.attributes.discounts.material_root_categories[id];
    },
    get_services_discount: function(id){
      return this.attributes.discounts.service_root_categories[id];
    }
  });
  win.$$MIS = $$MIS || {};
  win.$$MIS.CustomerCategory = CustomerCategory;
})(window, document, Backbone, window.$$MIS);
