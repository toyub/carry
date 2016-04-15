class Mis.Views.KehuCustomerProfilesItem extends Mis.Base.View
  tagName: 'tr'

  template: JST['kehu/customer_profiles/item']

  initialize: (options) ->
    @index = options.index
    @listenTo(@model, 'remove', @leave)

  render: ->
    @$el.html(@template(entity: @model, view: @))
    @

  customerUrl: ->
    "#store_customers/#{@model.id}"
