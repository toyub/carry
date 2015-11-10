class Mis.Views.XiaoshouPackageItemsMaterial extends Backbone.View
  tagName: 'ul'

  className: 'goods_wrap wrap'

  template: JST['xiaoshou/package_items/material']

  events:
    'change #store_material_id': 'renderDetails'

  render: ->
    @$el.html(@template())
    @

  open: ->
    @$("select").select2()
    @$el.show()

  renderDetails: (e) ->
    service = window.Store.materials.get($(e.target).val())
    if service
      $("#materialName").text(service.get 'name')
      $("#materialPrice").text(service.get 'cost_price')
    else
      $("#materialName").text("")
      $("#materialPrice").text("")
