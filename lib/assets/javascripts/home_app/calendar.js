jQuery(function($){
  $('.calendar').on('click', '.day', function(){

    var date = $('.simple-calendar table').data('month') + "-" + +$(this).text().match(/\d+/)[0];

    $(".calendar-floatwindow-wrap, .show-floatwindow-wrap").slideUp();
    $(this).parents("tbody").find('td').removeClass("active");
    $(this).addClass('active');

    $("#schedule_form .schedule-date").val(date);
    $("#schedule_form .calendar-start-date").val($('.simple-calendar table').data('start-date'));
    $(".js-add-event").on('click', function(){
      var target_wrap  = $(this).data('target');
      $(target_wrap).slideDown();
      $(target_wrap).on("click", '.cancel-btn, .close', function(){
        $(target_wrap).slideUp();
      })
    })

    $('.js-show-events').on('click', function(){
      var url = '/api/home/schedules/search?date=' + date
      $.ajax({
        url: url,
        dataType: 'script',
        success: function(res){
          var target_wrap  = $(".js-show-events").data('target');
          $(target_wrap).slideDown();
          $(".page-numbers a").eq(0).addClass('active');
          $(".page-numbers").on('click', 'a', function(){
            $(this).addClass('active').siblings('a').removeClass('active');
            get_current_schedule($(this).data('schedule-id'))
          })
          $(target_wrap).on("click", '.cancel-btn, .close', function(){
            $(target_wrap).slideUp();
            $(".show-floatwindow").remove();
          })
        }
      })
    })

  });

  get_current_schedule = function(id){
    var url = 'api/home/schedules/' + id;
    $.ajax({
      url: url,
      dataType: 'script',
      success: function(res){
      }
    })
  }

});
