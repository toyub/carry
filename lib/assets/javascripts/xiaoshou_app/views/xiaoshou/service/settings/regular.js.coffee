class Mis.Views.XiaoshouServiceSettingsRegular extends Mis.Base.View

  template: JST['xiaoshou/service/settings/regular']

  render: ->
    @$el.html(@template(setting: @model, store: Mis.store))
    @


