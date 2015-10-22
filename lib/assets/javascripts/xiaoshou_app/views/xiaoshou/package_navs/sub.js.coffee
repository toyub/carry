class Mis.Views.XiaoshouPackageNavsSub extends Backbone.View

  tagName: 'ul'

  className: 'goods_nav'

  template: JST['xiaoshou/package_navs/sub']

  render: ->
    @$el.html(@template())
    @
