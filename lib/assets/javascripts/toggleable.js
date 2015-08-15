jQuery(function($){
  $(window.document).on("click", 'input.toggleable', function(){
     if(this.dataset.checked){
       this.checked = false;
       this.dataset.checked = '';
       $("[data-id='"+this.dataset.target+"']").attr('disabled', true);
     }else{
       this.checked = true;
       this.dataset.checked = 'checked';
       $("[data-id='"+this.dataset.target+"']").removeAttr('disabled');
       $("[data-id='"+this.dataset.target+"']").first().focus();
     }
  });
});
