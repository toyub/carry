class Mis.Views.KehuCustomerProfilesShow extends Mis.Base.View
  @include Mis.Views.Concerns.Top

  template: JST['kehu/customer_profiles/show']

  initialize: ->

  render: ->
    @$el.html(@template())
    @renderTop()
    @
