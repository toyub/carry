(function(){

  function FormDialog(content, opt){
    opt = opt || {};
    opt = $.extend({
      close: {
        btn: 'a.close'
      }
    }, opt);

    this.hide =  function(){
      this.dialog.hide();
      this.overlay.hide();
    }

    this.overlay = $('<div>').addClass('overlay').appendTo('body');
    this.dialog = $('<div>').addClass('modalDialog')
                           .html("<a href='javascript:void(0)' class='close'>×</a>")
                           .append(content).appendTo('body');
    _this = this;
    var css_left = (window.screen.width - this.dialog.width())/2;
    this.dialog.css({top: '200px', left: css_left + 'px'})
    if(!opt)return;
    if(opt.cancel){
      this.dialog.on('click', opt.cancel.btn, function(evt){
        _this.overlay.hide();
        _this.dialog.hide();
        if(opt.cancel.callback){
          opt.cancel.callback.call(_this, evt, this)
        }
      });
    }

    if(opt.confirm){
      this.dialog.on('click', opt.confirm.btn, function(evt){
        _this.overlay.hide();
        _this.dialog.hide();
        if(opt.confirm.callback){
          opt.confirm.callback.call(_this, evt, this)
        }
      });
    }

    if(opt.close){
      this.dialog.on('click', opt.close.btn, function(evt){
        _this.overlay.hide();
        _this.dialog.hide();
        if(opt.close.callback){
          opt.close.callback.call(_this, evt, this)
        }
      });
    }
  }
  window.form_dialog = function(content, opt){
    return new FormDialog(content, opt);
  }
})(window, jQuery)
