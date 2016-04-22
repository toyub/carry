class Mis.addMaterialView extends Backbone.View
  template: JST["pos/zidingyi/add_material"]

  tagName: "tr"

  initialize: (options) ->
    @model = options.model
    @sale_categories = options.sale_categories
    @material_units = options.material_units

  events: ->
    'change input[name="quantity"], .retail_price' : 'resetAmount'

  resetAmount: ->
    quantity = +@$('input[name="quantity"]').val()
    retail_price = +@$('.retail_price').val()
    @$('.amount').val(quantity * retail_price)
    @$('.amount').change()

  render: ->
    @$el.html(@template(sale_categories: @sale_categories, material_units: @material_units))
    @$el.addClass(@model.cid)
    @

