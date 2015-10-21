
(function(win, doc, Backbone, $$MIS){
  views = {};
  var CommissionTemplateHandleView = Backbone.View.extend({
    el: 'body',
    initialize: function(opts){
      this.$pop = $("#pop");
      this.pop = this.$pop[0];
      this.commission_templates = new $$MIS.CommissionTemplateCollection();
      this.commission_templates.url = '/settings/commission_templates';
      var _this = this;
      this.commission_templates.fetch({
        success: function(collection, data, xhr, undef){
          _this.load();
        }
      });
    },
    events: {
      'click .new_btn': 'add',
      'click .edit_list': 'edit'
    },
    add: function(evt){
      var aim = parseInt(evt.target.dataset.aim);
      var commission_template = new $$MIS.CommissionTemplate({aim_to: aim});
      commission_template.sections = new $$MIS.CommissionTemplateSectionCollection();
      this.commission_templates.add(commission_template);
      var view = new $$MIS.CommissionTemplateFormView({
        model: commission_template,
        aim_div: $('#aim'+ commission_template.get('aim_to'))
      });

      this.$pop.append(view.render());
      commission_template.add_section();
      view.render_sections();
      views[view.cid] = view;
      this.$pop.show();
    },
    edit: function(evt){
      var target = evt.target;
      var view = views[target.dataset.viewid];
      if(!view){
        var modelid = target.dataset.modelid;
        var model = this.commission_templates.find_by_cid(modelid);
        var view = new $$MIS.CommissionTemplateFormView({
          model: model,
          aim_div: $('#aim'+ model.get('aim_to'))
        });
        this.$pop.append(view.render());
        views[view.cid] = view;
        this.$pop.show();
      }else{
        view.rerender();
        view.$el.show();
        this.$pop.show();
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
  win.$$MIS.CommissionTemplateHandleView = CommissionTemplateHandleView;
})(window, document, Backbone, window.$$MIS);
