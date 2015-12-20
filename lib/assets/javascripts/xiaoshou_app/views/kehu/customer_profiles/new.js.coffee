class Mis.Views.KehuCustomerProfilesNew extends Mis.Base.View
  @include Mis.Views.Concerns.Top
  @include Mis.Views.Concerns.Validateable

  template: JST['kehu/customer_profiles/form']

  initialize: ->
    @validateBinding()
    @listenTo(@model, 'sync', @handleSuccess)

  events:
    'submit #customerForm': 'createCustomer'
    'change .js-provinces': 'getCities'
    'change .js-cities': 'getRegions'

  render: ->
    @$el.html(@template(entity: @model, view: @))
    @renderTop()
    @renderNav()
    @

  renderNav: ->
    nav = new Mis.Views.KehuCustomerNavsMaster(model: @model.storeCustomer)
    @appendChildTo(nav, @$(".details .details_nav"))

  createCustomer: (e) ->
    e.preventDefault()
    attrs = @$("#customerForm").find("input, select, textarea").filter( -> $.trim(this.value).length > 0).serializeJSON()
    @model.set attrs
    console.log @model
    console.log @model.toJSON()
    @model.save() if @model.isValid(true)

  handleSuccess: ->
    @collection.add @model
    @goToShow()

  goToShow: ->
    window.location.hash = "#{@goToUrl()}/#{@model.id}"

  goToUrl: ->
    "#store_customers"

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
