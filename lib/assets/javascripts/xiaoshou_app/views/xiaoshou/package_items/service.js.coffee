class Mis.Views.XiaoshouPackageItemsService extends Mis.Base.View
  tagName: 'ul'

  className: 'service_wrap wrap'

  template: JST['xiaoshou/package_items/service']

  events:
    'change #store_service_id': 'renderDetails'
    'blur [name="quantity"]': 'setQuantity'

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
      @renderAmount()
    else
      $("#serviceName").text("")
      $("#servicePrice").text("")

  setQuantity: (evt)->
    target = evt.target
    @model.set('quantity', target.value)

  renderAmount: ->
    @$el.find('[name="amount"]').val(@model.packagedItemAmount())
