Mis.Views.Concerns.Searchable =
  search: () ->
    @resource = s.capitalize(s.underscored(@constructor.name).split("_")[1])
    @resourceSearch = new Mis.ResourceSearch(@collection)
    @filteredCollection = @resourceSearch.filteredCollection

    @listenTo(@filteredCollection, 'add', @renderResources)
    @listenTo(@filteredCollection, 'remove', @renderResources)
    @listenTo(@filteredCollection, 'reset', @renderResources)

  searchResource: ->
    @renderSearchForm()
    @renderResources()

  controllerName: ->
    "Mis.Views.#{@constructor.name.replace('Index', '')}"

  renderSearchForm: ->
    search = @searchFormAction(@resourceSearch)
    @prependChildTo(search, @$(".details .list_table"))

  renderResources: ->
    if @filteredCollection.length
      @$("tbody").removeClass("no_search_result").empty()
      @filteredCollection.each @renderResource, @
    else
      none = new Mis.Views.XiaoshouSharedNone(cols: @columns(), resource_name: @resourceName())
      @renderChild(none)
      @$("tbody").addClass("no_search_result").html none.el

  renderResource: (r, index) ->
    row = @resourceItem(model: r, index: index)
    @appendChildTo(row, @$("tbody"))

  columns: ->
    8

  resourceName: ->
    '套餐'
