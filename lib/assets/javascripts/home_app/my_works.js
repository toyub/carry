jQuery(function($){
  var menu_tmpl = JST['home/shortcuts/menu'];
  var my_tmpl = JST['home/shortcuts/my'];
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
            var my_work = {
              root_category: root_category,
              idx: work.idx,
              name: work.name
            };
            html += menu_tmpl(my_work)
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
        var html = data.my_shortcuts.map(function(work){
            return my_tmpl(work)
        }).join('');
        
        $("ul.js-work-menu").html(html);
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
