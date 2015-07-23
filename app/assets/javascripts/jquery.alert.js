(function ($) {

  /**
  * author: issac lau
  * Show zhanchuang alert dialog
  * @param [options] {{title, text}}
  * @param [e] {Event}
  */
  $.alert = function (options, e) {

    // 如果存在alert modal,则删除
    if ($('.alert-modal').length > 0){
      $('.alert-modal').remove();
    }

    var dataOptions = {};

    var settings = $.extend({}, $.alert.options, {
      close: function (o) {
        $(".alert-modal").fadeOut();
      },
      button: null
    }, dataOptions, options);

    // Modal
    var modalHTML = 
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
    '</div>';


    var modal = $(modalHTML);

    modal.find(".close").click(function () {
      settings.close(settings.button);
    });

    modal.find("i").click(function () {
      settings.close(settings.button);
    });

    // Show the modal
    $("body").append(modal);
    modal.fadeIn();
  };

  /**
  * 全局定义
  */
  $.alert.options = {
    text: "你确认吗?",
    title: "提示"
  }
})(jQuery);
