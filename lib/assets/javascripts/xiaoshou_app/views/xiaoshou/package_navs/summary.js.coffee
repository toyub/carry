class Mis.Views.XiaoshouPackageNavsSummary extends Backbone.View

  template: JST['xiaoshou/package_navs/summary']

  render: ->
    @$el.html(@template(package: @package))
    @
