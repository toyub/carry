(function(win, doc, Backbone, $$MIS){
  var CustomerCategory = Backbone.Model.extend({
    defaults: {
      color: '#000000',
      conditions: {profile_integrity_percentage: 0},
      privileges:{},
      discounts:{}
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
    },
    get_material_categories_discount: function(id){
      if(this.attributes.discounts && this.attributes.discounts.material_root_categories){
        return this.attributes.discounts.material_root_categories[id] || {};
      }else{
        return {};
      }

    },
    get_services_discount: function(id){
      if(this.attributes.discounts && this.attributes.discounts.service_root_categories){
        return this.attributes.discounts.service_root_categories[id] || {};
      }else{
        return {};
      }
    },
    truncated_name: function(){
      var name = this.get('name');
      if(name){
        return name.length > 7 ? (name.slice(0, 5) + '...') : name;
      }
    }
  });
  win.$$MIS = $$MIS || {};
  win.$$MIS.CustomerCategory = CustomerCategory;
})(window, document, Backbone, window.$$MIS);
