class Mis.Views.XiaoshouPackageSalesShow extends Mis.Base.View
  @include Mis.Views.Concerns.Top

  template: JST['xiaoshou/package_sales/show']

  events: ->
    'click #js-search' : 'searchOnClick'

  initialize: ->
    @listenTo(@model, 'change', @render)

  render: ->
    @$el.html(@template(package: @model.store_package))
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
    for item, index in @model.store_package.get('order_items')
      @renderOrderItem(item, index)

  renderOrderItem: (item, index) =>
    view = new Mis.Views.XiaoshouPackageOrderItems(model: item, index: index)
    @renderChild(view)
    @$("#package_order_items").append view.el

  searchOnClick: ->
    beginning = $("input[name='created_at_gteq']").val()
    end = $("input[name='created_at_lteq']").val()
    params = {
      'q': {
        'created_at_gteq': beginning,
        'created_at_lteq': end
      }
    }
    $.get("/api/store_packages/#{@model.store_package.id}", params, @set_order_items)

  set_order_items: (store_package) =>
    @$("#package_order_items").html('')
    @model.store_package.get('order_items').length = 0
    for item in store_package.order_items
      @model.store_package.get('order_items').push item
    @renderOrderItems()

  rootResource: ->
    "package"

  subResource: ->
    "sales"

  action: ->
    "show"
