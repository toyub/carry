class Mis.Views.XiaoshouServiceProfilesItem extends Mis.Base.View

  tagName: 'tr'

  template: JST['xiaoshou/service/profiles/service']

  initialize: (options) ->
    @index = options.index

  render: ->
    @$el.html(@template(_.extend @model.attributes, index: @index))
    @
