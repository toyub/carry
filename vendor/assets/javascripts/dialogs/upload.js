(function(win, $){
  var tmpl =
    '<div class="FloatContent">'+
      '<div class="bg-color-311951 float_head"></div>'+
      '<div class="uploading_progress_window">'+
        '<p>正在上传文件，请不要关闭窗口或刷新浏览器</p>'+
        "<ul id='progress_list'></ul>"+
        '<p id="upload_completed" style="display:none">上传完成！</p>'+
        '<div class="btn_group"><input class="save_btn btn disabled" value="确定" type="button"></div>'+
    '</div></div>';

    function dialog(){
      var dialog;
      if($("#FloatWindow").length > 0){
        dialog = $('#FloatWindow');
      }else{
        dialog = $('<div id="FloatWindow">');
        dialog.appendTo('body')
      }
      if(!dialog.hasClass('progress')){
        dialog.addClass('progress');
        dialog.html(tmpl);
        dialog.on('click', 'input.save_btn', function(){
          if(this.classList.contains('disabled')){return false;}
          dialog.hide();
          dialog.trigger('closed');
        });
      }
      return dialog;
    }

    var UploadDialog = {
      show: function(opt){
        if(!this.instance){
          this.instance = dialog();
          this.progress_list = this.instance.find('#progress_list');
          if(opt && opt.close){
            this.instance.on('closed', opt.close);
          }
        }
        this.instance.show();
      },
      add_progress: function(idx){
        this.progress_list.append('<li><span>正在上传文件' + idx +'</span><progress upid='+ idx +' value="0" max="100"></progress></li>');
      },
      up_progress: function(idx, position){
        this.progress_list.find('[upid='+ idx +']').val(position);
      },
      close: function(callback){
        this.instance.hide();
        if(callback){
          callback.call(this);
        }
      },
      enable_btn: function(){
        this.instance.find('input.save_btn').removeClass("disabled");
      },
      show_msg: function(){
        this.instance.find('#upload_completed').show();
      },
      completed: function(){
        this.instance.find('#upload_completed').show();
        this.enable_btn();
      }
    };
    window.UploadDialog = UploadDialog;
})(window, jQuery);
