class Mis.Views.XiaoshouServiceProfilesItem extends Mis.Base.View

  tagName: 'tr'

  template: JST['xiaoshou/service/profiles/service']

  render: ->
    @$el.html(@template(@model.attributes))
    @
