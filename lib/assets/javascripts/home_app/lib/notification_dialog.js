(function($$MIS){
  window.$$MIS = $$MIS || {};
  window.$$MIS.lib = window.$$MIS.lib || {};
  $(document).on('click', '#js-notifications .close', function(){
    $('#js-notifications').slideUp();
    notification_dialog_handler.trigger('reload');
  });

  $(document).on('click', '#js-notifications .js-envelope-open', function(evt){
    var id = this.dataset.id;
    var btn = this;
    var options = {
      url: EnvelopeUrl(id),
      method: 'PUT',
      contentType: 'application/json',
      data: JSON.stringify({status: "open"}),
      success: function(){
        btn.value = '已阅';
        btn.className = 'read-btn disabled';
      }
    }
    $.ajax(options)
  });

  $(document).on('click', '#js-notifications .js-envelope-destroy', function(){
    var id = this.dataset.id;
    var tr = $(this).parents('tr');
    var options = {
      url: EnvelopeUrl(id),
      method: 'DELETE',
      success: function(){
        tr.fadeOut().remove();
      }
    }
    $.ajax(options)
  });

  var EnvelopeUrl = function(id){
    return '/api/home/notifications/envelopes/' + id;
  }


  var NotificationDialog = function(content){
    $('#js-notifications').html(content);
    $('#js-notifications').show();
  }

  function NotificationDialogHandler(){
    _.extend(this, Backbone.Events);
    this.show_dialog = function(content){
      NotificationDialog(content);
    }
  }

  var notification_dialog_handler = null;
  function getNotificationDialogHandlerInstance(){
    if(!notification_dialog_handler){
      notification_dialog_handler = new NotificationDialogHandler();
    }
    return notification_dialog_handler;
  }

  window.$$MIS.lib.getNotificationDialogHandlerInstance = getNotificationDialogHandlerInstance;
})(window.$$MIS);
