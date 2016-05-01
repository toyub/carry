(function($$MIS){
  window.$$MIS = $$MIS || {};
  window.$$MIS.lib = window.$$MIS.lib || {};
  $(document).on('click', '#js-notifications .close', function(){
    $('#js-notifications').slideUp();
  })
  window.$$MIS.lib.NotificationDialog = function(content){
    $('#js-notifications').html(content);
    $('#js-notifications').show();
  }
})(window.$$MIS);
