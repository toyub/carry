class Mis.Views.XiaoshouServiceMaterialsResult extends Backbone.View

  tagName: 'tr'

  template: JST['xiaoshou/service/materials/result']

  render: ->
    @$el.html(@template(material: @model))
    @
