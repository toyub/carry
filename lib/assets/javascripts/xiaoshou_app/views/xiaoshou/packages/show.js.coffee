class Mis.Views.XiaoshouPackagesShow extends Mis.Base.View
  @include Mis.Mixins.Uploadable

  template: JST['xiaoshou/packages/show']

  initialize: ->
    @model.on('change', @render, @)

  render: ->
    @$el.html(@template(package: @model, view: @))
    @renderTop()
    @renderNav()
    @renderUploadTemplate()
    @renderPackageItems()
    @

  renderTop: ->
    view = new Mis.Views.XiaoshouSharedTop(collection: @collection, title: '套餐信息详情', redirect_url: 'package')
    @$("#mainTop").html view.render().el

  renderNav: ->
    view = new Mis.Views.XiaoshouPackageNavsMaster(model: @model, active: 'package')
    @$("#masterNav").html view.render().el

  packageEditUrl: ->
    "#store_packages/#{@model.id}/edit"

  renderPackageItems: ->
    @$("#packageItemList").show() if @model.package_setting.items.length > 0
    @model.package_setting.items.each @renderPackageItem

  renderPackageItem: (item) =>
    view = new Mis.Views.XiaoshouPackageItemsItem(model: item)
    @$("#packageItemList").append view.render().el
