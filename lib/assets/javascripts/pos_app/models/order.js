(function(win, doc, Backbone, $$MIS){
  var Order = Backbone.Model.extend({


    queuing: function(){
      return this.get('state') == 'queuing';
    },
    processing: function(){
      return this.get('state') == 'processing';
    },
    paying: function(){
      return this.get('state') == 'paying';
    },
    finished: function(){
      return this.get('state') == 'finished';
    }
  });
  win.$$MIS = $$MIS || {};
  win.$$MIS.Order = Order;
})(window, document, Backbone, window.$$MIS);
