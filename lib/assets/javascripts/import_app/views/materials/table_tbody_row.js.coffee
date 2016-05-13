class Mis.Views.Materials.tableTbodyRow extends Backbone.View
  template: JST['import/materials/table/tbody_row']

  tagName: 'tr'

  initialize: (opts) ->
    @model = opts.model
    @new_record = opts.new_record
    @model.on('importSave', @handleSave)

  handleSave: =>
    data = @$el.find('input, select')
    if !@new_record
      @model.save data.serializeJSON(), {
        success: (model, respone)->
      }

  render: ->
    @$el.html(@template({model: @model}))
    if !@new_record
      @$el.addClass('hightlight')
    @

