class Mis.Views.XiaoshouPackageItemsListItem extends Backbone.View
  tagName: 'ul'

  className: 'list_content'

  template: JST['xiaoshou/package_items/list_item']

  render: ->
    @$el.html(@template(item: @model))
    @
