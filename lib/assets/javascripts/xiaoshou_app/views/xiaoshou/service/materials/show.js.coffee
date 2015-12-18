class Mis.Views.XiaoshouServiceMaterialsShow extends Mis.Base.View
  el: "#show_server"

  template: JST['xiaoshou/service/materials/show']

  events:
    'click a.cancel': 'close'

  render: ->
    @$el.html(@template(material: @model))
    @$el.show()
    @

  close: ->
    @leave()
