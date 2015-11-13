class Mis.Models.StorePackage extends Backbone.Model

  urlRoot: '/api/store_packages'

  modelName: 'store_package'

  initialize: ->
    @parseUploads()
    @parseTrackings()
    @parsePackageSetting()

  validation:
    name:
      required: true
      msg: '请输入名称'

  validPeriod: ->
    @get 'period' + @get 'period_unit'

  parseUploads: ->
    @uploads = new Mis.Collections.Uploads(@get 'uploads')

  parseTrackings: ->
    @trackings = new Mis.Collections.StorePackageTrackings(store_package: @)

  parsePackageSetting: ->
    attrs = @get 'package_setting'
    @package_setting = new Mis.Models.StorePackageSetting(_.extend {store_package: @}, attrs)
