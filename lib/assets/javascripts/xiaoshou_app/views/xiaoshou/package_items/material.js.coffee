class Mis.Views.XiaoshouPackageItemsMaterial extends Mis.Base.View
  tagName: 'ul'

  className: 'goods_wrap wrap'

  template: JST['xiaoshou/package_items/material']

  events:
    'change #store_material_id': 'renderDetails'

  render: ->
    @$el.html(@template(item: @model))
    @$("select").select2()
    @$el.show()
    @

  renderDetails: (e) ->
    service = Mis.materials.get($(e.target).val())
    if service
      $("#materialName").text(service.get 'name')
      $("#materialPrice").text(service.get 'retail_price')
    else
      $("#materialName").text("")
      $("#materialPrice").text("")
