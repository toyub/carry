class Mis.Views.XiaoshouServiceProfilesEdit extends Backbone.View
  className: "base_info"

  template: JST['xiaoshou/service/profiles/edit']

  initialize: ->
    @model.materials.on('add', @addMaterial, @)

  events:
    'click #backToSHow': 'goToShow'
    'submit #editStoreService': 'updateOnSubmit'
    'click #add_server_btn': 'openMaterialForm'

  render: ->
    @$el.html(@template(service: @model, store: window.Store))
    @model.materials.each @addMaterial
    @

  addMaterial: (material) =>
    view = new Mis.Views.XiaoshouServiceMaterialsItem(model: material, action: 'edit', service: @model)
    @$(".materialList").append view.render().el

  updateOnSubmit: ->
    event.preventDefault()
    @model.save $("#editStoreService").serializeJSON()
    @goToShow()

  goToShow: ->
    view = new Mis.Views.XiaoshouServiceProfilesShow(model: @model)
    $("#bodyContent").html(view.render().el)
    @model.fetch()

  openMaterialForm: ->
    view = new Mis.Views.XiaoshouServiceMaterialsForm(model: @model)
    view.open()