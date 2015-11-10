class Mis.Views.XiaoshouPackageItemsService extends Backbone.View
  tagName: 'ul'

  className: 'service_wrap wrap'

  template: JST['xiaoshou/package_items/service']

  events:
    'change #store_service_id': 'renderDetails'

  render: ->
    @$el.html(@template())
    @

  open: ->
    @$("select").select2()
    @$el.show()

  renderDetails: (e) ->
    service = window.StoreServices.get($(e.target).val())
    if service
      $("#serviceName").text(service.get 'name')
      $("#servicePrice").text(service.get 'retail_price')
    else
      $("#serviceName").text("")
      $("#servicePrice").text("")
