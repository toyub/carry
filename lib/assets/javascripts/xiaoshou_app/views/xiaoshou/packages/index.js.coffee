class Mis.Views.XiaoshouPackagesIndex extends Backbone.View

  el: '#packageIndex'

  initialize: ->
    console.log 'xxx'

  events:
    'click div.item-query.c_price li': 'sortByPrice'
    'click div.prices li.submit': 'filterByPrice'
    'click div.item-query.screen li': 'filterByDate'
    'submit #store_service_search': 'searchOnSubmit'
    'click #newPackage': 'goToNew'

  render: ->
    @renderStats()
    @renderPackages()
    @

  renderStats: ->
    view = new Mis.Views.XiaoshouSharedStats(count: @collection.length, resource_name: '套餐')
    @$("#stats").html view.render().el

  renderPackages: ->
    if @collection.length
      @$("#packageList").removeClass("no_search_result").empty()
      @collection.each @renderPackage
    else
      view = new Mis.Views.XiaoshouSharedNone(cols: 8, resource_name: '套餐')
      @$("#packageList").addClass("no_search_result").html view.render().el

  renderPackage: (p) ->
    view = new Mis.Views.XiaoshouPackagesItem(model: p)
    @$("#packageList").append view.render().el

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

  searchOnSubmit: (event) ->
    event.preventDefault()

    options =
      reset: true
      data:
        q: {}
    $.extend(options['data'], $("form").serializeJSON())
    @collection.fetch(options)

  sort: =>
    $("div.prices li.item input").each(
      ->
        $(@).val($(@).parent().attr('data-filter'))
    )
    options =
      reset: true
      data:
        q: {}

    $.extend(options['data'], $("form").serializeJSON())
    $.extend(options['data']['q'], @filterParams())
    options['data']['q']['s'] = @sortParams()
    @collection.fetch(options)

  sortParams:  =>
    current = $("div.item-query.c_price a.active").parent()
    sortName = current.attr('data-name')
    sortDirection = current.attr('data-sort-direction')
    "#{sortName} #{sortDirection}"

  filterParams: =>
    options = {}
    $("li.j_active").each(
      ->
        options[$(@).attr('data-name')] = $(@).attr('data-filter')
    )
    options

  goToNew: ->
    model = new Mis.Models.StorePackage()
    view = new Mis.Views.XiaoshouPackagesNew(model: model)
    $("#bodyContent").html(view.render().el)
