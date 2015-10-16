
(function(win, doc, Backbone, $$MIS){
  var form_templ = JST['settings/commission_templates/new/form'];
  var methods = {
    get:function(method){
      return this[method] || this.type0;
    },
    type0:function(section_view){
      this.$el.find('[data-typeid=0]').html(section_view.render())
    },
    type1:function(section_view){
      this.$el.find('[data-typeid=1] > div > div.lists_content').append(section_view.render());
    },
    type2:function(section_view){
      this.$el.find('[data-typeid=2] > div > div.lists_content').append(section_view.render());
    }
  }
  var CommissionTemplateFormView = Backbone.View.extend({
    tagName: 'div',
    className: 'list_new_page',
    events: {
      'click .type': 'change_mode',
      'change .aim': 'change_aim',
      'click .new_list': 'add_section',
      'click input.save_btn': 'save'
    },
    render: function(){
      console.log(this.model)
      this.$el.html(form_templ(this.model));
      return this.$el;
    },
    change_mode: function(evt){
      var btn = evt.target;
      this.model.set('mode_id', btn.value);
      var container = this.$el.find('[data-typeid='+ this.model.get('mode_id') +']');
      this.$el.find('[data-typeid]').hide();
      container.show();
    },
    change_aim: function(evt){
      var target = evt.target;
      this.model.set('aim_to', target.value);
    },
    add_section: function(){
      this.model.add_section();
    },
    render_section: function(section_view){
      methods.get('type'+this.model.get('mode_id')).call(this, section_view);
    },
    save: function(){
      console.log(this.model)
      this.trigger('saved');
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.CommissionTemplateFormView = CommissionTemplateFormView;
})(window, document, Backbone, window.$$MIS);
