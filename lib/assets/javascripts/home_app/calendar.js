jQuery(function($){
  var schedule_form = $(".calendar-floatwindow-wrap");
  $('.calendar').on('click', '.day', function(){
    var date = $(this).parents('table').data('month') + "-" + +$(this).text();

    $(this).parents("tbody").find('td').removeClass("hover");
    $(this).addClass('hover');

    schedule_form.slideDown();
    $("#schedule_form .schedule-date").val(date)

      $(schedule_form).on("click", '.cancel-btn, .close', function(){
        $(schedule_form).slideUp();
      })
  });

  $(".js-add-event, .js-show-events").on('click', function(){
    var target_wrap  = $(this).data('target');
    $(target_wrap).slideDown();

    var date = $('.simple-calendar table').data('month') + "-" + +$('.today').text();
    $("#schedule_form .schedule-date").val(date)

      $(target_wrap).on("click", '.cancel-btn, .close', function(){
        $(target_wrap).slideUp();
      })
  })
});
