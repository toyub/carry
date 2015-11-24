class Mis.Views.KehuCustomerProfilesSearchForm extends Mis.Base.View
  className: 'search_nav'

  template: JST['kehu/customer_profiles/search_form']

  events:
    'click #searchCustomers': 'search'

  initialize: (search) ->
    @customerSearch = search

  render: ->
    @$el.html(@template())
    @

  search: (e) ->
    e.preventDefault()

    @customerSearch.search(reset: true, data: @$el.find("input").serializeJSON())
