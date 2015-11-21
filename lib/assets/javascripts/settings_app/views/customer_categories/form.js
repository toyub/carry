(function(win, doc, Backbone, $$MIS){
  var tmpl = JST['settings/customer_categories/form'];
  var CustomerCategoryFormView = Backbone.View.extend({
    tagName: 'div',
    className: 'customer_setting_wrap',
    events: {
      'submit form': 'save',
      'reset form': 'reset'
    },
    render: function(){
      this.$el.html(tmpl(this.model.attributes));
      this.name_el = $('<li>').html('新建客户类别');
      return this.$el;
    },
    save: function(evt){
      evt.preventDefault();
      var $form = $(evt.target)
      console.log($form.serializeJSON({checkboxUncheckedValue: 'false', parseBooleans: true}))
    },
    reset: function(evt){
      evt.preventDefault();
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.CustomerCategoryFormView = CustomerCategoryFormView;
})(window, document, Backbone, window.$$MIS);
