jQuery(function($){
  $(document).on("click", 'a.js-add', function(){
    $("div.js-work-floatwindow-wrap").show();
    $.ajax({
      url: "/api/home/shortcuts",
      type: "get",
      success: function(data){
        var html = ""
        data.works.forEach(function(root_category){
          html += "<div class='item'>"
          html += "<h3>"+ root_category.name +"</h3>"
          html += "<ul class='menu-list'>"
          root_category.sub_categories.forEach(function(work){
            if(data.my_works != null){
              if(data.my_works.indexOf(work.idx.toString()) === -1){
                html += "<li>"
                html += "<a href='javascript:void(0)' class='sub-menu js-sub-menu' data-id='"+ work.idx +"' >"
                html += "<div class='menu-icons'>"
                html += "<i class='menu-icon icon "+ root_category.icon +" '></i>"
                html += "<i class='fa fa-check check-icon'></i>"
                html += "</div>"
                html += "<span class='menu-name'>"+ work.name +"</span>"
                html += "</a></li>"
              }
            }else{
              html += "<li>"
              html += "<a href='javascript:void(0)' class='sub-menu js-sub-menu' data-id='"+ work.idx +"' >"
              html += "<div class='menu-icons'>"
              html += "<i class='menu-icon icon "+ root_category.icon +" '></i>"
              html += "<i class='fa fa-check check-icon'></i>"
              html += "</div>"
              html += "<span class='menu-name'>"+ work.name +"</span>"
              html += "</a></li>"
            }
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
    $(this).parent().toggleClass("check");
    $(this).toggleClass("check");
  });

  $(document).on('click', 'button.js-confirm-btn', function(){
    var arr = new Array()
    $('a.js-sub-menu.check').each(function(i, value){
      var _this = this
      arr.push($(_this).data("id"));
    });

    if(arr == ""){
      ZhanchuangAlert("请选择所需要添加的图标!");
     return false
    }

    $.ajax({
      url: "/api/home/staff_shortcuts",
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
      url: "/api/home/staff_shortcuts",
      type: 'delete',
      data: {id: id},
      success: function(){
        $("li#"+ id).hide();
      }
    });
  });

});
