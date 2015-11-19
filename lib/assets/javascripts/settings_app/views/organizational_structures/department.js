(function(win, doc, Backbone, $$MIS){
  var depart_tmpl = JST["settings/organizational_structures/department"];
  var DepartmentView = Backbone.View.extend({
    initialize: function(opt){
      this.model = opt.model;
      this.positions_path = opt.positions_path;
    },
    tagName: 'li',
    className: 'branch_li',
    events: {
      'click div:first > .fa-list': 'show_detail',
      'click div:first > span.name': 'edit',
      'blur div:first > input[name=name]': 'save',
      'click div:first > .fa-plus-circle': 'add_child'
    },
    render: function(){
      this.$el.html(depart_tmpl(this.model.attributes));
      return this.$el;
    },
    edit: function(evt){
      evt.preventDefault();
      evt.stopPropagation();
      this.$el.find('> .branch_name:first').addClass('editing');
      this.$el.find('> .branch_name:first > input[name=name]')[0].focus()
    },
    show_detail: function(){
      if(this.detail_view){
        this.detail_view.$el.show();
      }else{
        this.detail_view = new $$MIS.DepartmentDetailView({model: this.model, positions_path: this.positions_path});
        $('.details_content').append(this.detail_view.render());
        this.detail_view.$el.show();
      }
    },
    save: function(evt){
      evt.preventDefault();
      evt.stopPropagation();
      var name_input = evt.target;
      this.model.set('name', name_input.value);
      this.$el.find('div:first > span.name').html(this.model.get('name'));
      this.$el.find('> .branch_name').removeClass('editing');
    },
    add_child: function(evt){
      evt.preventDefault();
      evt.stopPropagation();
      var model = new $$MIS.Department();
      var department_view = new $$MIS.DepartmentView({model: model, positions_path: this.positions_path});
      this.$el.find('>ul').append(department_view.render());
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.DepartmentView = DepartmentView;
})(window, document, Backbone, window.$$MIS);
