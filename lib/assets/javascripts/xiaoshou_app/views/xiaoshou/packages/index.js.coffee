class Mis.Views.XiaoshouPackagesIndex extends Mis.Base.View

  template: JST['xiaoshou/packages/index']

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

  renderTop: ->
    top = new Mis.Views.XiaoshouSharedTop(title: '套餐列表')
    @renderChild(top)
    @$("#mainTop").html top.el

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
    row = new Mis.Views.XiaoshouPackagesItem(model: p)
    @renderChild(row)
    @$("#packageList").append row.el
