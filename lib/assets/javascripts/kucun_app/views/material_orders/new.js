(function(win, doc, Backbone, $$MIS){
  var NewOrderView = Backbone.View.extend({
    events: {
      'click div.add_material': 'show_search',
      'change #downpayment': 'set_debt'
    },
    initialize: function(){
      var self = this;
      this.search_view = new $$MIS.MaterialOrderSearchView({
        el: $('#pop_choose_goods'),
        resultList: $('#storage_tab'),
        materials: new $$MIS.MaterialCollection(),
        choices: new $$MIS.MaterialCollection()
      });
      this.search_view.on('done', function(els){
        self.rerender(els);
      })
      this.listenTo(this.search_view.choices, 'all', this.calc_total);
    },
    rerender:function(els){
      els.forEach(function(el){
        $('#storage_tab .handle').before(el);
      });

      this.calc_total();
    },
    calc_total: function(){
      var total_quantity=0,total_amount = 0;
      this.$('#storage_tab > tbody >tr:not(:last)').each(function(){
        var quantity = parseInt(this.children[8].children[0].value);
        var amount = this.children[7].children[0].value * quantity;
        total_quantity += quantity;
        total_amount += amount;
      });
      $('#storage_tab > tfoot > tr >td:eq(8)').html(total_quantity);
      $('#storage_tab > tfoot > tr >td:eq(9)').html(total_amount.toFixed(2));
      this.set_debt();
      $('#downpayment').attr('max', total_amount);
      this.total_amount = total_amount;
    },
    set_debt: function(){
      var debt = this.total_amount - (parseFloat($('#downpayment').val())||0);
      $('#debt').val(debt.toFixed(2));
    },
    show_search: function(){
      this.search_view.$el.show();
    },
    loadWith: function(material){
      var model = new $$MIS.Material(material)
      var view = new $$MIS.MaterialOrderChoiceView({
        model: model
      });
      view.model.set('price', model.get('cost_price'));
      view.model.set('quantity', 1);
      this.search_view.choices.add(view.model);
      this.rerender([view.render()]);
    }

  });
  win.$$MIS.NewMaterialOrderView = NewOrderView;
})(window, document, Backbone, window.$$MIS);
