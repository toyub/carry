class Mis.Views.XiaoshouPackageProfilesIndex extends Mis.Base.View
  @include Mis.Views.Concerns.Top
  @include Mis.Views.Concerns.Searchable

  template: JST['xiaoshou/package_profiles/index']

  initialize: ->
    @search()

  render: ->
    @$el.html(@template())
    @renderTop()
    @searchResource()
    @

  columns: ->
    8

  resourceName: ->
    '套餐'