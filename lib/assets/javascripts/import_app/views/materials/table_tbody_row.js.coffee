class Mis.Views.Materials.tableTbodyRow extends Backbone.View
  template: JST['import/materials/table/tbody_row']

  tagName: 'tr'

  initialize: (opts) ->
    @row = opts.rowData
    @new_record = opts.new_record

  render: ->
    @$el.html(@template({row: @row, new_record: @new_record}))
    @

