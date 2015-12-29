jQuery(function($){
  $(window.document).on("click", 'input.toggleable', function(){
     if(this.dataset.checked){
       this.checked = false;
       this.removeAttribute('checked');
       this.dataset.checked = '';
       $("[data-id='"+this.dataset.target+"']").attr('disabled', true);
       this.value = false;
     }else{
       this.checked = true;
       this.setAttribute('checked', true);
       this.dataset.checked = 'checked';
       $("[data-id='"+this.dataset.target+"']").removeAttr('disabled');
       $("[data-id='"+this.dataset.target+"']").first().focus();
       this.value=true;
     }

  });
});
