jQuery(function($){
  $(window.document).on("click", 'input[type="radio"].toggleable', function(){
     if(this.dataset.checked){
       this.checked = false;
       this.dataset.checked = '';
     }else{
       this.checked = true;
       this.dataset.checked = 'checked';
     }
  });
});