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
    },
    show_search: function(){
      this.search_view.$el.show();
    }

  });
  win.$$MIS.NewMaterialOrderView = NewOrderView;
})(window, document, Backbone, window.$$MIS);
