class Mis.Views.XiaoshouPackageItemsForm extends Mis.Base.View
  className: 'creating_window do_list_new_page'

  template: JST['xiaoshou/package_items/form']

  initialize: (options) ->
    Backbone.Validation.bind(@)
    @listenTo(@model, 'validated:invalid', @invalid)

  events:
    'click #saveAndClose': 'saveOnClick'
    'click #closeWithoutSave': 'close'
    'click #serviceItem': 'openServiceItem'
    'click #depositItem': 'openDepositItem'
    'click #materialItem': 'openMaterialItem'

  render: ->
    @$el.html(@template(item: @model))
    @renderItemForm()
    @

  add_new_item: ->
    if @model.isValid(true) && @model.package_setting
      @model.package_setting.items.add @model
      @close()
    @close()

  confirm_item_price: (msg) ->
    $.confirm
      text: msg,
      confirm: =>
        @add_new_item()

  saveOnClick: ->
    attrs = @$el.find("input, select").serializeJSON()
    @model.set attrs
    if @model.isStoreMaterial()
      if @model.price() - @model.cost_price() < 0
        @confirm_item_price('该商品设置的套餐价低于成本价，是否继续？')
      else if @model.price() - @model.retail_price() < 0
        @confirm_item_price('该商品设置的套餐价低于销售价，是否继续？')
      else
        @add_new_item()
    else if @model.isStoreService()
      if @model.price() - @model.retail_price() < 0
        @confirm_item_price('该服务设置的套餐价低于售价，是否继续？')
      else
        @add_new_item()
    else
      @add_new_item()

  close: ->
    @leave()

  renderItemForm: ->
    switch @model.get('package_itemable_type')
      when 'StoreMaterialSaleinfo' then @openMaterialItem()
      when 'StoreService' then @openServiceItem()
      when 'StoreDepositCard' then @openDepositItem()

  openServiceItem: ->
    view = new Mis.Views.XiaoshouPackageItemsService(model: @model)
    @renderChildInto(view, @$("#itemsCreateContents"))
    @currentView.leave() if @currentView
    @currentView = view

  openDepositItem: ->
    view = new Mis.Views.XiaoshouPackageItemsDeposit(model: @model)
    @renderChildInto(view, @$("#itemsCreateContents"))
    @currentView.leave() if @currentView
    @currentView = view

  openMaterialItem: ->
    view = new Mis.Views.XiaoshouPackageItemsMaterial(model: @model)
    @renderChildInto(view, @$("#itemsCreateContents"))
    @currentView.leave() if @currentView
    @currentView = view

  invalid: (model, errors) ->
    console.log errors
