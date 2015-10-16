
(function(win, doc, Backbone, $$MIS){
  var summary = JST['settings/commission_templates/new/summary'];
  views = [];
  var NewCommissionTemplateView = Backbone.View.extend({
    events: {
      'click .new_btn': 'show_form'
    },
    show_form: function(evt){
      var aim = evt.target.dataset.aim;
      alert(aim)
      var commission_template = new $$MIS.CommissionTemplate({aim_to: aim, name:'sdjafdsakf'});
      commission_template.sections = new $$MIS.CommissionTemplateSectionCollection();

      view = new $$MIS.CommissionTemplateFormView({
        model: commission_template
      });
      view.listenTo(commission_template.sections, 'add', function(model, collection, options) {
        var section_view = new $$MIS.CommissionTemplateSectionView({model: model});
        view.render_section(section_view);
      });
      $("#pop").html(view.render()).show()
      commission_template.add_section();
      var _this = this;
      view.on('saved', function(){
        $("#pop").hide();
        $('#aim'+view.model.get('aim_to')).append(summary(view.model))
        view.remove();
      });
      views.push(view);

    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.NewCommissionTemplateView = NewCommissionTemplateView;
})(window, document, Backbone, window.$$MIS);
