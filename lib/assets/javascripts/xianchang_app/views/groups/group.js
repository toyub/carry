(function(win, doc, Backbone, $$MIS){
  var tmpl = JST["xianchang/groups/group"];
  var GroupView = Backbone.View.extend({
    tagName: 'tr',
    events: {
      'dblclick span.edit': 'edit',
      'click a.save_btn': 'commit',
      'hi .dropable': 'hi_here',
      'click .delete_btn': 'destroy'
    },
    initialize: function(){
      this.listenTo(this.model, 'change', this.rerender);
      this.listenTo(this.model, 'remove', this.remove)
    },
    render: function(){
      this.$el.html(tmpl(this.model.attributes));
      return this.$el;
    },
    rerender: function(){
      this.$el.html(tmpl(this.model.attributes));
      this.render_members();
    },
    edit: function(evt){
      this.$el.find('div.group').addClass('editing');
      this.$el.find('a.save_btn').show();
    },
    commit: function(){
      var name = this.$el.find('input.js-group-name').val();
      this.model.set('name', name);
      if(this.model.hasChanged()){
        this.model.save();
      }else{
        this.rerender();
      }
    },
    hi_here: function(evt, staff_id){
      var target = evt.target;
    },
    render_members: function(){
      var members = this.model.members();
      if(members){
        members.forEach(function(member){
          var staff_html = '<li class="drag_staff" data-staff="'+ member.member_id + '" id="staff_'+ member.member_id +'" draggable="true" >'+ member.screen_name +'</li>';
          var group = "#group_"+ member.store_group_id + '_' + member.work_status;
          $(group).append(staff_html);
        });
      }
    },
    destroy: function(){
      if(this.$el.find('.person li').length > 0){
        ZhanchuangAlert('删除小组失败<br>删除小组前请先移除所有小组成员');
        return false;
      }
      this.model.destroy().error(function(ajax, status_str, error_type){
        errors = ajax.responseJSON.errors;
        var errors_msg = '删除小组失败<br>';
        for(error in errors){
          errors_msg = errors_msg + errors[error].join(', <br>') + '<br>';
        }

        ZhanchuangAlert(errors_msg);
      });
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.GroupView = GroupView;
})(window, document, Backbone, window.$$MIS);
