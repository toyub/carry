class Mis.Views.KehuCustomerProfilesSearchForm extends Mis.Base.View
  className: 'search_nav'

  template: JST['kehu/customer_profiles/search_form']

  initialize: (search) ->
    @serviceSearch = search

  render: ->
    @$el.html(@template())
    @
