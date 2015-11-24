class Mis.Views.XiaoshouPackageProfilesIndex extends Mis.Base.View
  @include Mis.Views.Concerns.Top
  @include Mis.Views.Concerns.Searchable

  template: JST['xiaoshou/package_profiles/index']

  initialize: ->
    @search()

  render: ->
    @$el.html(@template())
    @renderTop()
    @renderSearchForm()
    @renderPackages()
    @

  renderPackages: ->
    if @filteredCollection.length
      @$("tbody").removeClass("no_search_result").empty()
      @filteredCollection.each @renderPackage
    else
      none = new Mis.Views.XiaoshouSharedNone(cols: 8, resource_name: '套餐')
      @renderChild(none)
      @$("tbody").addClass("no_search_result").html none.el

  renderPackage: (p) =>
    row = new Mis.Views.XiaoshouPackageProfilesItem(model: p)
    @appendChildTo(row, @$("tbody"))
