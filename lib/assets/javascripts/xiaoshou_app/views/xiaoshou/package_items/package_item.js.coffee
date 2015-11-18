class Mis.Views.XiaoshouPackageItemsPackageItem extends Backbone.View
  tagName: 'ul'

  className: 'items_content'

  template: JST['xiaoshou/package_items/package_item']

  initialize: (options) ->
    @action = options.action if options
    @package_setting = @model.package_setting

    @model.on('remove', @remove, @)
    @model.on('change', @render, @)

  events:
    'click span.delete': 'clear'
    'click label.name': 'edit'

  render: ->
    @$el.html(@template(item: @model, view: @))
    @

  clear: ->
    @package_setting.items.remove @model

  remove: ->
    @model.off()
    @undelegateEvents()
    @$el.remove()

  isShow: ->
    @action == 'show'

  edit: ->
    if @isShow()
      view = new Mis.Views.XiaoshouPackageItemsShow(model: @model)
      view.open()
    else
      view = new Mis.Views.XiaoshouPackageItemsForm(model: @model)
      view.open()
