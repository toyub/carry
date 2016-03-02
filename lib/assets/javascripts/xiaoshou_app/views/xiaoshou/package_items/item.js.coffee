class Mis.Views.XiaoshouPackageItemsItem extends Backbone.View
  tagName: 'ul'

  className: 'list_content'

  initialize: (options) ->
    @index = options.index + 1

  template: JST['xiaoshou/package_items/item']

  render: ->
    @$el.html(@template(item: @model, index: @index))
    @
