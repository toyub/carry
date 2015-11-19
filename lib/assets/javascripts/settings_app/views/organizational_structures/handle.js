(function(win, doc, Backbone, $$MIS){
  var OrganizationalStructuresHandleView = Backbone.View.extend({
    el: 'body',
    initialize: function(opt){
      this.departments_path = opt.departments_path;
      this.positions_path = opt.positions_path;
      this.departments = new $$MIS.DepartmentCollection();
      this.departments.url = this.departments_path();
      this.depart_root = $('#depart_root');
      this.listenTo(this.departments, 'add', this.fetch_depart);
      this.departments.fetch();

    },
    fetch_depart: function(model, collection, ajax, undef){
      var department_view = new $$MIS.DepartmentView({model: model, positions_path: this.positions_path});
      this.depart_root.append(department_view.render());
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.OrganizationalStructuresHandleView = OrganizationalStructuresHandleView;
})(window, document, Backbone, window.$$MIS);
