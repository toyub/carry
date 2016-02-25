class Mis.Views.XiaoshouPackageProfilesShow extends Mis.Base.View
  @include Mis.Mixins.Uploadable
  @include Mis.Views.Concerns.Top

  template: JST['xiaoshou/package_profiles/show']

  initialize: ->
    @listenTo(@model, 'change', @render)

  render: ->
    @$el.html(@template(package: @model, view: @))
    @renderTop()
    @renderNav()
    @renderUploadTemplate()
    @renderPackageItems()
    @

  renderNav: ->
    nav = new Mis.Views.XiaoshouPackageNavsMaster(model: @model, active: 'package')
    @renderChild(nav)
    @$("#masterNav").html nav.el

  packageEditUrl: ->
    "#store_packages/#{@model.id}/edit"

  renderPackageItems: ->
    @$("#packageItemList").show() if @model.package_setting.items.length > 0
    @model.package_setting.items.each @renderPackageItem

  renderPackageItem: (item, index) =>
    item = new Mis.Views.XiaoshouPackageItemsItem(model: item, index: index)
    @renderChild(item)
    @$("#packageItemList").append item.el

  rootResource: ->
    "package"

  subResource: ->
    "profiles"

  action: ->
    "show"
