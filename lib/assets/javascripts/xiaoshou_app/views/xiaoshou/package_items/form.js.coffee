class Mis.Views.XiaoshouPackageItemsForm extends Backbone.View
  className: 'creating_window do_list_new_page'

  template: JST['xiaoshou/package_items/form']

  initialize: (options) ->
    Backbone.Validation.bind(@)
    @model.on('validated:invalid', @invalid, @)
    console.log 123

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

  open: ->
    $("#newPackageItem").html @render().el
    $("#newPackageItem").show()

  saveOnClick: ->
    console.log 'add package items'
    attrs = @$el.find("input, select").serializeJSON()
    @model.clear(silent: true)
    @model.set attrs
    if @model.isValid(true)
      @model.package_setting.items.add @model
      @close()

  close: ->
    @undelegateEvents()
    $("#newPackageItem").hide()

  renderItemForm: ->
    switch @model.get('package_itemable_type')
      when 'StoreMaterial' then @openMaterialItem()
      when 'StoreService' then @openServiceItem()
      when 'StoreDepositCard' then @openDepositItem()

  openServiceItem: ->
    view = new Mis.Views.XiaoshouPackageItemsService(model: @model)
    @$("#itemsCreateContents").html view.render().el
    view.open()

  openDepositItem: ->
    view = new Mis.Views.XiaoshouPackageItemsDeposit(model: @model)
    @$("#itemsCreateContents").html view.render().el
    view.open()

  openMaterialItem: ->
    view = new Mis.Views.XiaoshouPackageItemsMaterial(model: @model)
    @$("#itemsCreateContents").html view.render().el
    view.open()

  invalid: (model, errors) ->
    console.log errors
