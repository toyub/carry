class Mis.subCategorySelectView extends Backbone.View
  template: JST["import/materials/table/sub_category_select"]

  initialize: (options) ->
    @model = options.model

  render: ->
    @$el.html(@template(categories: @model))
    @

