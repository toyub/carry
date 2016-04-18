class Mis.Models.ZidingYiMaterial extends Backbone.Model

  defaults:
    name: null
    speci: null

class Mis.Collections.ZiDingYiMaterialCollection extends Backbone.Collection
  model: Mis.Models.ZidingYiMaterial
  url: '/api/pos/zidingyi/store_materials'
