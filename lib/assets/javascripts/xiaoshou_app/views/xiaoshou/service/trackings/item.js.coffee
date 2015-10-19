class Mis.Views.XiaoshouServiceTrackingsItem extends Backbone.View

  tagName: 'ul'

  className: 'tracking_list_content list_content'

  template: JST['xiaoshou/service/trackings/item']

  initialize: ->
    @model.on('change', @render, @)
    @model.on('destroy', @remove, @)

  events:
    'click label.content': 'editTracking'
    'click span.delete': 'clear'

  render: ->
    @$el.html(@template(tracking: @model))
    @

  editTracking: ->
    view = new Mis.Views.XiaoshouServiceTrackingsForm(model: @model)
    view.open()

  clear: ->
    @model.clear()

  remove: ->
    @$el.remove()
    @undelegateEvents()
    @model.off()
