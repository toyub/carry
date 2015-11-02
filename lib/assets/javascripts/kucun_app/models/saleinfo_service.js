(function(win, doc, Backbone, $$MIS){
  var mechanic_levels = ["初级以上(含初级)", "中级以上(含中级)", "高级以上(含高级)", "专家"]
  var SaleinfoService = Backbone.Model.extend({
    defaults: {
      tracking_delay_unit: 'minutes',
      work_time_unit: 'minutes',
      mechanic_level: 0,
      tracking_contact_way: 0
    },
    isTrackingNeeded: function(){
      return !!this.get('tracking_needed');
    },
    tracking_delay_in_seconds:function(){
      if(this.isTrackingNeeded()){
        return calc_delay(this.get('tracking_delay'), this.get('tracking_delay_unit'));
      }
    },
    mechanic_level_type: function(){
      return mechanic_levels[this.get('mechanic_level')];
    },
    work_time_h: function(){
      if(this.get('work_time')){
        return human_readable_time(calc_delay(this.get('work_time'), this.get('work_time_unit')));
      }
    },
    attrs: function(){
      var _attrs = _.clone(this.attributes);
      return _attrs;
    },
    form_attrs: function(){
      var _attrs = _.clone(this.attributes);
      _attrs.work_time_in_seconds = calc_delay(this.get('work_time'), this.get('work_time_unit'));
      if(this.isTrackingNeeded()){
        _attrs.tracking_delay_in_seconds = this.tracking_delay_in_seconds();
      }
      return _attrs;
    },
    summary_attrs: function(){
      var _attrs = _.clone(this.attributes);
      _attrs.work_time_h = this.work_time_h();
      _attrs.mechanic_level_type = this.mechanic_level_type();
      return _attrs;
    }
  });
  win.$$MIS = $$MIS || {};
  win.$$MIS.SaleinfoService = SaleinfoService;
})(window, document, Backbone, window.$$MIS);
