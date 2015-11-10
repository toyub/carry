class Mis.Views.XiaoshouPackageItemsPackageItem extends Backbone.View
  tagName: 'ul'

  className: 'items_content'

  template: JST['xiaoshou/package_items/package_item']

  initialize: ->
    @package_setting = @model.package_setting

    @model.on('remove', @remove, @)
    @model.on('change', @render, @)

  events:
    'click span.delete': 'clear'
    'click label.name': 'edit'

  render: ->
    @$el.html(@template(item: @model))
    @

  clear: ->
    @package_setting.items.remove @model

  remove: ->
    @model.off()
    @undelegateEvents()
    @$el.remove()

  edit: ->
    view = new Mis.Views.XiaoshouPackageItemsForm(model: @model)
    view.open()
