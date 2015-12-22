(function(win, doc, Backbone, $$MIS){
  var Order = Backbone.Model.extend({


    queuing: function(){
      console.log(this.get('status'))
      return this.get('status') == 'pending';
    },
    progressing: function(){
      return this.get('status') == 1;
    },
    paying: function(){
      return this.get('status') == 2;
    },
    finished: function(){
      return this.get('status') == 3;
    }
  });
  win.$$MIS = $$MIS || {};
  win.$$MIS.Order = Order;
})(window, document, Backbone, window.$$MIS);
