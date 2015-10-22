class Mis.Views.XiaoshouServiceProfilesIndex extends Backbone.View
  
  el: 'body'

  events:
    'click div.item-query.c_price li': 'sortByPrice'
    'click div.prices li.submit': 'filterByPrice'
    'click div.item-query.screen li': 'filterByDate'

  sortByPrice: (event) ->
    $(event.currentTarget).parent().prev().find("span:first").attr("title", $(event.currentTarget).text())
    $(event.currentTarget).parent().prev().find("span:first").text($(event.currentTarget).text())
    $(event.currentTarget).parent().prev().find("span i").attr('class', if $(event.currentTarget).attr("data-sort-derection") == 'asc' then 'fa fa-angle-up' else 'fa fa-angle-down')
    $(event.currentTarget).siblings().find("a").removeClass("active")
    $(event.currentTarget).find("a").addClass("active")
    @sort()

  filterByPrice: (event) ->
    $(event.currentTarget).parent().find("li.item").each(
      ->
        $(@).attr("data-filter", $(@).find("input").val())
    )
    @sort()

  filterByDate: (event) ->
    $(event.currentTarget).siblings().find("a").removeClass("active")
    $(event.currentTarget).find("a").addClass("active")
    $(event.currentTarget).siblings().removeClass("j_active")
    $(event.currentTarget).addClass("j_active")
    @sort()

  sort: =>
    $("div.prices li.item input").each(
      ->
        $(@).val($(@).parent().attr('data-filter'))
    )
    options =
      dataType: 'script'
      data:
        q: {}

    options['data']['q']['s'] = @sortParams()
    $.extend(options['data']['q'], @filterParams())
    console.log options
    $("form").ajaxSubmit(options)

  sortParams:  =>
    "#{$("div.item-query.c_price a.active").parent().attr('data-name')} #{$("div.item-query.c_price a.active").parent().attr('data-sort-direction')}"

  filterParams: =>
    options = {}
    $("li.j_active").each(
      ->
        options[$(@).attr('data-name')] = $(@).attr('data-filter')
    )
    console.log options
    options
