class Mis.Views.XiaoshouPackagesNew extends Mis.Base.View
  @include Mis.Mixins.Uploadable

  template: JST['xiaoshou/packages/new']

  initialize: ->
    Backbone.Validation.bind(@)
    @model.on('sync', @handleSuccess, @)

  events:
    'submit #createPackage': 'createOnSubmit'
    'click li img': 'previewImage'

  render: ->
    @$el.html(@template())
    @renderNav()
    @renderUploadTemplate()
    @

  renderNav: ->
    view = new Mis.Views.XiaoshouPackageNavsMaster(model: @model, active: 'package')
    @$("#masterNav").html view.render().el

  createOnSubmit: ->
    event.preventDefault()
    @model.set $("#createPackage").serializeJSON()
    @model.save() if @model.isValid(true)

  handleSuccess: ->
    @uploadImages()
    @goToShow()

  goToShow: ->
    view = new Mis.Views.XiaoshouPackagesShow(model: @model)
    $("#bodyContent").html view.render().el

  previewImage: (e) ->
    img = new Image()
    img.src = e.target.src
    $("#material_img_preview").html(img)
