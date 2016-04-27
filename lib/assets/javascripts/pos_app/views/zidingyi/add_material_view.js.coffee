class Mis.addMaterialView extends Backbone.View
  template: JST["pos/zidingyi/add_material"]

  tagName: "tr"

  initialize: (options) ->
    @model = options.model
    @sale_categories = options.sale_categories
    @material_units = options.material_units
    @material_root_category = options.material_root_category

  events: ->
    'change input[name="quantity"], .retail_price' : 'resetAmount'
    'change input.root_category': 'resetSubCategory'

  resetAmount: ->
    quantity = +@$('input[name="quantity"]').val()
    retail_price = +@$('.retail_price').val()
    @$('.amount').val(quantity * retail_price)
    @$('.amount').change()

  resetSubCategory: (evt) ->
    id = evt.target.value
    url = "/kucun/material_categories/" + id + "/sub_categories"
    $.get(url, (res) =>
      view = new Mis.subCategorySelectView(model: res)
      @$("#material_category_select").html(view.render().el)
    )

  render: ->
    @$el.html(@template(sale_categories: @sale_categories, material_units: @material_units, material_root_category: @material_root_category, cid: @model.cid ))
    @$el.addClass(@model.cid)
    @

