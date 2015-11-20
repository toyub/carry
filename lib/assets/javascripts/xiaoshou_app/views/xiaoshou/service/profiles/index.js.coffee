class Mis.Views.XiaoshouServiceProfilesIndex extends Mis.Base.View
  template: JST['xiaoshou/service/profiles/index']

  initialize: ->
    @serviceSearch = new Mis.ServiceSearch(@collection)

    @listenTo(@serviceSearch.filteredCollection, 'add', @renderServices)
    @listenTo(@serviceSearch.filteredCollection, 'remove', @renderServices)
    @listenTo(@serviceSearch.filteredCollection, 'reset', @renderServices)

  render: ->
    @$el.html(@template())
    @renderSearchForm()
    @renderServices()
    @

  renderSearchForm: ->
    search = new Mis.Views.XiaoshouServiceProfilesSearchForm(@serviceSearch)
    @renderChild(search)
    @$("#searchForm").html search.el

  renderServices: ->
    if @collection.length
      @$("#serviceList").removeClass("no_search_result").empty()
      @serviceSearch.filteredCollection.each @renderService
    else
      none = new Mis.Views.XiaoshouSharedNone(cols: 12, resource_name: '服务')
      @renderChild(none)
      @$("#serviceList").addClass("no_search_result").html none.el

  renderService: (service) =>
    view = new Mis.Views.XiaoshouServiceProfilesItem(model: service)
    @appendChildTo(view, @$("#serviceList"))
