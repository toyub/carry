class Mis.Views.XiaoshouPackageNavsMaster extends Backbone.View

  tagName: 'ul'

  template: JST['xiaoshou/package_navs/master']

  render: ->
    @$el.html(@template())
    @
