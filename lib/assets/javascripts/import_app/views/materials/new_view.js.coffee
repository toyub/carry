Mis.Views.Materials ||= {}

class Mis.Views.Materials.NewView extends Backbone.View
  template: JST['import/materials/new']

  render: ->
    @$el.html(@template())
    @

