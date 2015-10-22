class Mis.Views.XiaoshouServiceNavsMaster extends Backbone.View

  tagName: 'ul'

  template: JST['xiaoshou/service/navs/master']

  render: ->
    @$el.html(@template())
    @
