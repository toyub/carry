(function(Backbone, $, $$MIS ){
  window.$$MIS = $$MIS || {};
  var message_list_tmpl = JST['home/notifications/list'];
  var Handle = Backbone.View.extend({
    el: '#js-notifications',
    initialize: function(){
      this.message_counts = new $$MIS.Collections.NotificationCounter();
      this.listenTo(this.message_counts, 'add', this.show_counter)
      this.message_counts.fetch();
    },
    show_counter: function(model){
      console.log(model.getDomClass())
      var html = message_list_tmpl(model.attrs());
      this.$el.find('ul.items').append(html);
    }
  });

  window.$$MIS.HomeNotificationHandle = Handle;
})(Backbone, jQuery, window.$$MIS);
