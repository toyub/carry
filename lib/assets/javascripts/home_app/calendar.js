jQuery(function($){
  $('.calendar').on('click', '.day', function(){

    var date = $('.simple-calendar table').data('month') + "-" + +$(this).text().match(/\d+/)[0];

    $(".calendar-floatwindow-wrap, .show-floatwindow-wrap").slideUp();
    $(this).parents("tbody").find('td').removeClass("active");
    $(this).addClass('active');

    $("#schedule_form .schedule-date").val(date);
    $("#schedule_form .calendar-start-date").val($('.simple-calendar table').data('start-date'));

  });

  $(".js-add-event").on('click', function(){
    var target_wrap  = $(this).data('target');
    $(target_wrap).slideDown();
    $(target_wrap).on("click", '.cancel-btn, .close', function(){
      $(target_wrap).slideUp();
    })
  })

  $('.js-show-events').on('click', function(){

    var url = '/api/home/schedules/search?date=' + $("#schedule_form .schedule-date").val();
      $.ajax({
        url: url,
        dataType: 'script',
        success: function(res){
        }
      })
  })

});
