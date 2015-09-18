class Mis.Models.StoreService extends Backbone.Model

  urlRoot: '/api/store_services'

  modelName: 'store_service'

  initialize: ->
    @on('change:store_service_workflows_attributes', @parseWorkflows)
    @on('change:uploads', @parseUploads)
    @on('change:store_materials', @parseMaterials)
    @parseWorkflows()
    @parseUploads()
    @parseMaterials()

  validation:
    name:
      required: true
      msg: '请输入名称'
    retail_price: [
      {
        required: true,
        msg: '销售价不能为空'
      },
      {
        pattern: 'number',
        msg: '销售价必须是数字'
      }
    ]
    bargain_price: [
      required: false,
      {
        pattern: 'number',
        msg: '优惠价必须是数字'
      }
    ]
    point: [
      required: false,
      {
        pattern: 'digits',
        msg: '积分必须是整数'
      }
    ]
    store_service_category_id:
      required: true
      msg: '请选择类别'

  parseWorkflows: ->
    @workflows = new Mis.Collections.StoreServiceWorkflows(@get 'store_service_workflows_attributes')

  parseUploads: ->
    @uploads = new Mis.Collections.Uploads(@get "uploads")

  parseMaterials: ->
    @materials = new Mis.Collections.StoreMaterials(@get "store_materials")

  toJSON: ->
    json = _.clone(@attributes)
    json.store_service_store_materials_attributes = @materials.map(
      (material) ->
        {store_material_id: material.id}
    )
    hashWithRoot = {}
    hashWithRoot[@modelName] = json

