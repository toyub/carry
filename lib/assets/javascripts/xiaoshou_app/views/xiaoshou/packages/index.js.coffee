class Mis.Views.XiaoshouPackagesIndex extends Support.CompositeView

  template: JST['xiaoshou/packages/index']

  initialize: ->
    @listenTo(@collection, 'add', @renderPackage)

  events:
    'click div.item-query.c_price li': 'sortByPrice'
    'click div.prices li.submit': 'filterByPrice'
    'click div.item-query.screen li': 'filterByDate'
    'click #newPackage': 'goToNew'

  render: ->
    @$el.html(@template())
    @renderTop()
    @renderSearchForm()
    @renderPackages()
    @

  renderTop: ->
    top = new Mis.Views.XiaoshouSharedTop(title: '套餐列表')
    @renderChild(top)
    @$("#mainTop").html top.el

  renderSearchForm: ->
    search = new Mis.Views.XiaoshouSharedSearchForm(collection: @collection)
    @renderChild(search)
    @$("#searchForm").html search.el

  renderPackages: ->
    if @collection.length
      @$("#packageList").removeClass("no_search_result").empty()
      @collection.each @renderPackage
    else
      none = new Mis.Views.XiaoshouSharedNone(cols: 8, resource_name: '套餐')
      @renderChild(none)
      @$("#packageList").addClass("no_search_result").html none.el

  renderPackage: (p) =>
    row = new Mis.Views.XiaoshouPackagesItem(model: p)
    @renderChild(row)
    @$("#packageList").append row.el

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
    view = new Mis.Views.XiaoshouPackagesNew(model: model, collection: @collection)
    $("#bodyContent").html(view.render().el)
