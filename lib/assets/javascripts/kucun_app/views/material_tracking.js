(function(win, doc, Backbone, $$MIS){
  views = {};
  var MaterialTrackingView = Backbone.View.extend({
    el: 'body',
    initialize:function(options){
      this.urlRoot = options.urlRoot;
      this.model = new $$MIS.MaterialTracking();
      this.sections = new $$MIS.MaterialTrackingSectionCollection();
      this.sections.url = this.urlRoot + '/sections';
      var _this = this;
      this.sections.fetch().done(function(){
        _this.sections.each(function(model, idx, arr, undef){
          var _attrs = model.attrs();
          _attrs.modelid = model.cid;
          _attrs.idx = idx + 1;
          summary_el = Summary.tracking_section(_attrs);
          console.log(summary_el)
          $("#lists").append(summary_el);
        });
        $('div.list').show();
      });
      if($('#tracking_id').val()){
        this.model.set('id', $('#tracking_id').val())
      }
      this.section_lists = $("#lists");
    },
    events: {
      "click input[name='tracking[enabled]']": 'tracking_toggle',
      "click input[name='tracking[contact_way]']": 'set_tracking_way',
      "change select[name='tracking[tracking_mode]']": 'set_tracking_mode',
      "click .new_btn": 'add_section',
      "click .edit": 'edit_section',
      "click .delete": 'delete_section',
      'click #save_tracking': 'save'
    },
    tracking_toggle: function(event){
      var target = event.target;
      this.model.set('enabled', target.checked);
    },
    set_tracking_way: function(evt){
      var target = evt.target;
      this.model.set('contact_way', target.value);
    },
    set_tracking_mode: function(evt) {
      var target = evt.target;
      if(target.value == 0){
        $('#sections').find('.new_btn').addClass('disabled');
        $("input[name='tracking[reminder_required]']").attr('disabled', true)
      }else{
        $("input[name='tracking[reminder_required]'][disabled]").removeAttr('disabled');
        if(target.value == 2){
          $('#sections').find('.new_btn.disabled').removeClass('disabled')
        }else{
          if(!$('#sections').find('.new_btn').hasClass('disabled')){
              $('#sections').find('.new_btn').addClass('disabled');
          }
        }
      }
    },

    add_section: function(evt){
      var new_btn = evt.target;
      if(new_btn.classList.contains('disabled')){
        return false;
      }
      new_btn.classList.add('disabled');
      var _this = this;
      var section = new $$MIS.MaterialTrackingSection();
      var section_view = new $$MIS.MaterialTrackingSectionView({model: section});
      section_view.idx = $('#lists').children().length + 1;
      section.on("invalid", function(model, error) {
        alert(error);
      });

      this.sections.push(section);
      $("#sections").append(section_view.render());
      views[section_view.cid] = section_view;
      section_view.on('created', function(){
        $("#lists").append(section_view.show());
        $('div.list').show();
      });

      section_view.on('removed', function(){
        _this.sections.remove(section_view.model);
        delete section_view.model;
        section_view.$el.remove();
        delete views[section_view.cid];
        delete section_view;
      });
    },

    edit_section: function(evt) {
      var target = evt.target;
      if($(".new_btn").hasClass('disabled')){
        return false;
      }
      $(".new_btn").addClass('disabled');
      var viewid = target.dataset.viewid;
      console.log(viewid)
      if(viewid){
        var section_view = views[viewid];
      }else{
        var modelid = target.dataset.modelid;
        var section = this.sections.find(function(model){return model.cid == modelid;});
        section.on("invalid", function(model, error) {
          alert(error);
        });

        var section_view = new $$MIS.MaterialTrackingSectionView({model: section});
        section_view.summary_el = $(target).parents('div.list_tr');
        section_view.idx = section_view.summary_el.index() + 1;
        this.sections.push(section);
        $("#sections").append(section_view.render());
        views[section_view.cid] = section_view;
        target.dataset.viewid = section_view.cid;
      }
      section_view.$el.show();
    },

    delete_section: function(evt){
      var target = evt.target;
      this.section_lists.find('[data-id=' + target.dataset.target + ']').remove();
    },

    save: function(){
      this.model.urlRoot = this.urlRoot;
      this.model.set('tracking_mode', $("select[name='tracking[tracking_mode]']").val());
      this.model.set('reminder_required', $("input[name='tracking[reminder_required]']:checked").val());
      this.model.set("sections_attributes", this.sections);
      if(this.model.get('tracking_mode') == 2 && this.sections.length == 0){
        alert('请至少添加一条回访规则');
        return false;
      }
      this.model.save();
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.MaterialTrackingView = MaterialTrackingView;
})(window, document, Backbone, window.$$MIS);
