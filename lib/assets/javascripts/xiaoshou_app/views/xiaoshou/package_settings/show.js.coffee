class Mis.Views.XiaoshouPackageSettingsShow extends Mis.Base.View

  template: JST['xiaoshou/package_settings/show']

  events:
    'click #goToEdit': 'goToEdit'

  initialize: ->
    @listenTo(@model, 'change', @render)

  render: ->
    @$el.html(@template(setting: @model))
    @renderTop()
    @renderNav()
    @renderPackage()
    @renderItems()
    @

  renderTop: ->
    top = new Mis.Views.XiaoshouSharedTop(title: '套餐设置详情', redirect_url: 'package')
    @renderChildInto(top, @$("#mainTop"))

  renderNav: ->
    nav = new Mis.Views.XiaoshouPackageNavsMaster(model: @model.store_package, active: 'setting')
    @renderChild(nav)
    @$("#masterNav").html nav.el

  renderPackage: ->
    view = new Mis.Views.XiaoshouPackageNavsSummary(package: @model.store_package)
    @renderChild(view)
    @$("#packageSummary").html view.el

  renderItems: ->
    @model.items.each @renderItem

  renderItem: (item) =>
    view = new Mis.Views.XiaoshouPackageItemsPackageItem(model: item, action: 'show')
    @renderChild(view)
    @$("#itemList").append view.el

  goToEdit: ->
    @leave()
    view = new Mis.Views.XiaoshouPackageSettingsEdit(model: @model)
    $("#bodyContent").html view.render().el
