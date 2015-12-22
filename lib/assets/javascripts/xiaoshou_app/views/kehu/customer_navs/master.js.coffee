class Mis.Views.KehuCustomerNavsMaster extends Mis.Base.View
  tagName: 'ul'

  template: JST['kehu/customer_navs/master']

  render: ->
    @$el.html(@template(customer: @model))
    @
