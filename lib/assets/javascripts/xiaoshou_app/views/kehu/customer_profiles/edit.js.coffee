class Mis.Views.KehuCustomerProfilesEdit extends Mis.Base.View
  @include Mis.Views.Concerns.Top
  @include Mis.Views.Concerns.Validateable

  template: JST['kehu/customer_profiles/form']

  initialize: ->
    @validateBinding()
    @listenTo(@model, 'sync', @handleSuccess)

  events:
    'submit #customerForm': 'updateCustomer'

  render: ->
    @$el.html(@template(customer: @model, view: @))
    @renderTop()
    @renderNav()
    @

  renderNav: ->
    nav = new Mis.Views.KehuCustomerNavsMaster()
    @appendChildTo(nav, @$(".details .details_nav"))

  updateCustomer: (e) ->
    e.preventDefault()
    @model.set @$("#customerForm").serializeJSON()
    @modle.save() if @model.isValid(true)

  handleSuccess: ->
    @goToShow()

  goToShow: ->
    window.location.hash = @goToUrl()

  goToUrl: ->
    "#store_customers/#{@model.id}"
