
(function(win, doc, Backbone, $$MIS){
  var form_templ = JST['settings/commission_templates/new/form'];
  var methods = {
    get:function(method){
      return this[method] || this.mode0;
    },
    mode0:function(section_view){
      this.$el.find('[data-modeid=0]').html(section_view.render())
    },
    mode1:function(section_view){
      this.$el.find('[data-modeid=1] > div > div.lists_content').append(section_view.render());
    },
    mode2:function(section_view){
      this.$el.find('[data-modeid=2] > div > div.lists_content').append(section_view.render());
    }
  }
  var CommissionTemplateFormView = Backbone.View.extend({
    tagName: 'div',
    className: 'list_new_page',
    events: {
      'click .mode': 'change_mode',
      'click .new_list': 'add_section',
      'submit form': 'save',
      'click input.cancel_btn, .do_cancel': 'cancel'
    },
    render: function(){
      this.$el.html(form_templ(this.model.attrs()));
      return this.$el;
    },
    rerender:function(){
      this.$el.html(form_templ(this.model.attrs()));
      this.render_sections();
    },
    render_sections: function(){
      var _this = this;
      this.model.sections.models.forEach(function(model){
        var section_view = new $$MIS.CommissionTemplateSectionView({model: model});
        methods.get('mode'+ model.get('mode_id')).call(_this, section_view);
      });
    },
    change_mode: function(evt){
      var btn = evt.target;
      this.model.set('mode_id', parseInt(btn.value));
      if(!this.model.sections0()){
        // this.model.sections.add({
        //   mode_id: 0
        // });
        console.log('do not have ')
      }
      var container = this.$el.find('[data-modeid='+ this.model.get('mode_id') +']');
      this.$el.find('[data-modeid]').hide();
      container.show();
    },
    add_section: function(){
      this.model.add_section();
    },
    render_section: function(section_view){
      methods.get('mode'+this.model.get('mode_id')).call(this, section_view);
    },
    set_confined_to: function(evt){
      this.model.set('confined_to', evt.target.value);
    },
    save: function(evt){
      evt.preventDefault();
      var s = this.$el.find('[name^=template]').serializeJSON();
      this.model.set(s.template)
      this.model.sections = new $$MIS.CommissionTemplateSectionCollection(this.model.attributes.sections_attributes)
      if(!this.model.saved){
        this.trigger('saved');
        this.model.saved = true;
      }else{
        this.trigger('updated');
      }

    },
    cancel: function(){
      this.trigger('cancel');
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.CommissionTemplateFormView = CommissionTemplateFormView;
})(window, document, Backbone, window.$$MIS);
