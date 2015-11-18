class Mis.Views.XiaoshouSharedTop extends Mis.Base.View

  template: JST['xiaoshou/shared/top']

  initialize: (options = {}) ->
    @options = options

  render: ->
    @$el.html(@template(@options))
    @
