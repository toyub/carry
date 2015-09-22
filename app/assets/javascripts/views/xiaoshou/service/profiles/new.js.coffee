class Mis.Views.XiaoshouServiceProfilesNew extends Backbone.View

  template: JST['xiaoshou/service/profiles/new']

  render: ->
    @$el.html(@template(collection: @collection))
    @
