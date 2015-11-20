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
      'click div:first > .fa-plus-circle': 'add_child',
      'click div:first > .fa-folder': 'unfolder',
      'click div:first > .fa-folder-open': 'folder'
    },
    folder: function(evt){
      evt.preventDefault();
      evt.stopPropagation();
      this.$el.find('>div.branch_name').addClass('slide_up');
      this.$el.find('>ul.branch').slideUp();
    },
    unfolder: function(evt){
      evt.preventDefault();
      evt.stopPropagation();
      this.fetch_sub_departs();
    },
    edit: function(evt){
      evt.preventDefault();
      evt.stopPropagation();
      this.$el.find('> .branch_name:first').addClass('editing');
      this.$el.find('> .branch_name:first > input[name=name]')[0].focus()
    },
    show_detail: function(evt){
      evt.preventDefault();
      evt.stopPropagation();
      if(!this.detail_view){
        this.detail_view = new $$MIS.DepartmentDetailView({model: this.model, positions_path: this.positions_path});
        $('.details_content').append(this.detail_view.render());
        this.detail_view.$el.show();
      }
      $('.branch_details').hide();
      this.detail_view.$el.show();
    },
    save: function(evt){
      evt.preventDefault();
      evt.stopPropagation();
      var name_input = evt.target;
      this.model.set('name', name_input.value);
      this.$el.find('div:first > span.name').html(this.model.get('name'));
      this.$el.find('>div.branch_name').removeClass('editing');
      if(this.model.hasChanged()){
        this.model.save();
      }
    },
    add_child: function(evt){
      evt.preventDefault();
      evt.stopPropagation();
      this.fetch_sub_departs();
      var model = new $$MIS.Department({parent_id: this.model.get('id')});
      var department_view = new $$MIS.DepartmentView({model: model, positions_path: this.positions_path});
      department_view.model.urlRoot = this.model.urlRoot;
      console.log(this.model.urlRoot)
      this.$el.find('>ul').append(department_view.render()).show();
    },
    render: function(){
      this.$el.html(depart_tmpl(this.model.attributes));
      return this.$el;
    },
    fetch_sub_departs: function(){
      if(!this.hasFetch){
        if(this.model.sub_departs.length > 0){
          _this = this;
          this.model.sub_departs.each(function(model, index, collection, undef){
            var department_view = new $$MIS.DepartmentView({model: model, positions_path: _this.positions_path});
            department_view.model.urlRoot = _this.model.urlRoot;
            _this.$el.find('>ul').append(department_view.render()).show();
          });
        }
        this.hasFetch = true;
      }
      this.$el.find('>div.branch_name').removeClass('slide_up');
      this.$el.find('>ul.branch').slideDown();
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.DepartmentView = DepartmentView;
})(window, document, Backbone, window.$$MIS);
