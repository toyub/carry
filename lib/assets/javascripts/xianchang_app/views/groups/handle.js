(function(win, doc, Backbone, $$MIS){
  var GroupsHandleView = Backbone.View.extend({
    el: 'body',
    events: {
      'click .new_staffgroup': 'new_staffgroup'
    },
    initialize: function(opt){
      this.groups = new $$MIS.GroupCollection();
      this.groups.url = opt.urlRoot;
      this.listenTo(this.groups, 'add', this.add_group)
      this.groups.fetch();
    },
    new_staffgroup: function(){
      var group = new $$MIS.Group();
      var group_view = new $$MIS.GroupView({model: group});
      $('#staffGroupList').append(group_view.render())
    },
    add_group: function(model, collection, ajax){
      var group_view = new $$MIS.GroupView({model: model});
      $('#staffGroupList').append(group_view.render())
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.GroupsHandleView = GroupsHandleView;
})(window, document, Backbone, window.$$MIS);
