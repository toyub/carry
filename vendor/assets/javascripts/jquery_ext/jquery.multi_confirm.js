(function ($) {
  $.fn.multiConfirm = function (options) {
    if (typeof options === 'undefined') {
      options = {};
    }

    this.click(function (e) {
      e.preventDefault();

      var newOptions = $.extend({
          button: $(this)
      }, options);

      $.multiConfirm(newOptions, e);
    });

    return this;
  };

  $.multiConfirm = function (options, e) {
    if ($('.confirmation-modal').length > 0)
        return;

    var dataOptions = {};
    if (options.button) {
      var dataOptionsMapping = {
          'title': 'title',
          'text': 'text',
      };
      $.each(dataOptionsMapping, function(attributeName, optionName) {
        var value = options.button.data(attributeName);
        if (value) {
            dataOptions[optionName] = value;
        }
      });
    }

    var settings = $.extend({}, $.multiConfirm.options, {
      exchange: function () {
      },
      terminate: function () {
      },
      cancel: function (o) {
        $("#FloatWindow").fadeOut();
      },
      button: null
    }, dataOptions, options);

    // Modal
    var modalHeader = '';
    var modalHTML =
      '<div id="FloatWindow" >' +
        '<div class="FloatContent " >' +
          '<div class="bg-color-311951 float_head"></div>' +
             '<div class="fheader">' +
               '<span>' + settings.title + '</span>' +
               '<i class="lnr lnr-cross close_window do_close"></i>' +
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
            '<input type="button"  name="reset"  value="取消"  class="cancel_btn js-cancel">' +
            '<input type="button"  name="exchange"  value="' + settings.exchangeButton + '"  class="confirm_btn js-exchange">' +
            '<input type="button" name="terminate" value="' + settings.termianteButton + '"  class="confirm_btn js-terminate">' +
          '</div>' +
        '</div>' +
      '</div>'
    var modal = $(modalHTML);

    modal.find("i").click(function(){
      settings.cancel(settings.button);
      modal.remove()
    });
    modal.find(".js-cancel").click(function(){
      settings.cancel(settings.button);
      modal.remove()
    })
    modal.find(".js-exchange").click(function () {
      settings.exchange(settings.button);
      settings.cancel(settings.button);
      modal.remove()
    });
    modal.find(".js-terminate").click(function () {
      settings.terminate(settings.button);
      settings.cancel(settings.button);
      modal.remove()
    });

    $("body").append(modal);
    modal.fadeIn();
  };

  $.multiConfirm.options = {
      text: "是否确定?",
      title: "系统提示",
      confirmButton: "确定",
      cancelButton: "取消",
      exchangeButton: "切换工位",
      termianteButton: "结束流程",
  }
})(jQuery);
