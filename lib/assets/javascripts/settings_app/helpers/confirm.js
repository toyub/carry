confirm_dialog = function(html, opt){
  var overlay = $('<div>').addClass('overlay').appendTo('body');
  var dialog = $('<div>').addClass('modalDialog')
                         .html("<a href='javascript:void(0)' class='close'>×</a>")
                         .append(html).appendTo('body');
  var css_left = (window.screen.width - dialog.width())/2;
  dialog.css({top: '200px', left: css_left + 'px'})
  if(!opt)return;
  if(opt.cancel){
    dialog.on('click', opt.cancel.btn, function(evt){
      overlay.hide();
      dialog.hide();
      if(opt.cancel.callback){
        opt.cancel.callback.call(dialog, evt, this)
      }
    });
  }

  if(opt.confirm){
    dialog.on('click', opt.confirm.btn, function(evt){
      overlay.hide();
      dialog.hide();
      if(opt.confirm.callback){
        opt.confirm.callback.call(dialog, evt, this)
      }
    });
  }

  if(opt.close){
    dialog.on('click', opt.close.btn, function(evt){
      overlay.hide();
      dialog.hide();
      if(opt.close.callback){
        opt.close.callback.call(dialog, evt, this)
      }
    });
  }
}
