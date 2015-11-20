class Mis.Views.XiaoshouPackageItemsDeposit extends Mis.Base.View
  tagName: 'ul'

  className: 'fee_charge_wrap wrap'

  template: JST['xiaoshou/package_items/deposit']

  render: ->
    @$el.html(@template(item: @model))
    @$("select").select2()
    @$el.show()
    @
