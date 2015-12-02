(function(win, doc, $){
  var file_reader = new FileReader();


  function PiccutDialog(width, heigth, callback){

    if($('div.piccut').length > 0){
      var $dialog = $('div.piccut');
    }else{
      var $dialog = $('<div>').addClass('piccut');
      var $capture = $('<div>').addClass('capture');
      $capture.css({
        width: width + 'px',
        heigth: heigth + 'px'
      });
      $dialog.append($capture);
      var $arrange = $('<div>').addClass('arrange');
      $dialog.append($arrange);

      $dialog.append('<div class="buttons"><input type="file" class="imgfile" accept="image/jpeg,image/png" /><button class="button crop margin-right-20">截图</button><button class="button cancel">取消</button></div>');

      $dialog.on('change', 'input[type=file]', function(){
        var f1 = this.files.item(0);
        if(f1.type == 'image/png' || f1.type == 'image/jpeg'){
          file_reader.readAsDataURL(f1, 'image/png');
        }else{
          alert('错误的文件格式，请选择PNG或JPG格式的图片文件！');
          this.value = '';
        }
      });
      $dialog.appendTo('body');
    }

    if(!file_reader.onload){
      file_reader.onload = function(){
        $arrange.html('');
        var image = new Image();
        image.className = "resize-image";
        image.id = 'image_tag';
        image.src = this.result;

        var div = document.createElement("div");
        div.className = 'gallery';
        div.appendChild(image);

        $arrange.append(div);

        PictureCut(image, $dialog.find('.crop')[0], function(){
          $dialog.hide();
          callback.call(this);
        });
      }
    }
    $dialog.show();
  }

  win.PiccutDialog = PiccutDialog;

})(window, document, jQuery)
