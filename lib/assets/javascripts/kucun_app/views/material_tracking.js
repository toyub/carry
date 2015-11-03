(function(win, doc, Backbone, $$MIS){
  views = {};
  var MaterialTrackingView = Backbone.View.extend({
    el: 'body',
    initialize:function(options){
      this.urlRoot = options.urlRoot;
      this.model = new $$MIS.MaterialTracking();
      this.mtsc = new $$MIS.MaterialTrackingSectionCollection();
      this.mtsc.url = this.urlRoot + '/sections';
      var _this = this;
      this.mtsc.fetch().done(function(){
        _this.mtsc.each(function(a,b,c,d,e){
          console.log([this,a,b,c,d,e])
        });
      });
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

      this.mtsc.push(section);
      $("#sections").append(section_view.render());
      views[section_view.cid] = section_view;
      section_view.on('created', function(){
        $("#lists").append(section_view.show());
        $('div.list').show();
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
        var section = this.mtsc.find(function(model){return model.cid == modelid;});
        section.on("invalid", function(model, error) {
          alert(error);
        });

        var section_view = new $$MIS.MaterialTrackingSectionView({model: section});
        section_view.summary_el = $(target).parents('div.list_tr');
        section_view.idx = section_view.summary_el.index() + 1;
        this.mtsc.push(section);
        $("#sections").append(section_view.render());
        views[section_view.cid] = section_view;
      }
      section_view.$el.show();
    },

    delete_section: function(evt){
      var target = evt.target;
      this.section_lists.find('[data-id=' + target.dataset.target + ']').remove();
    },

    save: function(){
      var x = /\/kucun\/materials\/\d+\/tracking/;
      mtv.model.urlRoot = x.exec(window.location.href)[0];
      mtv.model.set('tracking_mode', $("select[name='tracking[tracking_mode]']").val());
      mtv.model.set('reminder_required', $("input[name='tracking[reminder_required]']:checked").val());
      mtv.model.set("sections_attributes", this.mtsc);
      if(mtv.model.get('tracking_mode') == 2 && this.mtsc.length == 0){
        alert('请至少添加一条回访规则');
        return false;
      }
      mtv.model.save();
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.MaterialTrackingView = MaterialTrackingView;
})(window, document, Backbone, window.$$MIS);
