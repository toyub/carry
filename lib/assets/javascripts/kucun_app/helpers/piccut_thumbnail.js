jQuery(function($){
  $('#material_img_thumbnails').on('click', 'li>img', function(evt){
    if(!$("#material_img_preview>img").length){
      var img = new Image();
      img.src = this.src;
      $("#material_img_preview").append(img);
    }else{
      $("#material_img_preview>img")[0].src = this.src;
    }
  });
});
