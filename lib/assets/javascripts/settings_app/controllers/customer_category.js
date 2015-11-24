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
      this.form_view = new $$MIS.CustomerCategoryFormView({model: this.model});
      $('#categories').append(this.form_view.render());
      this.name_el = $('<li>').html('新建客户类别');
      $('#categories_names').append(this.name_el);
      var _this = this;
      this.name_el.on('click', function(){
        $('.customer_setting_wrap').hide();
        $('.selected').removeClass('selected');
        _this.name_el.addClass('selected');
        _this.form_view.$el.show();
      })
    }
  };

  win.$$MIS = $$MIS || {};
  win.$$MIS.CustomerCategoriesController = Controller;
})(window, document, jQuery, window.$$MIS);
