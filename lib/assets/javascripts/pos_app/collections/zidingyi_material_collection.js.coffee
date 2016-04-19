class Mis.Models.ZidingYiMaterial extends Backbone.Model

  validate: (attrs) ->
    if attrs.name == ""
      return "商品名称不能为空"

class Mis.Collections.ZiDingYiMaterialCollection extends Backbone.Collection
  model: Mis.Models.ZidingYiMaterial
  url: '/api/pos/zidingyi/store_materials'

  saveAll: (options) ->
    @models.map @createMaterial
    options.success()

  createMaterial: (model) ->
    className = ".list-new-material tr." + model.cid
    input_or_select = @$(className).find("input,select")
    model.set input_or_select.serializeJSON()
    if model.isValid()
      model.save()
      (input.disabled = true) for input in input_or_select
    else
      alert(model.validationError)
