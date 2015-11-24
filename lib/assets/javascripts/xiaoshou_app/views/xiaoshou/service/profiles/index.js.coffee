class Mis.Views.XiaoshouServiceProfilesIndex extends Mis.Base.View
  @include Mis.Views.Concerns.Top
  @include Mis.Views.Concerns.Searchable

  template: JST['xiaoshou/service/profiles/index']

  initialize: ->
    @search()

  render: ->
    @$el.html(@template())
    @renderTop()
    @renderSearchForm()
    @renderServices()
    @

  renderServices: ->
    if @filteredCollection.length
      @$("tbody").removeClass("no_search_result").empty()
      @filteredCollection.each @renderService
    else
      none = new Mis.Views.XiaoshouSharedNone(cols: 12, resource_name: '服务')
      @renderChild(none)
      @$("tbody").addClass("no_search_result").html none.el

  renderService: (service) =>
    view = new Mis.Views.XiaoshouServiceProfilesItem(model: service)
    @appendChildTo(view, @$("tbody"))
