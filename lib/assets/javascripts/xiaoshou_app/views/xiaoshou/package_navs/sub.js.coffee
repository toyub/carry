class Mis.Views.XiaoshouPackageNavsSub extends Backbone.View

  tagName: 'ul'

  className: 'goods_nav'

  template: JST['xiaoshou/package_navs/sub']

  events:
    'click .next_info': 'goTo'

  render: ->
    @$el.html(@template())
    @
