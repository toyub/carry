class Mis.Views.KehuCustomerProfilesIndex extends Mis.Base.View
  @include Mis.Views.Concerns.Top
  @include Mis.Views.Concerns.Searchable

  template: JST['kehu/customer_profiles/index']

  initialize: ->
    @search()

  render: ->
    @$el.html(@template())
    @renderTop()
    @renderSearchForm()
    @renderCustomers()
    @

  renderCustomers: ->
    @filteredCollection.each @renderCustomer

  renderCustomer: (customer) =>
    row = new Mis.Views.KehuCustomerProfilesItem(model: customer)
    @appendChildTo(row, @$("tbody"))
