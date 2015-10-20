class Mis.Views.XiaoshouServiceMaterialsShow extends Backbone.View
  el: "#show_server"

  template: JST['xiaoshou/service/materials/show']

  events:
    'click a.cancel': 'close'

  render: ->
    @$el.html(@template(material: @model))
    @

  open: ->
    @render()
    @$el.show()

  close: ->
    @undelegateEvents()
    @$el.hide()
