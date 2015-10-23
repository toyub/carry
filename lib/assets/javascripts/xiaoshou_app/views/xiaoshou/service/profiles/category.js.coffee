class Mis.Views.XiaoshouServiceProfilesCategory extends Backbone.View

  tagName: 'li'

  template: JST['xiaoshou/service/profiles/category']

  render: ->
    @$el.html(@template(@model.attributes))
    @
