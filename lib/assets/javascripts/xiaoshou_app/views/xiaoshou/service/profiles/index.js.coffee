class Mis.Views.XiaoshouServiceProfilesIndex extends Mis.Base.View
  @include Mis.Views.Concerns.Top
  @include Mis.Views.Concerns.Searchable

  template: JST['xiaoshou/service/profiles/index']

  initialize: ->
    @search()

  render: ->
    @$el.html(@template())
    @renderTop()
    @searchResource()
    @

  columns: ->
    12

  resourceName: ->
    '服务'

  searchFormAction: (resource) ->
    new Mis.Views.XiaoshouServiceProfilesSearchForm(resource)

  resourceItem: (options) ->
    new Mis.Views.XiaoshouServiceProfilesItem(options)

  rootResource: ->
    "service"

  subResource: ->
    "profiles"

  action: ->
    "index"
