(function(win, doc, Backbone, $$MIS){
  var posi_tmpl = JST['settings/organizational_structures/position'];
  var PositionView = Backbone.View.extend({
    tagName: 'div',
    className: 'position',
    render: function(){
      this.$el.html(posi_tmpl(this.model.attributes));
      return this.$el;
    }

  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.PositionView = PositionView;
})(window, document, Backbone, window.$$MIS);
