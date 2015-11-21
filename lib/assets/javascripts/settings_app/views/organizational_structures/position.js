(function(win, doc, Backbone, $$MIS){
  var posi_tmpl = JST['settings/organizational_structures/position'];
  var PositionView = Backbone.View.extend({
    tagName: 'div',
    className: 'position',
    events: {
      'click .position_name span': 'edit',
      'click .fa-save': 'save',
      'click .fa-undo': 'undo',
      'click .fa-angle-double-left': 'folder',
      'click .fa-angle-double-right': 'unfolder'
    },
    render: function(){
      this.$el.html(posi_tmpl(this.model.attributes));
      return this.$el;
    },

    edit: function(){
        this.$el.find('.position_name').addClass('editing');
        this.$el.find('input[name=name]')[0].focus();
    },
    save: function(evt){
      var name_input = this.$el.find('input[name=name]');
      if(!name_input.val()){
        ZhanchuangAlert('请输入职位名称!');
        return;
      }
      this.model.set('name', name_input.val());
      this.$el.find('.position_name').removeClass('editing');
      if(this.model.hasChanged()){
        this.model.save();
      }
      this.render();
    },
    undo: function(){
      if(this.model.isNew()){
        this.remove();
      }else{
        this.render();
      }
    },
    folder: function(evt){
      this.$el.find('.position_name').addClass('slide_up');
      this.$el.find('.staff').slideUp("fast");
    },
    unfolder: function(evt){
      this.$el.find('.position_name').removeClass('slide_up');
      this.$el.find('.staff').slideDown("fast");
    }

  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.PositionView = PositionView;
})(window, document, Backbone, window.$$MIS);
