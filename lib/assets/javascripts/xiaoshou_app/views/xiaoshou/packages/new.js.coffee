class Mis.Views.XiaoshouPackagesNew extends Mis.Base.View
  @include Mis.Mixins.Uploadable

  template: JST['xiaoshou/packages/new']

  initialize: ->
    Backbone.Validation.bind(@)
    @model.on('sync', @handleSuccess, @)

  events:
    'submit #createPackage': 'createOnSubmit'

  render: ->
    @$el.html(@template())
    @renderTop()
    @renderNav()
    @renderUploadTemplate()
    @

  renderTop: ->
    view = new Mis.Views.XiaoshouSharedTop(title: '套餐详情新建', redirect_url: Routes.xiaoshou_packages_path())
    @$("#mainTop").html view.render().el

  renderNav: ->
    view = new Mis.Views.XiaoshouPackageNavsMaster(model: @model, active: 'package')
    @$("#masterNav").html view.render().el

  createOnSubmit: ->
    event.preventDefault()
    @model.set $("#createPackage").serializeJSON()
    @model.save() if @model.isValid(true)

  handleSuccess: ->
    @uploadImages()
