class Mis.Views.XiaoshouServiceProfilesShow extends Backbone.View

  template: JST['xiaoshou/service/profiles/show']

  render: ->
    @$el.html(@template(@model.attributes))
    @
