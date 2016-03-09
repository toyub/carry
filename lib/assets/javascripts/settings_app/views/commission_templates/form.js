
(function(win, doc, Backbone, $$MIS){
  var form_templ = JST['settings/commission_templates/new/form'];
  var templs = [
                JST['settings/commission_templates/sections/mode0'],
                JST['settings/commission_templates/sections/mode1'],
                JST['settings/commission_templates/sections/mode2']
              ];
  var section_templs = [null, /* template has one mode 0 section */
                        JST['settings/commission_templates/sections/section1'],
                        JST['settings/commission_templates/sections/section2']
                      ];
  var CommissionTemplateFormView = Backbone.View.extend({
    tagName: 'div',
    className: 'list_new_page',
    events: {
      'click .mode': 'change_mode',
      'click .new_list': 'add_section',
      'submit form': 'save',
      'click input.cancel_btn, .do_cancel': 'cancel',
      'click .delete_list': 'delete_section',
      'change [name="template[sharing_enabled]"]':'enable_level_weight'
    },
    initialize: function(opts){
      this.model = opts.model;
      this.aim_div = opts.aim_div;
    },
    container: function(){
      this._$container = this.$el.find('[data-id=container]');
      this._container = this._$container[0];
      return this._$container;
    },
    enable_level_weight: function(evt){
      var target = evt.target;
      if(evt.target.checked){
        this.$el.find('[name^="template[level_weight]"]').removeAttr('disabled');
      }else{
        this.$el.find('[name^="template[level_weight]"]').attr('disabled', true);
      }
    },
    render: function(){
      this.$el.html(form_templ(this.model.attrs()));
      this.render_sections();
      return this.$el;
    },
    add_section: function() {
      var mode_id = this.model.get('mode_id');
      if(mode_id == 0){return false;}
      var section = this.model.add_section();
      var attrs = section.attrs();
      attrs.idx = this.container().find('.lists_content').children().length + 1;
      this.container().find('.lists_content').append(section_templs[mode_id](attrs));
    },
    delete_section: function(evt){
      var target = evt.target;
      var cid = target.dataset.modelid;
      var ul = target.parentNode.parentNode;
      var section = this.model.sections.find(function(model){return model.cid == cid;});
      if(!this.model.destroy_sections){this.model.destroy_sections = []}

      if(section.isNew()){
        this.model.sections.remove(section);
      }else{
        this.model.destroy_sections.push({
          id: section.id,
          _destroy: true
        });
      }
      ul.remove();
    },
    rerender:function(){
      this.$el.html(form_templ(this.model.attrs()));
      this.render_sections();
    },
    change_mode: function(evt){
      var btn = evt.target;
      this.model.set('mode_id', parseInt(btn.value));
      if(this.model.get('mode_id') == 0){
        if(!this.model.sections0()){
          this.model.sections.add({
            mode_id: 0
          });
        }
      }
      this.render_sections();
    },
    render_sections: function(){
      var mode_id = this.model.get('mode_id');
      var html = '', class_name = '';
      if(mode_id == 0){
        html = templs[0](this.model.sections0().attrs());
        class_name= 'regular_ticheng do_ticheng_setting';
      }else if(mode_id == 1){
        var sections = this.model.sections1().map(function(section){
          return section.attrs();
        });
        html = templs[1]({sections: sections});
        class_name = 'ladder_ticheng do_ticheng_setting';
      }else if(mode_id == 2){
        var sections = this.model.sections2().map(function(section){
          return section.attrs();
        });
        html = templs[2]({sections: sections});
        class_name = 'period_ticheng do_ticheng_setting';
      }else{
        html = mode_id;
      }
      this.container().html(html)
      this._container.className = class_name;
    },
    save: function(evt){
      evt.preventDefault();
      var s = this.$el.find('[name^=template]').serializeJSON({checkboxUncheckedValue: 'false', parseBooleans: true})
      if(!s.template.sections_attributes || s.template.sections_attributes.length < 1){
        ZhanchuangAlert('至少要添加一条提成规则!')
        return false;
      }
      if(this.model.isNew()){
        this.create(s);
      }else{
        this.update(s);
      }
    },
    create: function(s){
      this.model.set(s.template)
      this.model.save();
      this.model.sections = new $$MIS.CommissionTemplateSectionCollection(this.model.attributes.sections_attributes)
      var attrs = this.model.attrs();
      attrs.idx = this.aim_div.children().length + 1;
      attrs.viewid = this.cid;
      this.aim_div.append(summary(attrs));
      this.$el.hide();
      $("#pop").hide();
    },
    update: function(s){
      this.model.set(s.template)
      if(this.model.destroy_sections){
        this.model.attributes.sections_attributes = this.model.attributes.sections_attributes.concat(this.model.destroy_sections);
      }
      this.model.save();
      this.model.sections = new $$MIS.CommissionTemplateSectionCollection(this.model.attributes.sections_attributes)
      var attrs = this.model.attrs();
      attrs.viewid = this.cid;
      attrs.idx = this.aim_div.find('ul[data-id='+ this.model.id + ']').index()+1;
      this.aim_div.find('ul[data-id='+ this.model.id + ']').html(summary_tmpl(attrs));
      this.$el.hide();
      $("#pop").hide();
    },
    cancel: function(){
      $("#pop").hide();
      if(this.model.isNew()){
        this.remove();
        delete this.model;
        delete views[this.cid];
        delete this;
      }else{
        this.$el.hide();
      }
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.CommissionTemplateFormView = CommissionTemplateFormView;
})(window, document, Backbone, window.$$MIS);
