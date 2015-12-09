class Mis.Views.XiaoshouPackageItemsShow extends Mis.Base.View
  className: 'creating_window do_list_new_page'

  template: JST['xiaoshou/package_items/show']

  events:
    'click #closeWithoutSave': 'close'

  render: ->
    @$el.html(@template(item: @model))
    @

  close: ->
    @leave()
