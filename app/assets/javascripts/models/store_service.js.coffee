class Mis.Models.StoreService extends Backbone.Model

  urlRoot: '/xiaoshou/service/categories'

  validation:
    name:
      required: true
      msg: '请输入名称'
