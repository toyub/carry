class Mis.Views.XiaoshouServiceMaterialsForm extends Backbone.View
  el: '#add_server'

  template: JST['xiaoshou/service/materials/form']

  render: ->
    @$el.html(@template(service: @model, store: window.Store))
    console.log window.Store
    @

  open: ->
    @render()
    @$el.show()

  close: ->
    @$el.hide()
