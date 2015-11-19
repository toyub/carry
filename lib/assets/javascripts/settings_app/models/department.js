(function(win, doc, Backbone, $$MIS){
  var Department = Backbone.Model.extend({

    defaults: {
      name: '新建部门',
      parent_id: 0
    },
    initialize: function(){
      this.sub_departs = new $$MIS.DepartmentCollection();
      if(this.attributes.departments && this.attributes.departments.length > 0){
        this.sub_departs.add(this.attributes.departments);
      }
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
