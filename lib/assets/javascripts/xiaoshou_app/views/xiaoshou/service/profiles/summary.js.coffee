class Mis.Views.XiaoshouServiceProfilesSummary extends Backbone.View

  tagName: 'tbody'

  template: JST['xiaoshou/service/profiles/summary']

  render: ->
    @$el.html(@template(setting: @model))
    @
