(function(win, doc, $, $$MIS){

  function Controller(model, handle){
    if(!model){
      this.model = new $$MIS.CustomerCategory();
    }else {
      this.model = model;
    }

    this.handle = handle;
    this.model.urlRoot = this.handle.urlRoot;
    this.model.material_categories = this.handle.material_categories;
    this.model.service_categories = this.handle.service_categories;
  }

  Controller.prototype = {
    constructor: Controller,
    show: function(){
      this.set_name_el();
      this.set_form_view();
      $('.selected').removeClass('selected');
      this.name_el.addClass('selected');
    },

    set_form_view: function(){
      this.form_view = new $$MIS.CustomerCategoryFormView({model: this.model});
      $('#categories').append(this.form_view.render());
      var _this = this;
      this.form_view.on('saved', function(){
        _this.render_name_el();
      });
      this.form_view.on('reseted', function(){
        if(this.model.isNew()){
          _this.form_view.remove();
          _this.name_el.remove();
        }else{
          _this.render_name_el();
        }
      });
    },

    render_name_el: function(){
      this.name_el.html(this.model.truncated_name() || '新建类别').attr('title', this.model.get('name'));
    },

    set_name_el: function(){
      this.name_el = $('<li>');
      this.render_name_el();
      $('#categories_names').append(this.name_el);
      var _this = this;
      this.name_el.on('click', function(){
        $('.customer_setting_wrap').hide();
        $('.selected').removeClass('selected');
        _this.name_el.addClass('selected');
        if(!_this.form_view){
          _this.set_form_view();
        }
        _this.form_view.$el.show();
        if(_this.model.isNew()){
          $('.button.delete').addClass('disabled');
        }else{
          $('.button.delete').removeClass('disabled');
        }
      });

      this.name_el.on('click:delete', function(){
        _this.destroy();
      })
    },
    destroy: function(){
      
    }
  };

  win.$$MIS = $$MIS || {};
  win.$$MIS.CustomerCategoriesController = Controller;
})(window, document, jQuery, window.$$MIS);
