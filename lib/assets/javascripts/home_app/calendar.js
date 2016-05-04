jQuery(function($){
  $('.js-add-event, .js-show-event').attr('disabled', true);

  $('.calendar').on('click', '.day', function(){

    if($(this).hasClass('prev-month')) {
      ZhanchuangAlert('请返回上个月查看');
    }else if($(this).hasClass('next-month')){
      ZhanchuangAlert('请去往下个月查看');
    }else {
      var date = $('.simple-calendar table').data('month') + "-" + +$(this).text().match(/\d+/)[0];

      $(".calendar-floatwindow-wrap, .show-floatwindow-wrap").slideUp();
      $(this).parents("tbody").find('td').removeClass("active");
      $(this).addClass('active');

      $("#schedule_form .schedule-date").val(date);
      $("#schedule_form .calendar-start-date").val($('.simple-calendar table').data('start-date'));

      $('.js-add-event, .js-show-event').attr('disabled', false);
    }


  });

  $(".js-add-event").on('click', function(){
    if(!$(this).attr('disabled')) {
      var target_wrap  = $(this).data('target');
      $(target_wrap).slideDown();
      $(target_wrap).on("click", '.cancel-btn, .close', function(){
        $(target_wrap).slideUp();
      })
    }
  })

  $('.js-show-event').on('click', function(){
    if(!$(this).attr('disabled')) {
      var url = '/api/home/schedules/search?date=' + $("#schedule_form .schedule-date").val();
      $.ajax({
        url: url,
        dataType: 'script',
        success: function(res){
        }
      })
    }
  })

});
