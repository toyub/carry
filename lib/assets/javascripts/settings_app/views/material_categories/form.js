(function(win, doc, Backbone, $$MIS){
  var tmpl = JST['settings/material_categories/form'];
  var MaterialCategoriesFormView = Backbone.View.extend({
    events: {
      'click .save_btn': 'save',
      'click .cancel_btn': 'cancel'
    },
    render: function(){
      this.$el.html(tmpl(this.model.attributes));
      return this.$el;
    },
    save: function(){
      var name = this.$el.find('.category_name').val();
      console.log(this)
    },
    cancel: function(){
      console.log(this)
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.MaterialCategoriesFormView = MaterialCategoriesFormView;
})(window, document, Backbone, window.$$MIS);
