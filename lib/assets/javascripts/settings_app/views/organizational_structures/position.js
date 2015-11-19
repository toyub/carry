(function(win, doc, Backbone, $$MIS){
  var posi_tmpl = JST['settings/organizational_structures/position'];
  var PositionView = Backbone.View.extend({
    tagName: 'div',
    className: 'position',
    events: {
      'click .position_name span': 'edit',
      'blur input[name=name]': 'save'
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
      var name_input = evt.target;
      this.model.set('name', name_input.value);
      this.$el.find('.position_name').removeClass('editing');
      this.render();
    }

  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.PositionView = PositionView;
})(window, document, Backbone, window.$$MIS);
