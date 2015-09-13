class Mis.Views.XiaoshouServiceProfilesItem extends Backbone.View

  tagName: 'tr'

  template: JST['xiaoshou/service/profiles/service']

  render: ->
    @$el.html(@template(@model.attributes))
    @
