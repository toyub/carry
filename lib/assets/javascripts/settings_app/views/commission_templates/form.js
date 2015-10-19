
(function(win, doc, Backbone, $$MIS){
  var form_templ = JST['settings/commission_templates/new/form'];
  var templs = [
                JST['settings/commission_templates/sections/mode0'],
                JST['settings/commission_templates/sections/mode1'],
                JST['settings/commission_templates/sections/mode2']
              ];
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
    },
    container: function(){
      if(!this._$container){
        this._$container = this.$el.find('[data-id=container]');
        this._container = this._$container[0];
      }
      return this._$container;
    },
    render: function(){
      this.$el.html(form_templ(this.model.attrs()));
      return this.$el;
    },
    rerender:function(){
      this.$el.html(form_templ(this.model.attrs()));
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
      var container = this.$el.find('#container');
      container.html('');
      this.render_sections();
    },
    render_sections: function(){
      var mode_id = this.model.get('mode_id');
      if(mode_id == 0){
        var html = templs[0](this.model.sections0().attributes);
        this.container().html(html)
        this._container.className = 'regular_ticheng do_ticheng_setting';
      }else if(mode_id == 1){
        var sections = this.model.sections1().map(function(section){
          return section.attributes;
        });
        var html = templs[1]({sections: sections});
        this.container().html(html)
        this._container.className = 'ladder_ticheng do_ticheng_setting';
      }else if(mode_id == 2){
        var sections = this.model.sections2().map(function(section){
          return section.attributes;
        });
        var html = templs[2]({sections: sections});
        this.container().html(html)
        this._container.className = 'period_ticheng do_ticheng_setting';
      }

    },
    save: function(evt){
      evt.preventDefault();
      var s = this.$el.find('[name^=template]').serializeJSON();
      this.model.set(s.template)
      this.model.sections = new $$MIS.CommissionTemplateSectionCollection(this.model.attributes.sections_attributes)
      if(!this.model.saved){
        this.create();
      }else{
        this.update();
      }
    },
    create: function(){
      var attrs = this.model.attrs();
      attrs.idx = this.aim_div.children().length + 1;
      attrs.viewid = this.cid;
      this.aim_div.append(summary(attrs));
      this.$el.hide();
      $("#pop").hide();
    },
    update: function(){
      this.aim_div.find('ul[data-id='+view.cid + ']').html(summary_tmpl(this.model.attrs()));
      this.$el.hide();
      $("#pop").hide();
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
