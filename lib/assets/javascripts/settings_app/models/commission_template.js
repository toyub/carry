(function(win, doc, Backbone, $$MIS){
  var confineds = ['部门', '个人'];
  var modes = ['标准提成', '阶梯提成', '分段提成'];
  var aims = ['销售', '技师', '其他'];
  var CommissionTemplate = Backbone.Model.extend({
    defaults: {
      mode_id: 0,
      confined_to: 0,
      level_weight:{},
      status: 0
    },
    add_section: function(){
      return this.sections.add({
          mode_id: this.get('mode_id')
        });
    },
    attrs: function(){
      var _attrs = _.clone(this.attributes);
      _attrs.cid = this.cid;
      _attrs.confined = confineds[_attrs.confined_to];
      _attrs.mode = modes[_attrs.mode_id];
      return _attrs;
    },
    sections0: function(){
      return this.sections.find(function(model){return model.get('mode_id') == 0});
    },
    sections1: function(){
      return this.sections.filter(function(model){ return model.get('mode_id') == 1});
    },
    sections2: function(){
      return this.sections.filter(function(model){ return model.get('mode_id') == 2});
    },
    toggle_status: function(){
      this.save();
    }
  });
  win.$$MIS = $$MIS || {};
  win.$$MIS.CommissionTemplate = CommissionTemplate;
})(window, document, Backbone, window.$$MIS);
