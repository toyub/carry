class Mis.Views.XiaoshouServiceProfilesShow extends Backbone.View

  template: JST['xiaoshou/service/profiles/show']

  events:
    'click #preview_list img': 'previewImage'
    'click #serviceEdit': 'gotoEdit'

  initialize: ->
    @model.on('sync', @renderMaterials, @)

    @model.uploads.on('add', @renderImage, @)

  render: ->
    @$el.html(@template(service: @model))
    @renderNav()
    @renderUploadTemplate()
    @renderImages()
    @renderMaterials()
    @

  renderNav: ->
    view = new Mis.Views.XiaoshouServiceNavsMaster(model: @model, active: 'service')
    @$("#masterNav").html view.render().el

  previewImage: (event) ->
    src = $(event.target).attr('src')
    image = "<img src='#{src}' />"
    @$("#material_img_preview").html(image)

  gotoEdit: ->
    view = new Mis.Views.XiaoshouServiceProfilesEdit(model: @model)
    @$("div.details_content").html(view.render().el)

  renderMaterials: =>
    @$(".materialList").empty()
    @model.materials.each @addMaterial

  addMaterial: (material) =>
    view = new Mis.Views.XiaoshouServiceMaterialsItem(model: material, action: 'show')
    @$(".materialList").append view.render().el

  renderImages: ->
    @model.uploads.each @renderImage

  renderImage: (image) =>
    view = new Mis.Views.XiaoshouUploadsItem(model: image)
    @$("#preview_list").append view.render().el

  renderUploadTemplate: ->
    view = new Mis.Views.XiaoshouUploadsTemplate(action: 'show')
    @$("#uploadTemplate").html view.render().el
