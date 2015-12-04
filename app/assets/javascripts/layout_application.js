$(document).ready(function(){
  var dropdownMenu={
    init: function(){
  		$(".nav_right").on("click","li",this.dropDown);
  	},

  	dropDown:function(e){
  		$(e.target).parents("li").toggleClass("open");
  		$(e.target).parents("li").siblings().removeClass("open")
  	}

  }
  dropdownMenu.init();
})
