(function($$MIS){
  window.$$MIS = $$MIS || {};
  window.$$MIS.lib = window.$$MIS.lib || {};
  $(document).on('click', '#js-notifications .close', function(){
    $('#js-notifications').slideUp();
  });

  $(document).on('click', '#js-notifications .js-envelope-open', function(evt){
    var id = this.dataset.id;
    var options = {
      url: EnvelopeUrl(id),
      method: 'PUT',
      contentType: 'application/json',
      data: JSON.stringify({status: "open"})
    }
    $.ajax(options)
  });

  $(document).on('click', '#js-notifications .js-envelope-destroy', function(){
    var id = this.dataset.id;
    var options = {
      url: EnvelopeUrl(id),
      method: 'DELETE'
    }
    $.ajax(options)
  });

  var EnvelopeUrl = function(id){
    return '/api/home/notifications/envelopes/' + id;
  }


  window.$$MIS.lib.NotificationDialog = function(content){
    $('#js-notifications').html(content);
    $('#js-notifications').show();
  }
})(window.$$MIS);
