jQuery(function($){
  $(document).on("click", 'a.js-add', function(){
    $("div.js-work-floatwindow-wrap").show();
    $.ajax({
      url: "/api/home/my_works",
      type: "get",
      success: function(data){
        var html = ""
        data.works.forEach(function(root_category){
          html += "<div class='item'>"
          html += "<h3>"+ root_category.name +"</h3>"
          html += "<ul class='menu-list'>"
          root_category.sub_categories.forEach(function(work){
            if(data.my_works != null){
              if(data.my_works.indexOf(work.idx.toString()) !== -1){
                console.log("1");
                html += "<li class='check'>"
              }else {
                html += "<li>"
              }
            }else{
              console.log("2");
              html += "<li>"
            }
            html += "<a href='javascript:void(0)' class='sub-menu js-sub-menu' data-id='"+ work.idx +"' >"
            if(data.my_works != null){
              if(data.my_works.indexOf(work.idx.toString()) !== -1){
                html += "<input type='hidden' name='works["+ work.idx +"]' id="+ work.idx +" value="+ work.idx +" >"
              }else{
                html += "<input type='hidden' name='works["+ work.idx +"]' id="+ work.idx +" value='' >"
              }
            }else{
              html += "<input type='hidden' name='works["+ work.idx +"]' id="+ work.idx +" value='' >"
            }
            html += "<div class='menu-icons'>"
            html += "<i class='menu-icon icon "+ root_category.icon +" '></i>"
            html += "<i class='fa fa-check check-icon'></i>"
            html += "</div>"
            html += "<span class='menu-name'>"+ work.name +"</span>"
            html += "</a></li>"
          })
          html += "</ul></div>"
        });
        $("form#works_form").html(html)
      }
    });
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
                  html += "<li class='item' id="+ work.idx +">"
                  html += "<a class='close js-close-my-work' data-id='"+ work.idx +"'>"
                  html += "<i class='fa fa-close'></i></a>"
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

  $(document).on('click', 'a.js-close-my-work', function(e){
    e.preventDefault();
    var id = $(this).data("id")
    $.ajax({
      url: "/api/home/store_staff",
      type: 'delete',
      data: {id: id},
      success: function(){
        $("li#"+ id).hide();
      }
    });
  });

});
