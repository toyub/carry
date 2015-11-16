(function(win, doc, Backbone, $$MIS){
  var section_form_tmpl = JST['kucun/trackings/new/form'];
  var section_summary_templ = JST['kucun/trackings/new/summary'];
  var attrs_for_reset = {};
  var MaterialTrackingSectionView = Backbone.View.extend({
    tagName: 'div',
    className: 'add_visit',
    events: {
      'click .save_btn': 'submit',
      'click .cancel_btn': 'cancel',
      'change [name^=section]': 'set_attr'
    },
    set_attr: function(evt){
      var target = evt.target;
      var attr = (/\[(\w+)\]/).exec(target.name)[1];
      this.model.set(attr, target.value);
    },
    cancel: function(){
      this.$el.hide();
      if(this.model.commited || !!this.model.get('id')){
        if(this.model.hasChanged()){
          this.model.set(attrs_for_reset);
        }
      }else{
        this.trigger('removed');
      }
      $(".new_btn").removeClass('disabled');
    },
    submit: function(){
      if(!this.model.isValid()){
        return false;
      }
      var delay = this.model.get('delay_interval');
      var delay_unit = this.model.get('delay_unit');
      var delay_in_seconds = calc_delay(delay, delay_unit);
      this.model.set('delay_in_seconds', delay_in_seconds);
      this.commit();
    },
    commit: function(){
      if(this.model.commited || !!this.model.get('id')){
        this.update();
      }else{
        this.create();
      }
      attrs_for_reset = this.model.attributes;
    },

    create: function(){
      this.model.commited = true;
      this.$el.hide();
      this.trigger('created');
      $(".new_btn").removeClass('disabled');
    },

    update: function(){
      this.$el.hide();
      this.refresh_show();
      $(".new_btn").removeClass('disabled');
    },

    show: function(){
      var _attrs = this.model.attrs();
      _attrs.viewid = this.cid;
      _attrs.modelid = this.model.cid;
      _attrs.idx = this.idx;
      this.summary_el = Summary.tracking_section(_attrs);
      return this.summary_el;
    },
    render: function(){
      this.$el.html(section_form_tmpl(this.model.attributes));
      return this.el;
    },
    refresh_show: function(){
      var _attrs = this.model.attrs();
      _attrs.viewid = this.cid;
      _attrs.modelid = this.model.cid;
      _attrs.idx = this.idx;
      this.summary_el.html(section_summary_templ(_attrs));
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.MaterialTrackingSectionView = MaterialTrackingSectionView;
})(window, document, Backbone, window.$$MIS);
