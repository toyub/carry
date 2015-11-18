class Mis.Views.XiaoshouPackagesEdit extends Mis.Base.View
  @include Mis.Mixins.Uploadable

  template: JST['xiaoshou/packages/edit']

  initialize: ->
    @model.on("sync", @handleSuccess, @)

  events:
    'submit #updatePackage': 'updateOnSubmit'
    'click #goToShow': 'goToShow'

  render: ->
    @$el.html(@template(package: @model))
    @renderTop()
    @renderNav()
    @renderUploadTemplate()
    @renderForm()
    @renderPackageItems()
    @

  renderTop: ->
    view = new Mis.Views.XiaoshouSharedTop(collection: @collection, title: '套餐信息编辑', redirect_url: 'package')
    @$("#mainTop").html view.render().el

  renderNav: ->
    view = new Mis.Views.XiaoshouPackageNavsMaster(model: @model, active: 'package')
    @$("#masterNav").html view.render().el

  renderForm: ->
    view = new Mis.Views.XiaoshouPackagesForm(model: @model)
    @$("#packageForm").html view.render().el

  updateOnSubmit: ->
    event.preventDefault()
    @model.set $("#updatePackage").serializeJSON()
    @model.save() if @model.isValid(true)

  goToShow: ->
    view = new Mis.Views.XiaoshouPackagesShow(model: @model, collection: @collection)
    $("#bodyContent").html view.render().el

  handleSuccess: ->
    @uploadImages()
    @goToShow()

  renderPackageItems: ->
    @$("#packageItemList").show() if @model.package_setting.items.length > 0
    @model.package_setting.items.each @renderPackageItem

  renderPackageItem: (item) =>
    view = new Mis.Views.XiaoshouPackageItemsItem(model: item)
    @$("#packageItemList").append view.render().el
