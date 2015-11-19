class Mis.Views.XiaoshouPackagesEdit extends Mis.Base.View
  @include Mis.Mixins.Uploadable

  template: JST['xiaoshou/packages/edit']

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

  renderTop: ->
    top = new Mis.Views.XiaoshouSharedTop(title: '套餐信息编辑', redirect_url: 'package')
    @renderChild(top)
    @$("#mainTop").html top.el

  renderNav: ->
    nav = new Mis.Views.XiaoshouPackageNavsMaster(model: @model, active: 'package')
    @renderChild(nav)
    @$("#masterNav").html nav.el

  renderForm: ->
    form = new Mis.Views.XiaoshouPackagesForm(model: @model)
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

  renderPackageItem: (item) =>
    item = new Mis.Views.XiaoshouPackageItemsItem(model: item)
    @renderChild(item)
    @$("#packageItemList").append item.el
