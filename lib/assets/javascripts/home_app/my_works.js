jQuery(function($){
  $(document).on("click", 'a.js-add', function(){
    $("div.js-work-floatwindow-wrap").show();
  });

  $(document).on('click', 'a.js-close-work-floatwindow-wrap', function(){
    $("div.js-work-floatwindow-wrap").hide();
  });

  $(document).on("click", 'a.js-sub-menu', function(){
    var value = $("input#"+$(this).data("id")).val();
    if(value.length > 0){
      $("input#"+$(this).data("id")).val("");
      $(this).parent().attr("class", "");
    }else {
      $("input#"+$(this).data("id")).val($(this).data("id"));
      $(this).parent().attr("class", "check");
    }
  });

  $(document).on('click', 'button.js-confirm-btn', function(){
    var arr = new Array()
    $('#works_form input').each(function(i){
      if($(this).val().length > 0){
        arr.push($(this).val());
      }
    });

    $.ajax({
      url: "/api/home/store_staff",
      type: 'put',
      data: {value: arr},
      success: function(data){
        $("div.js-work-floatwindow-wrap").hide();
        var html = ""
            if(data.my_works != null){
              data.works.forEach(function(work){
                if(data.my_works.indexOf(work.idx.toString()) !== -1){
                  html += "<li class='item'>"
                  html += "<a href='"+ work.url +"'>"
                  html += "<div class='item-icon'>"
                  html += "<i class='icon "+ work.icon +"'></i></div>"
                  html += "<span class='item-menu'>"
                  html += work.name
                  html += "</span></a></li>"
                }
              })
            }
            $("ul.js-work-menu").html(html)
      }
    });
  });

});
