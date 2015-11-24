Mis.Views.Concerns.Searchable =
  search: () ->
    @resource = s.capitalize(s.underscored(@constructor.name).split("_")[1])
    cons = eval("Mis.#{@resource}Search")
    @resourceSearch = new cons(@collection)
    @filteredCollection = @resourceSearch.filteredCollection

    renderResources = eval("this.render#{@resource}s")
    @listenTo(@filteredCollection, 'add', renderResources)
    @listenTo(@filteredCollection, 'remove', renderResources)
    @listenTo(@filteredCollection, 'reset', renderResources)

  renderSearchForm: ->
    cons = eval("Mis.Views.#{@constructor.name.replace('Index', 'SearchForm')}")
    search = new cons(@resourceSearch)
    @renderChild(search)
    @$("#searchForm").html search.el
