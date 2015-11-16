class Mis.Views.XiaoshouPackagesNew extends Backbone.View

  template: JST['xiaoshou/packages/new']

  initialize: ->
    Backbone.Validation.bind(@)
    @model.on('sync', @handleSuccess, @)

  events:
    'submit #createPackage': 'createOnSubmit'
    'click a.add_img': 'openImageForm'
    'click li img': 'previewImage'

  render: ->
    @$el.html(@template())
    @renderNav()
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

  uploadImages: ->
    url = @model.url() + '/save_picture'
    @$('#preview_list > img').each () ->
      img = @
      $.ajax(
        type: 'POST'
        url: url
        data:
          img: img.src
        dataType: 'json'
        success: (data) -> console.log data
      )

  goToShow: ->
    view = new Mis.Views.XiaoshouPackagesShow(model: @model)
    $("#bodyContent").html view.render().el

  openImageForm: ->
    view = new Mis.Views.XiaoshouServicePicturesForm()
    view.open()

  previewImage: (e) ->
    img = new Image()
    img.src = e.target.src
    $("#material_img_preview").html(img)
