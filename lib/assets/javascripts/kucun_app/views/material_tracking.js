(function(win, doc, Backbone, $$MIS){
  var MaterialTrackingView = Backbone.View.extend({
    events: {
      "click input[name='tracking[enabled]']": 'tracking_toggle',
      "click input[name='tracking[contact_way]']": 'set_tracking_way'
    },
    tracking_toggle: function(event){
      var target = event.target;
      this.model.set('enabled', target.checked);
    },
    set_tracking_way: function(event){
      var target = event.target;
      this.model.set('contact_way', target.value);
    }

  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.MaterialTrackingView = MaterialTrackingView;
})(window, document, Backbone, window.$$MIS);
