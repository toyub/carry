(function(win, doc, Backbone, $$MIS){
  var templs = [
                JST['settings/commission_templates/sections/mode0'],
                JST['settings/commission_templates/sections/mode1'],
                JST['settings/commission_templates/sections/mode2']
              ];


  var CommissionTemplateSectionView = Backbone.View.extend({
    render: function(){
      return templs[this.model.get('mode_id')](this.model.attributes);
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.CommissionTemplateSectionView = CommissionTemplateSectionView;
})(window, document, Backbone, window.$$MIS);
