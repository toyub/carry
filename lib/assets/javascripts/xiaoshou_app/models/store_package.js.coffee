class Mis.Models.StorePackage extends Backbone.Model

  urlRoot: '/api/store_packages'

  modelName: 'store_package'

  validPeriod: ->
    @get 'period' + @get 'period_unit'
