class Mis.Models.StorePackage extends Backbone.Model

  urlRoot: '/api/store_packages'

  modelName: 'store_package'

  initialize: ->
    @on('change:uploads', @parseUploads, @)
    @on('change:trackings', @parseTrackings, @)

    @parseUploads()
    @parseTrackings()
    @parsePackageSetting()

  validation:
    name:
      required: true
      msg: '请输入名称'

  validPeriod: ->
    @package_setting.validPeriod()

  parseUploads: ->
    @uploads = new Mis.Collections.Uploads(@get 'uploads')

  parseTrackings: ->
    attrs = @get('trackings')
    @trackings = new Mis.Collections.StorePackageTrackings(attrs, store_package: @)

  parsePackageSetting: ->
    attrs = @get 'package_setting'
    @package_setting = new Mis.Models.StorePackageSetting(_.extend {store_package: @}, attrs)
