(function(win, doc, Backbone, $$MIS){
  var Group = Backbone.Model.extend({
    urlRoot: '/api/osm/groups',
    defaults: {
      name: '新建小组'
    },

    members: function(){
      return this.attributes.store_group_members;
    }
  });
  win.$$MIS = $$MIS || {};
  win.$$MIS.Group = Group;
})(window, document, Backbone, window.$$MIS);
