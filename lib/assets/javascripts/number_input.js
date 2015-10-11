jQuery(function($){
  $(document).on('input', '[num]', function(evt){
    var value = '';
    if(this.hasAttribute('int')){
       value = parseInt(this.value);
    }else{
      value = parseFloat(this.value);
    }
    if(!!value){
      this.value = value;
    }else{
      this.value = '';
    }
  });
  
  $(document).on('keypress', '[num]', function(evt){
    /**
    *Special keyCode:
    * keyCode 45 -
    * keyCode 46 .
    */    
    if(evt.keyCode != 45 && evt.keyCode != 46 && (evt.keyCode < 48 || evt.keyCode > 57)){
      return false;
    }

    if(evt.keyCode == 45){
      if(this.selectionStart != 0){return false;}
      if(this.hasAttribute('un')){return false;}
      if((/-/).test(this.value)){return false;}
    }

    if(evt.keyCode == 46){
      if(this.selectionStart == 0){return false;}
      if(this.hasAttribute('int')){return false;}
      if((/\.+/).test(this.value)){return false;}
    }
  });
  $('[num]').each(function(){
    if(this.hasAttribute('int') && this.hasAttribute('un')){
      this.title = 'Only accept unsigned integer';
    }else if(this.hasAttribute('int')){
      this.title = 'Only accept integer';
    }else if(this.hasAttribute('un')){
      this.title = 'Only accept unsigned number';
    }else{
      this.title = 'Only accept number';
    }
  });
});