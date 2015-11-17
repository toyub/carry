class Mis.Views.XiaoshouServiceProfilesEdit extends Mis.Base.View
  @include Mis.Mixins.Uploadable

  className: "base_info"

  template: JST['xiaoshou/service/profiles/edit']

  initialize: ->
    @model.on("sync", @handleSuccess, @)
    @model.materials.on('add', @addMaterial, @)

  events:
    'click #backToSHow': 'goToShow'
    'submit #editStoreService': 'updateOnSubmit'
    'click #add_server_btn': 'openMaterialForm'
    'click li img': 'previewImage'

  render: ->
    @$el.html(@template(service: @model, store: window.Store))
    @renderUploadTemplate()
    @model.materials.each @addMaterial
    @

  addMaterial: (material) =>
    view = new Mis.Views.XiaoshouServiceMaterialsItem(model: material, action: 'edit', service: @model)
    @$(".materialList").append view.render().el

  updateOnSubmit: ->
    event.preventDefault()
    @model.set $("#editStoreService").serializeJSON()
    @model.save() if @model.isValid(true)

  goToShow: ->
    view = new Mis.Views.XiaoshouServiceProfilesShow(model: @model)
    $("#bodyContent").html(view.render().el)

  openMaterialForm: ->
    view = new Mis.Views.XiaoshouServiceMaterialsForm(model: @model)
    view.open()

  handleSuccess: ->
    @uploadImages()
    @goToShow()

  previewImage: (e) ->
    img = new Image()
    img.src = e.target.src
    $("#material_img_preview").html(img)
