class Mis.Views.XiaoshouSharedStats extends Backbone.View
  tagName: 'tr'

  template: JST['xiaoshou/shared/stats']

  initialize: (options) ->
    @count = options.count
    @resource_name = options.resource_name

  render: ->
    @$el.html(@template(count: @count, resource_name: @resource_name))
    @
