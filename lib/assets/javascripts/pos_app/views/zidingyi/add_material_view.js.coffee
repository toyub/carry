class Mis.addMaterialView extends Backbone.View
  template: JST["pos/zidingyi/add_material"]

  tagName: "tr"

  events: ->
    'change input[name="quantity"], .retail_price' : 'resetAmount'

  resetAmount: ->
    quantity = +@$('input[name="quantity"]').val()
    retail_price = +@$('.retail_price').val()
    @$('.amount').val(quantity * retail_price)
    @$('.amount').change()

  render: ->
    @$el.html(@template(@model.toJSON() ))
    @$el.addClass(@model.cid)
    @

