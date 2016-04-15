class Mis.Views.XiaoshouPackageItemsMaterial extends Mis.Base.View
  tagName: 'ul'

  className: 'goods_wrap wrap'

  template: JST['xiaoshou/package_items/material']

  events:
    'change #store_material_id': 'renderDetails'
    'blur [name="quantity"]': 'setQuantity'
    'blur [name="amount"]': 'setAmount'

  render: ->
    @$el.html(@template(item: @model))
    @$("select").select2()
    @$el.show()
    @

  renderDetails: (e) ->
    package_itemable = Mis.materials.get($(e.target).val())
    if package_itemable
      @model.set('package_itemable_id', package_itemable.id)
      @model.set('package_itemable_type', 'StoreMaterialSaleinfo')
      $("#materialName").text(package_itemable.get 'name')
      $("#materialPrice").text(package_itemable.get 'retail_price')
      @model.set('amount', @model.regularAmount())
      @$el.find('[name="amount"]').val(@model.packagedItemAmount())
      @renderPrice()
    else
      @clearResult()

  clearResult: ->
    $("#materialName").text("")
    $("#materialPrice").text("")
    @$el.find('[name="amount"]').val('')
    @$el.find('[name="price"]').val('')
    @$el.find('.js-regular-amount').text('')
    @$el.find('.js-discount-rate').text('')

  setQuantity: (evt)->
    target = evt.target
    @model.set('quantity', target.value)
    @renderPrice()

  setAmount: (evt)->
    target = evt.target
    @model.set('amount', target.value)
    @renderPrice()

  renderPrice: ->
    @$el.find('.js-regular-amount').text(@model.regularAmount())
    @$el.find('[name="price"]').val(@model.packagedItemPrice())
    @$el.find('.js-discount-rate').text(@model.discountRate())
