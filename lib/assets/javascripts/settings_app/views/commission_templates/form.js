
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
    initialize: function(opts){
      this.model = opts.model;
      this.aim_div = opts.aim_div;
      this.listenTo(this.model.sections, 'add', function(section, sections, options) {
        var section_view = new $$MIS.CommissionTemplateSectionView({model: section});
        this.render_section(section_view);
      });

      this.on('saved', function(){
        var attrs = this.model.attrs();
        attrs.idx = this.aim_div.children().length + 1;
        attrs.viewid = this.cid;
        this.aim_div.append(summary(attrs));
        this.$el.hide();
        $("#pop").hide();
      });

      this.on('updated', function(){
        this.aim_div.find('ul[data-id='+view.cid + ']').html(summary_tmpl(this.model.attrs()));
        this.$el.hide();
        $("#pop").hide();
      });
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
        _this.render_section(section_view);
      });
    },
    change_mode: function(evt){
      var btn = evt.target;
      this.model.set('mode_id', parseInt(btn.value));
      if(this.model.get('mode_id') == 0){
        if(!this.model.sections0()){
          this.model.sections.add({
            mode_id: 0
          })
        }
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
      $("#pop").hide();
      if(this.model.saved){
        this.$el.hide();
      }else{
        this.remove();
        delete this.model;
        delete views[this.cid];
        delete this;
      }
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.CommissionTemplateFormView = CommissionTemplateFormView;
})(window, document, Backbone, window.$$MIS);
