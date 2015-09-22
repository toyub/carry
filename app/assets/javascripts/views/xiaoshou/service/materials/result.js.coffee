class Mis.Views.XiaoshouServiceMaterialsResult extends Backbone.View

  tagName: 'tr'

  template: JST['xiaoshou/service/materials/result']

  initialize: ->
    @store = window.Store
    @model.on('change:selected', @renderSelectedMaterials, @)

  events:
    'click .check': 'toggleSelected'

  render: ->
    @$el.html(@template(material: @model))
    @

  renderSelectedMaterials: ->
    $("#selectedMaterials").empty()
    _.each @store.materials.selected(), @renderMaterial

  renderMaterial: (material) =>
    view = new Mis.Views.XiaoshouServiceMaterialsSelectedItem(model: material)
    $("#selectedMaterials").append view.render().el

  toggleSelected: ->
    @model.toggleSelected()
