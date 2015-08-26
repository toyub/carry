class Mis.Models.StoreServiceCategory extends Backbone.Model

  urlRoot: '/api/store_service_categories'

  modelName: 'store_service_category'

  validation:
    name:
      required: true
      msg: '请输入名称'
