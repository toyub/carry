(function(win, doc, Backbone, $$MIS){
  var CommissionTemplateSection = Backbone.Model.extend({
    defaults: {
      type_id: 0
    },
    attrs: function(){
      var _attrs = _.clone(this.attributes);
      _attrs.cid = this.cid;
      return _attrs;
    }
  });
  win.$$MIS = $$MIS || {};
  win.$$MIS.CommissionTemplateSection = CommissionTemplateSection;
})(window, document, Backbone, window.$$MIS);
