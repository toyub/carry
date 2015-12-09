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

  saveOnClick: ->
    attrs = @$el.find("input, select").serializeJSON()
    @model.clear(silent: true)
    @model.set attrs
    if @model.isValid(true)
      @model.package_setting.items.add @model
      @close()

  close: ->
    @leave()

  renderItemForm: ->
    switch @model.get('package_itemable_type')
      when 'StoreMaterial' then @openMaterialItem()
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
