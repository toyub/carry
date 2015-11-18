class Mis.Views.XiaoshouPackagesShow extends Mis.Base.View
  @include Mis.Mixins.Uploadable

  template: JST['xiaoshou/packages/show']

  events:
    'click #editPackage': 'goToEdit'

  initialize: ->
    @model.on('change', @render, @)

  render: ->
    @$el.html(@template(package: @model))
    @renderTop()
    @renderNav()
    @renderUploadTemplate()
    @renderPackageItems()
    @

  renderTop: ->
    view = new Mis.Views.XiaoshouSharedTop(title: '套餐信息详情', redirect_url: Routes.xiaoshou_packages_path())
    @$("#mainTop").html view.render().el

  renderNav: ->
    view = new Mis.Views.XiaoshouPackageNavsMaster(model: @model, active: 'package')
    @$("#masterNav").html view.render().el

  goToEdit: ->
    view = new Mis.Views.XiaoshouPackagesEdit(model: @model)
    $("#bodyContent").html view.render().el

  renderPackageItems: ->
    @$("#packageItemList").show() if @model.package_setting.items.length > 0
    @model.package_setting.items.each @renderPackageItem

  renderPackageItem: (item) =>
    view = new Mis.Views.XiaoshouPackageItemsItem(model: item)
    @$("#packageItemList").append view.render().el
