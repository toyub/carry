class Mis.Views.XiaoshouPackagesShow extends Mis.Base.View
  @include Mis.Mixins.Uploadable

  template: JST['xiaoshou/packages/show']

  events:
    'click #editPackage': 'goToEdit'

  initialize: ->
    @model.on('change', @render, @)

  render: ->
    @$el.html(@template(package: @model))
    @renderNav()
    @renderUploadTemplate()
    @renderPackageItems()
    @

  renderNav: ->
    view = new Mis.Views.XiaoshouPackageNavsMaster(model: @model, active: 'package')
    @$("#masterNav").html view.render().el

  renderSubNav: ->
    view = new Mis.Views.XiaoshouPackageNavsSub(package: @model)
    @$("#subNav").html view.render().el

  goToEdit: ->
    view = new Mis.Views.XiaoshouPackagesEdit(model: @model)
    $("#bodyContent").html view.render().el

  renderPackageItems: ->
    @$("#packageItemList").show() if @model.package_setting.items.length > 0
    @model.package_setting.items.each @renderPackageItem

  renderPackageItem: (item) =>
    view = new Mis.Views.XiaoshouPackageItemsItem(model: item)
    @$("#packageItemList").append view.render().el
