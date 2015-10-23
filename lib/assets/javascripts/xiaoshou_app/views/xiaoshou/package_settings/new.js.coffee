class Mis.Views.XiaoshouPackageSettingsNew extends Backbone.View

  template: JST['xiaoshou/package_settings/new']

  render: ->
    @$el.html(@template(setting: @model))
    @renderNav()
    @renderSubNav()
    @renderPackage()
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
