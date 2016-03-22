class Mis.Views.XiaoshouPackageOrderItems extends Mis.Base.View
  tagName: 'ul'

  template: JST['xiaoshou/package_order_items/package_order_item']

  render: ->
    @$el.html(@template(item: @model))
    @
