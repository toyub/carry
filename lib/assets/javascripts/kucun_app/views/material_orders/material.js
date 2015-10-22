(function(win, doc, Backbone, $$MIS){
  var MaterialView = Backbone.View.extend({
    tagName: 'div',
    className: 'list_content list_tr',
    events: {
      'click .checkbox': 'toggleChoose'
    },
    render: function(){
      this.$el.html(this.template(this.model.attributes));
      return this;
    },
    toggleChoose: function(){
      this.model.set("chosen", !this.model.get('chosen'));
    },
    template: JST["kucun/material_orders/new/search"]
  });
  win.$$MIS.OrderMaterialView = MaterialView;
})(window, document, Backbone, window.$$MIS);
