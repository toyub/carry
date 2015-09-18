class Mis.Views.XiaoshouServiceProfilesEdit extends Backbone.View
  className: "base_info"

  template: JST['xiaoshou/service/profiles/edit']

  events:
    'click #backToSHow': 'showService'
    'submit #editStoreService': 'updateOnSubmit'

  render: ->
    @$el.html(@template(service: @model, store: window.Store))
    @model.materials.each @addMaterial
    @

  showService: ->
    view = new Mis.Views.XiaoshouServiceProfilesShow(model: @model)
    $("#bodyContent").html(view.render().el)
    @model.fetch()

  addMaterial: (material) =>
    view = new Mis.Views.XiaoshouServiceMaterialsItem(model: material, action: 'edit', service: @model)
    @$(".materialList").append view.render().el

  updateOnSubmit: ->
    event.preventDefault()
    @model.set $("#editStoreService").serializeJSON()
    console.log JSON.stringify(@model.toJSON())
    @model.save()
    console.log('submit')
