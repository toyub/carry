class Mis.Views.XiaoshouPackageItemsForm extends Mis.Base.View
  className: 'creating_window do_list_new_page'

  template: JST['xiaoshou/package_items/form']

  initialize: (options) ->
    Backbone.Validation.bind(@)
    @listenTo(@model, 'invalid', @invalid)

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
    trigger_error = true
    if @model.package_setting
      if @model.isValid(trigger_error)
        @model.package_setting.items.add @model
        @close()
      else
        @model.unset()

  confirm_item_price: (msg) ->
    $.confirm
      text: msg,
      confirm: =>
        @add_new_item()

  saveOnClick: ->
    attrs = @$el.find("input, select").serializeJSON()
    invalidErrors = @model.validate(attrs)
    if invalidErrors
      @showErrorMessage(invalidErrors)
      return false

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

  openServiceItem: (evt)->
    if evt
      @activeThisButton(evt.currentTarget)
    @model.set('package_itemable_type', "StoreService")
    view = new Mis.Views.XiaoshouPackageItemsService(model: @model)
    @renderChildInto(view, @$("#itemsCreateContents"))
    @currentView.leave() if @currentView
    @currentView = view

  openDepositItem: (evt)->
    if evt
      @activeThisButton(evt.currentTarget)
    @model.set('package_itemable_type', "StoreDepositCard")
    view = new Mis.Views.XiaoshouPackageItemsDeposit(model: @model)
    @renderChildInto(view, @$("#itemsCreateContents"))
    @currentView.leave() if @currentView
    @currentView = view

  openMaterialItem: (evt)->
    if evt
      @activeThisButton(evt.currentTarget)
    @model.set('package_itemable_type', "StoreMaterialSaleinfo")
    view = new Mis.Views.XiaoshouPackageItemsMaterial(model: @model)
    @renderChildInto(view, @$("#itemsCreateContents"))
    @currentView.leave() if @currentView
    @currentView = view

  invalid: (model, errors) ->
    @showErrorMessage(errors)

  activeThisButton: (btn)->
    @$el.find('.active').removeClass('active')
    $(btn).addClass('active')

  showErrorMessage: (errors) ->
    html = '无法保存套餐项目设定,原因:'
    for key, value of errors
      html = html + "<br/> " + value

    ZhanchuangAlert(html)
