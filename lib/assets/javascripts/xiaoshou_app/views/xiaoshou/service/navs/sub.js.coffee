class Mis.Views.XiaoshouServiceNavsSub extends Backbone.View

  tagName: 'ul'

  className: 'goods_nav'

  template: JST['xiaoshou/service/navs/sub']

  render: ->
    @$el.html(@template())
    @
