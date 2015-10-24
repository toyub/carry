(function(win, doc, Backbone, $$MIS){
  var _section_edit_tmpl = null;
  var section_edit_tmpl = function(model){
    if(!_section_edit_tmpl){
      _section_edit_tmpl = _.template($('#section_edit_tmpl').html());
    }
    return _section_edit_tmpl.apply(model.attrs());
  }

  var section_summary_templ = JST['kucun/trackings/new/summary'];


  var calc_delay = function(delay, delay_unit){
    var one_hour = 3600;
    var one_day = one_hour * 24;
    switch(delay_unit){
      case 'hour' : return delay * one_hour;
      case 'day'  : return delay * one_day;
      case 'week' : return delay * one_day * 7;
      case 'month': return delay * one_day * 30;
      case 'year' : return delay * one_day * 365;
      default: throw new Error('argument "delay_unit" must be one of ["hour", "day", "week", "month", "year", but get '+delay_unit);
    }
  }

  var MaterialTrackingSectionView = Backbone.View.extend({
    events: {
      'click .save_btn': 'submit',
      'change [name^=section]': 'set_attr'
    },
    section_edit_tmpl: section_edit_tmpl,
    set_attr: function(event){
      var target = event.target;
      var attr = (/\[(\w+)\]/).exec(target.name)[1];
      this.model.set(attr, target.value);
    },
    submit: function(){
      if(!this.model.isValid()){
        return false;
      }
      var delay = this.model.get('delay');
      var delay_unit = this.model.get('delay_unit');
      var delay_in_seconds = calc_delay(delay, delay_unit);
      this.model.set('delay_in_seconds', delay_in_seconds);
      this.commit();
    },
    commit: function(){
      this.model.commit();
      this.trigger('after_commit', this, this.model);
    },
    show: function(){
      var html = '<div class="list_content list_tr" data-id="list_content_' +
                          this.model.cid + 
                          '">' + section_summary_templ(this.model.attrs()) + "</div>";
      return html;
    },
    render: function(){
      return this.section_edit_tmpl(this.model);
    },
    refresh_show: function(){
      return section_summary_templ(this.model.attrs());
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.MaterialTrackingSectionView = MaterialTrackingSectionView;
})(window, document, Backbone, window.$$MIS);
