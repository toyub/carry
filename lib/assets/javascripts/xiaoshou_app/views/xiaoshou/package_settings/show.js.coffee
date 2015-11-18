class Mis.Views.XiaoshouPackageSettingsShow extends Backbone.View

  template: JST['xiaoshou/package_settings/show']

  events:
    'click #goToEdit': 'goToEdit'

  initialize: ->
    @model.on('change', @render, @)

  render: ->
    @$el.html(@template(setting: @model))
    @renderNav()
    @renderPackage()
    @renderItems()
    @

  renderNav: ->
    view = new Mis.Views.XiaoshouPackageNavsMaster(model: @model.store_package, active: 'setting')
    @$("#masterNav").html view.render().el

  renderPackage: ->
    view = new Mis.Views.XiaoshouPackageNavsSummary(package: @model.store_package)
    @$("#packageSummary").html view.render().el

  renderItems: ->
    @model.items.each @renderItem

  renderItem: (item) =>
    view = new Mis.Views.XiaoshouPackageItemsPackageItem(model: item, action: 'show')
    @$("#itemList").append view.render().el

  goToEdit: ->
    view = new Mis.Views.XiaoshouPackageSettingsEdit(model: @model)
    $("#bodyContent").html view.render().el
