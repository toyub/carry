(function(win, doc, Backbone, $$MIS){
  var Group = Backbone.Model.extend({
    urlRoot: '/api/osm/groups',
    defaults: {
      name: 'New Group'
    }
  });
  win.$$MIS = $$MIS || {};
  win.$$MIS.Group = Group;
})(window, document, Backbone, window.$$MIS);
