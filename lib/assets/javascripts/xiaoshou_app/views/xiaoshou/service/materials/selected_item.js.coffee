class Mis.Views.XiaoshouServiceMaterialsSelectedItem extends Mis.Base.View

  tagName: 'tr'

  template: JST['xiaoshou/service/materials/selected_item']

  render: ->
    @$el.html(@template(material: @model))
    @
