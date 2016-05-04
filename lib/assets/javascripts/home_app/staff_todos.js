jQuery(function($){
    $("#new-todo").keyup(function(event){
       if(event.keyCode == 13){
         var pushContent = $("#new-todo").val();
         if(pushContent != ""){
           $.ajax({
             url: "/api/home/staff_todos",
             type: "Post",
             data: {content: pushContent },
             success: function(data){
               $("#new-todo").val("");
               var html = ""
                   html += "<li class='item'>"
                   html += "<span class='choose-icon'>"
                   html += "<label class='unchecked' for='check_"
                   html += data.todo.id
                   html += "'></label>"
                   html += "<input type='checkbox' value="
                   html += data.todo.id
                   html += " data-id="
                   html += data.todo.id
                   html += " id='check_"
                   html += data.todo.id
                   html += "'>"
                   html += "</span><div class='item-content'>"
                   html += "<span class='text acronyms js-text_"+ data.todo.id + "'>"
                   html += data.todo.content
                   html += "</span><i class='lnr lnr-chevron-down js-lnr' data-id='"+ data.todo.id +"'></i>"
                   html += "</div></li>"
              allTodos();
              highLightAllTodo();
              $("ul.js-planning-list").append(html);
             },
             error: function(response){
               ZhanchuangAlert(response.responseJSON.msg);
             }
           });
         }else {
           ZhanchuangAlert("请输入有效的内容!");
         };
       }
      });

      function doneTodos(){
          $.ajax({
            url: "/api/home/staff_todos",
            type: "get",
            success: function(data){
              var html = ""
              if(data.done.length > 0){
                data.done.forEach(function(todo){
                      html += "<li class='item'>"
                      html += "<span class='choose-icon'>"
                      html += "<label class='fa fa-check-circle check' for='check_"
                      html += todo.id
                      html += "'></label>"
                      html += "<input type='checkbox' value="
                      html += todo.id
                      html += " data-id="
                      html += todo.id
                      html += " id='check_"
                      html += todo.id
                      html += "'>"
                      html += "</span><div class='item-content'>"
                      html += "<span class='text acronyms js-text_"+ todo.id + "'>"
                      html += todo.content
                      html += "</span><i class='lnr lnr-chevron-down js-lnr' data-id='"+ todo.id +"'></i>"
                      html += "</div></li>"
                });
              };
              $("ul.js-planning-list").html(html);
            }
          });
      };


      function unfinishedTodos(){
          $.ajax({
            url: "/api/home/staff_todos",
            type: "get",
            success: function(data){
              var html = ""
              if(data.undone.length > 0){
                data.undone.forEach(function(todo){
                  html += "<li class='item'>"
                  html += "<span class='choose-icon'>"
                  html += "<label class='unchecked' for='check_"
                  html += todo.id
                  html += "'></label>"
                  html += "<input type='checkbox' value="
                  html += todo.id
                  html += " data-id="
                  html += todo.id
                  html += " id='check_"
                  html += todo.id
                  html += "'>"
                  html += "</span><div class='item-content'>"
                  html += "<span class='text acronyms js-text_"+ todo.id + "'>"
                  html += todo.content
                  html += "</span><i class='lnr lnr-chevron-down js-lnr' data-id='"+ todo.id +"'></i>"
                  html += "</div></li>"
                });
              };
              $("ul.js-planning-list").html(html);
            }
          });
      };


      function allTodos(){
          $.ajax({
            url: "/api/home/staff_todos",
            type: "get",
            success: function(data){
              var html = ""
              if(data.todos.length > 0){
                data.todos.forEach(function(todo){
                  html += "<li class='item'>"
                  html += "<span class='choose-icon'>"
                  html += todo.done == true ? "<label class='fa fa-check-circle check' for='check_" + todo.id + "'></label>" : "<label class='unchecked' for='check_" + todo.id +"'></label>"
                  html += "<input type='checkbox' value="
                  html += todo.id
                  html += " data-id="
                  html += todo.id
                  html += " id='check_" + todo.id +"'>"
                  html += "</span><div class='item-content'>"
                  html += "<span class='text acronyms js-text_"+ todo.id + "'>"
                  html += todo.content
                  html += "</span><i class='lnr lnr-chevron-down js-lnr' data-id='"+ todo.id +"'></i>"
                  html += "</div></li>"
                });
              };
              $("ul.js-planning-list").html(html);
            }
          });
      };

      $(document).on('click','a#delete_done_todos', function(){
        $.ajax({
          url: "/api/home/staff_todos/clear_done",
          type: "get",
          success: function(data){
            doneTodos();
            highLightDoneTodo();
            ZhanchuangAlert(data.msg);
          }
        });
      });

      function highLightDoneTodo(){
        $("#done-todos").attr("class", "active")
        $("#unfinished-todos").attr("class", "");
        $("#all-todos").attr("class", "");
      };

      function highLightUnfinishedTodo(){
        $("#unfinished-todos").attr("class", "active");
        $("#all-todos").attr("class", "");
        $("#done-todos").attr("class", "");
      };

      function highLightAllTodo(){
        $("#unfinished-todos").attr("class", "");
        $("#all-todos").attr("class", "active");
        $("#done-todos").attr("class", "");
      };

      $(document).on('click', 'a#done-todos', function(){
        doneTodos();
        highLightDoneTodo();
      });

      $(document).on('click', 'a#unfinished-todos', function(){
        unfinishedTodos();
        highLightUnfinishedTodo();
      });

      $(document).on('click', 'a#all-todos', function(){
        allTodos();
        highLightAllTodo();
      });


      $(document).on('click',"input:checkbox",function(){
         var todoId = $(this).data("id");
         $.ajax({
           url: "/api/home/staff_todos/" + todoId,
           type: "put",
           success: function(data){
             if(data.todo.done == true){
               $("label[for=check_"+ todoId +"]").removeClass("unchecked").addClass("fa fa-check-circle check")
             }else{
               $("label[for=check_"+ todoId +"]").addClass("unchecked").removeClass("fa fa-check-circle check")
             }
           }
         });
   	 });

      $(document).on('click','i.js-lnr', function(){
        $(this).toggleClass("lnr-chevron-down lnr-chevron-up");
        $("span.js-text_"+ $(this).data("id")).toggleClass("acronyms");
      });

  });
