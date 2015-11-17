(function(win, doc, Backbone, $$MIS){
  var tmpl = JST["settings/material_categories/category"];
  var MaterialCategoryView = Backbone.View.extend({
    tagName: 'div',
    className: 'main_category',
    events: {
      'click .new_second_category': 'add_sub',
      'click .show_details': 'toggle_details'
    },
    render: function(){
      this.$el.html(tmpl({}));
      var form_view = new $$MIS.MaterialCategoriesFormView({model: this.model});
      form_view.setElement(this.$el.find('.root'));
      form_view.render();

      this.subs_ul = this.$el.find('ul.subs');
      return this.$el;
    },
    add_sub: function(){
      var model = new $$MIS.MaterialCategory({parent_id: this.model.get('id')});
      var form_view = new $$MIS.MaterialCategoriesFormView({model: model, el: $('<li>')});
      form_view.render().insertBefore(this.subs_ul.find('.last'));
      form_view.$el.addClass('editing');
    },
    fetch_sub:function(m){
      var model = new $$MIS.MaterialCategory(m);
      var form_view = new $$MIS.MaterialCategoriesFormView({model: model, el: $('<li>')});
      form_view.render().insertBefore(this.subs_ul.find('.last'));
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
