class Mis.Views.XiaoshouPackageItemsDeposit extends Backbone.View
  tagName: 'ul'

  className: 'fee_charge_wrap wrap'

  template: JST['xiaoshou/package_items/deposit']

  render: ->
    @$el.html(@template())
    @

  open: ->
    @$("select").select2()
    @$el.show()
