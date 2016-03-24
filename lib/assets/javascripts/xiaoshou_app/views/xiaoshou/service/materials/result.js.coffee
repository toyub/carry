class Mis.Views.XiaoshouServiceMaterialsResult extends Mis.Base.View

  tagName: 'tr'

  template: JST['xiaoshou/service/materials/result']

  initialize: ->
    @store = Mis.store
    @listenTo(@model, 'change:selected', @renderSelectedMaterials)

  events:
    'click .check': 'toggleSelected'

  render: ->
    @$el.html(@template(material: @model))
    @

  renderSelectedMaterials: ->
    console.log 'xxxxxx'
    $("#selectedMaterials").empty()
    _.each @model.collection.selected(), @renderMaterial

  renderMaterial: (material) =>
    view = new Mis.Views.XiaoshouServiceMaterialsSelectedItem(model: material)
    @renderChild(view)
    $("#selectedMaterials").append view.el

  toggleSelected: ->
    @model.toggleSelected()
