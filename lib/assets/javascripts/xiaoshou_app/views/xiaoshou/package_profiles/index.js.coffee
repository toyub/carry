class Mis.Views.XiaoshouPackageProfilesIndex extends Mis.Base.View
  @include Mis.Views.Concerns.Top

  template: JST['xiaoshou/package_profiles/index']

  initialize: ->
    @packageSearch = new Mis.PackageSearch(@collection)

    @listenTo(@packageSearch.filteredCollection, 'add', @renderPackages)
    @listenTo(@packageSearch.filteredCollection, 'remove', @renderPackages)
    @listenTo(@packageSearch.filteredCollection, 'reset', @renderPackages)

  render: ->
    @$el.html(@template())
    @renderTop()
    @renderSearchForm()
    @renderPackages()
    @

  renderSearchForm: ->
    search = new Mis.Views.XiaoshouSharedSearchForm(@packageSearch)
    @renderChild(search)
    @$("#searchForm").html search.el

  renderPackages: ->
    if @collection.length
      @$("#packageList").removeClass("no_search_result").empty()
      @packageSearch.filteredCollection.each @renderPackage
    else
      none = new Mis.Views.XiaoshouSharedNone(cols: 8, resource_name: '套餐')
      @renderChild(none)
      @$("#packageList").addClass("no_search_result").html none.el

  renderPackage: (p) =>
    row = new Mis.Views.XiaoshouPackageProfilesItem(model: p)
    @renderChild(row)
    @$("#packageList").append row.el
