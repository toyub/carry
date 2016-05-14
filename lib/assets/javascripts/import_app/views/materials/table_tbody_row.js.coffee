class Mis.Views.Materials.tableTbodyRow extends Backbone.View
  template: JST['import/materials/table/tbody_row']

  tagName: 'tr'

  initialize: (opts) ->
    @collection = opts.collection
    @model = opts.model
    @new_record = opts.new_record
    @model.on('importSave', @handleSave)

  events: ->
    'change input.root_category': 'resetSubCategory'

  handleSave: =>
    data = @$el.find('input, select')
    @collection.allModels.push data.serializeJSON()

  resetSubCategory: (evt) ->
    id = evt.target.value
    url = "/kucun/material_categories/" + id + "/sub_categories"
    $.get(url, (res) =>
      view = new Mis.subCategorySelectView(model: res)
      @$("#material_category_select").html(view.render().el)
    )

  render: ->
    @$el.html(@template({
      root_categories:@collection.asSelectOptions.root_categories.toJSON(),
      brands:         @collection.asSelectOptions.brands.toJSON(),
      units:          @collection.asSelectOptions.units.toJSON(),
      manufacturers:  @collection.asSelectOptions.manufacturers.toJSON(),
      model:          @model
      }))
    if !@new_record
      @$el.addClass('hightlight')
    @

