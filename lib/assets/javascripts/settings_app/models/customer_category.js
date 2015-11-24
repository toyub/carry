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
      console.log(this.attributes,attrs)
      console.log(_.extend(this.attributes, attrs))
    }
  });
  win.$$MIS = $$MIS || {};
  win.$$MIS.CustomerCategory = CustomerCategory;
})(window, document, Backbone, window.$$MIS);
