jQuery(function($){
  $(document).on('click', 'li.js-yesterday-data', function(){
    $("li.js-today-data").removeClass("active");
    $("li.js-yesterday-data").addClass("active");
    $("div.js-today-panel-body").hide();
    $("div.js-yesterday-panel-body").show();
  });

  $(document).on('click', 'li.js-today-data', function(){
    $("li.js-today-data").addClass("active");
    $("li.js-yesterday-data").removeClass("active");
    $("div.js-today-panel-body").show();
    $("div.js-yesterday-panel-body").hide();
  });
});
