class Mis.Views.XiaoshouServiceProfilesNew extends Backbone.View
  initialize: ->
    @model.materials.on('add', @addMaterial, @)
    Backbone.Validation.bind(@)

  template: JST['xiaoshou/service/profiles/new']

  events:
    'submit #createService': 'createOnSubmit'
    'click #add_server_btn': 'openMaterialForm'

  render: ->
    @$el.html(@template(service: @model))
    @

  createOnSubmit: ->
    event.preventDefault()
    @model.set $("#createService").serializeJSON()
    @model.save() if @model.isValid(true)
    console.log @model
    console.log 'xxxx'

  openMaterialForm: ->
    view = new Mis.Views.XiaoshouServiceMaterialsForm(model: @model)
    view.open()

  addMaterial: (material) =>
    view = new Mis.Views.XiaoshouServiceMaterialsItem(model: material, action: 'edit', service: @model)
    @$(".materialList").append view.render().el
    @$(".materialList").parent().show()
