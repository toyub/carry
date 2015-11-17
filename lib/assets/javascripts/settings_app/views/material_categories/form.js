(function(win, doc, Backbone, $$MIS){
  var tmpl = JST['settings/material_categories/form'];
  var MaterialCategoriesFormView = Backbone.View.extend({
    events: {
      'submit form': 'save',
      'click .cancel_btn': 'cancel',
      'click input.category_name[readonly]': 'edit'
    },
    render: function(){
      this.$el.html(tmpl(this.model.attributes));
      return this.$el;
    },
    save: function(evt){
      evt.preventDefault();
      var name = this.$el.find('.category_name').val();

      this.model.set({name: name});
      this.$el.removeClass('editing');
      this.$el.find('.category_name').attr('readonly', true)
    },

    edit: function(evt){
      var name_input = evt.target;
      name_input.removeAttribute('readonly');
      this.$el.addClass('editing');
    },

    cancel: function(){
      if(this.model.isNew()){
        this.remove();
      }else{
        this.render();
        this.$el.removeClass('editing');
      }

    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.MaterialCategoriesFormView = MaterialCategoriesFormView;
})(window, document, Backbone, window.$$MIS);
