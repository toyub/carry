(function(win, doc, Backbone, $$MIS){
  var tmpl = JST["xianchang/groups/group"];
  var GroupView = Backbone.View.extend({
    tagName: 'tr',
    events: {
      'dblclick span.edit': 'edit',
      'click a.save_btn': 'commit'
    },
    initialize: function(){
      this.listenTo(this.model, 'change', this.rerender);
    },
    render: function(){
      this.$el.html(tmpl(this.model.attributes));
      return this.$el;
    },
    rerender: function(){
      this.$el.html(tmpl(this.model.attributes));
    },
    edit: function(evt){
      this.$el.find('div.group').addClass('editing');
      this.$el.find('a.save_btn').show();
    },
    commit: function(){
      var name = this.$el.find('input.js-group-name').val();
      this.model.set('name', name);
      this.model.save();
    }

  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.GroupView = GroupView;
})(window, document, Backbone, window.$$MIS);
