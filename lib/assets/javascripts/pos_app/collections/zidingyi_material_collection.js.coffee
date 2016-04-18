class Mis.Models.ZidingYiMaterial extends Backbone.Model

  defaults:
    name: null
    speci: null

  validate: (attrs) ->
    if attrs.name == ""
      return "商品名称不能为空"

class Mis.Collections.ZiDingYiMaterialCollection extends Backbone.Collection
  model: Mis.Models.ZidingYiMaterial
  url: '/api/pos/zidingyi/store_materials'

  saveAll: ->
    @models.map @createMaterial

  createMaterial: (model) ->
    tag = ".list-new-material tr." + model.cid
    model.set (@$(tag).find("input,select").serializeJSON())
    if model.isValid()
      model.save()
    else
      alert(model.validationError)
