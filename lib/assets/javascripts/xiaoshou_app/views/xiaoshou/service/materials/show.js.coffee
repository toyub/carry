class Mis.Views.XiaoshouServiceMaterialsShow extends Mis.Base.View
  template: JST['xiaoshou/service/materials/show']

  events:
    'click a.cancel': 'close'

  render: ->
    @$el.html(@template(material: @model))
    @

  close: ->
    $("#show_server").hide()
    @leave()
