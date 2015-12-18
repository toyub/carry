class Mis.Views.KehuCustomerProfilesNew extends Mis.Base.View
  @include Mis.Views.Concerns.Top
  @include Mis.Views.Concerns.Validateable

  template: JST['kehu/customer_profiles/form']

  initialize: ->
    @validateBinding()
    @listenTo(@model, 'sync', @handleSuccess)

  events:
    'submit #customerForm': 'createCustomer'

  render: ->
    @$el.html(@template(customer: @model, view: @))
    @renderTop()
    @renderNav()
    @

  renderNav: ->
    nav = new Mis.Views.KehuCustomerNavsMaster()
    @appendChildTo(nav, @$(".details .details_nav"))

  createCustomer: (e) ->
    e.preventDefault()
    @model.set @$("#customerForm").serializeJSON()
    @modle.save() if @model.isValid(true)

  handleSuccess: ->
    @collection.add @model
    @goToShow()

  goToShow: ->
    window.location.hash = "#{@goToUrl()}/#{@model.id}"

  goToUrl: ->
    "#store_customers"
