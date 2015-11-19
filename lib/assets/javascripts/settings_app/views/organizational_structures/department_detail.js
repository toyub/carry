(function(win, doc, Backbone, $$MIS){
  var depart_detail_tmpl = JST["settings/organizational_structures/department_detail"];
  var DepartmentDetailView = Backbone.View.extend({
    tagName: 'div',
    className: 'branch_details',
    initialize: function(opt){
      this.model = opt.model;
      this.positions_path = opt.positions_path;
      this.positions = new $$MIS.PositionCollection();
      this.positions.url = this.positions_path({store_department_id: 2});
      this.listenTo(this.positions, 'add', this.render_position);

    },
    render: function(){
      this.$el.html(depart_detail_tmpl({positions: []}))
      this.positions.fetch();
      return this.$el;
    },
    render_position: function(model, collection, ajax, undef){
      var position_view = new $$MIS.PositionView({model: model});
      position_view.render().insertBefore('div.clr');
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.DepartmentDetailView = DepartmentDetailView;
})(window, document, Backbone, window.$$MIS);
