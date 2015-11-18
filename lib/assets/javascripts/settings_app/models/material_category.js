(function(win, doc, Backbone, $$MIS){
  var MaterialCategory = Backbone.Model.extend({
    defaults: {
      parent_id: 0
    },
    isRoot: function(){
      return this.get('parent_id') == 0;
    },
    isSub: function(){
      return !!this.get('parent_id') && this.get('parent_id') != 0;
    }
  });
  win.$$MIS = $$MIS || {};
  win.$$MIS.MaterialCategory = MaterialCategory;
})(window, document, Backbone, window.$$MIS);
