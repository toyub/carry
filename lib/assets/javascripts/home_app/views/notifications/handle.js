(function(Backbone, $, $$MIS ){
  window.$$MIS = $$MIS || {};
  var message_list_tmpl = JST['home/notifications/list'];
  var notifications_tmpl = JST['home/notifications/notifications'];
  var NotificationUrl = function(extra_type){
    return '/api/home/notifications/' + extra_type;
  }
  var Handle = Backbone.View.extend({
    el: '#js-notification-counters',
    events: {
      'click li.item': "show_notifications"
    },
    initialize: function(){
      this.message_counts = new $$MIS.Collections.NotificationCounter();
      this.listenTo(this.message_counts, 'add', this.show_counter)
      this.message_counts.fetch();
    },
    show_counter: function(model){
      var html = message_list_tmpl(model.attrs());
      this.$el.find('ul.items').append(html);
    },
    show_notifications: function(evt){
      var target = evt.currentTarget;
      var extra_type = target.dataset.type;
      console.log(evt)
      var url = NotificationUrl(extra_type);
      $.get(url, function(notifications){
        var content = notifications_tmpl({notifications: notifications})
        $$MIS.lib.NotificationDialog(content);
      }).error(function(){

      });
    }

  });

  window.$$MIS.HomeNotificationHandle = Handle;
})(Backbone, jQuery, window.$$MIS);
