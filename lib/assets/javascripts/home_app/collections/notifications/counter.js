(function(Backbone, $, $$MIS ){
  window.$$MIS = $$MIS || {};
  window.$$MIS.Collections = window.$$MIS.Collections || {};

  var Counter = Backbone.Collection.extend({
    url:'/api/home/notifications/counters',
    model: $$MIS.Models.NotificationCounter
  });

  window.$$MIS.Collections.NotificationCounter = Counter;
})(Backbone, jQuery, window.$$MIS);
