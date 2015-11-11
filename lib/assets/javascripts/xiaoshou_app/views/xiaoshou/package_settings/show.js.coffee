class Mis.Views.XiaoshouPackageSettingsShow extends Backbone.View

  template: JST['xiaoshou/package_settings/show']

  events:
    'click #goToEdit': 'goToEdit'

  render: ->
    @$el.html(@template(setting: @model))
    @renderNav()
    @renderSubNav()
    @renderPackage()
    @renderItems()
    @

  renderNav: ->
    view = new Mis.Views.XiaoshouPackageNavsMaster()
    @$("#masterNav").html view.render().el

  renderSubNav: ->
    view = new Mis.Views.XiaoshouPackageNavsSub()
    @$("#subNav").html view.render().el

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
