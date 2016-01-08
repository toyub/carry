(function(win, doc, Backbone, $$MIS){
  var GroupMemberCollection = Backbone.Collection.extend({
    model: $$MIS.GroupMember
  });
  win.$$MIS.GroupMemberCollection = GroupMemberCollection;
})(window, document, Backbone, window.$$MIS);
