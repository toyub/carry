class Mis.Views.XiaoshouPackageItemsItem extends Backbone.View
  tagName: 'ul'

  className: 'list_content'

  template: JST['xiaoshou/package_items/item']

  render: ->
    @$el.html(@template(@model.attributes))
    @
