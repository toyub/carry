(function(win, doc, Backbone, $$MIS){
  var tmpl = JST['settings/material_categories/form'];
  var MaterialCategoryFormView = Backbone.View.extend({
    events: {
      'submit form': 'save',
      'click .cancel_btn': 'cancel',
      'click input.category_name[readonly]': 'edit'
    },
    render: function(){
      this.$el.html(tmpl(this.model.attributes));
      if(this.model.isNew()){
        this.$el.addClass('editing');
        this.$el.find('.category_name').removeAttr('readonly');
        this.$el.find('.category_name')[0].focus();
      }
      return this.$el;
    },
    save: function(evt){
      evt.preventDefault();
      var name = this.$el.find('.category_name').val();
      this.model.set({name: name});
      var _this = this;
      this.model.save('name', name, {
        success: function(){

          _this.$el.removeClass('editing');
          _this.$el.find('.category_name').attr('readonly', true)
          if(_this.model.isSub()){
            _this.trigger('save:sub');
          }
        },
        error: function(){
          ZhanchuangAlert('保存失败，请重试!');
        }
      });

    },

    edit: function(evt){
      var name_input = evt.target;
      name_input.removeAttribute('readonly');
      this.$el.addClass('editing');
    },

    cancel: function(){
      if(this.model.isNew()){
        this.remove();
        if(this.model.isRoot()){
          this.trigger('remove:root');
        }
      }else{
        this.render();
        this.$el.removeClass('editing');
      }

    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.MaterialCategoryFormView = MaterialCategoryFormView;
})(window, document, Backbone, window.$$MIS);
