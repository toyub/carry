class Mis.Views.XiaoshouPackageItemsService extends Mis.Base.View
  tagName: 'ul'

  className: 'service_wrap wrap'

  template: JST['xiaoshou/package_items/service']

  events:
    'change #store_service_id': 'renderDetails'
    'blur [name="quantity"]': 'setQuantity'
    'blur [name="amount"]': 'setAmount'

  render: ->
    @$el.html(@template(item: @model))
    @$("select").select2()
    @$el.show()
    @

  renderDetails: (e) ->
    package_itemable = Mis.services.get($(e.target).val())
    if package_itemable
      @model.set('package_itemable_id', package_itemable.id)
      @model.set('package_itemable_type', 'StoreService')
      $("#serviceName").text(package_itemable.get 'name')
      $("#servicePrice").text(package_itemable.get 'retail_price')
      @model.set('amount', @model.regularAmount())
      @$el.find('[name="amount"]').val(@model.packagedItemAmount())
      @renderPrice()
    else
      @clearResult()

  clearResult: ->
    $("#serviceName").text("")
    $("#servicePrice").text("")
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
