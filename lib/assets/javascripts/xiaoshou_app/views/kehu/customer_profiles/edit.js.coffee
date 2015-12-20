class Mis.Views.KehuCustomerProfilesEdit extends Mis.Base.View
  @include Mis.Views.Concerns.Top
  @include Mis.Views.Concerns.Validateable

  template: JST['kehu/customer_profiles/form']

  initialize: ->
    @validateBinding()
    #@listenTo(@model, 'sync', @handleSuccess)

  events:
    'submit #customerForm': 'updateCustomer'
    'change .js-provinces': 'getCities'
    'change .js-cities': 'getRegions'

  render: ->
    @$el.html(@template(entity: @model, view: @))
    @renderTop()
    @renderNav()
    @

  renderNav: ->
    nav = new Mis.Views.KehuCustomerNavsMaster()
    @appendChildTo(nav, @$(".details .details_nav"))

  updateCustomer: (e) ->
    e.preventDefault()
    attrs = @$("#customerForm").serializeJSON()
    customerAttrs = attrs.store_customer
    settlementAttrs = attrs.store_customer_settlement
    @model.storeCustomer.set customerAttrs
    @model.storeCustomerSettlement.set settlementAttrs
    @model.set _.omit(attrs, "store_customer", "store_customer_settlement")
    if @model.isValid(true)
      @model.save {}, success: =>
        @handleSuccess()

  handleSuccess: ->
    @goToShow()

  goToShow: ->
    window.location.hash = @goToUrl()

  goToUrl: ->
    "#store_customers/#{@model.id}"

  getCities: (e) ->
    $(".js-regions").html "<option value=''>请选择</option>"
    $(".js-cities").html "<option value=''>请选择</option>"
    $.get("/api/store_customer_entities/cities", {province: $(".js-provinces").val()}, (data) ->
      _.each data, (city) ->
        $(".js-cities").append "<option value='#{city.code}'>#{city.name}</option>"
    )

  getRegions: (e) ->
    $(".js-regions").html "<option value=''>请选择</option>"
    $.get("/api/store_customer_entities/regions", {province: $(".js-provinces").val(), city: $(".js-cities").val()}, (data) ->
      _.each data, (region) ->
        $(".js-regions").append "<option value='#{region.code}'>#{region.name}</option>"
    )
