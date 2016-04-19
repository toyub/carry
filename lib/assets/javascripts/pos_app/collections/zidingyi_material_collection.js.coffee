class Mis.Models.ZidingYiMaterial extends Backbone.Model

  validate: (attrs) ->
    if attrs.name == ""
      return "商品名称不能为空"

  toItemAttrs: (data) ->
    attrs = {
      name: data.name,
      speci: data.speci,
      orderable_type: 'StoreMaterialSaleinfo',
      orderable_id: data.orderable_id,
      retail_price: data.retail_price,
      price: data.retail_price,
      cached_price: 0,
      cost_price: 0,
      quantity: @get('quantity),
      discount: null,
      discount_reason: null
    }
    Mis.Vues.MaterialItem.items.push(attrs);

class Mis.Collections.ZiDingYiMaterialCollection extends Backbone.Collection
  model: Mis.Models.ZidingYiMaterial
  url: '/api/pos/zidingyi/store_materials'

  saveAll: ->
    @models.map @createMaterial
    $('.save-once').hide()
    $('.new-material').hide()

  createMaterial: (model) ->
    className = ".list-new-material tr." + model.cid
    input_or_select = @$(className).find("input,select")
    if model.isValid()
      model.save input_or_select.serializeJSON(), {
        success: (model, respone)->
          (input.disabled = true) for input in input_or_select
          model.toItemAttrs(respone)
      }
    else
      alert(model.validationError)
