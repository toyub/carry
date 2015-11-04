class Mis.Views.XiaoshouPackageNavsSummary extends Backbone.View
  tagName: 'tbody'

  template: JST['xiaoshou/package_navs/summary']

  initialize: (options) ->
    @package = options.package

  render: ->
    @$el.html(@template(package: @package))
    @
