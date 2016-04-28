class Mis.ziDingYiView extends Backbone.View 
  template: JST["pos/zidingyi/zidingyi"]
  el: ".order_custom"

  input_quantity_el: '.list-new-material input[name="quantity"]'
  input_amount_el: '.list-new-material input[name="amount"]'

  initialize: ->
    @collection = new Mis.Collections.ZiDingYiMaterialCollection()
    @listenTo(@collection, "add", @addMaterialView)
    @initSelection()
    @total_quantity = 0
    @total_amount = 0.0
    @render()

  events:
    'click .new-material': 'newMaterial'
    'click .save-once': 'saveOnce'
    'change .list-new-material input[name="quantity"]' : 'resetTotalQuantity'
    'change .list-new-material input[name="amount"]' : 'resetTotalAmount'

  initSelection: ->
    @sale_categories = new Mis.Collections.SaleCategoriesCollection()
    @sale_categories.fetch()
    @material_units = new Mis.Collections.MaterialUnitsCollection()
    @material_units.fetch()
    @material_root_category = new Mis.Collections.MaterialRootCategoryCollection()
    @material_root_category.fetch()

  resetTotalQuantity: ->
    @total_quantity = 0
    @total_quantity += +input.value for input in $(@input_quantity_el)
    $("#total-quantity").text @total_quantity

  resetTotalAmount: ->
    @total_amount = 0.0
    @total_amount += +input.value for input in $(@input_amount_el)
    $("#total-amount").text @total_amount

  render: ->
     @$el.html(@template())

  show: ->
     @$el.show()

  newMaterial: ->
    @collection.add({})

  addMaterialView: (model) ->
    view = new Mis.addMaterialView({model: model, sale_categories: @sale_categories, material_units: @material_units, material_root_category: @material_root_category})
    $(".list-new-material").append(view.render().el)
    view.$el.find('.as_select').as_select();

  saveOnce: ->
    @collection.saveAll()
