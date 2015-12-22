class Mis.Views.KehuCustomerProfilesIndex extends Mis.Base.View
  @include Mis.Views.Concerns.Top
  @include Mis.Views.Concerns.Searchable

  template: JST['kehu/customer_profiles/index']

  initialize: ->
    @search()

  render: ->
    @$el.html(@template())
    @renderTop()
    @searchResource()
    @

  columns: ->
    15

  resourceName: ->
    '客户'

  searchFormAction: (resource) ->
    new Mis.Views.KehuCustomerProfilesSearchForm(resource)

  resourceItem: (options) ->
    new Mis.Views.KehuCustomerProfilesItem(options)
