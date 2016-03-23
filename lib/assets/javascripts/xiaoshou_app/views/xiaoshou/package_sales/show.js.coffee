class Mis.Views.XiaoshouPackageSalesShow extends Mis.Base.View
  @include Mis.Views.Concerns.Top

  template: JST['xiaoshou/package_sales/show']

  events:
    'click #js-search' : 'searchOrderItems'

  initialize: ->
    @listenTo(@model, 'change', @render)

  render: ->
    @$el.html(@template(setting: @model))
    @renderTop()
    @renderNav()
    @renderPackage()
    @renderItems()
    @renderOrderItems()
    @

  renderNav: ->
    nav = new Mis.Views.XiaoshouPackageNavsMaster(model: @model.store_package, active: 'sale')
    @renderChild(nav)
    @$("#masterNav").html nav.el

  renderPackage: ->
    view = new Mis.Views.XiaoshouPackageNavsSummary(package: @model.store_package)
    @renderChild(view)
    @$("#packageSummary").html view.el

  renderItems: ->
    @model.items.each @renderItem

  renderItem: (item, index) =>
    view = new Mis.Views.XiaoshouPackageItemsPackageItem(model: item, index: index, action: 'show')
    @renderChild(view)
    @$("#itemList").append view.el

  renderOrderItems: ->
    for item in @model.store_package.get('order_items')
      @renderOrderItem(item)

  renderOrderItem: (item) =>
    view = new Mis.Views.XiaoshouPackageOrderItems(model: item)
    @renderChild(view)
    @$("#package_order_items").append view.el

  searchOrderItems: ->


  rootResource: ->
    "package"

  subResource: ->
    "sales"

  action: ->
    "show"
