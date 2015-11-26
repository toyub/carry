(function(win, doc, Backbone, $$MIS){
  var depart_detail_tmpl = JST["settings/organizational_structures/department_detail"];
  var DepartmentDetailView = Backbone.View.extend({
    tagName: 'div',
    className: 'branch_details',
    events: {
      'click .fa-plus-square': 'add_position'
    },
    initialize: function(opt){
      this.model = opt.model;
      this.positions_path = opt.positions_path;
      this.positions = new $$MIS.PositionCollection();
      this.positions.url = this.positions_path({store_department_id: this.model.get('id')});
      this.listenTo(this.positions, 'add', this.render_position);

    },
    render: function(){
      this.$el.html(depart_detail_tmpl(this.model.attributes))
      this.positions.fetch();
      return this.$el;
    },
    render_position: function(model, collection, ajax, undef){
      var position_view = new $$MIS.PositionView({model: model});
      position_view.render().insertBefore(this.$el.find('div.clr'));
    },
    add_position: function(evt){
      var model = new $$MIS.Position({store_department_id: this.model.get('id')});

      var position_view = new $$MIS.PositionView({model: model});
      position_view.model.urlRoot =  this.positions_path({store_department_id: this.model.get('id')})
      position_view.render().insertBefore(this.$el.find('div.clr'));
      position_view.$el.find('div.position_name').addClass('editing');
      position_view.$el.find('div.position_name > input').focus();
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.DepartmentDetailView = DepartmentDetailView;
})(window, document, Backbone, window.$$MIS);
