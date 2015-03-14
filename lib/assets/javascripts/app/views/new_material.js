(function(win, doc, Backbone, $$MIS){
  var NewMaterialView = Backbone.View.extend({
    events: {
      'change input[name]': "set_del",
      'change #material_category1': 're_render_subs'
    },

    set_del: function(evt){
      var input = evt.currentTarget;
      var name = input.name.match(/\[(.*)\]/)[1];
      if(!!name){
        this.model.set(name, input.value);
      }
    },

    re_render_subs: function(evt, data){
      var this_el = this.$el;
      this.category_collection.sub_categories(data.value, function(c, r, opt){
        this_el.find('input[name="material[store_material_category_id]"]').val('').trigger('change');
        this_el.find("span[data-select='#material_category_select']").html('请选择');
        this_el.find("#material_category_select > ol").html(this.to_options());
      })
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.NewMaterialView = NewMaterialView;
})(window, document, Backbone, window.$$MIS);