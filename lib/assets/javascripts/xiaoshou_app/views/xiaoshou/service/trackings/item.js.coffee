class Mis.Views.XiaoshouServiceTrackingsItem extends Backbone.View

  tagName: 'ul'

  className: 'tracking_list_content list_content'

  template: JST['xiaoshou/service/trackings/item']

  initialize: (options) ->
    @store_service = options.store_service

    @model.on('change', @render, @)

  events:
    'click label.content': 'editTracking'

  render: ->
    @$el.html(@template(tracking: @model))
    @

  editTracking: ->
    view = new Mis.Views.XiaoshouServiceTrackingsForm(model: @model, store_service: @store_service)
    view.open()
