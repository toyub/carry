(function(win, doc, Backbone, $$MIS){
  var tmpl = JST["settings/material_categories/category"];
  var MaterialCategoryView = Backbone.View.extend({
    tagName: 'div',
    className: 'main_category',
    events: {
      'click .new_second_category': 'add_sub',
      'click .show_details': 'toggle_details'
    },
    initialize: function(){
      this.model.sub_categories = new $$MIS.MaterialCategoryCollection();
    },
    render: function(){
      var idx = $('.categories').children('.main_category').length + 1;
      this.$el.html(tmpl({idx: idx}));
      var _this = this;
      var form_view = new $$MIS.MaterialCategoryFormView({model: this.model});
      form_view.setElement(this.$el.find('.root'));
      form_view.render();
      form_view.on('remove:root', function(){
        _this.remove();
      });

      this.listenTo(this.model.sub_categories, 'add', this.subfor)

      this.subs_ul = this.$el.find('ul.subs');
      return this.$el;
    },
    mount_subs: function(){
      var _this = this;
      this.model.attributes.sub_categories.forEach(function(m, idx){
        _this.fetch_sub(m);
      });
      this.count_sub();
      delete this.model.attributes.sub_categories;
    },
    count_sub:function(sub_string){
      this.$el.find('.show_subcategories').html(this.sub_names());
      this.$el.find('.count_categories').html(this.model.sub_categories.length);
    },

    sub_names: function(){
      return this.model.sub_categories.map(function(model, idx, collection){
        return model.get('name');
      }).join(', ');
    },

    subfor: function(model, collection, etypes, undef){
      this.count_sub();
    },

    add_sub: function(){
      if(this.model.isNew()){
        ZhanchuangAlert('请先保存类别');
        return false;
      }
      var _this = this;
      var model = new $$MIS.MaterialCategory({parent_id: this.model.get('id')});
      model.urlRoot = this.model.urlRoot;
      var form_view = new $$MIS.MaterialCategoryFormView({model: model, el: $('<li>')});
      form_view.render().insertBefore(this.subs_ul.find('.last'));
      form_view.$el.addClass('editing');
      form_view.on('save:sub', function(){
        _this.model.sub_categories.add(this.model);
      });
    },
    fetch_sub:function(m){
      var model = new $$MIS.MaterialCategory(m);
      model.urlRoot = this.model.urlRoot;
      var form_view = new $$MIS.MaterialCategoryFormView({model: model, el: $('<li>')});
      form_view.render().insertBefore(this.subs_ul.find('.last'));
      this.model.sub_categories.add(model);
    },
    toggle_details: function(evt){
      if(this.model.isNew()){
        ZhanchuangAlert('请先保存类别');
        return false;
      }
      var btn = evt.target;
      if(btn.classList.contains('lnr-chevron-down')){
        this.$el.find('.category_details').show();
        btn.classList.remove('lnr-chevron-down');
        btn.classList.add('lnr-chevron-up')
      }else{
        this.$el.find('.category_details').hide();
        btn.classList.remove('lnr-chevron-up');
        btn.classList.add('lnr-chevron-down');
      }

    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.MaterialCategoryView = MaterialCategoryView;
})(window, document, Backbone, window.$$MIS);
