(
  ($) ->
    $.alert = (options, e) ->
      $('.alert-modal').remove() if $('.alert-modal').length > 0

      dataOptions = {}

      settings = $.extend {}, $.alert.options, {
        close: (o) ->
          $(".alert-modal").fadeOut()
        button: null
      }, dataOptions, options

      modalHTML =
      '<div id="FloatWindow" class="alert-modal">' +
        '<div class="FloatContent " >' +
          '<div class="bg-color-311951 float_head"></div>' +
          '<div class="fheader">' +
            '<span>' + settings.title + '</span>' +
            '<i class="lnr lnr-cross close_window"></i>' +
          '</div>' +
          '<div class="textbody float-left">' +
            '<div class="float-left width-50 text-align-center">' +
             '<i class="lnr lnr-info font-34"></i>' +
            '</div>' +
           '<div class="float-left font-14 " style="width:380px; line-height:30px;">' +
             settings.text +
            '</div >' +
          '</div>' +
          '<div class="ffooter">' +
            '<input type="submit" name="commit" value="确认"  class="confirm_btn close">' +
          '</div>' +
        '</div>' +
      '</div>'
      modal = $(modalHTML)

      modal.find(".close").click( -> settings.close(settings.button) )

      modal.find("i").click(
        ->
          settings.close(settings.button)
      )

      $("body").append(modal)
      modal.fadeIn()

    $.alert.options =
      text: "你确认吗?"
      title: "系统提示"
) jQuery
