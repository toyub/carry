class Mis.Views.XiaoshouPackageProfilesEdit extends Mis.Base.View
  @include Mis.Mixins.Uploadable
  @include Mis.Views.Concerns.Top

  template: JST['xiaoshou/package_profiles/edit']

  initialize: ->
    @listenTo(@model, 'sync', @handleSuccess)

  events:
    'submit #updatePackage': 'updateOnSubmit'

  render: ->
    @$el.html(@template(package: @model, view: @))
    @renderTop()
    @renderNav()
    @renderUploadTemplate()
    @renderForm()
    @renderPackageItems()
    @

  renderNav: ->
    nav = new Mis.Views.XiaoshouPackageNavsMaster(model: @model, active: 'package')
    @renderChild(nav)
    @$("#masterNav").html nav.el

  renderForm: ->
    form = new Mis.Views.XiaoshouPackageProfilesForm(model: @model)
    @renderChild(form)
    @$("#packageForm").html form.el

  updateOnSubmit: ->
    event.preventDefault()
    @model.set $("#updatePackage").serializeJSON()
    @model.save() if @model.isValid(true)

  packageUrl: ->
    "#store_packages/#{@model.id}"

  handleSuccess: ->
    @uploadImages()

  renderPackageItems: ->
    @$("#packageItemList").show() if @model.package_setting.items.length > 0
    @model.package_setting.items.each @renderPackageItem

  renderPackageItem: (item, index) =>
    item = new Mis.Views.XiaoshouPackageItemsItem(model: item, index: index)
    @renderChild(item)
    @$("#packageItemList").append item.el

  rootResource: ->
    "package"

  subResource: ->
    "profiles"

  action: ->
    "edit"
