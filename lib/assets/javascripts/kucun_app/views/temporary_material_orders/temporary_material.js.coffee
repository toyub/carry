class Mis.Views.TemporaryMaterialView extends Backbone.View
  template: JST["kucun/temporary_materials/material"]

  tagName : 'tr'

  initialize: (options) ->
    @item = new Mis.Models.TemporaryItem({id: options.item_id})
    @item.on('sync', @render, @)
    @item.fetch()

  events:
    'change input.cost_price, input.quantity': 'resetAmount'
    'click .lnr-cross-circle' : 'removeItem'

  resetAmount: ->
    amount =  +@$("input.cost_price").val() * +@$("input.quantity").val()
    @$("input[name='amount']").val(amount)
    @refreshText()

  refreshText: ->

    total_amount = 0.0
    total_amount += +input_amount.value for input_amount in $("tbody.list-add-materials input[name='amount']")
    $('.temporary-order-amount').text(total_amount)
    $("#pay-field").change()

    total_quantity = 0
    total_quantity += +input_quantity.value for input_quantity in $("tbody.list-add-materials input.quantity")
    $('.temporary-order-quantity').text(total_quantity)


  removeItem: ->
    @remove()

  render: ->
    @$el.html(@template(item: @item.toJSON() ))
    @$el.appendTo($("tbody.list-add-materials"))
    @
