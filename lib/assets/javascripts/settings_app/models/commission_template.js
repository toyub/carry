(function(win, doc, Backbone, $$MIS){
  var confineds = ['班组', '个人'];
  var modes = ['标准提成', '阶梯提成', '分段提成'];
  var CommissionTemplate = Backbone.Model.extend({
    defaults: {
      mode_id: 0,
      confined_to: 0
    },
    add_section: function(){
      var section = {
        mode_id: this.get('mode_id')
      };
      this.sections.add(section);
    },
    sections: function(){
      var key = 'sections'+this.get('mode_id');
      return this[key];
    },
    attrs: function(){
      var _attrs = this.attributes;
      _attrs.confined = confineds[_attrs.confined_to];
      _attrs.mode = modes[_attrs.mode_id];
      _attrs.sections0 = this.sections.where(function(model){model.get('modeid') == 0}).map(function(model){return model.toJSON()});
      _attrs.sections1 = this.sections.where(function(model){model.get('modeid') == 1}).map(function(model){return model.toJSON()});
      _attrs.sections2 = this.sections.where(function(model){model.get('modeid') == 2}).map(function(model){return model.toJSON()});
      return _attrs;
    }
  });
  win.$$MIS = $$MIS || {};
  win.$$MIS.CommissionTemplate = CommissionTemplate;
})(window, document, Backbone, window.$$MIS);
