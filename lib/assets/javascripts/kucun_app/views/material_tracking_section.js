(function(win, doc, Backbone, $$MIS){
  var section_form_tmpl = JST['kucun/trackings/new/form'];
  var section_summary_templ = JST['kucun/trackings/new/summary'];

  var MaterialTrackingSectionView = Backbone.View.extend({
    tagName: 'div',
    className: 'add_visit',
    events: {
      'click .save_btn': 'submit',
      'change [name^=section]': 'set_attr'
    },
    set_attr: function(event){
      var target = event.target;
      var attr = (/\[(\w+)\]/).exec(target.name)[1];
      this.model.set(attr, target.value);
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
    },

    create: function(){
      this.commited = true;
      this.$el.hide();
      this.trigger('created');
    },

    update: function(){
      this.$el.hide();
      this.summary_el.html(section_summary_templ(this.model.attrs()));
    },

    show: function(){
      var _attrs = this.model.attrs();
      _attrs.viewid = this.cid;
      _attrs.modelid = this.model.cid;
      this.summary_el = $("<div>")
                        .addClass('list_content list_tr')
                        .html(section_summary_templ(_attrs));
      
      return this.summary_el;
    },
    render: function(){
      this.$el.html(section_form_tmpl(this.model.attrs()))
      return this.el;
    },
    refresh_show: function(){
      return section_summary_templ(this.model.attrs());
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.MaterialTrackingSectionView = MaterialTrackingSectionView;
})(window, document, Backbone, window.$$MIS);
