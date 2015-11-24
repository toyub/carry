class Mis.Views.KehuCustomerProfilesItem extends Mis.Base.View
  tagName: 'tr'

  template: JST['kehu/customer_profiles/item']

  initialize: ->
    @listenTo(@model, 'remove', @leave)

  render: ->
    @$el.html(@template(customer: @model, view: @))
    @

  customerUrl: ->
    "#store_customers/#{@model.id}"
