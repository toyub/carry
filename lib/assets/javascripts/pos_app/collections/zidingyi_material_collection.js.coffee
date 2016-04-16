class Mis.ZidingYiMaterialModel extends Backbone.Model

  urlRoot: '/api/pos/zidingyi/store_materials'

class Mis.ZiDingYiMaterialCollection extends Backbone.Collection

  url: '/api/pos/zidingyi/store_materials'

	model: Mis.ZidingYiMaterialModel

