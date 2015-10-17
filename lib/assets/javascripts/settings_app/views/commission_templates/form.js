
(function(win, doc, Backbone, $$MIS){
  var form_templ = JST['settings/commission_templates/new/form'];
  var type0_templ = JST['settings/commission_templates/sections/type0'];
  var type1_templ = JST['settings/commission_templates/sections/type1'];
  var type2_templ = JST['settings/commission_templates/sections/type2'];
  var methods = {
    get:function(method){
      return this[method] || this.type0;
    },
    type0:function(){
      this.$el.find('[data-typeid=0]').html(type0_templ({idx: 1}))
    },
    type1:function(){
      var x = this.model.sections.map(function(model){
        return type1_templ(model);
      });
      this.$el.find('[data-typeid=1] > div > div.lists_content > ul').html(x.join(''))
    },
    type2:function(){
      var x = this.model.sections.map(function(model){
        return type2_templ(model);
      });
      this.$el.find('[data-typeid=2] > div > div.lists_content > ul').html(x.join(''))
    }
  }
  var CommissionTemplateFormView = Backbone.View.extend({
    tagName: 'div',
    className: 'list_new_page',
    events: {
      'click .type': 'change_type'
    },
    render: function(){
      
      this.$el.html(form_templ(this.model));
      methods.get('type'+this.model.get('type_id')).call(this);
      return this.$el;
    },
    change_type: function(evt){
      var btn = evt.target;
      var container = this.$el.find('[data-typeid='+ btn.value +']');
      this.model.set('type_id', btn.value);
      this.$el.find('[data-typeid]').hide();
      container.show();
      methods.get("type"+this.model.get('type_id')).call(this);
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.CommissionTemplateFormView = CommissionTemplateFormView;
})(window, document, Backbone, window.$$MIS);
