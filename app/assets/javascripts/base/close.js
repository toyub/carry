jQuery(function($){
  $(window.document).on('click','span.close',function(){
  $("[data-id='"+this.dataset.target+"']").remove();
  });

  var close={
    doclose:function(closeElement,hideElement){

      if(closeElement==null){
        closeElement=".do_close";
      }
      $(document).on("click",closeElement,function(){
        console.log(hideElement);
        $(hideElement).hide();
      })
    }
  }
  close.doclose(".do_close","#FloatWindow");

  close.doclose(".do_close",".window_wrap");
});
