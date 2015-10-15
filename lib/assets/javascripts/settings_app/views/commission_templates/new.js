
(function(win, doc, Backbone, $$MIS){
  var NewCommissionTemplateView = Backbone.View.extend({
    events: {
      'click .new_btn': 'show_form'
    },
    show_form: function(){
      var commission_template = new $$MIS.CommissionTemplate();
      commission_template.sections = new $$MIS.CommissionTemplateSectionCollection();
      commission_template.sections.add(new $$MIS.CommissionTemplateSection({

      }));
      var view = new $$MIS.CommissionTemplateFormView({
        model: commission_template
      });
      $("#pop").html(view.render()).show()
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.NewCommissionTemplateView = NewCommissionTemplateView;
})(window, document, Backbone, window.$$MIS);
