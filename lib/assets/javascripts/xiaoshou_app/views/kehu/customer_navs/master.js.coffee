class Mis.Views.KehuCustomerNavsMaster extends Mis.Base.View
  className: 'ul'

  template: JST['kehu/customer_navs/master']

  render: ->
    @$el.html(@template())
    @
