(function(win, doc, Backbone, $$MIS){
  var NewOrderView = Backbone.View.extend({
    events: {
      'click div.text_div': 'show_search'
    },
    initialize: function(){
      this.search_view = new $$MIS.MaterialOrderSearchView({
        el: $('#pop_choose_goods'),
        resultList: $('#storage_tab'),
        materials: new $$MIS.MaterialCollection(),
        choices: new $$MIS.MaterialCollection()
      });


      var self = this;

      new_m_v = new $$MIS.NewMaterialView({
                                           el: $('#pop_new_material'),
                                           model: new $$MIS.Material()
                                         });

      new_m_v.category_collection = new  $$MIS.MaterialCategoryCollection();
      new_m_v.model.view = new_m_v;
      new_m_v.model.on('invalid', new_m_v.invalid_handle);

      this.search_view.on('done', function(els){
        self.rerender(els);
      })

      var pop_new_material_form = $("#pop_new_material form")[0];



      this.search_view.$el.on("click", '.new_btn', function(event){
        new_m_v.$el.show();
        self.search_view.$el.hide();
      });

      new_m_v.$el.on('submit', 'form', function(evt){
        evt.preventDefault();
        if(!new_m_v.model.isValid()){
          return false;
        }
        new_m_v.$el.hide();
        self.search_view.$el.show();
        self.search_view.materials.add(new_m_v.model.clone())
        return false;
      })

      new_m_v.$el.on("click", '.doclose,.cancel_btn', function(event){
        pop_new_material_form.reset();
        new_m_v.model.clear();
        new_m_v.$el.hide();
        self.search_view.$el.show();
      });


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
      $('#storage_tab > tfoot > tr >td:eq(9)').html(total_amount);
      this.set_debt(total_amount);
    },
    set_debt: function(debt){
      $('#debt').val(debt);
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
