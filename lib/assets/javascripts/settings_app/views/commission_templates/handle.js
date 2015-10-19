(function(win, doc, Backbone, $$MIS){
  var CommissionTemplateHandle = Backbone.View.extend({
    initialize: function(){
      x = new $$MIS.NewCommissionTemplateView({
        el: 'body'
      });
      x.commission_templates = new $$MIS.CommissionTemplateCollection();
      x.commission_templates.url = '/settings/commission_templates';
      x.commission_templates.fetch({
        success: function(collection, data, xhr, undef){
          x.load();
        }
      });
    }
  });
  win.$$MIS = $$MIS || {};
  win.$$MIS.CommissionTemplateHandle = CommissionTemplateHandle;
})(window, document, Backbone, window.$$MIS);
