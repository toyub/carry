(function(win, doc, Backbone, $$MIS){
  var tmpl = JST['settings/customer_categories/change'];
  var ChangeCustomerCategoriesView = Backbone.View.extend({
    tagName: 'div',
    className: 'batch_convert',
    render: function(){
      var x = {
        category: {id: 23, name: '个人'},
        customers: [{id: 1, name: '小明'}, {id: 2, name: '李磊'}],
        categories: [{id: 2, name: 'VIP'}, {id: 4, name: 'VVIP'}]
      }

      this.$el.html(tmpl(x));
      return this.$el;
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.ChangeCustomerCategoriesView = ChangeCustomerCategoriesView;
})(window, document, Backbone, window.$$MIS);
