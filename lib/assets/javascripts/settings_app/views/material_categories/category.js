(function(win, doc, Backbone, $$MIS){
  var tmpl = JST["settings/material_categories/category"];
  var MaterialCategoryView = Backbone.View.extend({
    tagName: 'div',
    className: 'main_category',
    render: function(){
      this.$el.html(tmpl({}));
      var form_view = new $$MIS.MaterialCategoriesFormView({model: this.model});
      form_view.setElement(this.$el.find('.root'));
      form_view.render();
      return this.$el;
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.MaterialCategoryView = MaterialCategoryView;
})(window, document, Backbone, window.$$MIS);
