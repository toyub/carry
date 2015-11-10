class Mis.Views.XiaoshouPackageNavsSub extends Backbone.View

  tagName: 'ul'

  className: 'goods_nav'

  template: JST['xiaoshou/package_navs/sub']

  initialize: (options) ->
    @package = options.package if options

  events:
    'click .next_info': 'goTo'

  render: ->
    @$el.html(@template())
    @

  goTo: ->
    model = new Mis.Models.StorePackageSetting(store_package: @package)
    view = new Mis.Views.XiaoshouPackageSettingsNew(model: model)
    $("#bodyContent").html(view.render().el)
