
(function(win, doc, Backbone, $$MIS){
  var summary_tmpl = JST['settings/commission_templates/new/summary'];
  var summary = function(model){
    return "<ul data-id=" + model.viewid + ">" + summary_tmpl(model) + "</ul>";
  }
  views = {};
  var NewCommissionTemplateView = Backbone.View.extend({
    events: {
      'click .new_btn': 'show_form',
      'click .edit_list': 'edit'
    },
    add: function(){

    },
    show_form: function(evt){
      var _this = this;
      var aim = evt.target.dataset.aim;
      var commission_template = new $$MIS.CommissionTemplate({aim_to: aim});
      commission_template.sections = new $$MIS.CommissionTemplateSectionCollection();
      var view = new $$MIS.CommissionTemplateFormView({
        model: commission_template
      });
      view.listenTo(commission_template.sections, 'add', function(model, collection, options) {
        var section_view = new $$MIS.CommissionTemplateSectionView({model: model});
        view.render_section(section_view);
      });

      $("#pop").append(view.render()).show()

      commission_template.add_section();

      view.aim_div = $('#aim'+view.model.get('aim_to'));
      view.on('saved', function(){
        var attrs = view.model.attrs();
        attrs.idx = view.aim_div.children().length + 1;
        attrs.viewid = view.cid;
        view.aim_div.append(summary(attrs));
        view.$el.hide();
        $("#pop").hide();
      });

      view.on('updated', function(){
        view.aim_div.find('ul[data-id='+view.cid + ']').html(summary_tmpl(view.model.attrs()))
        view.$el.hide();
        $("#pop").hide();
      });

      view.on('cancel', function(){
        $("#pop").hide();
        if(view.model.saved){
          view.$el.hide();
        }else{
          view.remove();
          delete view.model;
          delete views[view.cid];
          delete view;
        }

      });
      views[view.cid] = view;
    },
    edit: function(evt){
      var target = evt.target;
      var view = views[target.dataset.viewid];
      if(!view){
        var modelid = target.dataset.modelid;
        var model = this.commission_templates.find(function(model) {
          return model.cid = modelid;
        });
        view = new $$MIS.CommissionTemplateFormView({
          model: model
        });
        view.aim_div = $('#aim'+view.model.get('aim_to'));
        $("#pop").append(view.render()).show();
        view.render_sections();
        views[view.cid] = view;
      }else{
        view.rerender();
        view.$el.show();
        $("#pop").show();
      }
    },
    load: function() {
      aim0_html = "";
      aim1_html = "";
      aim2_html = "";
      this.commission_templates.each(function(model){
        model.sections = new $$MIS.CommissionTemplateSectionCollection(model.attributes.sections);
        var attributes = model.attrs();
        attributes.viewid = '';
        if(attributes.mode_id == 0){
          aim0_html += summary(attributes);
        }else if(attributes.mode_id == 1){
          aim1_html += summary(attributes);
        }else if(attributes.mode_id == 2){
          aim2_html += summary(attributes);
        }

        $("#aim0").html(aim0_html);
        $("#aim1").html(aim1_html);
        $("#aim2").html(aim2_html);
      });
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.NewCommissionTemplateView = NewCommissionTemplateView;
})(window, document, Backbone, window.$$MIS);
