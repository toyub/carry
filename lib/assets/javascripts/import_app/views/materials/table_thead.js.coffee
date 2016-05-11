class Mis.Views.Materials.tableThead extends Backbone.View
  template: JST['import/materials/table/thead']

  tagName: 'tr'

  initialize: (opts) ->
    @header = opts.header

  render: ->
    @$el.html(@template({header: @header}))
    @

