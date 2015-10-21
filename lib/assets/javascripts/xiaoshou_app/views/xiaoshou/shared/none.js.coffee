class Mis.Views.XiaoshouSharedNone extends Backbone.View
  tagName: 'tr'

  template: JST['xiaoshou/shared/none']

  initialize: (options) ->
    @cols = options.cols
    @resource_name = options.resource_name

  render: ->
    @$el.html(@template(cols: @cols, resource_name: @resource_name))
    @

