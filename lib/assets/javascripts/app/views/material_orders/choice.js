(function(win, doc, Backbone, $$MIS){
  var ChoiceView = Backbone.View.extend({
    tagName: 'tr',
    events: {
      'input .price': 'recalc',
      'input .quantity': 'recalc'
    },
    template: JST["kucun/material_orders/new/choice"],
    render: function(){
      this.$el.html(this.template(this.model.attributes));
      return this.$el;
    },
    recalc: function(evt){
      console.log(this, evt)
    }
  });
  win.$$MIS.MaterialOrderChoiceView = ChoiceView;
})(window, document, Backbone, window.$$MIS);
