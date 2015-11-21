(function(win, doc, Backbone, $$MIS){
  var Department = Backbone.Model.extend({

    defaults: {
      parent_id: 0
    },
    initialize: function(){
      this.sub_departs = new $$MIS.DepartmentCollection();
    },
    fetch_sub_departs: function(callback){
      this.sub_departs.url = this.url() + '/children';
      this.sub_departs.fetch({
        success: function(collection, res, opt, undef){
          callback();
        },
        error: function(collection, res, opt, undef){
          ZhanchuangAlert('系统错误，请稍后重试');
        }
      });
    },
    isRoot: function(){
      return this.get('parent_id') == 0;
    },
    isSub: function(){
      return !!this.get('parent_id') && this.get('parent_id') != 0;
    }
  });
  win.$$MIS = $$MIS || {};
  win.$$MIS.Department = Department;
})(window, document, Backbone, window.$$MIS);
