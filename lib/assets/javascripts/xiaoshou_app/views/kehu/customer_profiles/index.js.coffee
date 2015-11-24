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

  renderSearchForm: ->
    search = new Mis.Views.KehuCustomerProfilesSearchForm(@packageSearch)
    @renderChild(search)
    @$("#searchForm").html search.el

