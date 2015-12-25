class Mis.Views.KehuCustomerProfilesShow extends Mis.Base.View
  @include Mis.Views.Concerns.Top

  template: JST['kehu/customer_profiles/show']

  initialize: ->

  render: ->
    @$el.html(@template(entity: @model))
    @renderTop()
    @renderNav()
    @

  renderNav: ->
    nav = new Mis.Views.KehuCustomerNavsMaster(model: @model.storeCustomer)
    @appendChildTo(nav, @$(".details .details_nav"))

  rootResource: ->
    "customer"

  subResource: ->
    "profiles"

  action: ->
    "show"
