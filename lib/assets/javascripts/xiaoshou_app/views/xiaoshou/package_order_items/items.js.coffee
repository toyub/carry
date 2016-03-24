class Mis.Views.XiaoshouPackageOrderItems extends Mis.Base.View
  tagName: 'ul'

  template: JST['xiaoshou/package_order_items/package_order_item']

  initialize: (options) ->
    @index = options.index + 1

  render: ->
    @$el.html(@template(item: @model, index: @index))
    @
