(function(Backbone, $, $$MIS ){
  window.$$MIS = $$MIS || {};
  window.$$MIS.Models = window.$$MIS.Models || {};
  var dom_classes = {
    'Notifications::WorkReminder': "icon icon-envelope envelope",
    'Notifications::SystemBulletin': "fa fa-cog",
    'Notifications::TrackingReminder': "icon icon-phone",
    'Notifications::CalendarScheduleReminder': "fa fa-calendar",
    'UNDEFINED1': "fa fa-commenting",
    'UNDEFINED2': "fa fa-university"
  };

  var types={
    'Notifications::WorkReminder': "work_reminders",
    'Notifications::TrackingReminder': "tracking_reminders",
    'Notifications::CalendarScheduleReminder': "calendar_schedule_reminders",
    'Notifications::SystemBulletin': "system_bulletins"
  }

  var Counter = Backbone.Model.extend({
    urlRoot:'/api/home/notifications/counters',
    getDomClass: function(){
      return dom_classes[this.attributes.type];
    },
    getResourceType: function(){
      return types[this.attributes.type]
    },
    attrs: function(){
      var _attrs = _.clone(this.attributes);
      _attrs.dom_class = this.getDomClass();
      _attrs.resource_type = this.getResourceType();
      return _attrs;
    }
  });
  window.$$MIS.Models.NotificationCounter = Counter;
})(Backbone, jQuery, window.$$MIS);
