(function(Backbone, $, $$MIS ){
  window.$$MIS = $$MIS || {};
  window.$$MIS.Models = window.$$MIS.Models || {};
  var dom_classes = {
    'Notifications::WorkReminder': "fa fa-envelope",
    'Notifications::TrackingReminder': "fa fa-phone",
    'NOTD': "fa fa-commenting",
    'Notifications::CalendarScheduleReminder': "fa fa-calendar",
    'NOTD2': "fa fa-cog",
    'NOTD3': "fa fa-university"
  };

  var Counter = Backbone.Model.extend({
    urlRoot:'/api/home/notifications/counters',
    getDomClass: function(){
      return dom_classes[this.attributes.type];
    },
    attrs: function(){
      var _attrs = _.clone(this.attributes);
      _attrs.dom_class = this.getDomClass();
      return _attrs;
    }
  });
  window.$$MIS.Models.NotificationCounter = Counter;
})(Backbone, jQuery, window.$$MIS);
