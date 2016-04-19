class Mis.ziDingYiView extends Backbone.View 
  template: JST["pos/zidingyi/zidingyi"]
  el: ".order_custom"

  input_quantity_el: '.list-new-material input[name="quantity"]'
  input_amount_el: '.list-new-material input[name="amount"]'

  initialize: ->
    @collection = new Mis.Collections.ZiDingYiMaterialCollection()
    @listenTo(@collection, "add", @addMaterialView)
    @render()
    @total_quantity = 0
    @total_amount = 0.0

  events: 
    'click .new-material': 'newMaterial'
    'click .save-once': 'saveOnce'
    'change .list-new-material input[name="quantity"]' : 'resetTotalQuantity'
    'change .list-new-material input[name="amount"]' : 'resetTotalAmount'

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
    view = new Mis.addMaterialView(model: model)
    $(".list-new-material").append(view.render().el)

  saveOnce: ->
    @collection.saveAll()
