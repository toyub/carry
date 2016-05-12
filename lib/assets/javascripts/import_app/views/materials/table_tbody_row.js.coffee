class Mis.Views.Materials.tableTbodyRow extends Backbone.View
  template: JST['import/materials/table/tbody_row']

  tagName: 'tr'

  initialize: (opts) ->
    @row = opts.rowData

  render: ->
    @$el.html(@template(row: @row))
    @

