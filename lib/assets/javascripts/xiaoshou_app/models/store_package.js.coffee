class Mis.Models.StorePackage extends Backbone.Model

  urlRoot: '/api/store_packages'

  modelName: 'store_package'

  initialize: ->
    @parseUploads()

  validation:
    name:
      required: true
      msg: '请输入名称'

  validPeriod: ->
    @get 'period' + @get 'period_unit'

  parseUploads: ->
    @uploads = new Mis.Collections.Uploads(@get 'uploads')
