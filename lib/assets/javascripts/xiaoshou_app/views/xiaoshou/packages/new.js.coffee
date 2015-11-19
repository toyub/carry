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
    top = new Mis.Views.XiaoshouSharedTop(title: '套餐详情新建', redirect_url: 'package')
    @renderChild(top)
    @$("#mainTop").html top.el

  renderNav: ->
    nav = new Mis.Views.XiaoshouPackageNavsMaster(model: @model, active: 'package')
    @renderChild(nav)
    @$("#masterNav").html nav.el

  createOnSubmit: ->
    event.preventDefault()
    @model.set $("#createPackage").serializeJSON()
    @model.save() if @model.isValid(true)

  handleSuccess: ->
    @uploadImages()
