
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
      'click .edit_list': 'edit',
      'click .status_btn': 'toggle_status'
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
      commission_template.add_section();
      this.$pop.append(view.render());
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
    toggle_status: function(evt){
      var target = evt.target;
      var ul = target.parentNode.parentNode;
      var viewid = target.dataset.viewid;
      var view = views[viewid];
      if(!view){
        var modelid = target.dataset.modelid;
        model = this.commission_templates.find(function(model){return model.cid == modelid});
      }else{
        model = view.model;
      }
      if(model.get('status') == 0){
        model.set('status', 1);
      }else{
        model.set('status', 0);
      }
      model.toggle_status();
      var attrs = model.attrs();
      attrs.idx = $(ul).index() + 1;
      ul.innerHTML = summary_tmpl(attrs);
    },
    load: function() {
      var aim0_html = "", aim1_html = "", aim2_html = "",
          aim0idx = 0, aim1idx = 0, aim2idx = 0;
      this.commission_templates.each(function(model){

        model.sections = new $$MIS.CommissionTemplateSectionCollection(model.attributes.sections_attributes);
        var attributes = model.attrs();
        attributes.viewid = '';
        if(attributes.aim_to == 0){
          aim0idx += 1;
          attributes.idx = aim0idx;
          aim0_html += summary(attributes);
        }else if(attributes.aim_to == 1){
          aim1idx += 1;
          attributes.idx = aim1idx;
          aim1_html += summary(attributes);
        }else if(attributes.aim_to == 2){
          aim2idx += 1;
          attributes.idx = aim2idx;
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
