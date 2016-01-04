(function(win, doc, Backbone, $$MIS){
  var OrganizationalStructuresHandleView = Backbone.View.extend({
    el: 'body',
    events:{
      'click #add_root':'add_root_depart'
    },
    initialize: function(opt){
      this.departments_path = opt.departments_path;
      this.positions_path = opt.positions_path;
      this.departments = new $$MIS.DepartmentCollection();
      this.departments.url = this.departments_path();
      this.depart_root = $('#depart_root');
      this.listenTo(this.departments, 'add', this.fetch_depart);
      this.departments.fetch();

    },
    add_root_depart: function(){
      var model = new $$MIS.Department({parent_id: 0});
      model.urlRoot = this.departments_path();
      var department_view = new $$MIS.DepartmentView({model: model, positions_path: this.positions_path});
      this.depart_root.append(department_view.render());
      department_view.$el.find('div.branch_name:first').addClass('editing');
      department_view.$el.find('div.branch_name:first>input').focus();
    },
    fetch_depart: function(model, collection, ajax, undef){
      model.urlRoot = this.departments_path();
      var department_view = new $$MIS.DepartmentView({model: model, positions_path: this.positions_path});
      this.depart_root.append(department_view.render());
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.OrganizationalStructuresHandleView = OrganizationalStructuresHandleView;
})(window, document, Backbone, window.$$MIS);
