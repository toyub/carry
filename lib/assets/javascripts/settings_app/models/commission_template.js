(function(win, doc, Backbone, $$MIS){
  var CommissionTemplate = Backbone.Model.extend({
    defaults: {
      mode_id: 0
    },
    add_section: function(){
      var section = {
        mode_id: this.get('mode_id')
      };
      this.sections.add(section);
    }
  });
  win.$$MIS = $$MIS || {};
  win.$$MIS.CommissionTemplate = CommissionTemplate;
})(window, document, Backbone, window.$$MIS);
