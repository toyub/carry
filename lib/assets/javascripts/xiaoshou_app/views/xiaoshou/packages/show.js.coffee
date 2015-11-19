class Mis.Views.XiaoshouPackagesShow extends Mis.Base.View
  @include Mis.Mixins.Uploadable

  template: JST['xiaoshou/packages/show']

  initialize: ->
    @listenTo(@model, 'change', @render)

  render: ->
    @$el.html(@template(package: @model, view: @))
    @renderTop()
    @renderNav()
    @renderUploadTemplate()
    @renderPackageItems()
    @

  renderTop: ->
    top = new Mis.Views.XiaoshouSharedTop(title: '套餐信息详情', redirect_url: 'package')
    @renderChild(top)
    @$("#mainTop").html top.el

  renderNav: ->
    nav = new Mis.Views.XiaoshouPackageNavsMaster(model: @model, active: 'package')
    @renderChild(nav)
    @$("#masterNav").html nav.el

  packageEditUrl: ->
    "#store_packages/#{@model.id}/edit"

  renderPackageItems: ->
    @$("#packageItemList").show() if @model.package_setting.items.length > 0
    @model.package_setting.items.each @renderPackageItem

  renderPackageItem: (item) =>
    item = new Mis.Views.XiaoshouPackageItemsItem(model: item)
    @renderChild(item)
    @$("#packageItemList").append item.el
