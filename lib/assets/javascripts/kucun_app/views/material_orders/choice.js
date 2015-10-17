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
      var target = evt.target;
      var name = (/\[(\w+)\]/).exec(target.name.replace('store_material_order[items_attributes][]', ''))[1];
      this.model.set(name, target.value);
      this.$el.find('td:eq(9)').html((this.model.get('price') * this.model.get('quantity')).toFixed(2));
    }
  });
  win.$$MIS.MaterialOrderChoiceView = ChoiceView;
})(window, document, Backbone, window.$$MIS);
