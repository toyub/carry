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
      '<div id="noticebox" style="display: none;" class="alert-modal">' +
        '<div class="notice-content width640" style="display: block;">' + 
              '<div class="fheader">' + 
                '<span>' + settings.title + '</span>' +
                '<i class="lnr lnr-cross close-window"></i>' +
              '</div>' +
              '<div class="textbody">' +
                '<p>' + settings.text + '</p>' +
              '</div>' +
              '<div class="ffooter">' +
                '<input type="submit" name="commit" value="确认" class="confirm_btn float-right close">' +
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
      title: "提示"
) jQuery
